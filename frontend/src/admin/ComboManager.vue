<template>
    <div class="container_combo">
      <div class="p-5 mx-1 row d-flex justify-content-between" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999;">
        <h1>Combo Manager</h1>
        <router-link to="AddCombo">
          <button style="padding-left: 20px; padding-right: 20px;font-weight: 900; border-radius: 15px;" class="btn btn-success">Thêm Combo Mới</button>
        </router-link>
      </div>
      <br>
      <div class="p-5" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; height: 785px;">  

        <div style="overflow-y: auto; height: 750px;">
          <div style="width: 95%; margin-left: 2%;">

            <div v-for="(c, index) in allCombo" :key="index" style="background-color: #ffb3cc; border-radius: 20px;">
              <div class="row pt-4 mb-5">
                <div class="col-2 pl-5">
                  <h3 style="font-weight: 900;">{{ c.combo_name }} </h3>
                </div>
                <div class="col-2">
                  <h5 style="font-weight: 900;">{{ formatCurrency(c.combo_price) }}</h5>
                </div>
                <div class="col-6">
                  <h5 style="padding-right: 30px; font-weight: bold;">{{ c.combo_desc }}</h5>
                </div>
                <div class="col-2 text-right px-5">
                  <button @click="showdetails(c.combo_id)" class="btn p-2 mr-2" style="background-color:#e6e6e6; border-radius: 15px;">Details</button>
                  <router-link :to="{ name: 'EditCombo', params: { id: c.combo_id } }">
                    <button class="btn p-2" style="background-color: Orange; border-radius: 15px;">Edit</button>
                  </router-link>
                </div>
              </div>
        
              <div v-if="comboDetailStates[c.combo_id]" class="mx-5 mt-1 pt-2" style="background-color:#e6e6e6; border-radius: 20px;">
                <div v-if="comboDetails.length > 0" class="mt-2 text-left">
                  <div v-for="(f, index) in sortedComboDetails" :key="index" class="row">
                    <div class="col-2 offset-2 px-0" style="font-weight: 900;">{{ f.product_category }} <hr></div>
                    <div class="col-5 px-0" style="font-weight: 900;">{{ f.product_name }}<hr></div>
                    <div class="col-2 text-right px-0" style="font-weight: 900;">{{ formatCurrency(f.product_price)}} <hr></div>
                  </div>
                </div>
                <div v-else>
                  <p>No details available</p>
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
  import { mapState, mapMutations } from "vuex";
  export default {
    name: "ComboManager",
    data() {
      return {
        allCombo: [],
        comboDetails: [],
        comboDetailStates: {} 
      };
    },
    created() {
      this.getAllCombo();
      if (!this.admin) {
        this.$router.push("/");
      }
    },
    computed: {
      ...mapState(["admin"]),

        sortedComboDetails() {
            return this.comboDetails;
        }
    },

    methods: {
      ...mapMutations(["setAdmin"]),

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

        async showdetails(id) {
            // Toggle trạng thái chi tiết của combo được click
            this.comboDetailStates[id] = !this.comboDetailStates[id];
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
    },
  };
  </script>
  
<style scoped>

h1 {
    font-weight: 900;
    color: #d35ea4;
}
.container_combo{
    margin-left: 220px; 
    margin-right: 20px; 
    margin-top: 10px;
    top: 0;
    height: 98vh;  
    opacity: 0.8;
    border-radius: 20px;
 }


</style>
  