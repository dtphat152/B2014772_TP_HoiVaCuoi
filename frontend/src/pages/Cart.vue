<template>
    <vue-basic-alert :duration="300" :closeIn="2000" ref="alert" />
    <div class="shopping-cart-section pt-4">

        <div class="heading">
        </div>
        <section class="h-100 h-custom" style="background-color:none">
            <div class="h-100" style="width: 90%;padding-left: 10%;">
                <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12">
                    <div class="card card-registration card-registration-2" 
                        style="background-color: #d9d9d9; opacity: 0.8;border-radius: 15px;">
                    <div class="card-body p-0">
                        <div class="row g-0">

                        <div class="col-lg-8">
                            <div class="p-5">
                            <div class="d-flex justify-content-between align-items-center mb-5">
                                <h1 class="mb-0" style="color: #FF0099; font-weight: 900;">Dánh sách Dịch Vụ</h1>
                            </div>
                            <hr class="my-4">

                            <div class="" style="overflow-y: auto; height: 600px;">
                                <div style="width: 95%;">
                                <template v-for="(category, catIndex) in ['Khai Vị', 'Món Chính', 'Tráng Miệng','Bàn Ghế','Rạp Che','Cổng Hoa','Sảnh Tiệc','Gia Tiên','Mâm Quả','Xe Hoa']" :key="catIndex">
                                    <h3 class="mb-2 mb-2" style="color: #d35ea4;font-weight: 900;">{{ category }}</h3>
                                    <div v-for="(f, index) in filterProducts" :key="index">
                                        <div v-if="f.product_category === category" class="row mb-1 d-flex justify-content-between align-items-center"
                                        style="background-color: #ffb3cc; border-radius: 15px;margin-left: 10px;">
                                            <!-- Content for each product -->
                                            <div class="col-md-2 col-lg-2 col-xl-2" style="padding-left: 0px;">
                                                <img :src="require(`../assets/images/${f.product_src}`)" alt="" class="cart-product-img" 
                                                style="width: 100px; border-radius: 10px;">
                                            </div>
                                            <div class="col-md-3 col-lg-3 col-xl-4">
                                                <h4 class="text-black mb-0" style="font-weight: 900;color: black;">{{ f.product_name }}</h4>
                                                <h5 style="font-weight: 900;color: #d35ea4;">{{ formatCurrency(f.product_price) }}</h5>
                                            </div>
                                            <div class="col-md-3 col-lg-2 col-xl-2">
                                                <input type="number" id="number" v-model="itemQuantity[index]" @change="onQtyChange(index)"
                                                    class="form-control " min="0" max="1000" 
                                                    style="border: none; text-align: center; background: #d9d9d9; color: black;font-weight: 900; border-radius: 10px;">
                                            </div>
                                            <div class="col-md-3 col-lg-2 col-xl-2">
                                                <h6 class="mb-0" style="font-weight: 900; font-size: 15px;">{{ formatCurrency(calculateItemPrice(index)) }}</h6>
                                            </div>
                                            <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                                <button class="btn" @click="removeBtn(index)" 
                                                style="background: #d9d9d9; color: black;font-weight: 900; border-radius: 10px;">
                                                    <i class="fa fa-trash"></i>
                                                </button>
                                            </div>
                                            
                                        </div>
                                        <!-- Form group for each product -->
                                        <div v-if="f.product_category === category" class="row mb-5" 
                                            style="background-color: #ffb3cc; margin-left: 10px; border-radius: 10px;">
                                            <div class="form-group col-10">
                                                <input type="text" placeholder="Ghi chú..." class="form-control" 
                                                    style="border: none; font-weight: bold; background-color: #ffb3cc; color: black; font-size: 13px;" 
                                                    v-model="itemNotes[index]"
                                                >
                                            </div>
                                            <div class="col-2 text-right mt-2">
                                                <button @click="updateItemNotes(index)" 
                                                style="background-color: #d35ea4;border-radius: 5px; padding: 2px; margin: 2px; color: white;">Lưu</button>
                                                <button @click="deleteNotes(index)" 
                                                style="background-color: #d35ea4; border-radius: 5px; padding: 2px;  margin: 2px; color: white;">Xóa</button>
                                            </div>
                                            <br>
                                        </div>
                                    </div>
                                   
                                    <hr class="my-4">
                                </template>
                                </div>
                            </div>
                        <div class="pt-5">
                            <router-link to="/booking" class="text-black-50"><h5 style="font-weight: 800;">Tiếp tục Đặt hàng</h5>
                            </router-link>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 bg-grey">
                    <div class="p-5">
                    <h3 class="mb-5 mt-2 pt-1" style="color: #FF0099; font-weight: 900; ">Thông tin</h3>
                    <hr class="my-4">
                    
                    <div class="row mt-2 m-1">
                        <div class="col-10" style="background-color: #ffb3cc; border-radius: 15px;">
                            <div class="row d-flex justify-content-around p-2">
                                <h4 class="mt-2" style="color: black;font-weight: 900;">Ngày tổ chức</h4>
                                <input type="date" class="form-control" id="startDateInput" v-model="formattedStartDate"
                                style="background-color: #d9d9d9; font-weight: 900; text-align: center; border-radius: 15px; font-size: 15px; width: 180px; color: black;" >
                                <button @click="changeDate()" 
                                    style="background-color: #ffb3cc; border-radius: 15px;" class="px-2 my-1"><h5 style="font-weight: 900;">Lưu</h5></button>
                            </div>
                        </div>
                        <div class="col-2 text-center" style="background-color: #ffb3cc; border-radius: 15px;">
                            <button @click="showAddMealSetFunction()" style="background-color: #ffb3cc; padding-top: 5px;"><h5 style="font-weight: 900;">Thêm Suất</h5></button>
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
                            <button class="btn" @click="saveDateBtn()">
                                <h5 style="font-weight: 900;">Lưu</h5>
                            </button>
                        </div>
                    </div>  
                    <div v-for="(time, index) in this.selectedTime" :key="index">
                        <div class="row align-items-center m-1 mt-3" style="background-color: #d9d9d9; border-radius: 15px; padding-top: 5px;">
                            <div class="col-4 text-left">
                                <h5 style="color: black;font-weight: 900;">Suất thứ {{ index+1 }}</h5>
                            </div>
                            <div class="col-3">
                                <input title="Số Khách" type="number" :id="'number-' + index" class="form-control mb-3" min="0" max="1000" 
                                v-model="this.selectedGuest[index]" style="border: none; text-align: center; background: #d9d9d9; font-weight: 900; font-size: 14px; color: black;">
                            </div>
                            <div class="col-2">
                                <input type="time" :id="'time-' + index" v-model="this.selectedTime[index]" style=" background: #d9d9d9; font-weight: 900; font-size: 14px; margin-bottom: 5px;">
                            </div>
                            <div class="col-1 ">
                                <button class="btn" @click="removeDateBtn(index)"
                                    style="border-radius: 10px; background-color: #d9d9d9;">
                                    <h5 style="font-weight: 900;">Xóa</h5>
                                </button>
                            </div>
                            <div class="col-1 ">
                                <button class="btn" @click="updateDateBtn(index)"
                                    style="border-radius: 10px; background-color: #d9d9d9;">
                                    <h5 style="font-weight: 900;">Lưu</h5>
                                </button>
                            </div>
                        </div>   
                    </div>
                    <br>

                    <div class="form-group">
                        <textarea name="txtMsg" class="form-control" placeholder="Những điều bạn yêu cầu hoặc lưu ý" 
                            style="width: 100%; height: 50px; border: none; font-weight: 800; background: #ffb3cc; color: black; border-radius: 10px; font-size: 14px;" 
                            v-model="checkoutObj.notes" >
                        </textarea>
                    </div>
                    <div class="form-group">
                        <input type="text" name="coPhone" id="coPhone" placeholder="Phone number" class="form-control"
                        style="width: 100%; border: none; background: #ffb3cc; color: black; border-radius: 10px; font-weight: 900; font-size: 14px;" v-model="checkoutObj.phone" />
                    </div>
                    <div class="form-group">
                        <textarea type="text" name="coAddress" id="coAddress" placeholder="Address..."
                        style="width: 100%; border: none; background: #ffb3cc; color: black; border-radius: 10px; font-weight: 900; font-size: 14px;" class="form-control" v-model="checkoutObj.address" />
                    </div>
                    
                    <div class="row">
                        <div class="col-5">
                            <button style="width: 100%; background-color: #d9d9d9;" @click="showVoucher()">
                                <div class="row pl-4">
                                    <h4 style="font-weight: 800;">Chọn Voucher</h4> 
                                    <i class="fa-solid fa-ticket ml-3" style="font-size: 20px"></i> 
                                </div>  
                            </button>
                        </div>
                        <div class="col-7 text-right"> 
                            <h4 v-if="selectedVoucher!=0" style="font-weight: 800;">{{ formatCurrency(this.selectedVoucher) }}</h4> 
                            <h5 v-else style="font-weight: 800; color: #999999; padding-top: 3px;">Chưa có voucher được chọn</h5> 
                        </div>
                    </div>

                    <div v-if="showvoucher">
                        <div class="row justify-content-center">
                            <div class="col-10" v-for="(v, index) in voucherList.slice().reverse()" :key="index">
                                <div class="voucher row mt-3" style="background-color: #ffccdd; border-radius: 15px;">
                                    <div class="col-5">
                                        <h5 class="text-center" style="font-weight: 900; color: #ff667d;">TP-Voucher</h5>
                                        <h5 v-if="v.voucher_status==1" class="text-center" style="font-weight: 900; color: #2E8B57;">Chưa sử dụng</h5>
                                        <h5 v-if="v.voucher_status==2" class="text-center">Đang sử dụng</h5>
                                        <h5 v-if="v.voucher_status==0" class="text-center">Đã sử dụng</h5>
                                    </div>
                                    <div class="col-5 pt-3">
                                        <h3 class="text-center" style="font-weight: 900;">{{ formatCurrency(v.voucher_value) }}</h3>
                                    </div>
                                    <div class="col-2" style="padding-top: 5px;">
                                        <button class="btn" style="border-radius: 15px; font-weight: 800;" @click="addVoucher(v.voucher_id,v.voucher_value,v.voucher_status)">Chọn</button>
                                    </div>
                                </div>
                                <br>
                            </div>
                        </div>
                    </div>

                    <hr class="my-4">
                    <div class="d-flex justify-content-between mb-3">
                        <h5 class="text-uppercase" style="font-weight: 800;">Số lượng Bàn tiệc</h5>
                        <h5 style="font-weight: 800;">{{ tableNum }} </h5>
                    </div>
                    <div class="d-flex justify-content-between mb-3">
                        <h5 class="text-uppercase" style="font-weight: 800;">Giá mỗi Bàn (mâm)</h5>
                        <h5 style="font-weight: 800;">{{ formatCurrency(PriceOfTable())}} </h5>
                    </div>
                    <div class="d-flex justify-content-between mb-3">
                        <h5 class="text-uppercase" style="font-weight: 800;">Giá thành</h5>
                        <h5 style="font-weight: 800;">{{ formatCurrency(calculateSummaryPrice()+this.selectedVoucher) }}</h5>
                    </div>
                    <div v-if="this.selectedVoucher" class="d-flex justify-content-between mb-3">
                        <h5 class="text-uppercase" style="font-weight: 800;">Khuyến mãi</h5>
                        <h5 style="font-weight: 800;">- {{ formatCurrency(this.selectedVoucher) }}</h5>
                    </div>
                    <div class="d-flex justify-content-between mb-3">
                        <h5 class="text-uppercase" style="font-weight: 800;">Tổng Thanh Toán</h5>
                        <h5 style="font-weight: 800;">{{ formatCurrency(calculateSummaryPrice()) }}</h5>
                    </div>

                    <button type="button" @click="checkOutBtn()" class="btn btn-block"  
                        style="background-color: #FF0099; color: white; border-radius: 15px;"><h5 style="font-weight: 900;">Gửi Đơn Hàng</h5></button>
                    </div>
                </div>

                </div>
            </div>
            </div>
            </div>
            </div>
        </div>
        </section>
    </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
import VueBasicAlert from 'vue-basic-alert';
export default {
    name: "Cart",
    data() {
        return {
            cartItem: [],
            itemQuantity: [],
            itemNotes: [],
            voucherList: [],
            checkoutObj: {notes:"", phone: "", address: ""},
            dateID: '',
            date: '',
            selectedTime: [],
            selectedGuest: [],
            tempGuest: '',
            tempTime: '',
            tableNum: 0,
            tien: 100000,
            showAddMealSet: false,
            selectedVoucher: 0,
            selectedVoucher_id: null,
            showvoucher: false,
        };
    },

    created(){

    },

    mounted() {
        this.getAllCartItem();
        this.loadInfo();
        this.getDate();
        this.getNum();
        this.getVoucher();
    },

    computed: {
        ...mapState(["allProducts", "user"]),

        filterProducts: function () {
            return this.allProducts.filter((f) => this.matchID(f, this.cartItem));
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
        formatCurrency(amount) {
            if (!amount) return '';
            return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
        },

        matchID: function (product, cartArray) {
            return cartArray.includes(product.product_id);
        },
        async getAllCartItem() {
            if (this.user) {
                let existItem = await axios.get('/cartItem/' + this.user.user_id);
                existItem.data.forEach(element => {
                    this.cartItem.push(element.product_id);
                    this.itemQuantity.push(element.item_qty);
                    this.itemNotes.push(element.item_notes);
                });
            }
        },

        showVoucher() {
            this.showvoucher = !this.showvoucher;
        },
        async getVoucher() {
            try {
                let rsp = await axios.get(`/voucher/user/${this.user.user_id}`);
                this.voucherList = rsp.data
                    .filter(voucher => voucher.vc_status === 1)
                    .map(voucher => ({
                        voucher_id: voucher.vc_id,
                        voucher_value: voucher.vc_value,
                        voucher_status: voucher.vc_status,
                    }));
                console.log(this.voucherList);
            } catch (error) {
                console.error('Error while getting Voucher:', error);
            }
        },

        addVoucher(id,value,status){
            if(status==1){
                if(this.selectedVoucher!=0) this.selectedVoucher=0
                else {
                    this.selectedVoucher=value;
                    this.selectedVoucher_id = id;
                    this.showvoucher = false;
                }
            }
        },

        showAddMealSetFunction() {
            this.showAddMealSet = !this.showAddMealSet;
        },

        async loadInfo() {
            try {           

            this.checkoutObj = {
                phone: this.user.user_phone,
                address: this.user.user_address,
            };
            } catch (error) {
            console.error('Error fetching product:', error);
            }
        },
        
        formatDate(date) {
            if (date) {
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

        async getDate() {
            if (this.user) {
                try {
                    const response = await axios.get('/date/' + this.user.user_id);
                    if (response.data.length > 0) {
                        this.dateID = response.data[0].date_id;
                        const dateString = response.data[0].date_date;
                        const parts = dateString.split("-");
                        const year = parseInt(parts[2]);
                        const month = parseInt(parts[0]) - 1; // Trừ đi 1 vì tháng trong JavaScript bắt đầu từ 0
                        const day = parseInt(parts[1]);
                        this.date = new Date(year, month, day);
                        
                    } else {
                        this.dateID =  '';
                    }
                } catch (error) {
                    console.error('Đã xảy ra lỗi khi lấy dữ liệu dateID:', error);
                    this.dateID =  '';
                }
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

        async changeDate() {
            if (this.user) {
                let dateSelect = {
                    date_date: this.formatDateToSubmit(this.date),
                    user_id: parseInt(this.user.user_id),
                };
                try {
                let existDate = await axios.get('/date/' + this.user.user_id);

                if (existDate.data.length > 0) {
                    await axios.put("/date", dateSelect);
                    window.confirm(`Ngày Tổ Chức đã được thay đổi!`)
                } else {
                    await axios.post("/date", dateSelect);
                    window.confirm(`Ngày Tổ Chức đã được lưu lại!`)
                }
                } catch (error) {
                    console.error('Error submitting date:', error);
                    window.confirm(`Lỗi khi xác nhận ngày Tổ chức!`)
                }
            } 
        },

        async removeDateBtn(index) {
            let temp = index + 1 ;
            let confirmResult = window.confirm("Xác Nhận Hủy Suất Thứ " + temp );
            if (confirmResult) {
                let data = {
                    date_id: this.dateID,
                    dd_name: temp,
                };
                console.log(data);
                try {
                    await axios.delete(`/datedetails/detail/`, { data });            
                        console.log("Xóa thành công")
                        this.$refs.alert.showAlert('success', 'Success!', 'The Meat Set is deleted!')
                        this.selectedTime.splice(index, 1)
                        this.selectedGuest.splice(index, 1)                          
                } catch (error) {
                    console.error("Lỗi khi thực hiện xóa: ", error);
                }

                this.getNum();
                // this.setQuantity();
            }
        },
        async updateDateBtn(index) {
            let data = {
                date_id: this.dateID,
                dd_name: index + 1,
                dd_time: this.selectedTime[index],
                dd_guest: this.selectedGuest[index],
            };
            try {
                await axios.put('/datedetails/', data);
                console.log('Dữ liệu đã được chỉnh sửa thành công');
                console.log(data);
                // Sau khi cập nhật thành công, gọi hàm để lấy lại dữ liệu
                this.$refs.alert.showAlert('success', 'Thành Công!', 'Suất Đãi Khách đã được Cập nhật!');
                await this.getNum();
            } catch (error) {
                console.error('Lỗi khi chỉnh sửa dữ liệu:', error);
            }
        },

        calculateItemPrice: function (index) {
            let a = 0;
                a = parseInt(this.filterProducts[index].product_price) * this.itemQuantity[index];
            return a;
        },

        PriceOfTable: function () {
            let subtotal = 0;
            let i = 0;
             while (i < this.itemQuantity.length) {
                if (this.filterProducts[i].product_category=="Khai Vị" || this.filterProducts[i].product_category=="Món Chính" || this.filterProducts[i].product_category=="Tráng Miệng") {
                    subtotal = subtotal + parseInt(this.filterProducts[i].product_price);
                }
                i = i + 1;
            }
            return subtotal;
        },

        calculateSummaryPrice: function () {
            let subtotal = 0;
            let i = 0;
            while (i < this.itemQuantity.length) {
                subtotal = subtotal + this.calculateItemPrice(i)
                i = i + 1
            }
            return subtotal-this.selectedVoucher;
        },

        async getNum() {
            if (this.user) {
                try {
                    await this.getDate();
                    let response = await axios.get(`/datedetailsnobill/${this.dateID}`);
                    let data = response.data;
                    if (data && data.length > 0) {
                        let selectedTimes = [];
                        let selectedGuests = [];
                        this.tableNum=0;
                        // Lặp qua mỗi phần tử trong mảng data
                        data.forEach(item => {
                            selectedTimes.push(item.dd_time);
                            selectedGuests.push(item.dd_guest);
                            this.tableNum += item.dd_guest
                        });
                        // Gán giá trị của các mảng cho selectedTime và selectedGuest
                        this.selectedTime = selectedTimes;
                        this.selectedGuest = selectedGuests;

                        
                        this.tableNum = this.tableNum / 10;
                        this.setQuantity();
                    } else {
                        this.tableNum = 0;
                    }
                } catch (error) {
                    console.error('Lỗi khi lấy Số lượng bàn:', error);
                }
            }
        },

        async setQuantity(){
            try {
                this.itemQuantity.forEach((qty, index) => {
                            if (this.filterProducts[index].product_category === 'Khai Vị' 
                             || this.filterProducts[index].product_category === 'Món Chính'
                             || this.filterProducts[index].product_category === 'Tráng Miệng') {
                                this.itemQuantity[index] = this.tableNum;
                            }
                            if (this.filterProducts[index].product_category === 'Rạp Che' ) {
                                // if (this.itemQuantity[index] < Math.ceil(this.tableNum / 2)) 
                                this.itemQuantity[index] = Math.ceil(this.tableNum / 2);
                            }
                            if (this.filterProducts[index].product_category === 'Bàn Ghế' ) {
                                this.itemQuantity[index] =this.tableNum;
                            }
                            let data = {
                                user_id: parseInt(this.user.user_id),
                                product_id: parseInt(this.cartItem[index]),
                                item_qty: this.itemQuantity[index],
                                item_notes: this.itemNotes[index]
                            };
                            axios.put("/cartItem/", data)
                        });
            } catch (error) {
                console.error('Lỗi khi cài Số Lượng:', error);
            }
        },

        async saveDateBtn() {
            let data = {
                date_id: this.dateID,
                dd_name: this.selectedTime.length + 1,
                dd_time: this.tempTime,
                dd_guest: this.tempGuest,
            };

            try {
                await axios.post('/datedetails/', data);
                console.log('Dữ liệu đã được submit thành công:');
                console.log(data);
                // Sau khi cập nhật thành công, gọi hàm để lấy lại dữ liệu
                await this.getNum();
                this.tempTime = '';
                this.tempGuest = '';
                this.showAddMealSet = false;
            } catch (error) {
                console.error('Lỗi khi submit dữ liệu:', error);
            }
        },

        async onQtyChange(i) {
            let data = {
                user_id: parseInt(this.user.user_id),
                product_id: parseInt(this.cartItem[i]),
                item_qty: this.itemQuantity[i],
                item_notes: this.itemNotes[i]
            };
            let confirmResult = window.confirm("Bạn có chắc chắn muốn thay đổi số lượng sản phẩm thành " + this.itemQuantity[i] + "?" );
            if (confirmResult) {
                await axios.put("/cartItem/", data)
            }
        },
        
        async updateItemNotes(i) {
            let data = {
                user_id: parseInt(this.user.user_id),
                product_id: parseInt(this.cartItem[i]),
                item_qty: this.itemQuantity[i],
                item_notes: this.itemNotes[i]
            };
            let confirmResult = window.confirm("Bạn có chắc chắn muốn thay đổi Ghi chú của sản phẩm?");
            if (confirmResult) {
                try {
                    await axios.put("/cartItem/", data);
                    console.log("Đã cập nhật Ghi chú thành công.");
                } catch (error) {
                    console.error("Đã xảy ra lỗi khi cập nhật Ghi chú:", error);
                }
            }
        },

        async deleteNotes(i) {
            let data = {
                user_id: parseInt(this.user.user_id),
                product_id: parseInt(this.cartItem[i]),
                item_qty: this.itemQuantity[i],
                item_notes: ""
            };
            let confirmResult = window.confirm("Bạn có chắc chắn muốn xóa bỏ Ghi chú của sản phẩm?");
            if (confirmResult) {
                try {
                    await axios.put("/cartItem/", data);
                    console.log("Đã xóa Ghi chú thành công.");
                } catch (error) {
                    console.error("Đã xảy ra lỗi khi xóa Ghi chú:", error);
                }
            }
        },

        async removeBtn(index) {
            await axios.delete("/cartItem/" + this.user.user_id + "/" + this.cartItem[index]);

            this.cartItem.splice(index, 1);
            this.itemQuantity.splice(index, 1);
        },

        async sendBillDetails(billId, productId, qty , notes) {
            let billDetails = {
                bill_id: parseInt(billId),
                product_id: parseInt(productId),
                item_qty: parseInt(qty),
                item_notes: notes,
            }

            await axios.post("/billdetails", billDetails);
        },

        async checkOutBtn() {
            let confirmResult = window.confirm("Xác Nhận Gửi Yêu Cầu" );
            if (confirmResult) {
                let billId = (await axios.get("/billstatus/new")).data;

                if (billId == "") {
                    billId = 1
                } else {
                    billId = parseInt(billId.bill_id) + 1
                }

                this.cartItem.forEach((productId, index) => {
                    this.sendBillDetails(billId, productId, this.itemQuantity[index], this.itemNotes[index])
                });

                var now = new Date();
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var hour = ("0" + (now.getHours())).slice(-2);
                var min = ("0" + (now.getMinutes())).slice(-2);
                var currentTime = day + "/" + month + "/" + now.getFullYear() + " - " + hour + ":" + min;


                let billStatus = {
                    bill_id: parseInt(billId),
                    user_id: parseInt(this.user.user_id),
                    date_id: this.dateID,
                    voucher_id: this.selectedVoucher_id,
                    bill_phone: this.checkoutObj.phone,
                    bill_address: this.checkoutObj.address,
                    bill_when: currentTime,
                    bill_discount: this.selectedVoucher,
                    bill_deposits: parseInt(this.calculateSummaryPrice()/10),
                    bill_total: parseInt(this.calculateSummaryPrice()),
                    bill_notes: this.checkoutObj.notes,
                    bill_status: 1
                }

                axios.post("/billstatus", billStatus);
                axios.delete("/cartItem/" + this.user.user_id);
                let dataDateBill = {
                    date_id: this.dateID,
                    date_date: this.formatDateToSubmit(this.date),
                    bill_id: parseInt(billId)
                }
                axios.post("/datebill",dataDateBill)
                let voucher = {
                    vc_status: 2,
                    vc_id: this.selectedVoucher_id,
                }
                axios.put(`/voucher/status`,voucher)
                axios.delete(`/date/${this.user.user_id}`)
                this.cartItem = [];
                this.itemQuantity = [];

                this.$router.push("/myorder");
            }
        }


    },
    components: { VueBasicAlert }

}
</script>

<style></style>