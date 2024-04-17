<template>
    <div class="container_combo">

        <div class="p-5 mx-1 row" style="border-radius: 20px; background-color: rgba(117, 0, 164, 0.38); opacity: 1;">
            <h1>Combo Manager</h1>
        </div>
        <br>

        <div class="p-5" style="border-radius: 20px; background-color: rgba(117, 0, 164, 0.38); opacity: 1; height: 785px; ">
            <div  v-if="!showProductOrder" >
                <div class="row d-flex justify-content-between">
                    <div class="col"></div>
                    <div class="col text-center">
                        <h2 style="color: #d35ea4; font-weight: bold;">Edit Combo</h2>
                    </div>
                    <div class="col text-right">
                        <button @click="showornot()" title="Open ProductOrder" class="btn pt-1 mr-2" 
                            style="background-color: #40bf77;border-radius: 15px; font-weight: bold;"><h4>Thêm Món</h4>
                        </button>
                        <router-link to="/admin/combomanager">
                            <button class="btn pt-1" style="background-color: #DC143C; border-radius: 15px;">
                                <h4>Trở Về</h4>
                            </button>
                            
                        </router-link>
                    </div>
                </div>
                <br>
                <form  @submit.prevent="handleSubmit" autocomplete="off" class="myform" style="background-color: #f08faf; border-radius: 20px;">
                    <div class="form-group details-group">
                        <br>
                        <div class="form-group">
                            <input type="text"  placeholder="Name" class="form-control " autocapitalize="off"
                                v-model="comboObj.name"/>
                            <p class="error-mess" v-if="errorObj.nameErr.length > 0">{{ errorObj.nameErr[0] }}</p>
                        </div>
                        <div class="form-group">
                            <input type="text"  placeholder="Price" class="form-control"
                                v-model="comboObj.price" />
                            <p class="error-mess" v-if="errorObj.priceErr.length > 0">{{ errorObj.priceErr[0] }}</p>
                        </div>
                        <div class="form-group">
                            <textarea name="txtMsg" class="form-control" placeholder="Description" 
                                v-model="comboObj.desc" ></textarea>
                            <p class="error-mess" v-if="errorObj.descErr.length > 0">{{ errorObj.descErr[0] }}</p>
                        </div>
                    </div>
                    <br> 
                    <h3 class="mt-2 text-center">Danh sách sản phẩm:</h3>
                        <hr>
                        <div v-for="(f, index) in filterProducts" :key="index" class="mt-2 text-left">
                            <div class="productconbo row d-flex justify-content-between">
                                <div class="col text-center">{{ f.product_category }}</div>
                                    <div class="col text-center">{{ f.product_name }}<hr></div>
                                    <div class="col text-center">
                                        <button class="btn" style="color: crimson;" @click="removeBtn(index)">
                                            <i class="fa fa-trash"></i>
                                        </button>
                                    </div>
                            </div>
                        </div>
                    <div class="form-group">
                        <br><hr>
                        <input type="submit" value="Submit" class="btn p-2" style="width: 100%; background-color: #d35ea4; color: white; font-weight: bold;"/>
                    </div>
                </form>
            </div>
            <div v-else>
                <ProductOrder  :ID="this.id" @productAdded="handleProductAddedToCombo">
                    <button class="btn pt-1 pb-0" @click="closeView" style="background-color: #DC143C; border-radius: 15px;"><h4>Trở Về</h4></button>
                </ProductOrder>
            </div> 
        </div>
    </div>

    
</template>

<script>
import ProductOrder from "./component/ProductOrder.vue";
import axios from "axios";
import { mapState } from "vuex";
export default {
    props: ['id'],

    name: "EditCombo",

    data() {
        return {
            allProductsInCombo: [],
            comboObj: { name: "", price: "", desc: ""},
            errorObj: { nameErr: [], priceErr: [], descErr: [] },
            showProductOrder: false, 
        }
    },

    created() {
        this.loadSelectedCombo();
        // this.getAllProducts();
    },

    mounted() {
        // this.loadSelectedCombo();
        this.getAllProducts();
    },

    computed: {
        ...mapState(["allProducts"]),

        filterProducts: function () {
            return this.allProducts.filter(
                (f) => this.matchID(f, this.allProductsInCombo)
            );
        },
    },

    methods: {

        matchID: function (product, comboArray) {
            let temp = "";
            comboArray.forEach(element => {
                if (parseInt(product.product_id) == element) {
                    temp = product
                }
            });
            return temp
        },
        
        async loadSelectedCombo() {
            try {
                let response = await axios.get("/combo/"+this.id);
                let combo = response.data;
                // Kiểm tra nếu dữ liệu là một mảng
                if (Array.isArray(combo) && combo.length > 0) {
                    // Truy cập vào phần tử đầu tiên trong mảng
                    this.comboObj = {
                        name: combo[0].combo_name,
                        price: combo[0].combo_price,
                        desc: combo[0].combo_desc,
                    };
                } else {
                    console.error('Error fetching combo: Data is not in expected format');
                }
            } catch (error) {
                console.error('Error fetching combo:', error);
            }
        },


        resetCheckErr: function () {
            this.errorObj.nameErr = [];
            this.errorObj.priceErr = [];
            this.errorObj.descErr = [];
        },

        checkEmptyErr: function () {
            for (var typeErr in this.errorObj) {
                if (this.errorObj[typeErr].length != 0) {
                    return false;
                }
            }
            return true;
        },


        checkForm: function () {
            this.resetCheckErr();

            // Name validate
            if (!this.comboObj.name) {
                this.errorObj.nameErr.push('Entering name is required');
            }

            // Price validate
            if (!this.comboObj.price) {
                this.errorObj.priceErr.push('Entering price is required');
            }

            // Desc validate
            if (!this.comboObj.desc) {
                this.errorObj.descErr.push('Selecting desc method is required');
            }
        },

        closeView: function () {
            this.showProductOrder = !this.showProductOrder;
        },

        async getAllProducts() {
            let data = (await axios.get('/combodetails/' + this.id)).data;
            this.comboObj.price=0;
            await Promise.all(data.map(async element => {
                this.allProductsInCombo.push(element.product_id);
                let rsp = await axios.get(`/products/${element.product_id}`);
                // console.log(rsp.data.product_price);
                this.comboObj.price += parseInt(rsp.data.product_price);
                console.log(this.comboObj.price);
            }));
        },


        handleProductAddedToCombo() {
            this.updateAllProductsInCombo();
        },

        async updateAllProductsInCombo() {
            // Cập nhật danh sách sản phẩm trong combo khi có sản phẩm mới được thêm vào
            await this.getAllProducts();
        },


        showornot() {
            this.showProductOrder = !this.showProductOrder;
        },

        async removeBtn(index) {
            let confirmResult = window.confirm("Bạn có chắc chắn muốn xóa ra khỏi combo?" );
            if (confirmResult) {
                try {
                    await axios.delete("/combodetails/" + this.id + "/" + this.allProductsInCombo[index]);
                    console.log("Successfully removed product in combo:", this.id , this.allProductsInCombo[index]);
                } catch (error) {
                    console.error("Error remove product in combo:", error);
                }
                this.allProductsInCombo.splice(index, 1);
            }
        },


        async handleSubmit(e) {
            this.checkForm();

            if (!this.checkEmptyErr()) {
                e.preventDefault();
            } else { 
                let combo = {
                    combo_id: this.id,
                    combo_name: this.comboObj.name,
                    combo_price: this.comboObj.price,
                    combo_desc: this.comboObj.desc,
        
                }
                try {
                    await axios.put(`/combo/${this.id}`, combo);
                    this.$router.push("/admin/combomanager");
                } catch (error) {
                    console.error("Error submitting combo:", error);
                }
            }
        },
    
    },

    components: { ProductOrder }
};
</script>


<style scoped>

h1 {
    font-weight: bold;
    color: #d35ea4;
}

.container_combo{
    margin-left: 220px; 
    margin-right: 20px; 
    margin-top: 10px;
    top: 0;
    height: 98vh;  
    opacity: 0.8;
    border-radius: 20px;
 }

input, textarea {
    text-transform: none !important;
    background-color: rgba(117, 0, 164, 0.38);
    border-radius: 15px;
    border: none;
    color: white;
    font-weight: bold;
    font-size: 15px;
}

.myform {
    border: none;
    padding: 20px;
}

.productconbo {
    font-size: 15px;
    font-weight: bold;
}


</style>