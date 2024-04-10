<template>
    <div class="order-details">
        <div class="order-details-inner">
            <h2 class="d-flex justify-content-between">Order Details 
                
                <div>
                    <button @click="sendBillId(this.bill[0])" class="btn mr-2" style="background-color: #40bf77; border-radius: 10px;">Add to bill</button>
                    <slot></slot>
                </div>
            </h2>
            
            <div class="row">
                
            </div>
            <div class="row">
                <div class="col-8">
                    <ProductBill v-if="!showProductOrder" :Bill=[this.bill[0],this.email] ></ProductBill>

                    <ProductOrder v-if="showProductOrder" :ID="sendId" >
                        <button style="color: #c0c0c0; background-color: white;" @click="closeView()"><h5>Trở Về</h5></button>
                    </ProductOrder>                    
                </div>
                <div class="col-4">
                    <div class="row">
                        <div class="col-10 form-group" style="padding-right: 0; margin: 0;">
                        <textarea name="txtMsg" class="form-control" placeholder="Ghi chú của khách hàng..." 
                            style="width: 100%; border: none;  background-color: #FFF0F5; border-radius: 15px;" v-model="notes" ></textarea>
                        </div>
                        <div class="col-1">
                            <button class="btn" style="height: 100%; background-color: #FFF0F5; border-radius: 10px;" @click="updateBillNotes()">Lưu</button>
                        </div>
                    </div>
                    

                    <hr style="background-color: #FFF0F5;">
                    <div>
                        <div class="row mt-2 m-1">
                            <div class="col-8" style="background-color: #ffccdd; border-radius: 15px;">
                                Ngày tổ chức: {{ this.date }}
                            </div>
                            <div class="col-4 text-center" style="background-color: #ffb3cc; border-radius: 15px;">
                                <button @click="showAddMealSetFunction()" style="background-color: #ffb3cc;">Thêm</button>
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
                            <div class="row pt-2 align-items-center m-1" style="background-color: #FFF0F5; border-radius: 15px;">
                                <div class="col-3 text-left">
                                    <h6>Suất thứ {{ index+1 }} : </h6>
                                </div>
                                <div class="col-3">
                                    <input title="Số Khách" type="number" :id="'number-' + index" class="form-control " min="0" max="1000" 
                                    v-model="this.selectedGuest[index]" style="border: none; text-align: center; background: #FFF0F5;">
                                </div>
                                <div class="col-3">
                                    <input type="time" :id="'time-' + index" v-model="this.selectedTime[index]" style=" background: #FFF0F5;">
                                </div>
                                <div class="col-1 ">
                                    <button class="btn" @click="removeDateBtn(index)">
                                        Xóa
                                    </button>
                                </div>
                                <div class="col-1 ">
                                    <button class="btn" @click="updateDateBtn(index)">
                                        Lưu
                                    </button>
                                </div>
                            </div>   
                        </div>
                
                    </div>
                    <hr>
                    
                </div>
            </div>
            <hr style="background-color: #FFF0F5; height: 3px;">
            
        </div>
    </div>
</template>

<script>
import ProductBill from "./ProductBill.vue";
import ProductOrder from "./ProductOrder.vue";
import axios from "axios";
export default {
    props: ['bill'],
    name: "OrderDetail",

    data() {
        return {
            email: '',

            notes:"",

            date:'',
            selectedTime: [],
            selectedGuest: [],

            showAddMealSet : false,
            tempGuest: '',
            tempTime: '',

            billMatch: undefined,

            showProductOrder: false,
            sendId: undefined,
        }
    },

    created() {
        this.getEmail();
        this.getNotes();
        this.getBillStatus();
        this.getMeatSet();
    },

    computed: {
       
    },

    methods: {

        closeView: function () {
            this.showProductOrder = !this.showProductOrder;
        },

        sendBillId: function (id) {
            this.sendId = id
            this.showProductOrder = !this.showProductOrder;
        },

        async getBillStatus() {
            if (this.bill[0]) {
                this.billMatch = (await axios.get('/billstatus/bill/' + this.bill[0])).data[0];
            }
        },

        showProductOrderFunction() {
            this.showProductOrder = !this.showProductOrder;
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

        async getMeatSet() {
            console.log('Check: ');
            if (this.bill[2]) {
                console.log('Check: ' + this.bill[2]);
                try {
                    let response = await axios.get(`/datedetails/${this.bill[2]}`);
                    let data = response.data;
                    this.date = data[0].date_date;
                    if (Array.isArray(data) && data.length > 0) {
                        // Khởi tạo các mảng để lưu trữ dữ liệu từ mỗi phần tử
                        let selectedTimes = [];
                        let selectedGuests = [];
                        // Lặp qua mỗi phần tử trong mảng data
                        data.forEach(item => {
                            selectedTimes.push(item.dd_time);
                            selectedGuests.push(item.dd_guest);
                        });
                        // Gán giá trị của các mảng cho selectedTime và selectedGuest
                        this.selectedTime = selectedTimes;
                        this.selectedGuest = selectedGuests;
                    } else {
                        this.selectedTime = []; 
                        this.selectedGuest = []; 
                    }
                    console.log('Check2: ' + this.selectedTime);
                } catch (error) {
                    console.error('Lỗi khi lấy dữ liệu từ API:', error);
                }
                
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
                        this.$refs.alert.showAlert('success', 'Success!', 'The Meat Set is deleted!');
                        this.selectedTime.splice(index, 1);
                        this.selectedGuest.splice(index, 1);
                        
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
                console.log('Dữ liệu đã được chỉnh sửa thành công');
                console.log(data);
                // Sau khi cập nhật thành công, gọi hàm để lấy lại dữ liệu
                await this.getMeatSet();

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
                console.log('Dữ liệu đã được submit thành công:');
                console.log(data);
                // Sau khi cập nhật thành công, gọi hàm để lấy lại dữ liệu
                await this.getMeatSet();
                this.tempTime = '';
                this.tempGuest = '';
                this.showAddMealSet = false;
        
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

    },

    components: { ProductOrder, ProductBill }
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
    background-color: rgba(0, 0, 0, 0.2);
    display: flex;
    align-items: center;
    justify-content: center;
    outline: none; /* Clear outline */
}

.order-details .order-details-inner {
    width: 80%;
    height: 80%;
    background-color: #fff;
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
