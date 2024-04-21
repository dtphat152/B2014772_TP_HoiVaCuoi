<template>
    <vue-basic-alert :duration="300" :closeIn="4000" ref="alert" />
    <br>
  
    <div class="row d-flex justify-content-center" style="margin-top: 0px;">
      <br>
          <div class="col-8 form-group text-center" style="width: 150px;">
            <br>
            
                <h3  style="color: #FF0099; font-weight: bold;">Số lượng Khách và Thời Gian </h3>
                <div v-if="this.selectedNum!=0" class="row d-flex justify-content-center pt-2">
                    <div class="col-3 offset-3"><h5  style="color: #FF0099;">Thời Gian</h5></div>
                    <div class="col-3"><h5 style="color: #FF0099;">Số Khách</h5></div>
                    <div class="col-3"></div>
                </div>
                <div v-else>
                    <br>
                    <h5 style="color: #ef87aa;"></h5>
                    <button type="button" class="btn font-weight-bold" @click="incNum()"
                    style="background-color: #FFC0CB; border-color: none; color: back; margin-bottom: 10px; border: #808080; border-radius: 10px;" >
                        <i class="fa fa-plus" style="color: black;"></i> Thêm suất
                    </button>
                </div>

                <div v-for="index in selectedNum" :key="index" style="padding-bottom: 2px;">
                    <div class="row d-flex justify-content-center align-items-center pt-2">
                        <div class="col-3 text-right">
                            <h5 style="color: #FF0099;">Suất thứ {{ index }} :</h5>
                        </div>
                        <div class="col-3">
                            <input type="time" :id="'time-' + index" v-model="selectedTime[index]" 
                            style=" background: #ffb3cc; border-radius: 10px; padding: 4px; font-size: 15px;">
                        </div>
                        <div class="col-3">
                            <input title="Số Khách" type="number" :id="'number-' + index" class="form-control " min="0" max="1000" 
                            v-model="selectedGuest[index]" style="border: none; text-align: center; background: #ffb3cc; border-radius: 10px; font-size: 15px; font-weight: 900;">
                        </div>
                        
                        <div class="col-3">
                            <button class="btn" @click="removeBtn(index)"
                            style="background-color: #ffb3cc; border-radius: 10px; color: #404040;" >
                                <i class="fa fa-trash"></i>
                            </button>
                        </div>
                    </div>   
                </div>
                
                
                <div v-if="this.selectedNum!=0" style="text-align: center; padding-bottom: 12px; padding-top: 1px;">
                    <div class="pt-5">
                    <button type="button" class="btn font-weight-bold" @click="incNum()"
                    style="background-color: #FFC0CB; border-color: none; color: back; margin-bottom: 10px; border: #808080; border-radius: 10px;" >
                        <i class="fa fa-plus" style="color: black;"></i> Thêm suất
                    </button>
                    </div>
                    <button type="button" class="btn font-weight-bold" 
                        style="background-color: #FFC0CB; color: black; border-radius: 10px;" @click="submit">Xác Nhận
                    </button>
                </div>
                
          </div>
    </div>
    
  </template>
  
  <script>
  import VueBasicAlert from 'vue-basic-alert';
  import axios from "axios";
  import { mapState } from "vuex";
  export default {
    name: "DateDetails",
    data() {
      return {
        selectedNum: 0,
        selectedGuest: [],
        selectedTime: [],
        dateID: '',
        checkGetMeatSet : true,
      };
    },
  
    created(){
        
        this.getMeatSet();
      
    },

    mounted(){
        
    },
  
    computed: {
        ...mapState(["user"]),
        
         
    },
  
    methods: {
  
        incNum() {
            if (this.user) {
                this.selectedNum++;
                this.checkGetMeatSet = false;
            } else {
                this.$refs.alert.showAlert('error', 'Xin Lỗi!', 'Bạn chưa đăng nhập!')
            }
        },

        async getNum(){
            if (this.dateID){
                let response = await axios.get(`/datedetails/${this.dateID}`);
                if(response.data.length > 0){
                    let data = response.data;
                    this.selectedNum = data.length;
                }
            }
        },

        async getDate() {
            if (this.user) {
                try {
                    const response = await axios.get('/date/' + this.user.user_id);
                    if (response.data.length > 0) {
                        this.dateID = response.data[0].date_id;
                    } else {
                        this.dateID =  '';
                    }
                } catch (error) {
                    console.error('Đã xảy ra lỗi khi lấy dữ liệu dateID:', error);
                    this.dateID =  '';
                }
            }
        },

        async getMeatSet() {
            if (this.user) {
                await this.getDate();
                await this.getNum();
                if(this.dateID != '') {
                    for (let index = 1; index <= this.selectedNum; index++) {
                        
                        try {
                            let response = await axios.get(`/datedetails/${this.dateID}`);
                            if(response.data.length > 0){
                                let data = response.data;
                                if (data && data.length >= index) {
                                    this.selectedTime[index] = data[index - 1].dd_time;
                                    this.selectedGuest[index] = data[index - 1].dd_guest;
                                } else {
                                    this.selectedTime[index] = ''; 
                                    this.selectedGuest[index] = ''; 
                
                                }
                            }
                        } catch (error) {
                        
                            console.error('Lỗi khi lấy dữ liệu từ API:', error);
                        }
                    }
                }
            }
        },

        async removeBtn(index) {
            let confirmResult = window.confirm("Xác Nhận Hủy Suất Thứ " + index);
            if (confirmResult) {
                let data = {
                    date_id: parseInt(this.dateID),
                    dd_name: parseInt(index),
                };
                try {
                    let response = await axios.delete(`/datedetails/detail/`, { data });
                    if (response.status >= 200 && response.status < 300) {
                        console.log("Xóa thành công");
                        this.$refs.alert.showAlert('success', 'Success!', 'Đã xóa suất đãi khách!');
                        this.selectedTime.splice(index, 1);
                        this.selectedGuest.splice(index, 1);
                        this.selectedNum--;
                    } else {
                        console.error("Xóa không thành công, mã trạng thái: ", response.status);
                    }
                } catch (error) {
                    console.error("Lỗi khi thực hiện xóa: ", error);
                }
            }
        },


        async submit() {
            await this.getDate();
            if (this.dateID != ''){
                if(this.checkGetMeatSet == false){
                    let response = await axios.get(`/datedetails/${this.dateID}`);
                    let data = response.data;
                    let templenght = data.length + 1;
                    for (let index = templenght; index <= this.selectedNum; index++) {
                        let data = {
                            date_id: this.dateID,
                            dd_name: index,
                            dd_time: this.selectedTime[index],
                            dd_guest: this.selectedGuest[index],
                        };
                        
                            axios.post('/datedetails/', data)
                            .then(response => {
                                console.log('Dữ liệu đã được submit thành công:', response.data);
                            })
                            .catch(error => {
                                console.error('Lỗi khi submit dữ liệu:', error);
                            });
                    }
                    // this.$refs.alert.showAlert('success', 'Thành Công!', 'Suất đãi khách đã được lưu!');
                    window.confirm(`Suất đãi khách đã được lưu!`)
                    this.checkGetMeatSet = true;
                } else {

                    for (let index = 1; index <= this.selectedNum; index++) {
                        let data = {
                            date_id: this.dateID,
                            dd_name: index,
                            dd_time: this.selectedTime[index],
                            dd_guest: this.selectedGuest[index],
                        };

                        axios.put('/datedetails/', data)
                        .then(response => {
                            console.log('Dữ liệu đã được chỉnh sửa thành công:', response.data);
                            console.log(data);
                        })
                        .catch(error => {
                            console.error('Lỗi khi chỉnh sửa dữ liệu:', error);
                        });
                    }
                    // this.$refs.alert.showAlert('success', 'Thành Công!', 'Suất đãi khách đã được cập nhật!');
                    window.confirm(`Suất đãi khách đã được cập nhật!`)
                }
            } else window.confirm("Xin Lỗi! Bạn hãy chọn Ngày Tổ Chức Trước!")
        }

    },

    components: {
      VueBasicAlert
    }
  };
  </script>
  
  <style scoped>
  .dateinput {
    font-size: larger;
    font-weight: 500;
  }
  
  .borderNumber{
    border: 5px solid transparent; 
    border-image: linear-gradient(to right, #FFF0F5 0%, #FFF0F5 40%, transparent 40%, transparent 60%, #FFF0F5 60%, #FFF0F5 100%) 2;
  }
  
  </style>
  