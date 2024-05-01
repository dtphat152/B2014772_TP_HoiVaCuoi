<template>
<div class="row"  v-for="b in filterBills.slice().reverse()" :key="b.bill_id">
<div class="col">
   <div class="my-order">
        <div class="my-order-inner">
            <div class="row">
                <div class="col-11">
                    <div class="row">
                        <h4 class="col-1 ml-4 pt-1 mb-0 text-center font-weight-bold" 
                            style="background-color:white; border-radius: 10px; color: #FF0099;">
                            Mã đơn #{{ b.bill_id }} 
                        </h4>
                        <button v-if="b.bill_status==0 || b.bill_status==4" @click="hideBill(b.bill_id,b.bill_status)"
                            class="col-1 btn ml-1" style="background-color:Orange; border-radius: 10px; font-weight: 900;"> Ẩn </button>
                        <button v-if="b.bill_status==1" @click="cancelBill(b.bill_id,b.voucher_id)"
                            class="col-1 btn ml-1" style="background-color:Tomato; border-radius: 10px;  font-weight: 900;"> Hủy </button>
                        <button v-if="b.bill_status==2"  @click="showPaymentBTN()" 
                            class="col-1 btn ml-1" style="background-color:MediumSeaGreen; border-radius: 10px;"> Thanh Toán Cọc</button>
                            <button v-if="showPayment && b.bill_status==2" @click="sendMomo(b.bill_status,b.bill_id,b.bill_total,b.bill_deposits)"
                            class="col-1 btn ml-1" style="background-color:white; border-radius: 10px; color: Violet; font-weight: 900;">MOMO</button>
                            <button v-if="showPayment && b.bill_status==2" @click="sendVnPay(b.bill_status,b.bill_id,b.bill_total)"
                            class="col-1 btn ml-1" style="background-color:white; border-radius: 10px; color: Violet; font-weight: 900;">VN PAY</button>

                        <button v-if="b.bill_status==3" @click="showPaymentBTN()"
                            class="col-1 btn ml-1" style="background-color:SteelBlue; border-radius: 10px;"> Thanh Toán Đơn</button>
                            <button v-if="showPayment && b.bill_status==3" @click="sendMomo(b.bill_status,b.bill_id,b.bill_total,b.bill_deposits)"
                            class="col-1 btn ml-1 " style="background-color:white; border-radius: 10px; color: Violet; font-weight: 900;">MOMO</button>
                            <button v-if="showPayment && b.bill_status==3" @click="sendVnPay(b.bill_status,b.bill_id,b.bill_total)"
                            class="col-1 btn ml-1 " style="background-color:white; border-radius: 10px; color: Violet; font-weight: 900;">VN PAY</button>
                    </div>
                </div>
                <div class="col-1 text-right">
                    <i class="fa fa-refresh" @click="refresh()" style="font-size: 15px;" aria-hidden="true"></i>
                </div>
            </div>
            <br>
            <div class="row d-flex justify-content-around" > 
                <div class="col-10 " style="border-radius: 20px; background-color: white">
                    <div v-if="b.bill_status==0">
                        <h3 class="pl-3 text-warning text-center">Đơn Hàng của bạn đã Hủy. Rất Xin Lỗi !!!</h3>
                    </div>
                    <div v-else class="row d-flex justify-content-around p-2">
                        <div class="col text-center" :style="b.bill_status >= 1 ? { 'background-color': '#ffb3cc', 'border-start-start-radius': '10px', 'border-end-start-radius': '10px' } : ''">
                            <h3 style="font-weight: 900;">Đang Chờ Chấp Nhận</h3>
                        </div>
                        <div class="col text-center" :style="b.bill_status >= 2 ? { 'background-color': '#ffb3cc'} : ''">
                            <h3 style="font-weight: 900;">Đang Chờ Thanh Toán Cọc</h3>
                        </div>
                        <div class="col text-center" :style="b.bill_status >= 3 ? { 'background-color': '#ffb3cc'} : ''">
                            <h3 style="font-weight: 900;">Đang Chuẩn Bị Và Tiến Hành</h3>
                        </div>
                        <div class="col text-center" :style="b.bill_status >= 4 ? { 'background-color': '#ffb3cc', 'border-end-end-radius': '10px', 'border-start-end-radius': '10px' } : ''">
                            <h3 style="font-weight: 900;">Hoàn Thành Đơn Hàng</h3>
                        </div>  
                    </div>
                </div>
            </div>

            <br>
            
            <div class="row">
                <div class="col-8" style="border-radius: 20px; background-color: #ffb3cc">
                    <ProductBill  v-if="showProductBill" @send-price="handlePriceFromChild" :Bill="b.bill_id" ></ProductBill>

                    <ProductOrder v-if="!showProductBill" :ID="this.sendId" >
                        <button class="btn" style="background-color: #DC143C; border-radius: 10px;" @click="closeView">Trở Về</button>
                    </ProductOrder> 
                </div>
                <div class="col-4">
                    
                    <div class="container-datetime" style="background-color: #ffb3cc; border-radius: 20px; padding: 5px;">
                        <div class="date-mealset">
                            <div class="row mt-2 m-1">
                                <div class="col-10" style="background-color: #f2f2f2; border-radius: 15px;">
                                    <div class="row d-flex justify-content-around p-2">
                                        <h4 class="mt-2" style="color: black;font-weight: 900;">Ngày tổ chức:</h4>
                                        <input type="date" class="form-control" id="startDateInput" v-model="formattedStartDate"
                                            style="background-color: #ffb3cc; font-weight: 900; text-align: center; border-radius: 15px; font-size: 15px; width: 180px;" >
                                        <button @click="sendDate(b.bill_id,b.bill_status)" 
                                            style="background-color: #f2f2f2; border-radius: 15px;" class="px-2 my-1"><h5 style="font-weight: 900;">Lưu</h5></button>
                                    </div>
                                </div>
                                <div class="col-2 text-center" style="background-color: #f2f2f2; border-radius: 15px;">
                                    <button @click="showAddMealSetFunction()" style="background-color: #f2f2f2; padding-top: 5px;"><h5 style="font-weight: 900;">Thêm Suất</h5></button>
                                </div>
                            </div>
                            
                            <div v-if="this.showAddMealSet==true" class="row pt-2 align-items-center m-1" style="background-color: #ffb3cc; border-radius: 15px;">
                                <div class="col-3 text-left">
                                    <h6>Suất Mới: </h6>
                                </div>
                                <div class="col-3">
                                    <input title="Số Khách" type="number" class="form-control" min="0" max="1000" 
                                    v-model="this.tempGuest" style="border: none; text-align: center; background: #ffb3cc;">
                                </div>
                                <div class="col-3">
                                    <input type="time" v-model="this.tempTime" style=" background: #ffb3cc;">
                                </div>
                                <div class="col-1 ">
                                </div>
                                <div class="col-1 ">
                                    <button class="btn" @click="saveDateBtn(b.bill_id,b.bill_status)">
                                        Lưu
                                    </button>
                                </div>
                            </div>  

                            <div v-for="(time, index) in this.selectedTime" :key="index">
                                <div class="row align-items-center m-1 mt-3" style="background-color: #f2f2f2; border-radius: 15px; padding-top: 5px;">
                                    <div class="col-3 text-left">
                                        <h5 style="color: black;font-weight: 900;">Suất thứ {{ index+1 }}</h5>
                                    </div>
                                    <div class="col-3">
                                        <input title="Số Khách" type="number" :id="'number-' + index" class="form-control mb-2" min="0" max="1000" 
                                        v-model="this.selectedGuest[index]" style="border: none; text-align: center; background: #f2f2f2; font-weight: 900; font-size: 15px;">
                                    </div>
                                    <div class="col-3">
                                        <input type="time" :id="'time-' + index" v-model="this.selectedTime[index]" style=" background: #f2f2f2; font-weight: 900; font-size: 15px; margin-bottom: 5px;">
                                    </div>
                                    <div class="col-1 ">
                                        <button class="btn" @click="removeDateBtn(index,b.bill_id,b.bill_status)"
                                            style="border-radius: 10px; background-color: #f2f2f2;">
                                            <h5 style="font-weight: 800;">Xóa</h5>
                                        </button>
                                    </div>
                                    <div class="col-1 ">
                                        <button class="btn" @click="updateDateBtn(index,b.bill_id,b.bill_status)"
                                            style="border-radius: 10px; background-color: #f2f2f2;">
                                            <h5 style="font-weight: 800;">Lưu</h5>
                                        </button>
                                    </div>
                                </div>   
                            </div>
                        </div>
                    </div>
                    <br>
                    <div class="container-info" style="background-color: #ffb3cc; border-radius: 20px; padding: 10px;">
                        <div class="row">
                            <div class="col-10 pr-0">
                                <textarea name="txtMsg" class="form-control text-center" placeholder="Những điều bạn yêu cầu hoặc lưu ý" 
                                    style="width: 100%; height: 25px; border: none;  background: #f2f2f2; border-radius: 15px; font-weight: 900; font-size: 15px;" 
                                    v-model="b.bill_address" >   
                                </textarea>
                            </div>
                            <div class="col-2 pl-1">
                                <button @click="saveAdd(b.bill_address,b.bill_id,b.bill_status)" 
                                style="height: 100%; width: 100%; border-radius: 15px; background-color: #f2f2f2;"><h5 style="font-weight: 800;">Lưu</h5></button>
                            </div>
                        </div>
                        
                        <div class="row pt-3">
                            <div class="col-10 pr-0">
                                <input type="text"  v-model="b.bill_phone"
                                style="border-radius: 15px; background-color: #f2f2f2; text-align: center; height: 25px; width: 100%; font-weight: 900; font-size: 15px;" >
                            </div>
                            <div class="col-2 pl-1">
                                <button @click="savePhone(b.bill_phone,b.bill_id,b.bill_status)" 
                                style="height: 100%; width: 100%; border-radius: 15px; background-color: #f2f2f2; font-weight: 900;"><h5 style="font-weight: 800;">Lưu</h5></button>
                            </div>
                        </div>
                    </div>
                    <br>
                    <div class="container-info" style="background-color: #ffb3cc; border-radius: 20px; padding: 10px;">
                        <div class="row mr-1">
                            <div class="col-8 pr-1">
                                <textarea name="txtMsg" class="form-control text-center" placeholder="Những điều bạn yêu cầu hoặc lưu ý" 
                                    style="width: 100%; height: 25px; border: none;  background: #f2f2f2; border-radius: 15px; font-weight: 900;" 
                                    v-model="b.bill_notes" >   
                                </textarea>
                            </div>
                            <div class="col-4 pl-1 pt-1" style="border-radius: 15px; background-color: #f2f2f2; text-align: center; height: 25px; font-weight: 900;">
                                   {{b.bill_when}}
                            </div>
                        </div>
                        
                    </div>
                    <br>
                    <div class="container-info" style="background-color: #ffb3cc; border-radius: 20px; padding: 10px;">
                        <div class="mx-1" style="background: #f2f2f2; border-radius: 15px;">
                            <div class="row mx-1 p-1 d-flex justify-content-between">
                                <h5 style="font-weight: 900;">Số lượng Bàn tiệc (Mâm): </h5>
                                <h5 style="font-weight: 900;">{{ this.tableNum }} bàn</h5>
                            </div>
                            <div class="row mx-1 p-1 d-flex justify-content-between">
                                <h5 style="font-weight: 900;">Giá cả mỗi Bàn tiệc (Mâm): </h5>
                                <h5 style="font-weight: 900;">{{ formatCurrency(this.priceOfTable) }}</h5>
                            </div>
                            
                        </div>
                        <div class="row pt-3 mx-1">
                            <div class="col-12" style="width: 100%; height: 25px; border: none;  background: #f2f2f2; border-radius: 15px;">
                                <h4 class="text-center font-weight-bold pt-1" style="color: #FF0099;">{{ formatCurrency(b.bill_total) }}</h4>  
                            </div>
                        </div>
                    </div>
                    <br>
                    <div class="container-info" style="background-color: #ffb3cc; border-radius: 20px; padding: 10px;">
                        <div class="mx-1" style="background: #f2f2f2; border-radius: 15px;">
                            <div class="row mx-1 p-2" :style="b.bill_status >= 3 ? { 'color': 'MediumSeaGreen'} : '' ">
                                <div class="col-4 text-left">
                                    <h5 class="" style="font-weight: 900;">Tiền Cọc: </h5>
                                </div>
                                <div class="col-4 text-center">
                                    <h6 v-if="b.bill_status >= 3" style="font-weight: 900;">(đã thanh toán)</h6>
                                </div>
                                <div class="col-4 text-right">
                                    <h5 style="font-weight: 900;">{{ formatCurrency(b.bill_deposits) }}</h5>
                                </div>    
                            </div>
                            <div class="row mx-1 p-2" :style="b.bill_status >= 4 ? { 'color': 'MediumSeaGreen'} : '' ">
                                <div class="col-4 text-left">
                                    <h5 class="" style="font-weight: 900;">Còn Lại: </h5>
                                </div>
                                <div class="col-4 text-center">
                                    <h6 v-if="b.bill_status >= 4" style="font-weight: 900;">(đã thanh toán)</h6>
                                </div>
                                <div class="col-4 text-right">
                                    <h5 style="font-weight: 900;">{{ formatCurrency(b.bill_total-b.bill_deposits) }}</h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <button class="btn py-0" @click="sendBillId(b.bill_id)">
                    <h4 style="font-weight: 800; color: #32CD32;">Thêm Dịch Vụ</h4>
                </button>
            </div>  
        </div>
    </div>
</div> 
</div>
<div v-if="filterBills.length==0"  class="my-order"><div class="my-order-inner"><h1 style="text-align: center; font-weight: 900;">Đơn Hàng Rỗng</h1></div></div>
</template>


<script>
import ProductOrder from "../components/ProductOrder.vue"
import ProductBill from "../components/ProductBill.vue"
import axios from "axios";
import { mapState } from "vuex";

export default {
    name: 'MyOrder',

    data() {
        return {
            allBills: [],
            selectedTime: [],
            selectedGuest: [],
            date: [],
            showAddMealSet : false,
            tempGuest: '',
            tempTime: '',
            tableNum: '',
            priceOfTable:'',
            showProductBill: true,
            sendId: null,
            showPayment: false,
            interval: "",
            checkChangeStatus:0,
        }
    },

    watch: {
        checkChangeStatus: {
            handler: 'getAllBills', 
            immediate: true 
        },
    },

    mounted: function () {
        this.getAllBills();
        this.autoUpdate();
    },

    beforeUnmount() {
        clearInterval(this.interval)
    },

    computed: {
        ...mapState(["allProducts", "user"]),

        filterBills: function () {
            return this.allBills.filter((b) => b.bill_status <= 4 && b.bill_status >= 0);
        },

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
        async getAllBills() {
            if (this.user) {
                let bills = (await axios.get('/billstatus/user/' + this.user.user_id)).data;
                this.allBills = bills;
                for (const bill of bills) {
                    this.getMeatSet(bill.date_id,bill.bill_id);
                }
            }
        },

        async getAllBillStatus() {
            if (this.user) {
                try {
                    let response = await axios.get('/billstatus/status/user/' + this.user.user_id);
                    if (response.data) {
                        for (let i = 0; i < this.allBills.length; i++) {
                            if (this.allBills[i].bill_status !== response.data[i].bill_status) {
                                this.checkChangeStatus += 1;
                            }
                        }
                    }
                } catch (error) {
                    console.error('Error while fetching bill status:', error);
                }
            }
        },

        formatCurrency(amount) {
          if (!amount) return '';
          return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
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

        sendBillId: function (id) {
            this.sendId = id
            this.showProductBill = !this.showProductBill;
        },

        closeView: function () {
            this.showProductBill = !this.showProductBill;
        },

        showAddMealSetFunction() {
            this.showAddMealSet = !this.showAddMealSet;
        },

        showPaymentBTN() {
            this.showPayment = !this.showPayment;
        },

        refresh(){
            this.getAllBills();
        },

        autoUpdate: function () {
            this.interval = setInterval(function () {
                this.getAllBillStatus();
            }.bind(this), 1000);
        },

        handlePriceFromChild(price) {
            // Bắt sự kiện từ component con và cập nhật giá trị trong component cha
            this.priceOfTable = price;
        },

        async sendMomo(bill_status , bill_id, bill_total , bill_deposits) {
            try {
                let tien = bill_total-bill_deposits;
                let type = 'Thanh Toán Kết Sổ'
                if (bill_status==2) {
                    tien = parseInt(bill_deposits);
                    type = 'Thanh Toán Cọc'
                }       
                let data = {
                    bill_id: bill_id,
                    amount: tien,
                    bill_type: type
                };
                console.log("check:",data);
                const response = await axios.post(`/payment-online`, data);
                const redirectUrl = response.data.redirectUrl;
                console.log('Redirect URL:', redirectUrl);
                window.open(redirectUrl, '_blank');
            } catch (error) {
                console.error("Error in send Momo", error);
            }
        },
        
        async sendVnPay(bill_status,bill_id,bill_total , bill_deposits) {
            try {
                let tien = bill_total-bill_deposits;
                let type = 'Thanh Toán Kết Sổ'
                if (bill_status==2) {
                    tien = parseInt(bill_deposits);
                    type = 'Thanh Toán Cọc'
                }    
                let data = {
                    bill_id: bill_id,
                    amount: tien,
                    bill_type: type
                };
                const response = await axios.post(`/create_payment_vnpay`, data);
                const redirectUrl = response.data.redirectUrl;
                console.log('Redirect URL:', redirectUrl);
                window.open(redirectUrl, '_blank');
            } catch (error) {
                console.error('Error in send VN Pay: ', error);
            }
        },

        async getMeatSet(date_id,bill_id) {
            let table = 0;
            if (date_id) {
                const response = await axios.get('/datebill/' + bill_id);
                if (response.data.length > 0) {
                    const dateString = response.data[0].date_date;
                    const parts = dateString.split("-");
                    const year = parseInt(parts[2]);
                    const month = parseInt(parts[0]) - 1; // Trừ đi 1 vì tháng trong JavaScript bắt đầu từ 0
                    const day = parseInt(parts[1]);
                    this.date = new Date(year, month, day);
                }
                try {
                    let response = await axios.get(`/datedetails/${date_id}`);
                    let data = response.data;
                    console.log(data)
                    // this.date = this.formatDate(data[0].date_date);
                    
                    if (Array.isArray(data) && data.length > 0) {
                        // Khởi tạo các mảng để lưu trữ dữ liệu từ mỗi phần tử
                        let selectedTimes = [];
                        let selectedGuests = [];
                        // Lặp qua mỗi phần tử trong mảng data
                        data.forEach(item => {
                            selectedTimes.push(item.dd_time);
                            selectedGuests.push(item.dd_guest);
                            table+=item.dd_guest;
                        });
                        // Gán giá trị của các mảng cho selectedTime và selectedGuest
                        this.selectedTime = selectedTimes;
                        this.selectedGuest = selectedGuests;
                    } else {
                        this.selectedTime = []; 
                        this.selectedGuest = []; 
                    }
                    this.tableNum =  Math.ceil(table/10);
                } catch (error) {
                    console.error('Lỗi khi lấy dữ liệu từ API:', error);
                }
                
            }
        },
        
        async hideBill(id,bill_status) {
            if (bill_status==4) {
                await axios.put('/billstatus/' + id);
                this.getAllBills();
            } else if (bill_status==0) {
                await axios.put('billstatus/statuscancel/' + id);
                this.getAllBills();
            } 
        },

        async cancelBill(id,voucher_id) {
            let voucher = {
                vc_status: 1,
                vc_id: voucher_id,
            }
            axios.put(`/voucher/status`,voucher);
            await axios.put('/billstatus/cancel/' + id);
            this.getAllBills();
        },

        formatDateToSubmit(date) {
            if (date instanceof Date && !isNaN(date)) {
                let year = date.getFullYear();
                let month = date.getMonth() + 1;
                let day = date.getDate();

                month = month < 10 ? `0${month}` : month;
                day = day < 10 ? `0${day}` : day;
                return `${day}-${month}-${year}`;
            }
            return null;
        },
        
        async sendDate(bill_id,status){
            let year = this.date.getFullYear();
            let month = this.date.getMonth() + 1;
            let day = this.date.getDate();
            month = month < 10 ? `0${month}` : month;
            day = day < 10 ? `0${day}` : day;
            const Dateformat = `${day}-${month}-${year}`;
            if (status>=2 && status<=3) {
                let confirmResult = window.confirm(`Thay đổi Ngày tổ chức? Thời gian:`+Dateformat+`. Yêu cầu sẽ được gửi cho cửa hàng!` );
                if (confirmResult) {
                    let data1 = {
                        email: '',
                        title:`Đơn hàng #${bill_id} được yêu cầu cập nhật!`,
                        content: `Nội dung: Thay đổi Ngày tổ chức thành ${Dateformat}.`,
                        auth: `Khách hàng `+this.user.user_name+`.`,
                    }
                    try {
                        axios.post(`/sendemail/request`,data1);
                    } catch (error) {
                        console.error("Error Send email request:", error);
                    }
                }
            } else if (status==1) {window.confirm(`Bạn Chưa Thể Thay Đổi Thông Tin` );}
            else window.confirm(`Bạn Không Thể Thay Đổi Thông Tin` );
        },

        async saveDateBtn(bill_id,status) {
            if (status>=2 && status<=3) {
                let confirmResult = window.confirm(`Thêm Suất? Thời gian:`+this.tempTime+` và Khách: `+this.tempGuest+` Yêu cầu sẽ được gửi cho cửa hàng!` );
                if (confirmResult) {
                    let data1 = {
                        email: '',
                        title:`Đơn hàng #${bill_id} được yêu cầu cập nhật!`,
                        content: `Nội dung: Thêm Suất đãi khách, thời gian là ${this.tempTime} và số lượng khách ${this.tempGuest}.`,
                        auth: `Khách hàng `+this.user.user_name+`.`,
                    }
                    try {
                        axios.post(`/sendemail/request`,data1);
                    } catch (error) {
                        console.error("Error Send email request:", error);
                    }
                    this.tempTime = '';
                    this.tempGuest = '';
                    this.showAddMealSet = false;
                }
            } else if (status==1) {window.confirm(`Bạn Chưa Thể Thay Đổi Thông Tin` );}
            else window.confirm(`Bạn Không Thể Thay Đổi Thông Tin` );
        },

        removeDateBtn(index,bill_id,status) {
            if (status>=2 && status<=3) {
                let temp = index + 1 ;
                let confirmResult = window.confirm(`Hủy Suất thứ ` + temp +`? Yêu cầu sẽ được gửi cho cửa hàng!` );
                if (confirmResult) {
                    let data1 = {
                        email: '',
                        title:`Đơn hàng #${bill_id} được yêu cầu cập nhật!`,
                        content: `Nội dung: Xóa Suất đãi khách thứ ${parseInt(index + 1)}.`,
                        auth: `Khách hàng `+this.user.user_name+`.`,
                    }
                    try {
                        axios.post(`/sendemail/request`,data1);
                    } catch (error) {
                        console.error("Error Send email request:", error);
                    }        
                }
            } else if (status==1) {window.confirm(`Bạn Chưa Thể Thay Đổi Thông Tin` );}
            else window.confirm(`Bạn Không Thể Thay Đổi Thông Tin` );
        },

        updateDateBtn(index,bill_id,status) {
            if (status>=2 && status<=3) {
                let temp = index + 1 ;
                let confirmResult = window.confirm(`Hủy Suất thứ ` + temp +`? Yêu cầu sẽ được gửi cho cửa hàng!` );
                if (confirmResult) {
                    let data = {
                        dd_time: this.selectedTime[index],
                        dd_guest: this.selectedGuest[index],
                    };
                    let data1 = {
                        email: '',
                        title:`Đơn hàng #${bill_id} được yêu cầu cập nhật!`,
                        content: `Nội dung: Cập nhật Suất đãi khách thứ ${parseInt(index + 1)} thành ${data.dd_time} với số lượng khách ${data.dd_guest}.`,
                        auth: `Khách hàng `+this.user.user_name+`.`,
                    }
                    try {
                        axios.post(`/sendemail/request`,data1);
                    } catch (error) {
                        console.error("Error Send email request:", error);
                    }
                }
            } else if (status==1) {window.confirm(`Bạn Chưa Thể Thay Đổi Thông Tin` );}
            else window.confirm(`Bạn Không Thể Thay Đổi Thông Tin` );
        },

        saveAdd(address,bill_id,status){
            if (status>=2 && status<=3) {
                let confirmResult = window.confirm(`Thay đổi địa chỉ thành ` + address +`? Yêu cầu sẽ được gửi cho cửa hàng!` );
                if (confirmResult) {
                    let data1 = {
                        email: '',
                        title:`Đơn hàng #${bill_id} được yêu cầu cập nhật!`,
                        content: `Nội dung: Cập nhật Địa chỉ khách hàng thành ${address}.`,
                        auth: `Khách hàng `+this.user.user_name+`.`,
                    }
                    try {
                        axios.post(`/sendemail/request`,data1);
                    } catch (error) {
                        console.error("Error Send email request:", error);
                    }
                }
            } else if (status==1) {window.confirm(`Bạn Chưa Thể Thay Đổi Thông Tin` );}
            else window.confirm(`Bạn Không Thể Thay Đổi Thông Tin` );
        },

        savePhone(phone,bill_id,status){
            if (status>=2 && status<=3) {
                let confirmResult = window.confirm(`Thay đổi Số điện thoại thành ` + phone +`? Yêu cầu sẽ được gửi cho cửa hàng!` );
                if (confirmResult) {
                    let data1 = {
                        email: '',
                        title:`Đơn hàng #${bill_id} được yêu cầu cập nhật!`,
                        content: `Nội dung: Cập nhật Số điện thoại khách hàng thành ${phone}.`,
                        auth: `Khách hàng `+this.user.user_name+`.`,
                    }
                    try {
                        axios.post(`/sendemail/request`,data1);
                    } catch (error) {
                        console.error("Error Send email request:", error);
                    }
                }
            } else if (status==1) {window.confirm(`Bạn Chưa Thể Thay Đổi Thông Tin` );}
            else window.confirm(`Bạn Không Thể Thay Đổi Thông Tin` );
        },




    },
    components: { ProductBill , ProductOrder}
}
</script>

<style scoped>
.my-order{
    display: flex;
    align-items: center;
    justify-content: center;
    padding-top: 1%;
    padding-bottom: 5%;
}

.my-order .my-order-inner {
    width: 80%;
    height: 80%;
    background-color: #f2f2f2; 
    box-shadow: 0 1px 1px #999999;
    opacity: 1;
    padding: 32px;
    border: none; /* Clear border */
    border-radius: 20px;
}

.my-order .my-order-inner h2 {
    margin: 0;
    font-size: 32px;
    color: #ef87aa;
    margin-bottom: 20px;
}

.my-order .my-order-inner .product-detail .image img {
    height: 8rem;
    width: 8rem;
    margin: 20px;
}

.my-order .my-order-inner .product-detail .content {
    margin-top: 20px;
    font-size: 12px;
    width: 100%;
}

.my-order .my-order-inner .product-detail .content p:first-of-type {
    font-size: 16px;
    color: #ef87aa;
}

.my-order .my-order-inner .product-detail .content p span {
    font-size: 14px;
    color: black;
}

.my-order .my-order-inner .price {
    margin-top: 30px;
    font-size: 16px;
}

@media (max-width: 768px) {
    .my-order .my-order-inner {
        width: 80vw;
        height: 60vh;
    }

    .my-order .my-order-inner h2 {
        font-size: 20px;
    }

    .my-order .my-order-inner .product-detail .content .desc,
    .my-order .my-order-inner .product-detail .content .name span {
        font-size: 12px !important;
    }

    .my-order .my-order-inner .product-detail .content .name {
        font-size: 14px !important;
    }
}

@media (max-width: 576px) {
    .my-order .my-order-inner {
        width: 90vw;
        height: 65vh;
    }

    .my-order .my-order-inner div:first-of-type {
        flex-direction: column;
    }
}

@media (max-width: 376px) {
    .my-order .my-order-inner {
        width: 90vw;
        height: 65vh;
        padding: 5px !important;
    }

    .my-order .my-order-inner .product-detail .content .name {
        font-size: 12px !important;
    }
}

</style>