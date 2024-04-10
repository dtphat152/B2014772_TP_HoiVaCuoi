<template>
    <div class="text-center" style="margin-top: 90px; padding-left: 260px">

        <div class="row d-flex justify-content-between px-5" style="background-color: #FFF0F5;">
            <router-link to="combomanager">
                <h4 class="text-black-50 pt-2" style="background-color: none; color: red; font-weight: bold;">Back</h4>
            </router-link>
            <button @click="sendComboId(this.newstID)" title="Open ProductOrder" class="btn text-success" 
                style="background-color: none; font-weight: bold;"><h4>Add product to Combo</h4>
                <br>
            </button>
        </div>

        <div class="container" style="width: 100%;">    
            <hr style="background-color: #FFF0F5; height: 5px;"> <br>
            <div class="checkout-form-container">
                <form @submit.prevent="handleSubmit" autocomplete="off" class="myform" style="background-color: #FFF0F5;">
                    <div class="form-group details-group">
                        <h2 style="color: #d35ea4; font-weight: bold;">Add Combo</h2>
                        <br>
                        <div class="form-group">
                            <input type="text"  placeholder="Name" class="form-control " autocapitalize="off"
                                v-model="comboObj.name" style="background-color: aliceblue;"/>
                            <p class="error-mess" v-if="errorObj.nameErr.length > 0">{{ errorObj.nameErr[0] }}</p>
                        </div>
                        <!-- <div class="form-group">
                            <input type="text"  placeholder="Price" class="form-control"
                                v-model="comboObj.price" style="background-color: aliceblue;" />
                            <p class="error-mess" v-if="errorObj.priceErr.length > 0">{{ errorObj.priceErr[0] }}</p>
                        </div> -->
                        <div class="form-group">
                            <textarea name="txtMsg" class="form-control" placeholder="Description" 
                                style="width: 100%; height: 150px; background-color: aliceblue;"  v-model="comboObj.desc" ></textarea>
                            <p class="error-mess" v-if="errorObj.descErr.length > 0">{{ errorObj.descErr[0] }}</p>
                        </div>
                    </div>
                    <br> 
                    <h6 class="mt-2 text-left">Danh sách sản phẩm:</h6>
                    <div v-for="(f, index) in allProductsInCombo" :key="index" class="mt-2 text-left">
                        <div class="row">
                            <div class="col-2 offset-1 px-0">{{ f.product_category }} <hr></div>
                                <div class="col-7 px-0">{{ f.product_name }}<hr></div>
                                <div class="col-2 px-0 pt-2">
                                    <button class="btn" style="color: crimson;" @click="removeBtn(index)">
                                        <i class="fa fa-trash"></i>
                                    </button>
                                    
                                </div>
                        </div>
                    </div>
                    <br>
                    <h4 style="color: #d35ea4; font-weight: bold;">{{priceCombo()}} vnd</h4>
                    <div class="form-group">
                        <hr>
                        <input type="submit" value="Submit" class="btn p-2" style="width: 100%; background-color: #FFF0F5;"/>
                    </div>
                </form>
                    
            </div>
        </div>
    </div>
    <ProductOrder v-if="showProductOrder" :ID="sendId" @productAdded="handleProductAddedToCombo">
        <button class="btn" @click="closeView">back</button>
    </ProductOrder>
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

        // filterProducts: function () {
        //     return this.allProducts.filter(
        //         (f) => this.matchID(f, this.allProductsInCombo)
        //     );
        // },
    },

    methods: {
        
        // matchID: function (product, comboArray) {
        //     let temp = "";
        //     comboArray.forEach(element => {
        //         if (parseInt(product.product_id) == element) {
        //             temp = product
        //         }
        //     });
        //     return temp
        // },

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

        // async getAllProducts() {
        //         await this.getNewestComboID();
        //         let data = (await axios.get('/combodetails/' + this.newstID)).data;
        //         data.forEach(element => {
        //             this.allProductsInCombo.push(element.product_id);
        //         }); 
        // },

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

<style>
input {
    text-transform: none !important;
}

.container {
  width: 500px;
  margin-top: 10px;
}

.myform {
  border: 1px solid #ccc; /* Tạo viền xung quanh form */
  border-radius: 5px; /* Bo viền để làm mềm hơn */
  padding: 20px; /* Tạo khoảng cách giữa viền và nội dung form */
}

</style>