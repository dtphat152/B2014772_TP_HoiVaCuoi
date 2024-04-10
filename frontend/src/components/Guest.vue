<template>
    <vue-basic-alert :duration="300" :closeIn="4000" ref="alert" />
    <br>
  
    <div class="row d-flex justify-content-center" style="margin-top: 0px;height: 150px;">
      <br>
          <div class="col-8 form-group borderNumber text-center" style="width: 150px;">
            <br>
            
                <h2>Số Lượng Suốt Đãi Khách</h2>
                <div class="container" style="width:60%;">
                  <input type="number" id="number" v-model="selectedNum" @input="validateNum" class="form-control " min="0" max="1000" 
                    style="border: none; text-align: center; background: #FFF0F5;">
                </div>
                <!-- <h5 v-if="checkNum" class="text-center" style="color: #ef87aa;">Vui lòng chọn số lượng</h5>
                <h5 v-else> <br> </h5> -->
                <br>
                <br>
                <div style="text-align: center; padding-bottom: 12px; padding-top: 1px;">
                <button type="button" class="btn font-weight-bold" style="border-color: #FFF0F5; color: #ef87aa;" @click="submitNum">Xác Nhận</button>
                </div>
          </div>
    </div>
    <br><br>
  </template>
  
  <script>
  import VueBasicAlert from 'vue-basic-alert';
  import axios from "axios";
  import { mapState } from "vuex";
  export default {
    name: "Guest",
    data() {
      return {
        selectedNum: null,
        checkNum: true,
      };
    },
  
    created(){
      this.getNum();
    },
  
    computed: {
          ...mapState(["user"]),
  
         
    },
  
    methods: {
        validateNum() {
            if (this.selectedNum==0) {

                this.checkNum = true;
            }
            else {
            this.checkNum = false;
            }
        },
  
  
        async getNum() {
          if (this.user) {
            try {
                let existNum = await axios.get('/guestnumber/' + this.user.user_id);
    
                if (existNum.data.length > 0) {
                this.selectedNum = existNum.data[0].guest_number;  
                this.validateNum();
                console.log('Selected Num:', this.selectedNum);
                } else {
                // Gán giá trị mặc định nếu không có dữ liệu
                this.selectedNum = 0;
                console.log('Không có dữ liệu Số lượng khách.');
                }
            } catch (error) {
                console.error('Lỗi khi lấy Số lượng khách:', error);
            }
          }
        },

        async submitNum() {
        if (this.user) {
            let numSelect = {
                user_id: parseInt(this.user.user_id),
                guest_number: this.selectedNum,
            };

            try {
            let existNum = await axios.get('/guestnumber/' + this.user.user_id);

            if (existNum.data.length > 0) {
                await axios.put("/guestnumber", numSelect);
                this.$refs.alert.showAlert('success', 'Success!', 'The guest is changed!');
            } else {
                await axios.post("/guestnumber", numSelect);
                this.$refs.alert.showAlert('success', 'Success!', 'The guest is selected!');
            }
            } catch (error) {
            console.error('Error submitting guest:', error);
            this.$refs.alert.showAlert('error', 'Error!', 'An error occurred while submitting the guest.');
            }
        } else {
            this.$refs.alert.showAlert('warning', 'Sorry!', 'Login now to use this method!');
        }
        },

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
  