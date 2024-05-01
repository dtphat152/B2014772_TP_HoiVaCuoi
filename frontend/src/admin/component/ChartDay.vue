<template>
   <canvas id="chartDay"></canvas>            
</template>

<script>
import axios from "axios";
import Chart from 'chart.js/auto';
export default {
    props: ['info'],
    name: "ChartDay",

    data() {
        return {
            allBills: [],
            char1: null,
        }
    },

    created(){
        this.getAllBills();
    },

    async mounted() {
        await this.drawRevenueChart();
    },

    watch: {
        info: {
            handler: 'drawRevenueChart', // Tên phương thức sẽ được gọi khi prop info thay đổi
            immediate: true // Gọi ngay lập tức khi component được khởi tạo
        }
    },

    computed: {
        
    },


    methods: {

        async getAllBills() {
            let data = {
                start: this.info[0],
                end: this.info[1]
            }
            let rsp = await axios.post('/billstatus/datetodate',data)
            this.allBills = rsp.data;
        },

        createDataRevenue(){
            const revenueData = {}; 

            this.allBills.forEach(bill => {
                if (bill.bill_status >= 4) {
                    const dateString = bill.bill_when;
                    const parts = dateString.split(" - ");

                    const datePart = parts[0]; 
                    const dateParts = datePart.split("/"); 
                    
                    const year = parseInt(dateParts[2]);
                    const month = parseInt(dateParts[1]); 
                    const day = parseInt(dateParts[0]);

                    const key = `${day}-${month}-${year}`; 

                    if (!revenueData[key]) revenueData[key] = 0;

                    revenueData[key] += parseInt(bill.bill_total); 
                }
            });
            return revenueData;
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
            const ctx1 = document.getElementById('chartDay').getContext('2d');
            // Lấy phần tử chứa biểu đồ
            const chartElement = document.getElementById('chartDay');
            chartElement.width = chartElement.parentElement.offsetWidth;
            chartElement.height = chartElement.parentElement.offsetHeight;

            this.chart1 = new Chart(ctx1, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                    label: 'Doanh thu theo ngày',
                    data: data,
                    backgroundColor: '#ffb3cc',
                    borderRadius: 15,
                    borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                color: 'black' // Màu chữ cho trục tung
                            }
                        },
                        x: {
                            ticks: {
                                color: 'black' // Màu chữ cho trục hoành
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            labels: {
                                color: 'black' // Thiết lập màu chữ là trắng
                            }
                        }
                    }
                }
            });
        },

    }
        
}
</script>
