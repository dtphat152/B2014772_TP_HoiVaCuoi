<template>
  <vue-basic-alert :duration="300" :closeIn="4000" ref="alert" />
  <div class="container-combo" style="margin-top: 150px; margin-left: 20%; width: 60%; " >
    <div class="row" >
      <div class="col-1 d-flex align-items-center justify-content-center">
        <button @click="prevCombo" style="background: none; border: none; ">
          <span class="carousel-control-prev-icon" style="background-color: #f2f2f2; box-shadow: 0 1px 1px #999999; padding: 25px; border-radius: 15px;"></span>
        </button> 
      </div>
      <div class="col-10" style="background-color: #e6e6e6; box-shadow: 0 1px 1px #999999; border-radius: 100px; opacity: 0.8; width: 80%;">
        <br>
        <div class="row align-content-center">
          <div class="col-12">
            <div class="container zoom-light" style="border-radius: 100px; background-color: #ffccd4; width: 60%; box-shadow: 0 1px 1px #ffb3be">
              <!-- Phần tử đầu tiên -->
              <br>
              <div class="row justify-content-center mb-5">
                  <div class="col-3" v-for="(f, index) in sortedComboDetails.slice(0, 1)" :key="index">
                      <div>
                        <img :src="require(`../assets/images/${f.product_src}`)" class="zoom-img"
                        :style="{ width: '100%', height: '83px', 'border-radius': '10px'}"/> 
                      </div>
                  </div>
              </div>
              
              <!-- Phần tử 2, 3, 4 -->
              <div class="row justify-content-center">
                  <div class="col-3" v-for="(f, index) in sortedComboDetails.slice(1, 4)" :key="index">
                      <div>
                        <img :src="require(`../assets/images/${f.product_src}`)"  class="zoom-img"
                        :style="{ width: '100%', height: '83px', 'border-radius': '10px'}"/> 
                      </div>
                  </div>
              </div>
              
              <!-- Phần tử cuối cùng -->
              <div class="row justify-content-center mt-5">
                  <div class="col-3" v-for="(f, index) in sortedComboDetails.slice(4, 5)" :key="index">
                      <div>
                        <img :src="require(`../assets/images/${f.product_src}`)"  class="zoom-img"
                        :style="{ width: '100%', height: '83px', 'border-radius': '10px'}"/> 
                      </div>
                  </div>
              </div>
              <br>
            </div>
            <br>
            
            <div class="row d-flex justify-content-center" v-for="(f, index) in sortedComboDetails" :key="index" >
              <div class="col text-right">
                <h4 style="color: black; font-weight: bold;"> {{ f.product_category }}  </h4>
              </div>
              <div class="col text-center ">
                <h4 style="color: black; font-weight: bold;"> {{ f.product_name }}  </h4>
              </div>
              <div class="col text-left">
                <h4 style="color: black; font-weight: bold;"> {{ formatCurrency(f.product_price) }}</h4>
              </div>
            </div>
            <br>
            <hr>
            <div>
              <div class="row d-flex justify-content-center"> 
                <div class="col-8 text-center ">
                  <h4 style="color: #595959; font-weight: bold;">{{ currentComboDesc() }}</h4>
                </div>
              </div> 
              <br>
              <div class="row justify-content-center">
                <h3 style="color: black; font-weight: 900;"> {{ currentComboName() }}</h3>
              </div>
    
              <div class="row justify-content-center">
                <h3 style="color: #FF0099; font-weight: bold;"> Giá: {{ formatCurrency(currentComboPrice()) }}</h3>
              </div>
              <div class="row justify-content-center">
                <button @click="addToCart()" type="button" class="btn btn-lg font-weight-bold" 
                  style="background-color: #FFC0CB; color: black; border-radius: 10px;">
                  Thêm Vào Giỏ
                </button>
              </div>
              <br>
            </div>

          </div>
        </div>
      </div>
      <div class="col-1 d-flex align-items-center justify-content-center">
        <button @click="nextCombo" style="background: none; border: none;" class="zoom-light">
          <span class="carousel-control-next-icon" style="background-color: #e6e6e6; box-shadow: 0 1px 1px #999999; padding: 25px; border-radius: 15px;"></span>
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
    name: "Combo",
    data() {
      return {
        allCombo: [],
        comboDetails: [],
        currentIndex: 0
      };
    },
  
    created(){
      this.showdetails(1);
    },

    mounted(){
      this.getAllCombo();
    },
  
    computed: {
      ...mapState(["user"]),
  
      sortedComboDetails() {
        return this.comboDetails;
      },

      // imageHeight() {
      //       return `calc(100% * 2 / 3)`;
      // },

    },
  
    methods: {
      formatCurrency(amount) {
          if (!amount) return '';
          return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
      },

      async getAllCombo() {
        try {
          const response = await axios.get("/combo");
          this.allCombo = response.data;
        } catch (error) {
          console.error("Error fetching combo:", error);
        }
      },

      currentComboName() {
        return this.allCombo[this.currentIndex] ? this.allCombo[this.currentIndex].combo_name : '';
      },

      currentComboDesc() {
        return this.allCombo[this.currentIndex] ? this.allCombo[this.currentIndex].combo_desc : '';
      },

      currentComboPrice() {
        return this.allCombo[this.currentIndex] ? this.allCombo[this.currentIndex].combo_price : '';
      },
  
      async showdetails(id) {
        try {
          const response = await axios.get(`/combodetails/product/${id}`);
  
          this.comboDetails = response.data.sort((a, b) => {
            const categoryOrder = { "Khai Vị": 1, "Món Chính": 2, "Tráng Miệng": 3 };
            return categoryOrder[a.product_category] - categoryOrder[b.product_category];
          });
        } catch (error) {
          console.error("Error fetching combo details:", error);
        }
      },
  
      nextCombo() {
        if (this.currentIndex < this.allCombo.length - 1) {
          this.currentIndex++;
          this.showdetails(this.allCombo[this.currentIndex].combo_id);
        }
      },
  
      prevCombo() {
        if (this.currentIndex > 0) {
          this.currentIndex--;
          this.showdetails(this.allCombo[this.currentIndex].combo_id);
        }
      },

      async addToCart() {
        if (this.user) {
          const comboId = this.allCombo[this.currentIndex].combo_id;
          try {
              await this.showdetails(comboId);
              // let comboDetails = comboDetailsResponse.data; // Lấy dữ liệu từ response
              if (Array.isArray(this.comboDetails)) {
                let count = 0;
                for (const product of this.comboDetails) {
                    let existItem = await axios.get('/cartItem/' + parseInt(this.user.user_id) + '/' + parseInt(product.product_id));
                    console.log(this.comboDetails.length)
                    if (existItem.data.length > 0) {
                      count+=1
                    } else {
                        let data = {
                            user_id: parseInt(this.user.user_id),
                            product_id: parseInt(product.product_id),
                            item_qty: 1,
                            item_notes: '',
                        };
                        await axios.post("/cartItem/", data) 
                    }
                }
                if(count == this.comboDetails.length ) { this.$refs.alert.showAlert('warning', 'Xin Lỗi!', 'Combo đã được thêm vào giỏ trước đó!') }
                else this.$refs.alert.showAlert('success', 'Cám Ơn!', 'Thêm Combo thành công!')
              } else {
                  console.error("Combo details is not an array:", this.comboDetails);
                  // Xử lý lỗi nếu comboDetails không phải là một mảng
              } 
          } catch (error) {
              console.error("Error fetching combo details:", error);
              // Handle error
          }
        } else {
            this.$refs.alert.showAlert('warning', 'Xin Lỗi!', 'Bạn chưa Đăng Nhập')
        }
      }

      

    },        
  
    components: {
      VueBasicAlert
    }
  };
  </script>
  
  <style scoped>
    .zoom-light {
      transition: transform 0.2s ease;
    }

    .zoom-light:hover {
      transform: scale(1.1); /* Hoặc bất kỳ giá trị zoom nào bạn muốn */
      background-color: #e600e6;
    }

    .zoom-img {
      transition: transform 0.2s ease;
    }

    .zoom-img:hover {
      transform: scale(1.5); /* Hoặc bất kỳ giá trị zoom nào bạn muốn */
    }
  </style>
  