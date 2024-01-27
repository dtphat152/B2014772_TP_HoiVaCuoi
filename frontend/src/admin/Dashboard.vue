<template>
    <div class="admin-container">
        <div class="d-flex justify-content-between">
            <h1>Hello Admin!</h1>
            <button class="bg-dark rounded-lg" @click="handleLogout()">Logout</button>
        </div>

        <div class="row d-flex justify-content-around" style="margin-top: 40px;">
            <canvas id="revenueChart" style="height: 300px;"></canvas>

            <div class="" style="margin-top: 40px;">
                <br><br><br><br>
                <router-link to="ProductManager" class="text-black-50">
                    <button class="btn-warning p-1 rounded-lg">Product Manager</button>
                </router-link>
            </div>
        </div>

        <div class="table-responsive">
            <!-- PROJECT TABLE -->
            <table class="table colored-header datatable project-list">
                <thead>
                    <tr>
                        <th>Bill Id</th>
                        <th>User Id</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>When</th>
                        <th>Paid</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(b) in filterBills.slice().reverse()" :key="b.bill_id">
                        <td>{{ b.bill_id }}</td>
                        <td>{{ b.user_id }}</td>
                        <td>{{ b.bill_phone }}</td>
                        <td>{{ b.bill_address }}</td>
                        <td>{{ b.bill_when }}</td>
                        <td>{{ b.bill_paid }}</td>
                        <td>${{ b.bill_total }}</td>
                        <td>{{ avaiableStatus[b.bill_status] }}</td>
                        <td class="d-flex justify-content-center">
                            <button v-if="b.bill_status < 5 " class="btn-info p-2 rounded-lg" @click="nextStatusBtn(b.bill_id)">
                                {{ avaiableStatus[b.bill_status + 1] }}
                            </button>

                            <button v-if="b.bill_status >= 1 && b.bill_status <=3" class="btn-danger p-2 rounded-lg ml-1" @click="cancelBtn(b.bill_id)">
                                Cancel
                            </button>

                            <button v-else-if="b.bill_status == 5 && b.bill_paid == 'false'" class="btn-warning p-2 rounded-lg"
                                @click="paidBtn(b.bill_id)">
                                Paid
                            </button>

                            <button v-else-if="b.bill_status == 5 && b.bill_paid == 'true'" class="btn-success p-2 rounded-lg"
                                @click="nextStatusBtn(b.bill_id)">
                                {{ avaiableStatus[b.bill_status + 1] }} 
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>


<script>
import axios from "axios";
import Chart from 'chart.js/auto';
import { mapState, mapMutations } from "vuex";
export default {
    name: 'Dashboard',

    data() {
        return {
            avaiableStatus: ["cancel", "waiting", "confirmed", "prepared","delivery", "delivered", "completed"],
            allBills: [],
            showOrderDetails: false,
            sendId: undefined,
            interval: "",
            chart: null,
        }
    },

    created() {
        this.getAllBills();
        if (!this.admin) {
            this.$router.push("/");
        }
    },

    mounted: function () {
        this.autoUpdate();
        this.drawRevenueChart();
    },

    beforeUnmount() {
        clearInterval(this.interval)
    },

    computed: {
        ...mapState(["allProducts", "admin"]),

        filterBills: function () {
            return this.allBills.filter((b) => b.bill_status <= 6 && b.bill_status > 0);
        },
    },

    methods: {
        ...mapMutations(["setAdmin"]),

        async getAllBills() {
            this.allBills = (await axios.get('/billstatus')).data;
        },

        sendBillId: function (id) {
            this.sendId = id
            this.showOrderDetails = !this.showOrderDetails;
        },

        closeView: function () {
            this.showOrderDetails = !this.showOrderDetails;
        },

        handleLogout: function () {
            this.setAdmin("");
        },

        async nextStatusBtn(id) {
            await axios.put('/billstatus/' + id);
            this.getAllBills();
        },

        async paidBtn(id) {
            await axios.put('/billstatus/paid/' + id);
            await this.getAllBills();
            await this.drawRevenueChart();
        },

        async cancelBtn(id) {
            await axios.put('/billstatus/cancel/' + id);
            this.getAllBills();
        },

        autoUpdate: function () {
            this.interval = setInterval(function () {
                this.getAllBills();
            }.bind(this), 1000);
        },




        async drawRevenueChart() {
            await this.getAllBills();

            console.log("Calling drawRevenueChart");
            const revenueData = {}; 

            this.allBills.forEach(bill => {


                if (bill.bill_paid == 'true') {
                const dateString = bill.bill_when;
                const parts = dateString.split(" - ");

                const datePart = parts[0]; 
                const dateParts = datePart.split("/"); 
                
                const year = parseInt(dateParts[2]);
                const month = parseInt(dateParts[1]) - 1; 

                const billDate = new Date(year , month);
                const billMonth = billDate.getMonth() + 1; 
                const billYear = billDate.getFullYear();
                const key = `${billYear}-${billMonth}`; 

                if (!revenueData[key]) {
                    revenueData[key] = 0;
                }

                revenueData[key] += parseInt(bill.bill_total); 
                }
            });

            const labels = Object.keys(revenueData);
            const data = Object.values(revenueData);

            // Vẽ biểu đồ bằng Chart.js
            const ctx = document.getElementById('revenueChart').getContext('2d');

            if (this.chart) {
            this.chart.destroy(); // Nếu có, hủy biểu đồ cũ
            }

            // Lấy phần tử chứa biểu đồ
            const chartElement = document.getElementById('revenueChart');

            // Cập nhật kích thước của phần tử
            chartElement.width = chartElement.parentElement.offsetWidth;
            chartElement.height = chartElement.parentElement.offsetHeight;

            // Vẽ biểu đồ mới
            this.chart = 
            new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                label: 'Doanh thu theo tháng',
                data: data,
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
                }]
            },
            options: {
                scales: {
                y: {
                    beginAtZero: true
                }
                }
            }
            });
        }



    },
}
</script>

<style scoped>
.admin-container {
    background-color: #fff;
    height: 100vh;
    padding: 2rem 9%;
    font-size: 16px;
}

.project-list>tbody>tr>td {
    padding: 12px 8px;
}

.project-list>tbody>tr>td .avatar {
    width: 22px;
    border: 1px solid #CCC;
}

.table-responsive {
    margin-top: 8vh;
}

.action-btn,
.cancel-btn,
.paid-btn {
    width: 100px;
    height: 25px;
    color: white;
    text-transform: capitalize;
}

.action-btn {
    background-color: #17a2b8;
    margin-right: 10px;
}

.cancel-btn,
.paid-btn {
    background-color: red;
}

.action-btn:hover {
    background-color: #2927ae;
}
</style>