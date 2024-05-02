<template>
    <div class=" py-3">
        <div class="">
            <div class=" row d-flex justify-content-between">
                <div class="col-2"> <slot></slot> </div>
            </div>
            
            <div class="" style="overflow-y: auto; height: 543px;">
                <div style="width: 95%;">
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
                                    <input type="text"  placeholder="Tên sản phẩm" class="form-control " autocapitalize="off" v-model="productObj.name" />
                                </div>
                                <div class="form-group">
                                    <textarea name="txtMsg" class="form-control" placeholder="Mô tả sản phẩm ..." 
                                        style="width: 100%; height: 150px;"  v-model="productObj.desc" ></textarea>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-1">
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
                                <input type="submit" value="Gửi yêu cầu" class="p-2"/>
                            </div>
                        </form>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
export default {
    props: ['ID'],
    name: "ProductNew",

    data() {
        return {
            productObj: { name: "" , desc: "", cat: ""},
            images: '',
            file: null,
        }
    },

    created() {
     
    },

    computed: {
        ...mapState(["user"]),
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

        async handleSubmit() {
            let ok = window.confirm("Yêu cầu sẽ được gửi cho cửa hàng! Tiếp tục?");
            if (ok) {
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
                    product_price: 0,
                    product_desc: this.productObj.desc,
                    product_category: this.productObj.cat,
                    product_src: urlimg,
                    product_mota : this.ID,
                    product_style: 'Món Tùy Chọn',
                }
                axios.post("/products", product);
                this.$emit('childEvent');
                let data1 = {
                    email: '',
                    title:`Đơn hàng #${this.ID} được yêu cầu cập nhật!`,
                    content: `Nội dung: Thêm mới sản phẩm yêu cầu ${this.productObj.name} vào đơn hàng.`,
                    auth: `Khách hàng `+this.user.user_name+`.`,
                }
                try {
                    axios.post(`/sendemail/request`,data1);
                } catch (error) {
                    console.error("Error Send email update:", error);
                }  
                this.productObj.name="";this.productObj.desc="";this.productObj.cat="";this.images="";this.file=null;
            }              
        },
    }
}
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
</style>