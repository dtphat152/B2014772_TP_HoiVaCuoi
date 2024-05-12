<template>
    <div class=" py-3">
        <div class="">
            <div class=" row d-flex justify-content-between">
                <div class="col-2"> <slot></slot> </div>
            </div>
            
            <div class="mt-3" style="overflow-y: auto; height: 543px; padding: 20px; background-color: #ef87aa; border-radius: 20px;">
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
                                    <input type="text"  placeholder="Giá sản phẩm" class="form-control " autocapitalize="off" v-model="productObj.price" />
                                </div>
                                <div class="form-group">
                                    <textarea name="txtMsg" class="form-control" placeholder="Mô tả sản phẩm ..." 
                                        style="width: 100%; height: 150px;"  v-model="productObj.desc" ></textarea>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-2">
                                            <input type="file" id="fileInputImage" accept="image/*" ref="fileInput" @change="handleImageChange" style="display: none;">
                                            <div class="col-1"><i class="fa fa-camera-retro text-center" @click="openPostImage" style="font-size: 30px; color: black;" aria-hidden="true"></i></div>
                                            <input type="submit" value="Xác Nhận" class="p-2 mt-3"/>
                                        </div>
                                        <div class="col-4">
                                            <img v-if="images.length > 0" :src="images" alt="Selected image" style="width: 100%; border-radius: 10px;">
                                        </div>
                                    </div>   
                                </div>
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
            productObj: { id: "", name: "" , desc: "", cat: "", price: "", src: ""},
            images: '',
            file: null,
        }
    },

    created() {
        this.getProdductNew();
    },

    computed: {
        ...mapState(["user"]),
    },


    methods: {

        formatCurrency(amount) {
          if (!amount) return '';
          return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
        },

        async getProdductNew() {
            let rsp = await axios.get(`/products/mota/${this.ID[0]}`)
            let data = rsp.data;
            this.productObj.id = data.product_id;
            this.productObj.name = data.product_name;
            this.productObj.desc = data.product_desc;
            this.productObj.cat = data.product_category;
            this.images = data.product_src;
            this.productObj.src = data.product_src;
            console.log(this.productObj);
        },

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

        async delete(pic) {
            try {
                let path = pic.substring(pic.indexOf('/uploads'));
                let basePath = 'D://Luan_Van//TP_HoiVaCuoi//backend';
                let absolutePath = basePath.concat(path);
                console.log(absolutePath);
                let data = { old: absolutePath };
                await axios.put(`/uploading/useravt`, data);
                
            } catch (error) {
                console.error('Error updating user avatar:', error);
            }
        },

        async handleSubmit() {
            let confirmResult = window.confirm(`Nội dung: Thêm mới ${this.productObj.name} với giá ${this.formatCurrency(this.productObj.price)} vào đơn hàng #${this.ID[0]} với số lượng ${this.ID[2]}?`);
            if (confirmResult && this.productObj.price!='') {
                if (this.productObj.src!=this.images) {
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
                        this.delete(this.productObj.src);
                        this.productObj.src = urlimg;
                    }
                }
                
                let product = {
                    product_name: this.productObj.name,
                    product_price: this.productObj.price,
                    product_desc: this.productObj.desc,
                    product_category: this.productObj.cat,
                    product_src: this.productObj.src,
                    product_mota: '',
                    product_style: 'Món Tùy Chọn',
                }
                axios.put(`/products/${this.productObj.id}`, product);
                let billDetails = {
                    bill_id: parseInt(this.ID[0]),
                    product_id: parseInt(this.productObj.id),
                    item_qty: parseInt(this.ID[2])
                };
                try {
                    await axios.post("/billdetails", billDetails);
                    let billdata = { 
                        bill_total: this.ID[3] + parseInt(this.productObj.price*this.ID[2]),
                    };
                    await axios.put(`/billstatus/billtotal/${this.ID[0]}`, billdata);
                    this.$emit('childEvent');
                    let data1 = {
                        email: this.ID[1],
                        title:`Đơn hàng #${this.ID[0]} của bạn đã được cập nhật!`,
                        content: `Nội dung: Thêm mới ${this.productObj.name} với giá ${this.formatCurrency(this.productObj.price)} vào đơn hàng của bạn với số lượng ${this.ID[2]}.`,
                    }
                    try {
                        console.log(data1)
                        axios.post(`/sendemail/update`,data1);
                    } catch (error) {
                        console.error("Error Send email update:", error);
                    }     

                } catch (error) {
                    console.error("Error updating bill total:", error);
                }  
            } else window.confirm('Hãy Thử Lại')
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
  border-radius: 20px; /* Bo viền để làm mềm hơn */
}
</style>