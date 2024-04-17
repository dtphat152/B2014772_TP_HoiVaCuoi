<template>
    <div class="container_dashboard">
        <div class="p-5" style="border-radius: 20px; background-color: rgba(117, 0, 164, 0.38); opacity: 1;">
            <h1>Dashboard</h1>
        </div>
        <br>
        <div class="p-5" style="border-radius: 20px; background-color: rgba(117, 0, 164, 0.38); opacity: 1;">
            <canvas id="revenueChart" style="height: 300px;"></canvas>
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


                if (bill.bill_status >= 3) {
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

h1 {
    font-weight: bold;
    color: #d35ea4;
}

.container_dashboard{
    margin-left: 220px; 
    margin-right: 20px; 
    margin-top: 10px;
    top: 0;
    height: 98vh;  
    opacity: 0.8;
    border-radius: 20px;
 }

</style>