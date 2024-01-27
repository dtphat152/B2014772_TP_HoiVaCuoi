<template>
    <div class="container" style="width: 800px; margin-top: 30px;" :class="filterBills.length > 0 ? '' : 'fit-screen'">
        <div v-if="filterBills.length > 0" class="my-order-cards">
            <div v-for="b in filterBills.slice().reverse()" class="card" :key="b.bill_id" style="margin-bottom: 10px;">
                <div class="d-flex justify-content-between p-3">
                    <div>
                        <span>Order No - </span>
                        <span>{{ b.bill_id }}</span>
                    </div>
                    <button @click="sendBillId(b.bill_id)" class="btnDetails">show order details</button>
                </div>

                <div class="d-flex justify-content-between">
                    <div class="w-50  py-1 pl-5"><span class="font-weight-bold">Paid:</span>{{ " " + b.bill_paid }}
                    </div>
                    <div class="w-100  py-1 px-1"><span class="font-weight-bold">Status:</span>{{ " " + avaiableStatus[b.bill_status] }}
                    </div>
                    <div class="w-50  py-1 pl-5"><span class="font-weight-bold">When:</span> {{ b.bill_when }}</div>
                </div>
                <div class="d-flex justify-content-between">

                    <div class="w-50  py-1 pl-5"><span class="font-weight-bold">Total:</span> ${{ b.bill_total }}</div>
                    <div class="w-100  py-1 px-1"><span class="font-weight-bold">Address:</span>{{ " " + b.bill_address }}
                    </div>
                    <div class="w-50  py-1 pl-5"><span class="font-weight-bold">Phone:</span>{{ " " + b.bill_phone }}
                    </div>
                </div>
                <hr class="" style="margin-left: 50px; margin-right: 50px;">
                <div v-if="b.bill_status==0">
                    <h4 class="pl-3 text-warning">The order was canceled for some reason. So sorry!!</h4>
                </div>
                <div v-else class="card-body">
                    <div class="d-flex">
                        <div :class="b.bill_status >= 1 ? 'text-color' : '' ">
                            <h4 class=" pl-3">Waiting_____</h4>
                        </div>
                        <div :class="b.bill_status >= 2 ? 'text-color' : ''">
                            <h4 class="">Confirmed_and_Preparing_____</h4>
                        </div>
                        <div :class="b.bill_status >= 3 ? 'text-color' : ''">
                            <h4 class="">Prepared_____</h4>
                        </div>
                        <div :class="b.bill_status >= 4 ? 'text-color' : ''">
                            <h4 class="">Delivering_____</h4>
                        </div>
                        <div :class="b.bill_status >= 5 ? 'text-color' : ''">
                            <h4 class="">Received</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div v-else class="container text-center">
            <div>
                <img src="../assets/images/notfound.jpg" alt="" />
            </div>
            <div class="">
                <h2 style="color: #17a2b8;">You do not have any orders yet</h2>
            </div>
            <br>
            <router-link to="/product">
                <button class="bg-info p-1 rounded-lg">Order Now</button>
            </router-link>
        </div>

        <OrderDetails v-if="showOrderDetails" :bill="sendId">
            <button class="btn" @click="closeView">X</button>
        </OrderDetails>
    </div>

</template>


<script>
import OrderDetails from "@/components/OrderDetails.vue";
import axios from "axios";
import { mapState } from "vuex";
export default {
    name: 'MyOrder',

    data() {
        return {
            avaiableStatus: ["cancel", "confirmed", "preparing", "checking", "delivering", "delivered"],
            allBills: [],

            showOrderDetails: false,
            sendId: null,

            interval: "",
        }
    },

    created() {
        this.getAllBills();
    },

    mounted: function () {
        this.autoUpdate();
    },

    beforeUnmount() {
        clearInterval(this.interval)
    },

    computed: {
        ...mapState(["allProducts", "user"]),

        filterBills: function () {
            return this.allBills.filter((b) => b.bill_status <= 6 && b.bill_status >= 0);
        },
    },

    methods: {
        async getAllBills() {
            if (this.user) {
                this.allBills = (await axios.get('/billstatus/user/' + this.user.user_id)).data;
            }
        },

        sendBillId: function (id) {
            this.sendId = id
            this.showOrderDetails = !this.showOrderDetails;
        },

        closeView: function () {
            this.showOrderDetails = !this.showOrderDetails;
        },

        autoUpdate: function () {
            this.interval = setInterval(function () {
                this.getAllBills();
            }.bind(this), 1000);
        }
    },
    components: { OrderDetails }
}
</script>
<style>
.text-color{
    color: #ef87aa;
}

.btnDetails
{
    width: 20%;
    border-radius: 1rem;
    padding: 1%;
    color: #000000;
    font-weight: bold;
    background-color: #FFF0F5;
    border: none;
    cursor: pointer;
}

</style>