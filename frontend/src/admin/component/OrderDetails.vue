<template>
    <vue-basic-alert :duration="300" :closeIn="2000" ref="alert" />
    <div class="order-details">
        <div class="order-details-inner">
            <h2 class="d-flex justify-content-between font-weight-bold">Chi Tiết Đơn #{{ this.bill[0] }} 
                
                <div>
                    <button v-if="this.newProduct!=''" @click="sendBillId3(this.bill[0],this.bill[1])" class="btn mr-2" style="background-color: #FFD700; border-radius: 10px;">
                        <h5 style="font-weight: 900;">Add New</h5>
                    </button>
                    <button @click="sendBillId1(this.bill[0])" class="btn mr-2" style="background-color: #40bf77; border-radius: 10px;">
                        <h5 style="font-weight: 900;">Add to bill</h5>
                    </button>
                    <button @click="sendBillId2(this.bill[0])" class="btn mr-2" style="background-color: #FF7F50; border-radius: 10px;">
                        <h5 style="font-weight: 900;">Staff</h5>
                    </button>
                    <slot></slot>
                </div>
            </h2>
            
            <div class="row">
                
            </div>
            <div class="row">
                <div class="col-8">
                    <Staff v-if="showProductBill==3" :ID="this.sendId" >
                        <button class="btn" style="background-color: #DC143C; border-radius: 10px;" @click="closeView">Trở Về</button>
                    </Staff>
                    
                    <ProductBill v-if="showProductBill==1" :Bill=[this.bill[0],this.email] @childEvent="getBillStatus"></ProductBill>

                    <ProductOrder v-if="showProductBill==2" :ID=[this.sendId,this.email,this.total] >
                        <button class="btn" style="background-color: #DC143C; border-radius: 10px;" @click="closeView">Trở Về</button>
                    </ProductOrder>           
                    
                    <ProductNew v-if="showProductBill==4" :ID=[this.sendId,this.email,this.number,this.total] @childEvent="closeView" >
                        <button class="btn" style="background-color: #DC143C; border-radius: 10px;" @click="closeView">Trở Về</button>
                    </ProductNew>    
                </div>
                <div class="col-4 pt-3" style="background-color: #f08faf; border-radius: 20px;">
                    <div class="container-info" style="background-color: #d3d3d3; border-radius: 20px; padding: 10px;">
                        <div class="row">
                            <div class="col-10 form-group" style="padding-right: 0; margin: 0;">
                            <textarea name="txtMsg" class="form-control" placeholder="Ghi chú của khách hàng..." 
                                style="width: 100%; border: none;  background-color: #ffccdd; border-radius: 15px; font-weight: 900;" v-model="notes" ></textarea>
                            </div>
                            <div class="col-1">
                                <button class="btn" style="height: 100%; background-color: #f08faf; border-radius: 10px;" @click="updateBillNotes()">
                                    <h5 style="font-weight: 900;">Lưu</h5>
                                </button>
                            </div>
                        </div>
                    </div>

                    <hr style="background-color: #ffccdd;">
                    <div class="container-info" style="background-color: #d3d3d3; border-radius: 20px; padding: 10px;">
                        <div class="row mt-2 m-1">
                            <div class="col-9" style="background-color: #f08faf; border-radius: 15px;">
                                <div class="row d-flex justify-content-around p-2">
                                    <h5 class="mt-1" style="font-weight: 900;">Ngày tổ chức:</h5>
                                    <input type="date" class="form-control" id="startDateInput" v-model="formattedStartDate"
                                        style="background-color: #ffccdd; font-weight: 900; text-align: center; border-radius: 15px; width: 150px;" >
                                    <button @click="updateDate()" 
                                        style="background-color: #ffccdd; border-radius: 15px;" class="px-2 my-1"><h6 style="font-weight: 900;">Lưu</h6></button>
                                </div>
                            </div>
                            <div class="col-3 text-center" style="background-color: #f08faf; border-radius: 15px;">
                                <button @click="showAddMealSetFunction()" style="background-color: #f08faf; padding-top: 5px;">
                                    <h5 style="font-weight: 900;">Thêm suất</h5>
                                </button>
                            </div>
                        </div>
                        
                        <div v-if="this.showAddMealSet==true" class="row pt-2 align-items-center m-1" style="background-color: #ffb3cc; border-radius: 15px;">
                            <div class="col-3 text-left">
                                <h6>Suất Mới: </h6>
                            </div>
                            <div class="col-3">
                                <input title="Số Khách" type="number" class="form-control " min="0" max="1000" 
                                v-model="this.tempGuest" style="border: none; text-align: center; background: #ffb3cc;">
                            </div>
                            <div class="col-3">
                                <input type="time" v-model="this.tempTime" style=" background: #ffb3cc;">
                            </div>
                            <div class="col-1 ">
                            </div>
                            <div class="col-1 ">
                                <button class="btn" @click="saveDateBtn()">
                                    Lưu
                                </button>
                            </div>
                        </div>   

                        <div v-for="(time, index) in this.selectedTime" :key="index">
                            <div class="row pt-2 align-items-center m-1" style="background-color: #ffccdd; border-radius: 15px;">
                                <div class="col-3 text-left">
                                    <h6 style="font-weight: 900;">Suất thứ {{ index+1 }} : </h6>
                                </div>
                                <div class="col-3">
                                    <input title="Số Khách" type="number" :id="'number-' + index" class="form-control " min="0" max="1000" 
                                    v-model="this.selectedGuest[index]" style="border: none; text-align: center; background: #ffccdd; font-weight: 900;">
                                </div>
                                <div class="col-3">
                                    <input type="time" :id="'time-' + index" v-model="this.selectedTime[index]" style=" background: #ffccdd; font-weight: 900;">
                                </div>
                                <div class="col-1 ">
                                    <button class="btn p-1" style="border-radius: 10px; background-color: #f08faf; font-weight: 900;" 
                                        @click="updateDateBtn(index)">
                                        Lưu
                                    </button>
                                </div>
                                <div class="col-1 ">
                                    <button class="btn p-1" style="border-radius: 10px; background-color: #f08faf; font-weight: 900;" 
                                        @click="removeDateBtn(index)">
                                        Xóa
                                    </button>
                                </div>
                            </div>   
                        </div>
                
                    </div>
                    <hr style="background-color: #ffccdd;">
                    <div class="container-info" style="background-color: #d3d3d3; border-radius: 20px; padding: 10px;">
                        <div class="row">
                            <div class="col-10 pr-0">
                                <textarea name="txtMsg" class="form-control text-center" placeholder="Những điều bạn yêu cầu hoặc lưu ý" 
                                    style="width: 100%; height: 25px; border: none;  background: #ffccdd; border-radius: 15px; font-weight: 900;" 
                                    v-model="address" >   
                                </textarea>
                            </div>
                            <div class="col-2 pl-1">
                                <button @click="saveAddress(address)" style="height: 100%; width: 100%; border-radius: 15px; background-color: #f08faf;">Lưu</button>
                            </div>
                        </div>
                        
                        <div class="row pt-3">
                            <div class="col-10 pr-0">
                                <input type="text" style="border-radius: 15px; background-color: #ffccdd; text-align: center; height: 25px; width: 100%; font-weight: 900;" 
                                    v-model="phone" >
                            </div>
                            <div class="col-2 pl-1">
                                <button @click="savePhone(phone)" style="height: 100%; width: 100%; border-radius: 15px; background-color: #f08faf;">Lưu</button>
                            </div>
                        </div>
                    </div>
                    <br>
                    <div style="background-color: #d3d3d3; border-radius: 20px; padding: 10px;">
                        <div class="mx-1" style="background: #f2f2f2; border-radius: 15px;">
                            <div class="row mx-1 p-1 d-flex justify-content-between">
                                <h5 style="font-weight: 900;">{{ this.number*10 }} khách mời</h5>
                                <h5 style="font-weight: 900;">{{ this.number }} bàn tiệc</h5>
                            </div>                    
                        </div>
                        <div class="row pt-3 mx-1">
                            <div class="col-12" style="width: 100%; height: 25px; border: none;  background: #f2f2f2; border-radius: 15px;">
                                <h4 class="text-center font-weight-bold pt-1" style="color: #FF0099;">{{ formatCurrency(this.total) }}</h4>  
                            </div>
                        </div>
                    </div>
                    <br>
                    <div class="container-info" style="background-color: #d3d3d3; border-radius: 20px; padding: 10px;">
                        <div class="mx-1" style="background: #f2f2f2; border-radius: 15px;">
                            <div class="row mx-1 p-2" :style="this.status >= 3 ? { 'color': 'MediumSeaGreen'} : '' ">
                                <div class="col-4 text-left">
                                    <h5 class="" style="font-weight: 900;">Tiền Cọc: </h5>
                                </div>
                                <div class="col-4 text-center">
                                    <h6 v-if="this.status >= 3" style="font-weight: 900;">(đã thanh toán)</h6>
                                </div>
                                <div class="col-4 text-right">
                                    <h5 style="font-weight: 900;">{{ formatCurrency(this.deposits) }}</h5>
                                </div>    
                            </div>
                            <div class="row mx-1 p-2" :style="this.status >= 4 ? { 'color': 'MediumSeaGreen'} : '' ">
                                <div class="col-4 text-left">
                                    <h5 class="" style="font-weight: 900;">Còn Lại: </h5>
                                </div>
                                <div class="col-4 text-center">
                                    <h6 v-if="this.status >= 4" style="font-weight: 900;">(đã thanh toán)</h6>
                                </div>
                                <div class="col-4 text-right">
                                    <h5 style="font-weight: 900;">{{ formatCurrency(this.total-this.deposits) }}</h5>
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
import ProductNew from "./ProductNew.vue";
import ProductBill from "./ProductBill.vue";
import ProductOrder from "./ProductOrder.vue";
import Staff from "./Staff.vue";
import axios from "axios";
import VueBasicAlert from 'vue-basic-alert';
export default {
    props: ['bill'],
    name: "OrderDetail",

    data() {
        return {
            email: '',
            status: '',
            notes:"",
            address:"",
            phone:"",
            date:'',
            deposits:'',
            total:'',
            selectedTime: [],
            selectedGuest: [],
            number: 0,
            showAddMealSet : false,
            tempGuest: '',
            tempTime: '',

            billMatch: undefined,

            showProductBill: 1,
            sendId: undefined,

            newProduct: '',
        }
    },

    created() {
        this.getEmail();
        this.getBillStatus();
        this.getMeatSet();
        this.getProdductNew();
    },

    watch: {
        showProductBill: {
            handler: 'getBillStatus', 
            immediate: true 
        },
    },

    computed: {
        formattedStartDate: {
          get() {
            // Chuyển đổi giá trị ngày từ đối tượng Date sang chuỗi có định dạng "yyyy-MM-dd"
            return this.date ? this.formatDate(this.date) : null;
          },
          set(value) {
            // Chuyển đổi giá trị ngày từ chuỗi có định dạng "yyyy-MM-dd" sang đối tượng Date
            this.date = value ? new Date(value) : null;
          },
        },
    },

    methods: {
        formatCurrency(amount) {
          if (!amount) return '';
          return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
        },


        closeView: function () {
            this.showProductBill = 1;
        },

        sendBillId1: function (id) {
            this.sendId = id
            if ( this.showProductBill == 2 ) this.showProductBill = 1
            else this.showProductBill = 2;
        },

        sendBillId2: function (id) {
            this.sendId = id
            if ( this.showProductBill == 3 ) this.showProductBill = 1
            else this.showProductBill = 3;
        },

        sendBillId3: function (id) {
            this.sendId = id
            if ( this.showProductBill == 4 ) this.showProductBill = 1
            else this.showProductBill = 4;
        },

        refresh(){
            this.getBillStatus();
            // this.getMeatSet();
            // this.showProductBill = 1;
        },

        async getBillStatus() {
            if (this.bill[0]) {
                let rsp = await axios.get(`/billstatus/bill/${this.bill[0]}`)
                let data = rsp.data;
                this.billMatch = rsp.data[0];
                this.notes = data[0].bill_notes;
                this.address = data[0].bill_address;
                this.phone = data[0].bill_phone;
                this.deposits = data[0].bill_deposits;
                this.total = data[0].bill_total;
                this.status = data[0].bill_status;
            }
        },

        async getProdductNew() {
            let rsp = await axios.get(`/products/mota/${this.bill[0]}`)
            this.newProduct = rsp.data;
        },

        async getNotes() {
            let rsp = await axios.get(`/billstatus/bill/${this.bill[0]}`)
            let data = rsp.data;
            this.notes = data[0].bill_notes;
        },

        async getEmail() {
            try {
                const response = await axios.get(`/users/byid/` + this.bill[1]);
                const user = response.data;
                this.email = user.user_email;
            } catch (error) {
                console.error("Error fetching user:", error);
            }
        },


        async updateBillNotes() {
            let data = {
                bill_id: this.bill[0],
                bill_notes: this.notes,
            };
            let confirmResult = window.confirm("Bạn có chắc chắn muốn thay đổi Ghi chú của đơn hàng?");
            if (confirmResult) {
                try {
                    await axios.put("billstatus/notes/", data);
                    console.log("Đã cập nhật Ghi chú thành công.");
                    let data1 = {
                        email: this.email,
                        title: `Đơn hàng #${this.bill[0]} của bạn đã được cập nhật!`,
                        content: `Nội dung: Cập Nhật Ghi Chú thành "${this.notes}".`,
                    }
                    try {
                        axios.post(`/sendemail/update`,data1);
                    } catch (error) {
                        console.error("Error Send email update:", error);
                    }
                } catch (error) {
                    console.error("Đã xảy ra lỗi khi cập nhật Ghi chú:", error);
                }
                
            }
        },

        formatDate(date) {
            if (date instanceof Date && !isNaN(date)) {
                let year = date.getFullYear();
                let month = date.getMonth() + 1;
                let day = date.getDate();

                month = month < 10 ? `0${month}` : month;
                day = day < 10 ? `0${day}` : day;

                // Trả về chuỗi có định dạng "yyyy-MM-dd"
                return `${year}-${month}-${day}`;
            }
            return null;
        },

        async getMeatSet() {
            if (this.bill[2]) {
                const response = await axios.get('/datebill/' + this.bill[0]);
                if (response.data.length > 0) {
                    const dateString = response.data[0].date_date;
                    const parts = dateString.split("-");
                    const year = parseInt(parts[2]);
                    const month = parseInt(parts[0]) - 1; // Trừ đi 1 vì tháng trong JavaScript bắt đầu từ 0
                    const day = parseInt(parts[1]);
                    this.date = new Date(year, month, day);
                }
                try {
                    let response = await axios.get(`/datedetails/${this.bill[2]}`);
                    let data = response.data;
                    if (Array.isArray(data) && data.length > 0) {
                        // Khởi tạo các mảng để lưu trữ dữ liệu từ mỗi phần tử
                        let selectedTimes = [];
                        let selectedGuests = [];
                        // Lặp qua mỗi phần tử trong mảng data
                        data.forEach(item => {
                            selectedTimes.push(item.dd_time);
                            selectedGuests.push(item.dd_guest);
                            this.number += parseInt(item.dd_guest);
                        });
                        // Gán giá trị của các mảng cho selectedTime và selectedGuest
                        this.selectedTime = selectedTimes;
                        this.selectedGuest = selectedGuests;
                    } else {
                        this.selectedTime = []; 
                        this.selectedGuest = []; 
                    }
                } catch (error) {
                    console.error('Lỗi khi lấy dữ liệu từ API:', error);
                }
                this.number = Math.ceil(this.number / 10);
            }
        },

        formatDateToSubmit(date) {
            if (date) {
                const year = date.getFullYear();
                let month = date.getMonth() + 1;
                let day = date.getDate();

                month = month < 10 ? `0${month}` : month;
                day = day < 10 ? `0${day}` : day;

                // Trả về chuỗi có định dạng "yyyy-MM-dd"
                return `${month}-${day}-${year}`;
            }

            return null;
        },

        async deleteStaff(){
            try {
                await axios.delete(`staffschedule/allbybill/${this.bill[0]}`);
            } catch (error) {
                console.error('Error in delete staff schedule',error)
            }
        },

        async updateDate(){
            let dateSelect = {
                date_date: this.formatDateToSubmit(this.date),
                bill_id: this.bill[0],
            };
            await axios.put("/datebill", dateSelect);
            this.deleteStaff();
            this.$refs.alert.showAlert('success', 'Success!', 'Ngày đã được thay đổi thành công!');   
                const dateString =dateSelect.date_date;
                const parts = dateString.split("-");
                const year = parseInt(parts[2]);
                const month = parseInt(parts[0]); 
                const day = parseInt(parts[1]);
                let showdate = `${day}/${month}/${year}`;
            let data1 = {
                email: this.email,
                title:`Đơn hàng #${this.bill[0]} của bạn đã được cập nhật!`,
                content: `Nội dung: Thay đổi ngày tổ chức thành ${showdate}.`,
            }
            try {
                axios.post(`/sendemail/update`,data1);
            } catch (error) {
                console.error("Error Send email update:", error);
            }
        },

        async removeDateBtn(index) {
            let temp = index + 1 ;
            let confirmResult = window.confirm("Xác Nhận Hủy Suất Thứ " + temp );
            if (confirmResult) {
                let data = {
                    date_id: parseInt(this.bill[2]),
                    dd_name: parseInt(index + 1),
                };
                try {
                    let response = await axios.delete(`/datedetails/detail/`, { data });
                    if (response.status >= 200 && response.status < 300) {
                        console.log("Xóa thành công");
                        this.$refs.alert.showAlert('success', 'Success!', 'Suất Đãi đã được xóa!');
                        this.selectedTime.splice(index, 1);
                        this.selectedGuest.splice(index, 1);
                        this.deleteStaff();
                        let data1 = {
                            email: this.email,
                            title:`Đơn hàng #${this.bill[0]} của bạn đã được cập nhật!`,
                            content: `Nội dung: Xóa Suất đãi khách thứ ${parseInt(index + 1)}.`,
                        }
                        try {
                            axios.post(`/sendemail/update`,data1);
                        } catch (error) {
                            console.error("Error Send email update:", error);
                        }
                            
                    } else {
                        console.error("Xóa không thành công, mã trạng thái: ", response.status);
                    }
                } catch (error) {
                    console.error("Lỗi khi thực hiện xóa: ", error);
                }

                this.getMeatSet();
            }
        },
        async updateDateBtn(index) {
            let data = {
                date_id: this.bill[2],
                dd_name: index + 1,
                dd_time: this.selectedTime[index],
                dd_guest: this.selectedGuest[index],
            };

            try {
                await axios.put('/datedetails/', data);
                this.$refs.alert.showAlert('success', 'Success!', 'Dữ liệu đã được chỉnh sửa thành công!');
                console.log(data);
                // Sau khi cập nhật thành công, gọi hàm để lấy lại dữ liệu
                await this.getMeatSet();
                this.deleteStaff();
                let data1 = {
                    email: this.email,
                    title:`Đơn hàng #${this.bill[0]} của bạn đã được cập nhật!`,
                    content: `Nội dung: Cập nhật Suất đãi khách thứ ${parseInt(index + 1)} thành ${data.dd_time} với số lượng khách ${data.dd_guest}.`,
                }
                try {
                    axios.post(`/sendemail/update`,data1);
                } catch (error) {
                    console.error("Error Send email update:", error);
                }

            } catch (error) {
                console.error('Lỗi khi chỉnh sửa dữ liệu:', error);
            }
        },


        showAddMealSetFunction() {
            this.showAddMealSet = !this.showAddMealSet;
        },

        async saveDateBtn() {
            let data = {
                date_id: this.bill[2],
                dd_name: this.selectedTime.length + 1,
                dd_time: this.tempTime,
                dd_guest: this.tempGuest,
            };

            try {
                await axios.post('/datedetails/', data);
                this.$refs.alert.showAlert('success', 'Success!', 'Dữ liệu đã được chỉnh sửa thành công!');
                console.log(data);
                // Sau khi cập nhật thành công, gọi hàm để lấy lại dữ liệu
                await this.getMeatSet();
                this.tempTime = '';
                this.tempGuest = '';
                this.showAddMealSet = false;
                this.deleteStaff();
                let data1 = {
                    email: this.email,
                    title:`Đơn hàng #${this.bill[0]} của bạn đã được cập nhật!`,
                    content: `Nội dung: Thêm Suất đãi khách thứ ${data.dd_name} với thời gian là ${data.dd_time} và số lượng khách ${data.dd_guest}.`,
                }
                try {
                    axios.post(`/sendemail/update`,data1);
                } catch (error) {
                    console.error("Error Send email update:", error);
                }
            } catch (error) {
                console.error('Lỗi khi submit dữ liệu:', error);
            }
        },
        
        async saveAddress() {
            let data = {
                bill_id: this.bill[0],
                bill_address: this.address,
            };
            let confirmResult = window.confirm("Bạn có chắc chắn muốn thay đổi Địa Chỉ của đơn hàng?");
            if (confirmResult) {
                try {
                    await axios.put("billstatus/address/", data);
                    this.$refs.alert.showAlert('success', 'Success!', 'Địa chỉ đã được chỉnh sửa thành công!');
                    let data1 = {
                        email: this.email,
                        title: `Đơn hàng #${this.bill[0]} của bạn đã được cập nhật!`,
                        content: `Nội dung: Cập Nhật Địa Chỉ thành "${this.notes}".`,
                    }
                    try {
                        axios.post(`/sendemail/address`,data1);
                    } catch (error) {
                        console.error("Error Send email address:", error);
                    }
                } catch (error) {
                    console.error("Đã xảy ra lỗi khi cập nhật Địa Chỉ:", error);
                }
                
            }
        },

        async savePhone() {
            let data = {
                bill_id: this.bill[0],
                bill_phone: this.phone,
            };
            let confirmResult = window.confirm("Bạn có chắc chắn muốn thay đổi Số Điện Thoại của đơn hàng?");
            if (confirmResult) {
                try {
                    await axios.put("billstatus/phone/", data);
                    this.$refs.alert.showAlert('success', 'Success!', 'Dữ liệu đã được chỉnh sửa thành công!');
                    let data1 = {
                        email: this.email,
                        title: `Đơn hàng #${this.bill[0]} của bạn đã được cập nhật!`,
                        content: `Nội dung: Cập Nhật Số Điện Thoại thành "${this.notes}".`,
                    }
                    try {
                        axios.post(`/sendemail/phone`,data1);
                    } catch (error) {
                        console.error("Error Send email phone:", error);
                    }
                } catch (error) {
                    console.error("Đã xảy ra lỗi khi cập nhật Số Điện Thoại:", error);
                }
                
            }
        },
    },

    components: { ProductOrder, ProductBill , Staff, ProductNew, VueBasicAlert}
}
</script>

<style scoped>
.order-details {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 99;
    background-color: rgba(0, 0, 0, 0.7);
    display: flex;
    align-items: center;
    justify-content: center;
    outline: none; /* Clear outline */
}

.order-details .order-details-inner {
    width: 80%;
    height: 80%;
    background-color: #d3d3d3;
    padding: 32px;
    border: none; /* Clear border */
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); /* Add shadow for better visibility */
    border-radius: 20px;
}

.order-details .order-details-inner h2 {
    margin: 0;
    font-size: 32px;
    color: #ef87aa;
    margin-bottom: 20px;
}

.order-details .order-details-inner .product-detail .image img {
    height: 8rem;
    width: 8rem;
    margin: 20px;
}

.order-details .order-details-inner .product-detail .content {
    margin-top: 20px;
    font-size: 12px;
    width: 100%;
}

.order-details .order-details-inner .product-detail .content p:first-of-type {
    font-size: 16px;
    color: #ef87aa;
}

.order-details .order-details-inner .product-detail .content p span {
    font-size: 14px;
    color: black;
}

.order-details .order-details-inner .price {
    margin-top: 30px;
    font-size: 16px;
}

@media (max-width: 768px) {
    .order-details .order-details-inner {
        width: 80vw;
        height: 60vh;
    }

    .order-details .order-details-inner h2 {
        font-size: 20px;
    }

    .order-details .order-details-inner .product-detail .content .desc,
    .order-details .order-details-inner .product-detail .content .name span {
        font-size: 12px !important;
    }

    .order-details .order-details-inner .product-detail .content .name {
        font-size: 14px !important;
    }
}

@media (max-width: 576px) {
    .order-details .order-details-inner {
        width: 90vw;
        height: 65vh;
    }

    .order-details .order-details-inner div:first-of-type {
        flex-direction: column;
    }
}

@media (max-width: 376px) {
    .order-details .order-details-inner {
        width: 90vw;
        height: 65vh;
        padding: 5px !important;
    }

    .order-details .order-details-inner .product-detail .content .name {
        font-size: 12px !important;
    }
}

</style>
