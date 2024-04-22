<template>
    <div class="">
        <div class="">
            <div class=" row d-flex justify-content-between">
                <div class="col-3"> 
                    <div class="row">
                        <slot></slot> 
                        <button v-if="show" class="btn ml-2 p-2" @click="showFunction()" 
                            style="background-color: #40bf77; border-radius: 10px; font-weight: 900; color: white;">Nhân Viên</button>
                        <button v-if="!show" class="btn ml-2 p-2" @click="showFunction()" 
                            style="background-color: #40bf77; border-radius: 10px; font-weight: 900; color: black;">Nhân Viên</button>
                        <button v-if="!show" class="btn ml-2 p-2" @click="showFunction()" 
                            style="background-color: #FFA500; border-radius: 10px; font-weight: 900; color: white;">Bill#{{this.ID}}</button>
                        <button v-if="show" class="btn ml-2 p-2" @click="showFunction()" 
                            style="background-color: #FFA500; border-radius: 10px; font-weight: 900; color: black;">Bill#{{this.ID}}</button>
                    </div>
                                        
                </div>
                <div class="col-6  mb-3">
                    <h1 v-if="show" style="font-weight: 900; text-align: center;">Danh Sách Nhân Viên</h1>
                    <h5 v-if="show" style="font-weight: 800; text-align: center;">Rỗi lúc {{ this.showtime }} {{ this.showdate }}  </h5>
                    <h1 v-if="!show" style="font-weight: 900; text-align: center;">Nhân Viên Đơn #{{ this.ID }}</h1>
                    <div class="row pt-2">
                        <input v-if="show" type="text" v-model="searchKeyword" 
                        style="width: 100%; padding: 5px; border-radius: 20px; background-color: #ffe6e9; font-weight: 800;" placeholder="Tìm kiếm nhân viên...">
                    </div>
                </div>
                <div class="col-3 text-right">
                    <h5 style="font-weight: 800; padding-right: 10px;">Đề xuất: {{ this.number }}</h5>
                    <h5 style="font-weight: 800; padding-right: 10px;">Đã chọn: {{ this.staffListInBill.length }}</h5>
                </div>
                
            </div>
            
            <div v-if="show" style="overflow-y: auto; height: 503.5px;">
                <div style="width: 95%;">
                    <div  v-for="(s, index) in filteredStaffList" :key="index">
                        <div class="row align-content-center p-3" style="background-color: #f08faf; margin-left: 10px; border-radius: 10px;">
                            <div class="col-1 text-center">
                                <h3>{{index+1}}</h3>
                            </div>
                            <div class="col-4 text-center">
                                <h3>{{s.staff_name}}</h3>
                            </div>
                            <div class="col-4" style="padding-top: 5px;">
                                <h5 style="text-transform: none;">{{s.staff_email}}</h5>
                            </div>
                            <div class="col-2 text-right">
                                <button class="btn p-2" @click="addBill(s.staff_id)" style="height: fit-content; border-radius: 10px; background-color: #40bf77;">
                                    Chọn
                                </button>
                            </div>
                        </div>
                        <hr>
                    </div>    
                </div>
            </div>
            <div v-if="!show" style="overflow-y: auto; height: 550px;">
                <div style="width: 95%;">
                    <div  v-for="(s, index) in staffListInBill" :key="index">
                        <div class="row align-content-center p-3" style="background-color: #f08faf; margin-left: 10px; border-radius: 10px;">
                            <div class="col-1 text-center">
                                <h3>{{index+1}}</h3>
                            </div>
                            <div class="col-4 text-center">
                                <h3>{{s.staff_name}}</h3>
                            </div>
                            <div class="col-4" style="padding-top: 5px;">
                                <h5 style="text-transform: none;">{{s.staff_email}}</h5>
                            </div>
                            <div class="col-2 text-right">
                                <button class="btn p-2" @click="delBill(s.staff_id,s.staff_name)" 
                                style="height: fit-content; border-radius: 10px; background-color: #FF4500; color: white;">Xóa</button>
                            </div>
                        </div>
                        <hr>
                    </div>    
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from "axios";
// import { mapState } from "vuex";
export default {
    props: ['ID'],
    name: "Staff",

    data() {
        return {
            staffList: [],
            staffListInBill: [],
            show: false,
            searchKeyword: '',
            date_id: '',
            date:'',
            selectedTime: [],
            showdate: '',
            showtime: '',
            number:0,
        }
    },

    mounted() {
        this.getAllStaff();
        this.getStaffInBill();
        this.getDateAndTime();
    },

    computed: {
        filteredStaffList() {
            return this.staffList.filter(s => s.staff_name.toLowerCase().includes(this.searchKeyword.toLowerCase()));
        }
    },


    methods: {
        async getAllStaff(){
            let rsp = await axios.get(`staffschedule/notinbill/${this.ID}`);
            this.staffList = rsp.data.map( staff => ({
                staff_id : staff.staff_id,
                staff_name : staff.staff_name,
                staff_email : staff.staff_email
            }));
        },

        async getStaffInBill(){
            let rsp = await axios.get(`staffschedule/inbill/${this.ID}`);
            this.staffListInBill = rsp.data.map( staff => ({
                staff_id : staff.staff_id,
                staff_name : staff.staff_name,
                staff_email : staff.staff_email
            }));
            console.log("In bill",this.staffListInBill)
        },

        showFunction() {
            this.show =!this.show ;
        },

        async getDateAndTime() {
            const response = await axios.get('/datebill/' + this.ID);
            if (response.data.length > 0) {
                this.date = response.data[0].date_date;
                this.date_id = response.data[0].date_id;
                    //this.showdate
                    const dateString = this.date;
                    const parts = dateString.split("-");
                    const year = parseInt(parts[2]);
                    const month = parseInt(parts[0]); 
                    const day = parseInt(parts[1]);
                    this.showdate = `${day}/${month}/${year}`;
            }
            try {
                let response = await axios.get(`/datedetails/${this.date_id}`);
                let data = response.data;
                if (Array.isArray(data) && data.length > 0) {
                    let selectedTimes = [];
                    data.forEach(item => {
                        selectedTimes.push(item.dd_time);
                        this.showtime+= item.dd_time;
                        this.showtime+=' - '
                        this.number+=parseInt(item.dd_guest);
                    });
                    this.selectedTime = selectedTimes;
                } else {
                    this.selectedTime = []; 
                }
            } catch (error) {
                console.error('Lỗi khi lấy dữ liệu từ API:', error);
            }
            this.number = Math.ceil(this.number / 40);
        },

        async addBill(id){
            this.selectedTime.forEach( async time =>{
                let data = {
                    staff_id : id,
                    ss_date : this.date,
                    ss_time: time,
                    bill_id: this.ID
                };
                try {
                    await axios.post(`staffschedule`,data);
                } catch (error) {
                    console.error('Error in post staff schedule',error)
                }
            });
            this.staffList = this.staffList.filter(staff => staff.staff_id !== id);
            this.getStaffInBill();
        },

        async delBill(id,name){
            let cm = window.confirm('Hủy nhân viên '+name+' ra khỏi đơn #'+this.ID)
            if (cm){
                try {
                    await axios.delete(`staffschedule/all/${id}`);
                } catch (error) {
                    console.error('Error in delete staff schedule',error)
                }
                this.staffListInBill = this.staffListInBill.filter(staff => staff.staff_id !== id);
                this.getAllStaff();
            }
        },

        

    }
}
</script>
