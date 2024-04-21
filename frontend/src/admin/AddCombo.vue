<template>
    <div class="container_combo">

        <div class="p-5 mx-1 row" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999;">
            <h1>Combo Manager</h1>
        </div>
        <br>

        <div class="p-5" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; height: 785px; ">
            <div  v-if="!showProductOrder" >
                <div class="row d-flex justify-content-between">
                    <div class="col"></div>
                    <div class="col text-center">
                        <h2 style="color: #d35ea4; font-weight: 900;">Edit Combo</h2>
                    </div>
                    <div class="col text-right">
                        <button @click="sendComboId(this.newstID)" title="Open ProductOrder" class="btn pt-1 mr-2" 
                            style="background-color: #40bf77;border-radius: 15px; font-weight: bold;"><h4 style="font-weight: 900;">Thêm Món</h4>
                        </button>
                        <router-link to="/admin/combomanager">
                            <button class="btn pt-1" style="background-color: #DC143C; border-radius: 15px;">
                                <h4 style="font-weight: 900;">Trở Về</h4>
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
                            <textarea name="txtMsg" class="form-control" placeholder="Description" 
                                v-model="comboObj.desc" ></textarea>
                            <p class="error-mess" v-if="errorObj.descErr.length > 0">{{ errorObj.descErr[0] }}</p>
                        </div>
                    </div>
                    <br> 
                    <h3 class="mt-2 text-center" style="font-weight: 900;">Danh sách sản phẩm:</h3>
                    <hr>
                    <div v-for="(f, index) in allProductsInCombo" :key="index" class="mt-2 text-left">
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
                    <br><hr>
                    <h3 class="text-center">Giá Combo: {{ formatCurrency(priceCombo()) }}</h3>
                    <br>
                    <div class="form-group">       
                        <input type="submit" value="Submit" class="btn p-2" style="width: 100%; background-color: #d35ea4; color: white; font-weight: bold;"/>
                    </div>
                </form>
            </div>
            <div v-else>
                <ProductOrder :ID="sendId" @productAdded="handleProductAddedToCombo">
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
    name: "AddCombo",

    data() {
        return {
            allProductsInCombo: [],
            comboObj: { name: "", price: "", desc: ""},
            errorObj: { nameErr: [], descErr: [] },
            showProductOrder: false,
            sendId: undefined,
            newstID: 0,  
            submited: false  
        }
    },

    created() {
        this.getNewestComboID();
        
    },

    mounted() {
        this.getAllProducts();
    },

    computed: {
        ...mapState(["allProducts"]),

    },

    methods: {
        formatCurrency(amount) {
          if (!amount) return '';
          return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
        },

        resetCheckErr: function () {
            this.errorObj.nameErr = [];
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

            // Desc validate
            if (!this.comboObj.desc) {
                this.errorObj.descErr.push('Selecting desc method is required');
            }
        },

        closeView: function () {
            this.showProductOrder = !this.showProductOrder;
        },

        async getAllProducts() {
            try {
                await this.getNewestComboID();
                const response = await axios.get(`/combodetails/product/${this.newstID}`);
                this.allProductsInCombo = response.data.sort((a, b) => {
                    const categoryOrder = { "Khai Vị": 1, "Món Chính": 2, "Tráng Miệng": 3 };
                    return categoryOrder[a.product_category] - categoryOrder[b.product_category];
                });
                // return this.allProductsInCombo;
            } catch (error) {
                console.error("Error fetching combo details:", error);
            }
        },

        priceCombo(){
            let total = 0;
            for ( const product of this.allProductsInCombo ) {
                total += parseInt(product.product_price)
            }
            return total;
        },

        handleProductAddedToCombo() {
            this.updateAllProductsInCombo();
        },

        async updateAllProductsInCombo() {
            // Cập nhật danh sách sản phẩm trong combo khi có sản phẩm mới được thêm vào
            await this.getAllProducts();
        },

        async getNewestComboID() {
            try {
                let response = await axios.get("/combo/new");
                let comboId = response.data;
                if (comboId == '') {
                    console.log("Newest ID is empty");
                    comboId = 1;
                } else {
                    comboId = parseInt(comboId.combo_id) + 1;
                }
                
                this.newstID = comboId;
            } catch (error) {
                console.error("Error fetching newest combo ID:", error);
            }
        },

        sendComboId: function (id) {
            this.sendId = id
            this.showProductOrder = !this.showProductOrder;
        },

        async removeBtn(index) {
            let confirmResult = window.confirm("Bạn có chắc chắn muốn xóa ra khỏi combo?" );
            if (confirmResult) {
                try {
                    await axios.delete("/combodetails/" + this.newstID + "/" + this.allProductsInCombo[index]);
                    console.log("Successfully removed product in combo:", this.newstID , this.allProductsInCombo[index]);
                } catch (error) {
                    console.error("Error remove product in combo:", error);
                }
                this.allProductsInCombo.splice(index, 1);
            }
        },

        async deleteAll(){
            await axios.delete("/billdetails/all/"+this.newstID);
            console.log("Successfully removed all product in new combo"+this.newstID);
        },

        async handleSubmit(e) {
            this.checkForm();

            if (!this.checkEmptyErr()) {
                e.preventDefault();
            } else {
                let combo = {
                    combo_id: this.newstID,
                    combo_name: this.comboObj.name,
                    combo_price: this.priceCombo(),
                    combo_desc: this.comboObj.desc,
        
                }

                await axios.post("/combo", combo);
                this.submited = true;
                this.$router.push("/admin/combomanager");

            }
        }
    },

    beforeRouteLeave(to, from, next) {
        if (this.submited) next();
        else {
        let confirmResult = window.confirm("Bạn có chắc chắn muốn thoát trông khi chưa hoàn thành tạo combo?" );
        if (confirmResult) {
        // Thực hiện các hành động để lưu dữ liệu trước khi rời khỏi component
            this.deleteAll();
        // Chuyển đến route mới
        next();
        } else {
            next(false)
        }
        }
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
    background-color: #f2f2f2;
    border-radius: 15px;
    border: none;
    color: black;
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