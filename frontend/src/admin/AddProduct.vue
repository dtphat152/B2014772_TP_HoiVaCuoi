<template>
    <div class="container-add">
        <div class="row p-5 mx-1  d-flex justify-content-between" 
            style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999;">
            <div class="col">
                <h1 style="font-weight: bold; color: #d35ea4;">Add Product</h1>
            </div>
            <div class="col text-right">
                <router-link to="productmanager">
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
                        <form @submit.prevent="handleSubmit" autocomplete="off" class="myform" style="border: none;">
                            <div class="form-group details-group">
                                <div class="row"></div>
                                <div class="form-group row">
                                    <div class="col-1">
                                        <label for="sel1">
                                            <h3 style="font-weight: bold; color: rgba(139, 131, 143, 0.8); padding-left: 10px;">Loại:</h3>
                                        </label>
                                    </div>
                                    <div class="col-11">
                                        <select class="form-control" id="sel1" v-model="productObj.cat" 
                                            style="background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; border: none; border-radius: 20px; color: black;
                                            font-weight: bold; font-size: 16px;">
                                            <option>Khai Vị</option>
                                            <option>Món Chính</option>
                                            <option>Tráng Miệng</option>
                                            <option>Thức Uống</option>
                                            <option>Bàn Ghế</option>
                                            <option>Rạp Che</option>
                                            <option>Cổng Hoa</option>
                                            <option>Sảnh Tiệc</option>
                                            <option>Gia Tiên</option>
                                            <option>Mâm Quả</option>
                                            <option>Xe Hoa</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="text"  placeholder="Tên sản phẩm" class="form-control " autocapitalize="off"
                                        v-model="productObj.name" />
                                    <!-- <p class="error-mess" v-if="errorObj.nameErr.length > 0">{{ errorObj.nameErr[0] }}</p> -->
                                </div>
                                <div class="form-group">
                                    <input type="text"  placeholder="Giá bán" class="form-control"
                                        v-model="productObj.price" />
                                    <!-- <p class="error-mess" v-if="errorObj.priceErr.length > 0">{{ errorObj.priceErr[0] }}</p> -->
                                </div>
                                <div class="form-group">
                                    <textarea name="txtMsg" class="form-control" placeholder="Mô tả..." 
                                        style="width: 100%; height: 150px;"  v-model="productObj.desc" ></textarea>
                                    <!-- <p class="error-mess" v-if="errorObj.descErr.length > 0">{{ errorObj.descErr[0] }}</p> -->
                                </div>
                                <div class="form-group">
                                    <input type="text"  placeholder="Đặc điểm thể loại" class="form-control"
                                        v-model="productObj.mota" />
                                    <!-- <p class="error-mess" v-if="errorObj.srcErr.length > 0">{{ errorObj.srcErr[0] }}</p> -->
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-2">
                                            <input type="file" id="fileInputImage" accept="image/*" ref="fileInput" @change="handleImageChange" style="display: none;">
                                            <div class="col-1"><i class="fa fa-camera-retro text-center" @click="openPostImage" style="font-size: 30px; color: black;" aria-hidden="true"></i></div>
                                        </div>
                                        <div class="col-4">
                                            <img v-if="images.length > 0" :src="images" alt="Selected image" style="width: 100%; border-radius: 10px;">
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
                <div class="row p-5 mx-1" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; height: 295px;">
                    
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
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from "axios";
// import { mapState } from "vuex";
export default {
    name: "AddProduct",

    data() {
        return {
            productObj: { name: "", price: "", desc: "", cat: "", mota:""},
            errorObj: { nameErr: [], priceErr: [], descErr: [], catErr: [],  },
            images: '',
            file: null,
        }
    },

    created() {
        
    },

    computed: {
        
    },

    methods: {

        openPostImage() {
            this.$refs.fileInput.click();
        },
        handleImageChange() {
            this.file = this.$refs.fileInput.files[0];
            if (this.file) {
                const reader = new FileReader();
                reader.onload = () => {
                this.images = reader.result;
                };
                reader.readAsDataURL(this.file);
            }
        },
        
        resetCheckErr: function () {
            this.errorObj.nameErr = [];
            this.errorObj.priceErr = [];
            this.errorObj.descErr = [];
            this.errorObj.catErr = [];
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
        },

        async handleSubmit(e) {
            this.checkForm();

            if (!this.checkEmptyErr()) {
                e.preventDefault();
            } else {
                let urlimg = '';
                if (this.file) {
                    const formData = new FormData();
                    formData.append('image', this.file);           
                    const response = await axios.post(`/uploading/post/`, formData, {
                        headers: {
                        'Content-Type': 'multipart/form-data'
                        }
                    });
                    urlimg = response.data;
                }
                let product = {
                    product_name: this.productObj.name,
                    product_price: this.productObj.price,
                    product_desc: this.productObj.desc,
                    product_category: this.productObj.cat,
                    product_mota: this.productObj.mota,
                    product_src: urlimg,
                    product_buy: 0
                }

                axios.post("/products", product);

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