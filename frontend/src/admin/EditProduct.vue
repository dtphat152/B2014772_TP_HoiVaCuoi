<template>
    <div class="container-add">
        <div class="row p-5 mx-1  d-flex justify-content-between" 
            style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999;">
            <div class="col">
                <h1 style="font-weight: bold; color: #d35ea4;">Edit Product</h1>
            </div>
            <div class="col text-right">
                <router-link :to="{ path: '/admin/productmanager' }">
                    <button class="btn" style="background-color: #cccccc; border-radius: 20px; color: black; ">
                        <h3 style="font-weight: 900;">Trở Về</h3>
                    </button>
                </router-link>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-10">
                <div class="row mx-1">
                    <div class="col-12 checkout-form-container" 
                        style="background-color: #ffe6ee;box-shadow: 0 1px 1px #999999; border: none; border-radius: 20px;">
                        <form @submit="handleSubmit" autocomplete="off" class="myform" style="border: none;">
                            <div class="form-group details-group">
                                <div class="row"></div>
                                <div class="form-group row">
                                    <div class="col-1">
                                        <label for="sel1">
                                            <h3 style="font-weight: bold; color: rgba(139, 131, 143, 0.8); padding-left: 10px;">Caterogy:</h3>
                                        </label>
                                    </div>
                                    <div class="col-11">
                                        <select class="form-control" id="sel1" v-model="productObj.cat" 
                                            style="background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; border: none; border-radius: 20px; color: black;
                                            font-weight: bold; font-size: 16px;">
                                            <option>Khai Vị</option>
                                            <option>Món Chính</option>
                                            <option>Tráng Miệng</option>
                                            <option>Rạp Che</option>
                                            <option>Sảnh Tiệc</option>
                                            <option>Gia Tiên</option>
                                            <option>Sân Khấu</option>
                                            <option>Mâm Quả</option>
                                            <option>Xe Hoa</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="text"  placeholder="Name" class="form-control " autocapitalize="off"
                                        v-model="productObj.name" />
                                </div>
                                <div class="form-group">
                                    <input type="text"  placeholder="Price" class="form-control"
                                        v-model="productObj.price" />
                                </div>
                                <div class="form-group">
                                    <textarea name="txtMsg" class="form-control" placeholder="Description" 
                                        style="width: 100%; height: 150px;"  v-model="productObj.desc" ></textarea>
                                </div>
                                <div class="form-group">
                                    <input type="text"  placeholder="Src Image" class="form-control"
                                        v-model="productObj.src" />
                                </div>
                                <div class="form-group">
                                    <div class="form-group row">
                                        <div class="col-1">
                                            <label for="sel1">
                                                <h3 style="font-weight: bold; color: rgba(139, 131, 143, 0.8); padding-left: 10px;">
                                                    Style:
                                                </h3> 
                                            </label>
                                        </div>
                                        <div class="col-11">
                                            <select class="form-control" id="sel1" v-model="productObj.sty"
                                            style="background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; border: none; border-radius: 20px; color: black;
                                                    font-weight: bold; font-size: 16px;">
                                                <option>Món Tùy Chọn</option>
                                                <option>Món Chính Thức</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br>
                            <div class="form-group">
                                <input type="submit" value="Submit" class="p-2"/>
                            </div>
                        </form>
                    </div>
                </div>
                <br>
                <div class="row p-5 mx-1" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; height: 250px;">
                    
                </div>
            </div>
            <div class="col-2">
                <div class="row p-5 mr-1" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; height: 785px;">
                    <div class="col-12">
                        <h5 style="color: Crimson; font-weight: bold; margin-bottom: 15px;" v-if="errorObj.catErr.length > 0">
                            {{ errorObj.catErr[0] }}
                        </h5>
                        <h5 style="color: Crimson; font-weight: bold; margin-bottom: 15px;" v-if="errorObj.nameErr.length > 0">
                            {{ errorObj.nameErr[0] }}
                        </h5>
                        <h5 style="color: Crimson; font-weight: bold; margin-bottom: 15px;" v-if="errorObj.priceErr.length > 0">
                            {{ errorObj.priceErr[0] }}
                        </h5>
                        <h5 style="color: Crimson; font-weight: bold; margin-bottom: 15px;" v-if="errorObj.descErr.length > 0">
                            {{ errorObj.descErr[0] }}
                        </h5>
                        <h5 style="color: Crimson; font-weight: bold; margin-bottom: 15px;" v-if="errorObj.srcErr.length > 0">
                            {{ errorObj.srcErr[0] }}
                        </h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
export default {
    props: ['id'],
    name: "EditProduct",
    
    data() {
        return {
            productObj: { name: "", price: "", desc: "", cat: "", src: "" , sty:""},
            errorObj: { nameErr: [], priceErr: [], descErr: [], catErr: [], srcErr: [] },
            
        }
    },

    created() {
        this.loadSelectedProduct();
    },

    computed: {
        ...mapState(["allProducts"]),

        selectedProduct: function () {
            return this.allProducts.filter((f) => parseInt(f.product_id) == parseInt(this.id));
        }
    },

    methods: {
        async loadSelectedProduct() {
            try {            
            // Lấy phần tử đầu tiên từ mảng selectedProduct
            const selectedProduct = this.selectedProduct[0];

            // Gán dữ liệu từ selectedProduct vào productObj
            this.productObj = {
                name: selectedProduct.product_name,
                price: selectedProduct.product_price,
                desc: selectedProduct.product_desc,
                cat: selectedProduct.product_category,
                src: selectedProduct.product_src,
                sty: selectedProduct.product_style,
            };
            } catch (error) {
            console.error('Error fetching product:', error);
            }
        },
        
        resetCheckErr: function () {
            this.errorObj.nameErr = [];
            this.errorObj.priceErr = [];
            this.errorObj.descErr = [];
            this.errorObj.catErr = [];
            this.errorObj.srcErr = [];
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
            if (!this.productObj.name) {
                this.errorObj.nameErr.push('Tên Sản Phẩm Không Được Để Trống');
            }

            // Price validate
            if (!this.productObj.price) {
                this.errorObj.priceErr.push('Giá Sản Phẩm Không Được Để Trống');
            }

            // Desc validate
            if (!this.productObj.desc) {
                this.errorObj.descErr.push('Mô Tả Sản Phẩm Không Được Để Trống');
            }
            // Cat validate
            if (!this.productObj.cat) {
                this.errorObj.catErr.push('Phải Chọn Phân Loại Cho Sản Phẩm');
            }
            // Src validate
            if (!this.productObj.src) {
                this.errorObj.srcErr.push('Đường Dẫn Hình Ảnh Không Được Để Trống');
            }
        },

        async handleSubmit(e) {
            this.checkForm();

            if (!this.checkEmptyErr() && this.productObj.sty!="Món Tùy Chọn") {
                e.preventDefault();
            } else {
                if(this.productObj.sty=="Món Chính Thức") this.productObj.sty="";
                let product = {
                    product_name: this.productObj.name,
                    product_price: this.productObj.price,
                    product_desc: this.productObj.desc,
                    product_category: this.productObj.cat,
                    product_src: this.productObj.src,
                    product_style: this.productObj.sty,
                }

                axios.put(`/products/${this.id}`, product);
                
                this.$router.push("/admin/productmanager");

            }
        }
    }
};
</script>

<style scoped>
input, textarea {
    text-transform: none !important;
    font-size: 16px;
    font-weight: bold;
    color: black;
    background-color: #f2f2f2;box-shadow: 0 1px 1px #999999;
    border: none;
    border-radius: 20px;
    margin-bottom: 15px;
}

.myform {
  border: 1px solid #ccc; /* Tạo viền xung quanh form */
  border-radius: 5px; /* Bo viền để làm mềm hơn */
  padding: 20px; /* Tạo khoảng cách giữa viền và nội dung form */
}

.container-add{
    margin-left: 220px; 
    margin-right: 20px; 
    margin-top: 10px;
    top: 0;
    height: 98vh;  
    opacity: 0.8;
    border-radius: 20px;
 }

</style>