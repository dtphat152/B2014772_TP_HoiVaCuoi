<template>
    <div class="container_order" >
        <div class="row p-5" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; margin: 0 1px;">
            <div class="col-4">
                <h1 @click="filBill(0,3)">Orders</h1>
            </div>
            <div class="col-6">
                <div class="row" style="padding: 10px; background-color:#ffe6ea; border-radius: 15px;">
                    <div class="col text-center">
                        <button class="btn p-0 px-2 rounded-lg"  @click="filBill(0,1)" :style="{ 'background-color': (this.filbot === 0 && this.filtop === 1) ? '#fff' : '' }">
                            <h4 v-if="orderCounts[1]" style="font-weight: 900; text-align: center; color: #DC143C;">Đơn Mới ({{ orderCounts[1] }})</h4>
                            <h4 v-else style="font-weight: 900; text-align: center;">Đơn Mới (0)</h4>
                        </button>
                    </div>
                    <div class="col text-center" >
                        <button class="btn p-0 px-1 rounded-lg"  @click="filBill(1,2)" :style="{ 'background-color': (this.filbot === 1 && this.filtop === 2) ? '#fff' : '' }">
                            <h4 v-if="orderCounts[2]" style="font-weight: 900; text-align: center;">Chờ Cọc ({{ orderCounts[2] }})</h4>
                            <h4 v-else style="font-weight: 900; text-align: center;">Chờ Cọc (0)</h4>
                        </button>
                    </div>
                    <div class="col text-center">
                        <button class="btn p-0 rounded-lg"  @click="filBill(2,3)" :style="{ 'background-color': (this.filbot === 2 && this.filtop === 3) ? '#fff' : '' }">
                            <h4 v-if="orderCounts[3]" style="font-weight: 900; text-align: center; color: #008000;">Thực Hiện ({{ orderCounts[3] }})</h4>
                            <h4 v-else style="font-weight: 900; text-align: center;">Thực Hiện (0)</h4>
                        </button>
                    </div>
                    <div class="col text-center">
                        <button class="btn p-0 px-1 rounded-lg"  @click="filBill(3,4)" :style="{ 'background-color': (this.filbot === 3 && this.filtop === 4) ? '#fff' : '' }">
                            <h4 v-if="orderCounts[4]" style="font-weight: 900; text-align: center;">Hoàn Thành ({{ orderCounts[4] }})</h4>
                            <h4 v-else style="font-weight: 900; text-align: center;">Hoàn Thành (0)</h4>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <br>
        <div class="p-5" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; height: 775px;">
            <!-- PROJECT TABLE -->
            <div style="overflow-y: auto; height: 720px;">
                <div style="width: 95%; margin-left: 2%;">
                    <div v-for="(b) in filterBills.slice().reverse()" :key="b.bill_id" >
                        <div class="row" :style="{ 'background-color': b.bill_status === 4 ? '#ffe6ee' : b.bill_status === 1 ? '#ff6699' : b.bill_status === 2 ? '#ff99bb':'#ffb3cc', 
                            'height': 'auto', 'margin-top': '10px', 'border-radius' : '15px', 'box-shadow' : '0 1px 1px #999999' }">
                            <div class="col-1 d-flex align-items-center justify-content-center"
                                :style="{ 'color': b.bill_status === 4 ? '#00FF00' : b.bill_status === 1 ? '#FF0000' : ''}">
                                <h5 style="font-weight: 900;">{{ avaiableStatus[b.bill_status] }}</h5>
                            </div>
                            <div class="col-10 pt-3">
                                <div class="row">
                                    <div class="col-1 text-right">
                                        <button class="btn" @click="sendBillId(b.bill_id,b.user_id,b.date_id)">
                                            <h5 style="font-weight: 900;">#{{ b.bill_id }}</h5>
                                        </button>
                                    </div>
                                    <div class="col-3">
                                        <button class="btn pl-0">
                                            <h4 style="font-weight: 900;">{{ b.userName }}</h4>
                                        </button>
                                    </div>
                                    <div class="col-8 text-right">
                                        <h5 style="font-weight: 900;">{{ b.bill_when }}</h5>
                                    </div>
                                </div>
                                <div class="row py-1">
                                    <div class="col-1 offset-1">
                                        <h5 style="font-weight: 900;">{{ b.bill_phone }}</h5>
                                    </div>
                                    <div class="col-2">
                                        <h5 style="font-weight: 900; text-align: center;"> {{ b.userDate }}</h5>
                                    </div>
                                    <div class="col-4">
                                        <h5 style="font-weight: 900;">{{ b.bill_address }}</h5>
                                    </div>
                                    <div class="col-4 text-right">
                                        <button @click="sendBillId(b.bill_id,b.user_id,b.date_id)" class="btn px-0 mx-0" style="color: darkcyan;">
                                            <h5 style="font-weight: 900;">xem chi tiết...</h5>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-1 px-0">
                                <button v-if="b.bill_status==1" class="p-2" @click="nextStatusBtn(b.bill_id,b.bill_status,b.user_id,b.voucher_id,b.bill_total)" 
                                    style="height: 50%;width: 70%; background-color: #40bf77; border-radius: 15px; margin-top: 15%; color: black;">
                                    Chấp Nhận
                                </button>
                                <button v-if="b.bill_status==2" class="p-2" @click="nextStatusBtn(b.bill_id,b.bill_status,b.user_id,b.voucher_id,b.bill_total)" 
                                    style="height: 50%;width: 70%; background-color: #999999; border-radius: 15px; margin-top: 15%; color: black;">
                                    Xác Nhận
                                </button>
                                <button v-if="b.bill_status==3" class="p-2" @click="nextStatusBtn(b.bill_id,b.bill_status,b.user_id,b.voucher_id,b.bill_total)" 
                                    style="height: 50%;width: 70%; background-color: #bfbfbf; border-radius: 15px; margin-top: 15%; color: black;">
                                    Hoàn Thành
                                </button>

                                <button v-if="b.bill_status >= 1 && b.bill_status <=3" class="p-2 " 
                                    @click="cancelBtn(b.bill_id,b.user_id,b.voucher_id)" 
                                    style="height: 50%;width: 30%;  border-radius: 15px; background-color: #DAA520; color: black;">
                                    Hủy
                                </button>

                                <button v-if="b.bill_status == 4 " class="btn p-2 ml-1" style="height: 100%; width: 100%; background-color: none; border-start-end-radius: 15px; border-end-end-radius: 15px; color: black;">
                                   <h5 style="font-weight: 900;">Ẩn Đơn</h5> 
                                </button>
                            </div>
                        </div>       
                    
                    </div>
                </div>
            </div>
        </div>
    </div>

    <OrderDetail v-if="showOrderDetails" :bill=[sendId1,sendId2,sendId3]>
        <button class="btn" style="background-color: #DC143C; border-radius: 10px;" @click="closeView"><h5 style="font-weight: 900;">X</h5></button>
    </OrderDetail>

</template>


<script>
import OrderDetail from "./component/OrderDetails.vue";
import axios from "axios";
import { mapState } from "vuex";

export default {
    name: 'Order',

    data() {
        return {
            avaiableStatus: ["Hủy", "Chờ Đồng Ý", "Chờ Cọc", "Đang Diễn Ra", "Hoành Thành"],
            allBills: [],
            filtop: 3,
            filbot: 0,
            showOrderDetails: false,
            sendId1: undefined,
            sendId2: undefined,
            sendId3: undefined, 
        }
    },

    created() {
        this.getAllBills();
        if (!this.admin) {
            this.$router.push("/");
        }
    },

    mounted(){
        this.autoUpdate();
    },

    computed: {
        ...mapState(["allProducts", "admin","voucher_value"]),

        orderCounts: function() {
            const counts = [];
            this.allBills.forEach(bill => {
                counts[bill.bill_status] = (counts[bill.bill_status] || 0) + 1;
            });
            
            return counts;
        },

        filterBills: function () {
            return this.allBills.filter((b) => b.bill_status <= this.filtop && b.bill_status > this.filbot);
        },
    },

    methods: {
        // ...mapMutations(["setAdmin"]),

        async getAllBills() {
            try {
                const response = await axios.get('/billstatus');
                const bills = response.data;
                for (const bill of bills) {
                    bill.userName = await this.showUserName(bill.user_id);
                    bill.userDate = await this.showBillDate(bill.bill_id)
                }
                this.allBills = bills;
            } catch (error) {
                console.error("Error fetching bills:", error);
            }
        },

        filBill(bot,top){
            if (bot==this.filbot && top==this.filtop) {
                this.filbot=0;
                this.filtop=3;
            } else {
                this.filbot=bot;
                this.filtop=top;
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

        autoUpdate: function () {
            this.interval = setInterval(function () {
                this.getAllBills();
            }.bind(this), 2000);
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

        async showBillDate(id) {
            let date = '';
            try {
                let existDate = await axios.get('/datebill/' + id);
                if (existDate.data.length > 0) {
                    date = existDate.data[0].date_date;  
                }
            } catch (error) {
                console.error('Lỗi khi lấy ngày tháng:', error);
            }
            if (!date) {
                date = '';
            }
            return date;
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

        async nextStatusBtn(id,bill_status,user_id,voucher_id,total) {
            if (bill_status==1) {
                let voucher = {
                    vc_status: 0,
                    vc_id: voucher_id,
                }
                axios.put(`/voucher/status`,voucher)
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
            if (bill_status==3 && total>=10000000) {
                let voucher = {
                    user_id: user_id,
                    vc_value: this.voucher_value,
                    vc_status:1
                }
                try {
                    await axios.post(`/voucher`,voucher)
                } catch (error) {
                    console.error('Error in crate voucher',error)
                }
                
            }
            await axios.put('/billstatus/' + id);
            this.getAllBills();
    
        },

        async paidBtn(id) {
            await axios.put('/billstatus/paid/' + id);
            await this.getAllBills();
        },

        async cancelBtn(id,user_id,voucher_id) {
            let voucher = {
                    vc_status: 1,
                    vc_id: voucher_id,
                }
                axios.put(`/voucher/status`,voucher)
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

</style>