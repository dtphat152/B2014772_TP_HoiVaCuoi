<template>
    <div class="container_dashboard">
        <div class="p-5" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; ">
            <h1>Dashboard</h1>
        </div>
        <br>
        
        <div class="row">
            <div class="col-4">
                <div class="row">
                    <div class="col-4 p-4 ml-4" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; ">
                        <div class="p-3" style="border-radius: 15px; background: #d3d3d3;">
                            <div class="row" >
                                <div class="col text-center">
                                    <button v-if="showTop5" class="p-2 " @click="top5()"
                                    style="border: none; text-align: center; background: #f2f2f2; color: black; font-weight: 900; border-radius: 10px;">Chọn Nhiều Nhất</button>
                                    <button v-if="!showTop5" class="p-2 " @click="top5()"
                                    style="border: none; text-align: center; background: #d3d3d3; color: black; font-weight: 900; border-radius: 10px;">Chọn Nhiều Nhất</button>
                                </div>
                            </div>
                            <br>
                            <div class="row" >
                                <div class="col text-center">
                                    <button v-if="!showTop5" class="p-2 " @click="top5()"
                                    style="border: none; text-align: center; background: #f2f2f2; color: black; font-weight: 900; border-radius: 10px;">Chọn Ít Nhất</button>
                                    <button v-if="showTop5" class="p-2 " @click="top5()"
                                    style="border: none; text-align: center; background: #d3d3d3; color: black; font-weight: 900; border-radius: 10px;">Chọn Ít Nhất</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-7 p-4 ml-4" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999;">
                        <div class="p-3" style="border-radius: 15px; background: #d3d3d3;">
                            <div class="row d-flex justify-content-between" >
                                <div class="col">
                                    <input type="date" class="form-control " v-model="this.startDate" 
                                    style="border: none; text-align: center; background: #f2f2f2; color: black; font-weight: 900; border-radius: 10px;">
                                </div>
                                <div class="col">
                                    <input type="date" class="form-control " v-model="this.endDate" 
                                    style="border: none; text-align: center; background: #f2f2f2; color: black; font-weight: 900; border-radius: 10px;">
                                </div>
                            </div>
                            <br>
                            <div class="row justify-content-center">
                                <button class="btn " @click="reDrawChart1()"
                                style="width: 94%; border-radius: 10px; background: #f2f2f2; color: black; font-weight: 900; ">Xác Nhận</button>
                            </div>
                        </div>
                    </div>
                </div>
                <br>
                <div class="row ml-2 mr-2 p-4" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999;  height: 35.5vh;">
                    <div v-if="showTop5" class="col-12 p-4" >
                        <h3 style="text-align: center; color: black; font-weight: 900;font-weight: bold;">Top 5 Được Chọn Nhiều Nhất</h3>
                        <div class="p-4" style="border-radius: 20px; background-color: #d3d3d3; width: 100%;">
                            <div class="row p-2 m-1 d-flex justify-content-between" style="border-radius: 20px; background-color: #f2f2f2;"
                                v-for="(f) in filterProductsDesc" :key="f.product_id">
                                <h4 style="color: #ff80aa; font-weight: 900;">{{ f.product_name }}</h4>
                                <h4 style="color: #ff80aa; font-weight: 900;">{{ f.product_buy }} Lượt Chọn</h4>
                            </div>
                        </div>
                    </div>
                    <div v-else class="col-12 p-4" >
                        <h3 style="text-align: center; color: black; font-weight: 900;font-weight: bold;">Top 5 Được Chọn Ít Nhất</h3>
                        <div class="p-4" style="border-radius: 20px; background-color: #d3d3d3; width: 100%;">
                            <div class="row p-2 m-1 d-flex justify-content-between" style="border-radius: 20px; background-color: #f2f2f2;"
                                v-for="(f) in filterProductsAsc" :key="f.product_id">
                                <h4 style="color: #ff80aa; font-weight: 900;">{{ f.product_name }}</h4>
                                <h4 style="color: #ff80aa; font-weight: 900;">{{ f.product_buy }} Lượt Chọn</h4>
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
            <div class="col-8 pl-0">
                <div class="" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; height: 50vh;">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>
        </div>
        <br>
        <div class="row" >
            <div class="p-4 mx-4" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; height: 33.5vh; width: 100%;"> 
                <ChartDay :info=[this.startDate,this.endDate]>
                </ChartDay>
            </div>
        </div>
        
    </div>
</template>


<script>
import axios from "axios";
import Chart from 'chart.js/auto';
import { mapState, mapMutations } from "vuex";
import ChartDay from "./component/ChartDay.vue";

export default {
    name: 'Dashboard',

    data() {
        return {
            allBills: [],
            fiveProductDesc: [],
            fiveProductAsc: [],
            char1: null,
            showTop5: true,
            startDate: new Date('2024-01-01'), 
            endDate: new Date('2024-12-31'),
        }
    },

    created() {
        if (!this.admin) this.$router.push("/");
        this.getAllBills();
        this.getFiveProductDesc();
        this.getFiveProductAsc();

        const Datenow = new Date();
        const currentDay = Datenow.getDate();
        const currentMonth = Datenow.getMonth() + 1; // Tháng bắt đầu từ 0, nên cần cộng thêm 1
        const currentYear = Datenow.getFullYear();
        // Chuyển đổi đối tượng Date sang chuỗi 'yyyy-mm-dd'
        const formattedMonth = currentMonth < 10 ? '0' + currentMonth : currentMonth; // Thêm "0" phía trước nếu là tháng có một chữ số
        const formattedDay = currentDay < 10 ? '0' + currentDay : currentDay; // Thêm "0" phía trước nếu là ngày có một chữ số
        this.startDate = new Date(`${currentYear}-01-01`).toISOString().split('T')[0];
        this.endDate = new Date(`${currentYear}-${formattedMonth}-${formattedDay}`).toISOString().split('T')[0];

    },

    watch: {
        startDate: {
            handler: 'drawRevenueChart', 
            immediate: true 
        },
        endDate: {
            handler: 'drawRevenueChart', 
            immediate: true 
        },
        showTop5: {
            handler: 'drawRevenueChart', 
            immediate: true 
        },
    },


    async mounted() {
        await  this.drawRevenueChart();
    },


    computed: {
        ...mapState(["allProducts", "admin"]),
        filterProductsDesc: function () {
            return this.fiveProductDesc
        },
        filterProductsAsc: function () {
            return this.fiveProductAsc
        },
    },

    methods: {
        ...mapMutations(["setAdmin"]),

        top5(){
            this.showTop5=!this.showTop5;
        },

        async getAllBills() {
            let data = {
                start: this.startDate,
                end: this.endDate
            }
            let rsp = await axios.post('/billstatus/datetodate',data)
            this.allBills = rsp.data;
        },

        async getFiveProductDesc() {
            let rsp = await axios.get('/productstop5')
            this.fiveProductDesc = rsp.data;
        },

        async getFiveProductAsc() {
            let rsp = await axios.get('/productsbot5')
            this.fiveProductAsc = rsp.data;
        },

        createDataRevenue(){
            const revenueData = {}; 

            this.allBills.forEach(bill => {
                if (bill.bill_status >= 4) {
                    const dateString = bill.date_date;
                    const parts = dateString.split("-");
                    // const datePart = parts[0]; 
                    // const dateParts = datePart.split("-"); 
                    
                    const year = parseInt(parts[2]);
                    const month = parseInt(parts[0]); 

                    const key = `${month}-${year}`; 

                    if (!revenueData[key]) revenueData[key] = 0;

                    revenueData[key] += parseInt(bill.bill_total); 
                }
            });
            return revenueData;
        },

        reDrawChart1(){
            this.getAllBills();
            this.drawRevenueChart();
        },

        async drawRevenueChart() {
            await this.getAllBills();  
                     
            let revenueData = this.createDataRevenue();
            const labels = Object.keys(revenueData);
            const data = Object.values(revenueData);

            if (this.chart1) {
            this.chart1.destroy(); // Nếu có, hủy biểu đồ cũ
            }

            // Vẽ biểu đồ bằng Chart.js
            const ctx1 = document.getElementById('revenueChart').getContext('2d');
            // Lấy phần tử chứa biểu đồ
            const chartElement = document.getElementById('revenueChart');
            chartElement.width = chartElement.parentElement.offsetWidth;
            chartElement.height = chartElement.parentElement.offsetHeight;

            this.chart1 = new Chart(ctx1, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                    label: 'Doanh Thu Theo Tháng',
                    data: data,
                    backgroundColor: '#ffb3cc',
                    // borderColor: 'rgba(153, 0, 153, 1)',
                    borderRadius: 15,
                    borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                color: 'black' 
                            }
                        },
                        x: {
                            ticks: {
                                color: 'black' 
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            labels: {
                                color: 'black'
                            }
                        }
                    }
                }
            });
        },            
    },
    components: {ChartDay}
}
</script>

<style scoped>

h1 {
    font-weight: 900;
    color: #d35ea4; font-weight: 900;
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