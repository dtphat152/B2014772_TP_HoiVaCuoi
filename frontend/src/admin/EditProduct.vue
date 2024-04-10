<template>
    <div class="container" style="width: 600px; margin-top: 100px;">
        <div>
            <router-link to="/admin/productmanager">
                <p class="text-black-50">Back</p>
            </router-link>
        </div>
        <hr> <br>
        <div class="checkout-form-container">
            <form @submit="handleSubmit" autocomplete="off" class="myform">
                <div class="form-group details-group">
                    <h4>Edit Product</h4>
                    <div class="form-group">
                        <label for="sel1">Caterogy:</label>
                        <select class="form-control" id="sel1" v-model="productObj.cat">
                            <option>Khai Vị</option>
                            <option>Món Chính</option>
                            <option>Tráng Miệng</option>
                            <option>Rạp Che</option>
                            <option>Sảnh Tiệc</option>
                            <option>Ban Nhạc</option>
                            <option>MC</option>
                            <option>Gia Tiên</option>
                            <option>Sân Khấu</option>
                            <option>Mâm Quả</option>
                            <option>Xe Hoa</option>
                            <option>Áo Cưới</option>
                            <option>Trang Điểm</option>
                            <option>Ghi Hình</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <input type="text"  placeholder="Product Name" class="form-control " autocapitalize="off"
                            v-model="productObj.name" />
                        <p class="error-mess" v-if="errorObj.nameErr.length > 0">{{ errorObj.nameErr[0] }}</p>
                    </div>
                    <div class="form-group">
                        <input type="text"  placeholder="Product Price" class="form-control"
                            v-model="productObj.price" />
                        <p class="error-mess" v-if="errorObj.priceErr.length > 0">{{ errorObj.priceErr[0] }}</p>
                    </div>
                    <div class="form-group">
                        <textarea name="txtMsg" class="form-control" placeholder="Product Description" 
                            style="width: 100%; height: 150px;"  v-model="productObj.desc" ></textarea>
                        <p class="error-mess" v-if="errorObj.descErr.length > 0">{{ errorObj.descErr[0] }}</p>
                    </div>
                    <div class="form-group">
                        <input type="text"  placeholder="Product Src Image" class="form-control"
                            v-model="productObj.src" />
                        <p class="error-mess" v-if="errorObj.srcErr.length > 0">{{ errorObj.srcErr[0] }}</p>
                    </div>
                    <div class="form-group">
                        <input type="text"  placeholder="Product Discount" class="form-control"
                            v-model="productObj.dis" />
                    </div>
                    <div class="form-group">
                        <label for="sel1">Style:</label>
                        <select class="form-control" id="sel1" v-model="productObj.sty">
                            <option>Món Tùy Chọn</option>
                            <option>Món Chính Thức</option>
                        </select>
                    </div>
                </div>
                <br>
                <div class="form-group">
                    <input type="submit" value="Submit" class="btn-info p-2"/>
                </div>
            </form>
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
            productObj: { name: "", price: "", desc: "", cat: "", src: "" , dis:"" , sty:""},
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
                dis: selectedProduct.product_discount,
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
                this.errorObj.nameErr.push('Entering name is required');
            }

            // Price validate
            if (!this.productObj.price) {
                this.errorObj.priceErr.push('Entering price is required');
            }

            // Desc validate
            if (!this.productObj.desc) {
                this.errorObj.descErr.push('Selecting desc method is required');
            }
            // Cat validate
            if (!this.productObj.cat) {
                this.errorObj.catErr.push('Selecting cat method is required');
            }
            // Src validate
            if (!this.productObj.src) {
                this.errorObj.srcErr.push('Selecting src image method is required');
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
                    product_discount: this.productObj.dis,
                    product_style: this.productObj.sty,
                }

                axios.put(`/products/${this.id}`, product);
                
                this.$router.push("/admin/productmanager");

            }
        }
    }
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