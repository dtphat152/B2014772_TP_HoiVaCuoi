<template>
    <div class="container_order" style="width: 100%; padding-left: 260px; padding-right: 10px;">
      <div class="mt-5 mx-2 row d-flex justify-content-between">
        <h1>Combo Manager</h1>
        <router-link to="AddCombo">
          <button style="padding-left: 20px; padding-right: 20px;font-weight: bold;" class="btn btn-success">Thêm Combo Mới</button>
        </router-link>
      </div>
      <br><hr style="background-color: #FFF0F5; height: 3px;">
  
      <div v-for="(c, index) in allCombo" :key="index" style="background-color: #FFF0F5;">
        <div class="row pt-4">
          <div class="col-2 pl-5">
            <h3>{{ c.combo_name }} </h3>
          </div>
          <div class="col-2">
            <h5>{{ formatCurrency(c.combo_price) }}</h5>
          </div>
          <div class="col-6">
            <p style="padding-right: 30px;">{{ c.combo_desc }}</p>
          </div>
          <div class="col-2 text-right px-5">
            <button @click="showdetails(c.combo_id)" class="btn p-2 rounded-lg mr-2" style="background-color: #db7093;">Details</button>
            <router-link :to="{ name: 'EditCombo', params: { id: c.combo_id } }">
              <button class="btn p-2 rounded-lg" style="background-color: #FFDAB9;">Edit</button>
            </router-link>
          </div>
        </div>
  
        <div v-if="comboDetailStates[c.combo_id]" class="mx-5 mt-1 pt-2" style="background-color: #FFFAFA;">
          <div v-if="comboDetails.length > 0" class="mt-2 text-left">
            <div v-for="(f, index) in sortedComboDetails" :key="index" class="row">
              <div class="col-2 offset-2 px-0">{{ f.product_category }} <hr></div>
              <div class="col-5 px-0">{{ f.product_name }}<hr></div>
              <div class="col-2 text-right px-0">{{ formatCurrency(f.product_price)}} <hr></div>
            </div>
          </div>
          <div v-else>
            <p>No details available</p>
          </div>
        </div>
        <hr>
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
  .navbar {
    flex-direction: column;
  }
  .navbar-nav {
    width: 100%;
  }
  .table-responsive {
    margin-top: 5vh;
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
  