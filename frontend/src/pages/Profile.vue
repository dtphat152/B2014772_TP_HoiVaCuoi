<template>
    <vue-basic-alert :duration="300" :closeIn="2000" ref="alert" />
    <div class="" style="padding-left: 250px; padding-right: 250px;">
        <div class="heading">
                <h3 style="font-weight: 800;">Xin chào {{ this.user.user_name }}</h3><br>
        </div>

        <div class="row" >
            <div class="col-md-4 text-right" style="border-radius: 25px; overflow: hidden; background-color: #f2f2f2;">
                <div class="row justify-content-between py-3 pt-4" style="padding-bottom: 0px !important;">
                    <div v-if="this.user.user_status=='active'" class="col-1"><h4 style="text-align: center; font-weight: 900; color: #00FF7F;">{{ this.user.user_status }}</h4></div>
                    <div v-if="this.user.user_status=='blocked'" class="col-1"><h4 style="text-align: center; font-weight: 900; color: #DC143C;">{{ this.user.user_status }}</h4></div>
                    <div class="col-4 text-center">
                        <img :src="this.user.user_avt" alt="Mô tả hình ảnh" :style="{ width: '150px', heigth : '150px','border-radius': '50px',border: '5px solid #ffb3cc'}"/>
                    </div>
                    <div class="col-1 text-right pr-5">
                        <i class="fa fa-pencil-square" @click="showEdit()" aria-hidden="true" style="font-size: 25px; color: #FF7F50;"></i><br>
                        <i class="fa fa-plus-square pt-3" @click="showUpPost()" aria-hidden="true" style="font-size: 25px; color: #3CB371;"></i> <br>
                        <i class="fa-solid fa-file-invoice pt-3 ml-1" @click="showBill()" aria-hidden="true" style="font-size: 23px; color: #B0C4DE;"></i>
                        <i class="fa-solid fa-ticket  pt-3" @click="showVoucher()" style="font-size: 20px; color: #FFA500;"></i>
                        <i class="fa fa-home pt-3" @click="showView0()" aria-hidden="true" style="font-size: 22px; color: #48D1CC;"></i>
                    </div>
                </div>
                <input type="file" id="fileInputAvt" accept="image/*" @change="handleFileChange" style="display: none;">
                <i class="fa fa-camera" aria-hidden="true" @click="openFileInput" style="font-size: 23px; color: #b3b3b3; margin-right: 160px;"></i>
                <br> <br>
                <h1 class="text-center pb-3" style="font-weight: 900;">{{ this.user.user_name }}</h1>
                <br>
                <h4 class="text-center pb-1" style="text-transform: none; font-weight: 800; ">
                    {{ this.user.user_email }}
                </h4> 
                <br>
                <h4 class="text-center pb-1" style="text-transform: none; font-weight: 800; ">
                    {{ this.user.user_phone }}
                </h4>
                <br>
                <h4 class="text-center  pb-1" style="text-transform: none; font-weight: 800; ">
                    {{ this.user.user_address }}
                </h4>
                <br>
            </div>

            <div class="col-md-8">
                <div style="border-radius: 25px; background-color: #f2f2f2;padding-left: 10px; padding-bottom: 30px; min-height: 500px;">
                    <div v-if="view ==1 || view==2 " class="px-5 pt-5">
                        <form v-if="this.view!=2" action="" @submit.prevent="handleCheckEdit" novalidate autocomplete="off">
                            <h3 style="font-weight: 900;color: #d35ea4;">Nhập mật khẩu để tiếp tục!</h3>
                            <div class="form-group">
                                <input type="password" id="uPass" name="uPass" class="form-control"
                                    placeholder="Mật khẩu..." v-model="this.checkPass" />
                            </div>
                            <h5 v-if="this.errPass!=''" style="font-weight: 800; color: #FF0000;">{{ this.errPass }}</h5>
                            <div class="form-group">
                                <input type="submit" value="Tiếp Tục" class="p-3 mt-2" 
                                    style="background-color: #ef87aa; border-radius: 15px; font-weight: 900; font-size: 15px;" />
                            </div>
                        </form>
                        <div v-if="this.view==2">
                        <form id="editForm" @submit.prevent="handleEditSubmit" novalidate autocomplete="off">
                            <h3 style="font-weight: 900;color: #d35ea4;">Chỉnh Sửa Tài Khoản</h3>
                            <div class="form-group">
                                <input type="text" name="uName" placeholder="Họ Và Tên" id="uName" class="form-control"
                                    v-model="user.user_name" />
                            </div>
                            <div class="form-group">
                                <input type="email" name="uEmail" placeholder="example@gmail.com" id="uEmail" class="form-control"
                                    v-model="user.user_email" />
                                <p class="error-mess" v-if="errorObj.emailErr.length > 0">{{ errorObj.emailErr[0] }}</p>
                            </div>
                            <div class="form-group">
                                <input type="text" name="uPass" placeholder="Lớn hơn hoặc bằng 8 kí tự và phải có ít nhất một kí tự đặc biệt" id="uPass"
                                    class="form-control" v-model="checkPass" />
                                <!-- <p class="error-mess" v-if="errorObj.passErr.length > 0">{{ errorObj.passErr[0] }}</p> -->
                            </div>
                            <div class="form-group">
                                <input type="tel" name="uPhone" placeholder="vd: 0987654321" id="uPhone"
                                    class="form-control" v-model="user.user_phone" />
                                <p class="error-mess" v-if="errorObj.phoneErr.length > 0">{{ errorObj.phoneErr[0] }}</p>
                            </div>
                            <div class="form-group">
                                <textarea type="text" name="uAddress" placeholder="Địa chỉ của bạn" id="uAddress"
                                    class="form-control" v-model="user.user_address" ></textarea>
                            </div>
                            <div class="form-group">
                                <input type="submit" value="Cập Nhật" class="p-3 mt-2" 
                                    style="background-color: #ef87aa; border-radius: 15px; font-weight: 900; font-size: 15px;" />
                            </div>
                        </form>
                        </div>
                    </div>

                    <div v-if="view==3" class="pr-3">
                        <div class="row justify-content-between">
                            <div class="col-2"></div>
                            <div class="col-8"><h2 class="text-center" style="font-weight: 900;">Cản Nhận Của Bạn Ra Sao</h2></div>
                            <div class="col-1 text-right" style="padding-top: 13px;">
                                <button v-if="caption!='' || images!=''" @click="submitPost()" class="btn px-3" style="background-color: #3CB371;border-radius: 10px;font-weight: 900;">
                                    Post
                                </button>
                            </div>
                            <input type="file" id="fileInputImage" accept="image/*" ref="fileInput" @change="handleImageChange" style="display: none;">
                            <div class="col-1"><i class="fa fa-camera-retro text-right pt-3" @click="openPostImage" style="font-size: 30px; color: #ffccdd;" aria-hidden="true"></i></div>
                        </div>
                        <div class="row">
                            <div class="col-8 p-2 pl-5">
                                <textarea name="txtMsg" class="form-control" placeholder="Tôi cảm thấy . . . " 
                                    v-model="caption" ></textarea> 
                            </div>
                            <div class="col-4 pt-4">
                                <div class="" style="overflow-y: auto; height: 88px; ">
                                    <div style="width: 90%; margin-left: 4%;">
                                        <div v-for="(b, index) in billList.slice().reverse()" :key="index">
                                            <button style="width: 100%;border-radius: 10px;" @click="addDate(b.bill_date )">
                                                <h5 style=" font-weight: 900; text-align: center; background-color: #ffccdd; border-radius: 10px; padding: 5px;">{{ b.bill_date }}</h5>
                                            </button>
                                            <button  style="width: 100%;border-radius: 10px;" @click="addAddress(b.bill_address)">
                                                <h5 style=" font-weight: 900; text-align: center; background-color: #ffccdd; border-radius: 10px; padding: 5px;">{{ b.bill_address }}</h5>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div v-if=" caption!='' || images!='' " class="PostCard p-3" style="background-color: #ffccdd; border-radius: 20px;">
                            <div class="row">
                                <div class="col-1 ml-4" style="padding-left: 0 !important;">
                                    <img :src="this.user.user_avt" :style="{ width: '100%', heigth : '100%','border-radius': '50px',border: '5px solid #ffb3cc'}"/>
                                </div>
                                <div class="col-9 pt-1" style="padding-left: 0 !important;">
                                    <h1 style="font-weight: 900;">{{ this.user.user_name }}</h1>
                                    <h5 style="font-weight: 800;">hh/mm - dd/mm/yyyy</h5>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12 px-5 py-1">
                                    <h3 style="font-weight: 800;">{{ this.caption }}</h3>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12 px-5">
                                    <h4 v-if="this.postDate!=''&& this.postAddress!=''" style="font-weight: bold;">#{{ this.postDate }}  tại {{ this.postAddress }}</h4>
                                    <h4 v-if="this.postDate!=''&& this.postAddress==''" style="font-weight: bold;">#{{ this.postDate }}</h4>
                                    <h4 v-if="this.postDate==''&& this.postAddress!=''" style="font-weight: bold;">tại {{ this.postAddress }}</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12 px-5">
                                    <img v-if="images.length > 0" :src="images" alt="Selected image" style="width: 100%; border-radius: 10px;">
                                </div>
                            </div>
                        </div>                        
                    </div>
                    <div v-if="view==0" class="pr-5 pt-5 pl-5">
                        <div v-for="(p, index) in postList.slice().reverse()" :key="index">
                            <div class="PostCard p-3" style="background-color: #ffccdd; border-radius: 20px;">
                                <div class="row">
                                    <div class="col-1 ml-4" style="padding-left: 0 !important;">
                                        <img :src="p.post_user_avt" :style="{ width: '100%', heigth : '100%','border-radius': '50px',border: '5px solid #ffb3cc'}"/>
                                    </div>
                                    <div class="col-9 pt-1" style="padding-left: 0 !important;">
                                        <h1 style="font-weight: 900;">{{ p.post_user_name }}</h1>
                                        <h5 style="font-weight: 800;">{{p.post_when}}</h5>
                                    </div>
                                    <div class="col-1 text-right pt-2">
                                        <i v-if="p.post_hide==0" @click="hidePost(postList.length-index-1)" class="fa fa-lock" aria-hidden="true" style="font-size: 25px;"></i>
                                        <i v-if="p.post_hide!=0" @click="hidePost(postList.length-index-1)" class="fa fa-unlock-alt" aria-hidden="true" style="font-size: 25px;"></i>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12 px-5 py-1">
                                        <h3 style="font-weight: 800;">{{ p.post_cap }}</h3>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12 px-5">
                                        <h4 style="font-weight: bold;">{{ p.post_info }}</h4>
                                    </div>
                                </div>
                                <div class="row" v-if="p.post_img!=''">
                                    <div class="col-12 px-5">
                                        <img :src="p.post_img" alt="Selected image" style="width: 100%; border-radius: 10px;">
                                    </div>
                                </div>
                            </div> 
                            <br> <br>    
                        </div>
                    </div>
                    <div v-if="view==4">
                        <h2 class="text-center" style="font-weight: 900;">Your Voucher List</h2>
                        <div class="row justify-content-center">
                            <div class="col-8" v-for="(v, index) in voucherList.slice().reverse()" :key="index">
                                <div class="voucher row mt-5" style="background-color: #ffccdd;">
                                    <div class="col-2">
                                        <div class="row">
                                            <div class="col-10" style="background-color: #f2f2f2; border-top-right-radius: 20px;border-bottom-right-radius: 20px ;"><h1 style="color: #f2f2f2;">.</h1></div>
                                        </div>
                                        <div class="row">
                                            <div class="col-8" style="background-color: #f2f2f2;"><h3 style="color: #f2f2f2;">.</h3></div>
                                        </div>
                                        <div class="row">
                                            <div class="col-10" style="background-color: #f2f2f2; border-top-right-radius: 20px;border-bottom-right-radius: 20px ;"><h1 style="color: #f2f2f2;">.</h1></div>
                                        </div>
                                    </div>
                                    <div class="col-8">
                                        <h3 class="text-center" style="font-weight: 900; color: #ff667d;">TP-Voucher</h3>
                                        <h1 class="text-center" style="font-weight: 900;">{{ formatCurrency(v.voucher_value) }}</h1>
                                        <h3 v-if="v.voucher_status==1" class="text-center" style="font-weight: 900; color: #2E8B57;">Chưa sử dụng</h3>
                                        <h3 v-if="v.voucher_status==2" class="text-center">Đang sử dụng</h3>
                                        <h3 v-if="v.voucher_status==0" class="text-center">Đã sử dụng</h3>
                                    </div>
                                    <div class="col-2">
                                        <div class="row">
                                            <div class="col-10 offset-2" style="background-color: #f2f2f2; border-top-left-radius: 20px;border-bottom-left-radius: 20px ;"><h1 style="color: #f2f2f2;">.</h1></div>
                                        </div>
                                        <div class="row">
                                            <div class="col-8 offset-4" style="background-color: #f2f2f2;"><h3 style="color: #f2f2f2;">.</h3></div>
                                        </div>
                                        <div class="row">
                                            <div class="col-10 offset-2" style="background-color: #f2f2f2; border-top-left-radius: 20px;border-bottom-left-radius: 20px ;"><h1 style="color: #f2f2f2;">.</h1></div>
                                        </div>
                                    </div>
                                </div>
                                <br> <br>
                            </div>
                        </div>
                    </div>
                    <div v-if="view==5">
                        <h2 class="text-center" style="font-weight: 900;">Bill List</h2> <br>
                        <div class="" style="overflow-y: auto; height: 380px;">
                            <div style="width: 90%; margin-left: 4%;">
                                <div v-for="(b, index) in billList.slice().reverse()" :key="index">
                                    <div class="row" 
                                    :style="{ 
                                        'background-color': '#ffb3cc', 
                                        'margin-left': '10px', 
                                        'border-radius': '25px', 
                                        'padding': '5px'
                                    }">
                                    <div class="col-12">
                                        <div class="row justify-content-between">
                                            <div class="col-3">
                                                <h4 style=" font-weight: 900;">Bill #{{ b.bill_id }}</h4> 
                                            </div>
                                            <div class="col-4 text-center" style="">
                                                <h3 v-if="b.bill_status==0" style=" font-weight: 900; color: #FF0000;">Đã Hủy</h3>
                                                <h3 v-if="b.bill_status==1" style=" font-weight: 900; color: #6A5ACD;">Chờ Xác Nhận</h3>
                                                <h3 v-if="b.bill_status==2" style=" font-weight: 900; color: #6A5ACD;">Chờ Thanh Toán Cọc</h3>
                                                <h3 v-if="b.bill_status==3" style=" font-weight: 900; color: #3CB371;">Đang Thực Hiện</h3>
                                                <h3 v-if="b.bill_status>=4" style=" font-weight: 900; color: #1E90FF;">Đã Hoàn Thành</h3>
                                            </div>
                                            <div class="col-3 text-right">
                                                <h4 style=" font-weight: 900;">{{ b.bill_when }}</h4> 
                                            </div>
                                        </div>
                                        <hr style="width: 80%; margin-left: 10%;">
                                        <div class="row justify-content-center">
                                            <div class="col-5 text-center">
                                                <h5 style=" font-weight: 900;">Ngày Tổ Chức: {{ b.bill_date }}</h5>
                                            </div> 
                                        </div>
                                        <div class="row justify-content-between">
                                            <div class="col-3"></div>
                                            <div class="col-4 text-center" style="">
                                                <h5 v-if="b.bill_status" style=" font-weight: 900;">{{ b.bill_address }}</h5>
                                                <h4 v-if="b.bill_status" style=" font-weight: 900;">{{ formatCurrency(b.bill_total) }}</h4>
                                            </div>
                                            <div class="col-3 text-right"></div>
                                        </div>
                                    </div>
                                    </div>
                                    <br>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
      

</template>

<script>
import VueBasicAlert from 'vue-basic-alert';
import { mapState } from "vuex";
import axios from "axios";
export default {
    name: "Profile",

    data() {
        return {
            postList: [],
            billList: [],
            voucherList: [],
            view: 0,
            checkPass: '',
            errPass: '',
            errorObj: { emailErr: [], phoneErr: [],  },
            caption:'',
            postDate: '',
            postAddress: '',
            images: '',
            file: null,
            selectedFile: null,
        }
    },

    computed: {
        ...mapState(["user"]),
    },

    created() {
        this.getAllBillInfo()
        this.getAllPost()
    },

    watch: {
        selectedFile :{
            handler: 'upload'
        }
    },

    methods: {
        showVoucher(){
            if (this.view==4) this.view=0 
            else {
                this.view = 4;
                this.getVoucher();
            }
        },
        async getVoucher(){
            try {
                let rsp = await axios.get(`/voucher/user/${this.user.user_id}`);
                this.voucherList = rsp.data.map(voucher => ({
                    voucher_id : voucher.vc_id,
                    voucher_value: voucher.vc_value,
                    voucher_status: voucher.vc_status,
                }));
                console.log(this.voucherList)
            } catch (error) {
                console.error('Error while get Voucher:', error);
            }
        },
        formatCurrency(amount) {
          if (!amount) return '';
          return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
        },

        showView0(){
            this.view = 0;
            this.getAllBillInfo()
            this.getAllPost()
        },
        showBill(){
            if (this.view==5) this.view=0 
            else {
                this.view = 5;
                this.getAllBillInfo();
            }
        },

        async getAllPost(){
            try {
                let rsp = await axios.get(`/post/${this.user.user_id}`);
                this.postList = rsp.data.map(post => ({
                    post_id : post.post_id,
                    post_user_avt: post.user_avt,
                    post_user_name: post.user_name,
                    post_when : post.post_when,
                    post_cap : post.caption,
                    post_info : post.info,
                    post_img : post.image,
                    post_hide : post.hide,
                }));
            } catch (error) {
                console.error('Error while fetching bill info:', error);
            }
        },
        async hidePost(index){
            if(this.postList[index].post_hide == 0) {
                let data = {
                    caption: this.postList[index].post_cap,
                    hide: 1
                }
                await axios.put(`/post/${this.postList[index].post_id}`,data)
                this.postList[index].post_hide = 1
            } else if(this.postList[index].post_hide == 1) {
                let data = {
                    caption: this.postList[index].post_cap,
                    hide: 0
                }
                await axios.put(`/post/${this.postList[index].post_id}`,data)
                this.postList[index].post_hide = 0
            } else this.$refs.alert.showAlert('warning', 'Xin lỗi!', 'Bạn không thể bỏ ẩn bài đăng này!')
        },
        async showUpPost(){
            let check = false
            for (let index = 0; index < this.billList.length; index++) {
                if (this.billList[index].bill_status>=4) {
                    check = true
                }  
            }
            let rsp = await axios.get(`/users/byid/${this.user.user_id}`)
            let status = rsp.data.user_status
            if (check && status=='active') {
                console.log(this.user.user_status)
                if (this.view==3) this.view=0 
                else this.view = 3;
            } else this.$refs.alert.showAlert('warning', 'Xin lỗi!', 'Bạn chưa thể Chia sẻ cảm xúc!')
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
        addDate(date){
            if(this.postDate=='') this.postDate = date;
            else this.postDate='';
        },
        addAddress(address){
            if(this.postAddress=='') this.postAddress = address;
            else this.postAddress='';
        },
        async getAllBillInfo(){
            try {
                let rsp = await axios.get(`/users/allbill/${this.user.user_id}`);
                this.billList = rsp.data.map(bill => ({
                    bill_id: bill.bill_id,
                    bill_address: bill.bill_address,
                    bill_when: bill.bill_when,
                    bill_discount: bill.bill_discount,
                    bill_total: bill.bill_total,
                    bill_status : bill.bill_status,
                    date_id : bill.date_id,
                    bill_date : this.formatDate(bill.date_date),
                }));
            } catch (error) {
                console.error('Error while fetching bill info:', error);
            }
        },
        formatDate(dateString) {
            const parts = dateString.split("-");
            const year = parseInt(parts[2]);
            const month = parseInt(parts[0]); 
            const day = parseInt(parts[1]);
            return `${day}/${month}/${year}`;
        },
        async submitPost(){
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
            var now = new Date();
            var day = ("0" + now.getDate()).slice(-2);
            var month = ("0" + (now.getMonth() + 1)).slice(-2);
            var hour = ("0" + (now.getHours())).slice(-2);
            var min = ("0" + (now.getMinutes())).slice(-2);
            var currentTime = hour + ":" + min +  " - " + day + "/" + month + "/" + now.getFullYear() ;
            let data = {
                user_id : this.user.user_id,
                caption : this.caption,
                hide: 0,
                info : '#'+this.postDate+' tại '+this.postAddress,
                image : urlimg,
                post_when: currentTime
            }
            // console.log('DATA: ',data);
            await axios.post(`/post`,data);
            this.caption=''; this.postDate=''; this.postAddress=''; this.images='';
        },

        async handleCheckEdit(e){
            e.preventDefault();
            let data = await axios.get('/users/' + this.user.user_email);
            let password = data.data.user_password;
            if (this.checkPass==password) this.view=2;
            else if(this.checkPass=='') {
                this.errPass = 'Vui lòng nhập Mật Khẩu!';
                this.$refs.alert.showAlert('warning', 'Xin lỗi!', 'Mật Khẩu Không được bỏ trống!')
            }
            else {
                this.errPass = 'Mật Khẩu Không Đúng! Vui lòng nhập lại!';
                this.$refs.alert.showAlert('warning', 'Xin lỗi!', 'Mật Khẩu Không Đúng!')
            }
            console.log("this.view",this.view)
        },
        async showEdit(){
            if (this.view==1 || this.view==2) this.view=0 
            else this.view = 1;
        },
        resetCheckErr: function () {
            this.errorObj.emailErr = [];
            this.errorObj.phoneErr = [];
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
            // Email validate
            if (!this.user.user_email) {
                this.errorObj.emailErr.push("Email Không Được Bỏ Trống");
            }
            else {
                if (!/[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$/.test(this.user.user_email)) {
                    this.errorObj.emailErr.push('Email Không Hợp Lệ');
                }
            }
            // Phone validate
            if (!this.user.user_phone) {
                this.errorObj.phoneErr.push('Số Điện Thoại Không Được Bỏ Trống');
            }
            else {
                if (!this.user.user_phone.startsWith('0')) {
                    this.errorObj.phoneErr.push('Số Điện Thoại Không Hợp Lệ');
                }
                if (this.user.user_phone.length != 10) {
                    this.errorObj.phoneErr.push('Số điện thoại phải có chính xác 10 chữ số');
                }
            }            
        },
        async handleEditSubmit(e) {
            e.preventDefault();
            this.checkForm();
            if (!this.checkEmptyErr()) {
                e.preventDefault();
            } else {
                let data = {
                    user_name: this.user.user_name,
                    user_email: this.user.user_email,
                    user_password: this.checkPass,
                    user_phone: this.user.user_phone,
                    user_address: this.user.user_address,
                    user_id: this.user.user_id
                }
                console.log(data)
                await axios.put("/users/", data);
                this.showEdit();
                this.$refs.alert.showAlert('success', 'Thành công!', 'Thông tin được thay đổi!')
            }
        },

        handleFileChange(event) {
            this.selectedFile = event.target.files[0];
        },
        openFileInput() {
            document.getElementById('fileInputAvt').click();
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
        async upload() {
            let rsp = await axios.get(`/users/byid/${this.user.user_id}`);
            console.log(this.user.user_id);
            let pic = rsp.data.user_avt;
            console.log(pic);
            if (pic != `http://localhost:8081/uploads/image-1713705036580.jpg`) {
                this.delete(pic);
            }
            const formData = new FormData();
            formData.append('image', this.selectedFile);
            console.log('selectedFile: ',  this.selectedFile);
            console.log('formData: ',  formData);
            let id = this.user.user_id;
            try {
            const response = await axios.post(`/uploading/useravt/${id}`, formData, {
                headers: {
                'Content-Type': 'multipart/form-data'
                }
            });
            console.log('Image uploaded successfully:', response.data);
            this.user.user_avt = response.data;
            } catch (error) {
            console.error('Error uploading image:', error);
            }
        },
    },
    components: {
        VueBasicAlert
    }
};
</script>

<style scoped>


form {
    width: 100%;
    background: #ffb3cc; 
    opacity: 0.8;
    /* box-shadow: 0 1rem 1rem rgba(0, 0, 0, 0.05); */
    /* border: 0.1rem solid rgba(0, 0, 0, 0.2); */
    padding: 2rem;
    padding-bottom: 5px;
    border-radius: 15px;
    animation: fadeUp 0.4s linear;
}

 form h3 {
    padding-bottom: 1rem;
    font-size: 2rem;
    text-transform: uppercase;
    color: #130f40;
    margin: 0;
}

 form .form-control {
    margin: 0.7rem 0;
    border-radius: 15px;
    background: #f2f2f2;
    padding: 2rem 1.2rem;
    font-size: 1.6rem;
    color: black;
    font-weight: 900;
    text-transform: none;
    width: 100%;
    border: none;
}

 form label {
    font-size: 2rem;
    margin: 0;
    padding: 0;
}

textarea{
    margin: 0.7rem 0;
    border-radius: 20px;
    background: #ffccdd;
    padding: 2rem 1.2rem;
    font-size: 1.6rem;
    color: black;
    font-weight: 900;
    text-transform: none;
    width: 100%;
    border: none;
}

</style>
