<template>
    <div class="container_order" style="width: 100%; padding-left: 260px; padding-right: 10px;">
        <div class="mt-5">
            <h1>Orders</h1>
            <h3 style="padding: 10px; background-color:#ffe6ea; border-radius: 15px;">
                <span :class="{ 'text-danger pr-5': orderCounts[1] }">
                    {{ orderCounts[1] ? 'Đơn Mới: ' + orderCounts[1] + '  ' : '' }}
                </span>
                <span :class="{ 'pr-5': orderCounts[2] }">
                    {{ orderCounts[2] ? 'Đang Chờ Cọc: ' + orderCounts[2] + '  ' : '' }}
                </span>
                <span :class="{ 'pr-5': orderCounts[3] }">
                    {{ orderCounts[3] ? 'Đang Thực Hiện: ' + orderCounts[3] + '  ' : '' }}
                </span>
                <span :class="{ 'text-success pr-5': orderCounts[4] }">
                    {{ orderCounts[4] ? 'Đã Hoàn Thành: ' + orderCounts[4] + '  ' : '' }}
                </span>
                
            </h3>
        </div>

        <div class="m-5">
            <!-- PROJECT TABLE -->
            
            <div v-for="(b) in filterBills.slice().reverse()" :key="b.bill_id" >
                <div class="row" :style="{ 'background-color': b.bill_status === 4 ? '#FFFAFA' : b.bill_status === 1 ? '#FFC0CB' : '#FFF0F5', 
                    'height': 'auto', 'margin-top': '5px', 'border-radius' : '15px' }">
                    <div class="col-1 d-flex align-items-center justify-content-center"
                        :style="{ 'color': b.bill_status === 4 ? '#00FF00' : b.bill_status === 1 ? '#FF0000' : ''}">
                        <h5 style="font-weight: bold;">{{ avaiableStatus[b.bill_status] }}</h5>
                    </div>
                    <div class="col-10 pt-3">
                        <div class="row">
                            <div class="col-1 text-right">
                                <button class="btn">
                                    <h5>#{{ b.bill_id }}</h5>
                                </button>
                            </div>
                            <div class="col-3">
                                <button class="btn pl-0">
                                    <h5>{{ b.userName }}</h5>
                                </button>
                            </div>
                            <div class="col-8 text-right">
                                <h6>{{ b.bill_when }}</h6>
                            </div>
                        </div>
                        <div class="row py-1">
                            <div class="col-1 offset-1">
                                <h6>{{ b.bill_phone }}</h6>
                            </div>
                            <div class="col-2">
                                <h6> {{ b.userDate }}</h6>
                            </div>
                            <div class="col-4">
                                <h6>{{ b.bill_address }}</h6>
                            </div>
                            <div class="col-4 text-right">
                                <button @click="sendBillId(b.bill_id,b.user_id,b.date_id)" class="btn px-0 mx-0" style="color: darkcyan;">xem chi tiết...</button>
                            </div>
                        </div>
                    </div>
                    <div class="col-1 px-0">
                        <button v-if="b.bill_status < 4 " class="p-2" @click="nextStatusBtn(b.bill_id,b.bill_status,b.user_id)" 
                            style="height: 100%;width: 70%; background-color: #ff99aa;">
                            {{ avaiableStatus[b.bill_status + 1] }}
                        </button>

                        <button v-if="b.bill_status >= 1 && b.bill_status <=3" class="p-2 " 
                            @click="cancelBtn(b.bill_id,b.user_id)" 
                            style="height: 100%;width: 30%;  border-start-end-radius: 15px; border-end-end-radius: 15px; background-color: #ff6680;">
                            Hủy
                        </button>

                        <button v-if="b.bill_status == 4 " class="btn p-2 ml-1" style="height: 100%; width: 100%; background-color: none; border-start-end-radius: 15px; border-end-end-radius: 15px;">
                            Ẩn
                        </button>
                    </div>
                </div>       
            
            </div>
             
        </div>
    </div>

    <OrderDetail v-if="showOrderDetails" :bill=[sendId1,sendId2,sendId3]>
        <button class="btn" style="background-color: #c0c0c0; border-radius: 10px;" @click="closeView">X</button>
    </OrderDetail>

</template>


<script>
import OrderDetail from "./component/OrderDetails.vue";
import axios from "axios";
import { mapState, mapMutations } from "vuex";
export default {
    name: 'Order',

    data() {
        return {
            avaiableStatus: ["Hủy", "Chờ", "Chấp Nhận", "Xác Nhận Cọc", "Hoành Thành"],
            allBills: [],
            showOrderDetails: false,
            sendId1: undefined,
            sendId2: undefined,
            sendId3: undefined 
        }
    },

    created() {
        this.getAllBills();
        if (!this.admin) {
            this.$router.push("/");
        }
    },


    computed: {
        ...mapState(["allProducts", "admin"]),

        orderCounts: function() {
            const counts = {};
            this.allBills.forEach(bill => {
                counts[bill.bill_status] = (counts[bill.bill_status] || 0) + 1;
            });
            return counts;
        },

        filterBills: function () {
            return this.allBills.filter((b) => b.bill_status <= 6 && b.bill_status > 0);
        },
    },

    methods: {
        ...mapMutations(["setAdmin"]),

        async getAllBills() {
            try {
                const response = await axios.get('/billstatus');
                const bills = response.data;
                for (const bill of bills) {
                    bill.userName = await this.showUserName(bill.user_id);
                    bill.userDate = await this.showUserDate(bill.user_id)
                }
                this.allBills = bills;
            } catch (error) {
                console.error("Error fetching bills:", error);
            }
        },


        sendBillId: function (id1,id2,id3) {
            this.sendId1 = id1;
            this.sendId2 = id2;
            this.sendId3 = id3;
            this.showOrderDetails = !this.showOrderDetails;
        },

        closeView: function () {
            this.showOrderDetails = !this.showOrderDetails;
        },

        handleLogout: function () {
            this.setAdmin("");
        },

        async showUserName(id){
            let userName = '';
            try {
                const response = await axios.get(`/users/byid/` + id);
                const user = response.data;
                userName = user.user_name;
            } catch (error) {
                console.error("Error fetching user:", error);
            }
            return userName;
        },

        async showUserDate(id) {
            let date = '';
            try {
                let existDate = await axios.get('/date/' + id);
                console.log('Selected Date 0:', existDate.data[0]);
                if (existDate.data.length > 0) {
                    date = existDate.data[0].date_date;  
                    console.log('Selected Date 1:', date);
                }
            } catch (error) {
                console.error('Lỗi khi lấy ngày tháng:', error);
            }
            if (!date) {
                console.log('Không có dữ liệu ngày được tìm thấy.');
                date = '';
            }
            console.log('Selected Date 2:', date);
            return date;
        },


        async getDate(id) {
            try {
                let existDate = await axios.get('/date/' + id);
                console.log('Dữ liệu được trả về từ axios.get:', existDate.data[0].date_start);
                if (existDate.data.length > 0) {
                return {
                    start: new Date(existDate.data[0].date_start),
                    end: new Date(existDate.data[0].date_end)
                };
                
                } else {
                return {
                    start: new Date(''),
                    end: new Date('')
                };
                }   
            } catch (error) {
                console.error('Đã xảy ra lỗi khi lấy dữ liệu ngày tháng:', error);
                return {
                start: new Date(''),
                end: new Date('')
                };
            }
        },

        formatDate(date) {
        if (date) {
            const year = date.getFullYear();
            let month = date.getMonth() + 1;
            let day = date.getDate();

            month = month < 10 ? `0${month}` : month;
            day = day < 10 ? `0${day}` : day;

            // Trả về chuỗi có định dạng "yyyy-MM-dd"
            return `${year}-${month}-${day}`;
        }

        return null;
        },



        async nextStatusBtn(id,bill_status,user_id) {
            if (bill_status==1) {
                let email = '';
                try {
                    const response = await axios.get(`/users/byid/` + user_id);
                    const user = response.data;
                    email = user.user_email;
                } catch (error) {
                    console.error("Error fetching user:", error);
                }
                let data = {
                    email: email,
                    content: "Chào bạn! Đơn hàng #"+id+" của bạn đã được chấp nhận. Cám ơn bạn đã chọn chung tôi!",
                }
                try {
                    axios.post(`/sendemail/status`,data);
                } catch (error) {
                    console.error("Error Send email:", error);
                }
            }
            await axios.put('/billstatus/' + id);
            this.getAllBills();
        },

        async paidBtn(id) {
            await axios.put('/billstatus/paid/' + id);
            await this.getAllBills();
        },

        async cancelBtn(id,user_id) {

            let email = '';
            try {
                const response = await axios.get(`/users/byid/` + user_id);
                const user = response.data;
                email = user.user_email;
            } catch (error) {
                console.error("Error fetching user:", error);
            }
            let data = {
                email: email,
                content: "Chào bạn! Chúng tôi đã hủy đơn hàng #"+id+" của bạn. Rất xin lỗi về việc hủy đơn!",
            }
            try {
                axios.post(`/sendemail/status`,data);
            } catch (error) {
                console.error("Error Send email:", error);
            }
        
            await axios.put('/billstatus/cancel/' + id);
            this.getAllBills();
        },

    },
    components: { OrderDetail }
}
</script>

<style scoped>

 

</style>