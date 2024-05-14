<template>
    <div class="container_order">
        <div class="row p-5" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; margin: 0 1px;">
            <h1>User Manager</h1>
        </div>
        <br>
        <div class="p-5" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; height: 785px;">
           <div v-if="selectedRow!=-1" class="row">
                <div class="col-9 p-3">
                    <div style="border-radius: 20px; background-color: white; height: 720px;">
                        <!-- Display user details here -->
                        <div v-if="selectedUser">
                            <div class="row justify-content-between py-3">
                                <div v-if="selectedUser.user_status=='active'" class="col-1"><h4 style="text-align: center; font-weight: 900; color: #00FF7F;">{{ selectedUser.user_status }}</h4></div>
                                <div v-if="selectedUser.user_status=='blocked'" class="col-1"><h4 style="text-align: center; font-weight: 900; color: #DC143C;">{{ selectedUser.user_status }}</h4></div>
                                <div class="col-2 text-center">
                                    <img :src="selectedUser.user_avt" alt="Mô tả hình ảnh" :style="{ width: '70%', 'border-radius': '50px'}"/>

                                </div>
                                <div class="col-1 text-right pr-5">
                                    <i class="fa fa-pencil-square" @click="showEdit()" aria-hidden="true" style="font-size: 25px; color: #FF7F50;"></i><br>
                                    <input type="file" id="fileInputAvt" accept="image/*" @change="handleFileChange" style="display: none;">
                                    <i class="fa fa-camera pt-3" aria-hidden="true" @click="openFileInput" style="font-size: 23px; color: #FFD700;"></i><br>
                                    <i v-if="selectedUser.user_status=='active'" @click="blockUser(selectedUser.user_id)" class="fa fa-lock pt-3" aria-hidden="true" 
                                        style="font-size: 23px; color: #DC143C;"></i>
                                    <i v-if="selectedUser.user_status=='blocked'" @click="unBlockUser(selectedUser.user_id)" class="fa fa-unlock-alt pt-3" aria-hidden="true" style="font-size: 23px; color: #00FF7F;"></i>
                                    <br>
                                    <i class="fa-solid fa-ticket pt-3" @click="showVoucher()" aria-hidden="true" style="font-size: 19px; color: #48D1CC;"></i>
                                </div>
                            </div>
                            <h2 class="text-center pb-3" style="font-weight: 900;">{{ selectedUser.user_name }}</h2>
                            <h4 class="text-center pb-1" style="text-transform: none; font-weight: 800; ">
                                <i class="fa fa-envelope" aria-hidden="true"></i> 
                                {{ selectedUser.user_email }}
                                <a :href="`https://mail.google.com/mail/?view=cm&fs=1&to=${selectedUser.user_email}`" target="_blank"> 
                                    <i class="fa fa-share" aria-hidden="true" style="color: black;"></i>
                                </a>
                            </h4>
                            <h4 class="text-center pb-1" style="text-transform: none; font-weight: 800; ">
                                <i class="fa fa-phone-square" aria-hidden="true"></i>
                                {{ selectedUser.user_phone }}
                            </h4>
                            <h4 class="text-center  pb-1" style="text-transform: none; font-weight: 800; ">
                                <i class="fa fa-map" aria-hidden="true"></i>
                               {{ selectedUser.user_address }}
                            </h4>
                            <hr style="width: 80%; margin-left: 10%;">
                            <!-- Hiển thị các thông tin khác về người dùng -->
                            <div v-if="view==1">
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
                            <div v-if="view==2" class="px-5">
                                <form id="editForm" @submit.prevent="handleEditSubmit" novalidate autocomplete="off">
                                    <h3 style="font-weight: 900;color: #d35ea4;">Chỉnh Sửa Tài Khoản</h3>
                                    <div class="form-group">
                                        <input type="text" name="uName" placeholder="Họ Và Tên" id="uName" class="form-control"
                                            v-model="selectedUser.user_name" />
                                    </div>
                                    <div class="form-group">
                                        <input type="email" name="uEmail" placeholder="example@gmail.com" id="uEmail" class="form-control"
                                            v-model="selectedUser.user_email" />
                                        <p class="error-mess" v-if="errorObj.emailErr.length > 0">{{ errorObj.emailErr[0] }}</p>
                                    </div>
                                    <div class="form-group">
                                        <input type="tel" name="uPhone" placeholder="vd: 0987654321" id="uPhone"
                                            class="form-control" v-model="selectedUser.user_phone" />
                                        <p class="error-mess" v-if="errorObj.phoneErr.length > 0">{{ errorObj.phoneErr[0] }}</p>
                                    </div>
                                    <div class="form-group">
                                        <textarea type="text" name="uAddress" placeholder="Địa chỉ của bạn" id="uAddress"
                                            class="form-control" v-model="selectedUser.user_address" ></textarea>
                                    </div>
                                     <div class="form-group">
                                        <input type="submit" value="Cập Nhật" class="p-3 mt-2" 
                                            style="background-color: #ef87aa; border-radius: 15px; font-weight: 900; font-size: 15px;" />
                                    </div>
                                </form>
                            </div>
                            <div v-if="view==3">
                            <div class="row mx-5">
                                <div class="col-8 p-3 offset-2" style="background-color: #e6e6e6; border-radius: 20px;">
                                    <h2 class="text-center" style="font-weight: 900; color: #228B22;">Voucher Value</h2>
                                    <br>
                                    <h4 class="text-center" style="font-weight: 800;">Giá trị voucher gửi tặng khách hàng</h4>
                                    <input type="number" v-model="this.value" class="text-center" style="width: 40%; margin-left: 30%; border-radius: 15px; font-size: 20px;"><br><br>
                                    <h4 v-if="this.value!=''" class="text-center" style="font-weight: 800; color: #228B22;">( {{ formatCurrency(this.value) }} )</h4>
                                    <button class="btn" @click="giveVoucher()" 
                                        style="width: 20%; margin-left: 40%; background-color: #ffb3cc; border-radius: 10px; font-weight: 800;">Give</button>
                                </div>
                                <div class="col-2"></div>
                            </div>
                            <br><hr style="width: 60%; margin-left: 20%;">
                            <div class="row justify-content-center">
                                <div v-if="voucherList.length==0"><h3 style="font-weight: 800; color: red; padding-top: 10px;">Không có voucher nào cả</h3></div>
                                <div v-else class="col-10" >
                                    <h3 style="font-weight: 800; color: black; padding-top: 10px; text-align: center;">Danh sách các voucher của khách hàng</h3>
                                    <div v-for="(v, index) in voucherList.slice().reverse()" :key="index">
                                        <div class="voucher row mt-3" style="background-color: #ffccdd; border-radius: 15px;">
                                            <div class="col-5">
                                                <h5 class="text-center" style="font-weight: 900; color: #ff667d;">TP-Voucher</h5>
                                                <h5 v-if="v.voucher_status==1" class="text-center" style="font-weight: 900; color: #2E8B57;">Chưa sử dụng</h5>
                                                <h5 v-if="v.voucher_status==2" class="text-center" style="font-weight: 900;">Đang sử dụng</h5>
                                                <h5 v-if="v.voucher_status==0" class="text-center" style="font-weight: 900;">Đã sử dụng</h5>
                                            </div>
                                            <div class="col-5 pt-3">
                                                <h3 class="text-center" style="font-weight: 900;">{{ formatCurrency(v.voucher_value) }}</h3>
                                            </div>
                                            <div class="col-2" style="padding-top: 5px;">
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
                <div class="col-3 p-3">
                    <div style="border-radius: 20px; background-color: white; height: 720px;">
                        <h2 class="text-center" style="font-weight: 900;">User List</h2>
                        <br><hr style="width: 80%; margin-left: 10%;">
                        <div class="" style="overflow-y: auto; height: 640px; ">
                            <div style="width: 95%;">
                                <div v-for="(u, index) in userList" :key="index">
                                    <div class="row" @click="showDetails(u,index)" 
                                    :style="{ 
                                        'background-color': selectedRow === index ? '#ff80aa' : '#ffb3cc', 
                                        'margin-left': '10px', 
                                        'border-radius': '25px', 
                                        'padding': '5px'
                                    }">
                                        <div class="col-3">
                                            <img :src="u.user_avt" 
                                            :style="{ width: '100%', 'border-radius': '30px'}"/> 
                                            
                                        </div>
                                        <div class="col-8 pl-0 pt-2">
                                            <h3 style=" font-weight: 900;">{{ u.user_name }}</h3> 
                                            <h5 style="text-transform: none;">{{ u.user_email }}</h5>
                                        </div>
                                        <div class="col-1 align-content-center" style="">
                                            <i class="fa fa-caret-right" aria-hidden="true" style="font-size: 15px;"></i>
                                        </div>
                                    </div>
                                    <br>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
           </div>
           <div v-else class="row justify-content-center">
                <div class="col-10 p-5">
                    <div style="border-radius: 20px; background-color: white; height: 680px;">
                        <h2 class="text-center" style="font-weight: 900;">User List</h2>
                        <br><hr style="width: 80%; margin-left: 10%;">
                        <div class="" style="overflow-y: auto; height: 600px; ">
                            <div style="width: 90%; margin-left: 5%;">
                                <div v-for="(u, index) in userList" :key="index">
                                    <div class="row justify-content-center" @click="showDetails(u,index)" 
                                    :style="{ 
                                        'background-color': selectedRow === index ? '#ff80aa' : '#ffb3cc', 
                                        'margin-left': '10px', 
                                        'border-radius': '25px', 
                                        'padding': '5px'
                                    }">
                                        <div class="col-1">
                                            <img :src="u.user_avt" 
                                            :style="{ width: '100%', 'border-radius': '30px'}"/> 
                                        </div>
                                        <div class="col-8 pl-0 pt-3">
                                            <h3 style=" font-weight: 900;">{{ u.user_name }}</h3> 
                                            <h5 style="text-transform: none;">{{ u.user_email }}</h5>
                                        </div>
                                        <div class="col-1 align-content-center" style="">
                                            <i class="fa fa-caret-right" aria-hidden="true" style="font-size: 15px;"></i>
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
import axios from "axios";
export default {
    name: 'UserManager',

    data() {
        return {
           userList: [],
           selectedUser: null,
           selectedRow: -1,
           view: 1,
           errorObj: { emailErr: [], phoneErr: [],  },
           selectedFile: null,
           billList: [],
           voucherList: [],
           value: ''
        }
    },

    created() {
        this.getUserList(); 
    },

    watch: {
        selectedFile :{
            handler: 'upload'
        }
    },

    methods: {
        formatCurrency(amount) {
            if (!amount) return '';
            return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
        },

        async getUserList() {
            try {
                let rsp = await axios.get(`/users/all`);
                this.userList = rsp.data.map(user => ({
                    user_id: user.user_id,
                    user_name: user.user_name,
                    user_email: user.user_email,
                    user_phone: user.user_phone,
                    user_password: user.user_password,
                    user_address: user.user_address,
                    user_avt : user.user_avt,
                    user_status : user.user_status,
                }));
                console.log('user: ',this.userList)
            } catch (error) {
                console.error('Error while fetching users:', error);
            }
        },

        async getAllBillInfo(user_id){
            try {
                let rsp = await axios.get(`/users/allbill/${user_id}`);
                this.billList = rsp.data.map(bill => ({
                    bill_id: bill.bill_id,
                    bill_address: bill.bill_address,
                    bill_when: bill.bill_when,
                    bill_discount: bill.bill_discount,
                    bill_total: bill.bill_total,
                    bill_status : bill.bill_status,
                    date_id : bill.date_id,
                    bill_date : bill.date_date,
                }));
            } catch (error) {
                console.error('Error while fetching bill info:', error);
            }
        },

        async getVoucher(user_id){
            try {
                let rsp = await axios.get(`/voucher/user/${user_id}`);
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

        showDetails(user,index) {
            this.selectedUser = user;
            this.selectedRow = index;
            this.getAllBillInfo(this.selectedUser.user_id);
            this.getVoucher(this.selectedUser.user_id);
        },

        showEdit(){
            if (this.view == 2) this.view = 1
            else this.view = 2;
        },
        
        showVoucher(){
            if (this.view == 3) this.view = 1
            else this.view = 3;
        },
        async giveVoucher() {
            let ok = window.confirm(`Xác nhận tặng voucher trị giá ${this.formatCurrency(this.value)} cho khách hàng`)
            if (ok) {
                let voucher = {
                    user_id: this.selectedUser.user_id,
                    vc_value: this.value,
                    vc_status:1
                }
                console.log("VC: ",voucher)
                try {
                    await axios.post(`/voucher`,voucher)
                    this.value = ''
                } catch (error) {
                    console.error('Error in crate voucher',error)
                }
            }
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
            if (!this.selectedUser.user_email) {
                this.errorObj.emailErr.push("Email Không Được Bỏ Trống");
            }
            else {
                if (!/[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$/.test(this.selectedUser.user_email)) {
                    this.errorObj.emailErr.push('Email Không Hợp Lệ');
                }
            }
            // Phone validate
            if (!this.selectedUser.user_phone) {
                this.errorObj.phoneErr.push('Số Điện Thoại Không Được Bỏ Trống');
            }
            else {
                if (!this.selectedUser.user_phone.startsWith('0')) {
                    this.errorObj.phoneErr.push('Số Điện Thoại Không Hợp Lệ');
                }
                if (this.selectedUser.user_phone.length != 10) {
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
                    user_name: this.selectedUser.user_name,
                    user_email: this.selectedUser.user_email,
                    user_phone: this.selectedUser.user_phone,
                    user_address: this.selectedUser.user_address,
                    user_id: this.selectedUser.user_id
                }
                console.log(data)
                await axios.put("/users/", data);
                this.showEdit();
                }
        },

        async blockUser(user_id){
            let data = {
                "user_status": "blocked",
                "user_id": user_id
            }
            await axios.put(`/users/status`,data);
            if (this.selectedUser && this.selectedUser.user_id === user_id) {
                this.selectedUser.user_status = "blocked";
            }
        },

        async unBlockUser(user_id){
            let data = {
                "user_status": "active",
                "user_id": user_id
            }
            await axios.put(`/users/status`,data);
            if (this.selectedUser && this.selectedUser.user_id === user_id) {
                this.selectedUser.user_status = "active";
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
            let rsp = await axios.get(`/users/byid/${this.selectedUser.user_id}`);
            console.log(this.selectedUser.user_id);
            let pic = rsp.data.user_avt;
            console.log(pic);
            if (pic != `http://localhost:8081/uploads/image-1713705036580.jpg`) {
                this.delete(pic);
            }
            const formData = new FormData();
            formData.append('image', this.selectedFile);
            console.log('selectedFile: ',  this.selectedFile);
            console.log('formData: ',  formData);
            let id = this.selectedUser.user_id;
            try {
            const response = await axios.post(`/uploading/useravt/${id}`, formData, {
                headers: {
                'Content-Type': 'multipart/form-data'
                }
            });
            console.log('Image uploaded successfully:', response.data);
            this.selectedUser.user_avt = response.data;
            } catch (error) {
            console.error('Error uploading image:', error);
            }
        }

    }
}

</script>

<style scoped>

h1 {
    font-weight: 900;
    color: #d35ea4;
}

.container_order{
    margin-left: 220px; 
    margin-right: 20px; 
    margin-top: 10px;
    top: 0;
    height: 98vh;  
    opacity: 0.8;
    border-radius: 20px;
 }

  form {
    width: 100%;
    background: #ffb3cc; 
    opacity: 0.8;
    box-shadow: 0 1rem 1rem rgba(0, 0, 0, 0.05);
    border: 0.1rem solid rgba(0, 0, 0, 0.2);
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


</style>