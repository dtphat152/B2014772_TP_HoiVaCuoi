<template>
    <div class="text-center" style="margin-top: 90px; padding-left: 260px">

        <div class="row d-flex justify-content-between px-5" style="background-color: #FFF0F5;">
            <router-link to="/admin/combomanager">
                <h4 class="text-black-50 pt-2" style="background-color: none; color: red; font-weight: bold;">Back</h4>
            </router-link>
            <button @click="showornot()" title="Open ProductOrder" class="btn text-success" 
                style="background-color: none; font-weight: bold;"><h4>Add product to Combo</h4>
                <br>
            </button>
        </div>

        <div class="container" style="width: 100%; ">

        <hr style="background-color: #FFF0F5; height: 5px;"> <br>
        <div class="checkout-form-container">
            <form @submit.prevent="handleSubmit" autocomplete="off" class="myform" style="background-color: #FFF0F5;">
                <div class="form-group details-group">
                    <h2 style="color: #d35ea4; font-weight: bold;">Edit Combo</h2>
                    <br>
                    <div class="form-group">
                        <input type="text"  placeholder="Name" class="form-control " autocapitalize="off"
                            v-model="comboObj.name" style="background-color: aliceblue;"/>
                        <p class="error-mess" v-if="errorObj.nameErr.length > 0">{{ errorObj.nameErr[0] }}</p>
                    </div>
                    <div class="form-group">
                        <input type="text"  placeholder="Price" class="form-control"
                            v-model="comboObj.price" style="background-color: aliceblue;" />
                        <p class="error-mess" v-if="errorObj.priceErr.length > 0">{{ errorObj.priceErr[0] }}</p>
                    </div>
                    <div class="form-group">
                        <textarea name="txtMsg" class="form-control" placeholder="Description" 
                            style="width: 100%; height: 150px; background-color: aliceblue;"  v-model="comboObj.desc" ></textarea>
                        <p class="error-mess" v-if="errorObj.descErr.length > 0">{{ errorObj.descErr[0] }}</p>
                    </div>
                </div>
                <br> 
                <h6 class="mt-2 text-left">Danh sách sản phẩm:</h6>
                    <div v-for="(f, index) in filterProducts" :key="index" class="mt-2 text-left">
                        <div class="row">
                            <div class="col-2 offset-1 px-0">{{ f.product_category }} <hr></div>
                                <div class="col-7 px-0">{{ f.product_name }}<hr></div>
                                <div class="col-2 px-0 pt-2">
                                    <button class="btn" style="color: crimson;" @click="removeBtn(index)">
                                        <i class="fa fa-trash"></i>
                                    </button>
                                    
                                </div>
                        </div>
                    </div>
                
               

                <div class="form-group">
                    <br><hr>
                    <input type="submit" value="Submit" class="btn p-2" style="width: 100%; background-color: #d35ea4; color: white; font-weight: bold;"/>
                </div>
               
            </form>
            
        </div>
    </div>
</div>

    <div v-if="showProductOrder" class="order-details">
        <div class="order-details-inner">
            <ProductOrder  :ID="this.id" @productAdded="handleProductAddedToCombo">
                <button class="btn" @click="closeView">back</button>
            </ProductOrder>
        </div>
    </div> 
</template>

<script>
import ProductOrder from "./component/ProductOrder.vue";
import axios from "axios";
import { mapState } from "vuex";
export default {
    props: ['id'],

    name: "EditCombo",

    data() {
        return {
            allProductsInCombo: [],
            comboObj: { name: "", price: "", desc: ""},
            errorObj: { nameErr: [], priceErr: [], descErr: [] },
            showProductOrder: false, 
        }
    },

    created() {
        // this.loadSelectedCombo();
        // this.getAllProducts();
    },

    mounted() {
        this.loadSelectedCombo();
        this.getAllProducts();
    },

    computed: {
        ...mapState(["allProducts"]),

        filterProducts: function () {
            return this.allProducts.filter(
                (f) => this.matchID(f, this.allProductsInCombo)
            );
        },
    },

    methods: {

        matchID: function (product, comboArray) {
            let temp = "";
            comboArray.forEach(element => {
                if (parseInt(product.product_id) == element) {
                    temp = product
                }
            });
            return temp
        },
        
        async loadSelectedCombo() {
            try {
                let response = await axios.get("/combo/"+this.id);
                let combo = response.data;
                // Kiểm tra nếu dữ liệu là một mảng
                if (Array.isArray(combo) && combo.length > 0) {
                    // Truy cập vào phần tử đầu tiên trong mảng
                    this.comboObj = {
                        name: combo[0].combo_name,
                        price: combo[0].combo_price,
                        desc: combo[0].combo_desc,
                    };
                } else {
                    console.error('Error fetching combo: Data is not in expected format');
                }
            } catch (error) {
                console.error('Error fetching combo:', error);
            }
        },


        resetCheckErr: function () {
            this.errorObj.nameErr = [];
            this.errorObj.priceErr = [];
            this.errorObj.descErr = [];
        },

        checkEmptyErr: function () {
            for (var typeErr in this.errorObj) {
                if (this.errorObj[typeErr].length != 0) {
                    return false;
                }
            }
            return true;
        },


        checkForm: function () {
            this.resetCheckErr();

            // Name validate
            if (!this.comboObj.name) {
                this.errorObj.nameErr.push('Entering name is required');
            }

            // Price validate
            if (!this.comboObj.price) {
                this.errorObj.priceErr.push('Entering price is required');
            }

            // Desc validate
            if (!this.comboObj.desc) {
                this.errorObj.descErr.push('Selecting desc method is required');
            }
        },

        closeView: function () {
            this.showProductOrder = !this.showProductOrder;
        },

        async getAllProducts() {
                let data = (await axios.get('/combodetails/' + this.id)).data;
                data.forEach(element => {
                    this.allProductsInCombo.push(element.product_id);
                    // console.log("Data:"+element.product_id);
                }); 
        },

        handleProductAddedToCombo() {
            this.updateAllProductsInCombo();
        },

        async updateAllProductsInCombo() {
            // Cập nhật danh sách sản phẩm trong combo khi có sản phẩm mới được thêm vào
            await this.getAllProducts();
        },


        showornot() {
            this.showProductOrder = !this.showProductOrder;
        },

        async removeBtn(index) {
            let confirmResult = window.confirm("Bạn có chắc chắn muốn xóa ra khỏi combo?" );
            if (confirmResult) {
                try {
                    await axios.delete("/combodetails/" + this.id + "/" + this.allProductsInCombo[index]);
                    console.log("Successfully removed product in combo:", this.id , this.allProductsInCombo[index]);
                } catch (error) {
                    console.error("Error remove product in combo:", error);
                }
                this.allProductsInCombo.splice(index, 1);
            }
        },


        async handleSubmit(e) {
            this.checkForm();

            if (!this.checkEmptyErr()) {
                e.preventDefault();
            } else { 
                let combo = {
                    combo_id: this.id,
                    combo_name: this.comboObj.name,
                    combo_price: this.comboObj.price,
                    combo_desc: this.comboObj.desc,
        
                }
                try {
                    await axios.put(`/combo/${this.id}`, combo);
                    this.$router.push("/admin/combomanager");
                } catch (error) {
                    console.error("Error submitting combo:", error);
                }
            }
        },
    
    },

    components: { ProductOrder }
};
</script>

<style>
/* .containerEdit {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 99;
    background-color: rgba(0, 0, 0, 0.2);
    display: flex;
    align-items: center;
    justify-content: center;
} */

input {
    text-transform: none !important;
}

.container {
  width: 500px;
  margin-top: 10px;
}

.myform {
  border: 1px solid #ccc; /* Tạo viền xung quanh form */
  border-radius: 5px; /* Bo viền để làm mềm hơn */
  padding: 20px; /* Tạo khoảng cách giữa viền và nội dung form */
}

.order-details {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      z-index: 99;
      background-color: rgba(0, 0, 0, 0.2);
      display: flex;
      align-items: center;
      justify-content: center;
      outline: none; /* Clear outline */
  }

  .order-details .order-details-inner {
      width: 80%;
      height: 80%;
      background-color: #fff;
      padding: 32px;
      border: none; /* Clear border */
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); /* Add shadow for better visibility */
      border-radius: 20px;
  }

  .order-details .order-details-inner h2 {
      margin: 0;
      font-size: 32px;
      color: #ef87aa;
      margin-bottom: 20px;
  }

  .order-details .order-details-inner .product-detail .image img {
      height: 8rem;
      width: 8rem;
      margin: 20px;
  }

  .order-details .order-details-inner .product-detail .content {
      margin-top: 20px;
      font-size: 12px;
      width: 100%;
  }

  .order-details .order-details-inner .product-detail .content p:first-of-type {
      font-size: 16px;
      color: #ef87aa;
  }

  .order-details .order-details-inner .product-detail .content p span {
      font-size: 14px;
      color: black;
  }

  .order-details .order-details-inner .price {
      margin-top: 30px;
      font-size: 16px;
  }

  @media (max-width: 768px) {
      .order-details .order-details-inner {
          width: 80vw;
          height: 60vh;
      }

      .order-details .order-details-inner h2 {
          font-size: 20px;
      }

      .order-details .order-details-inner .product-detail .content .desc,
      .order-details .order-details-inner .product-detail .content .name span {
          font-size: 12px !important;
      }

      .order-details .order-details-inner .product-detail .content .name {
          font-size: 14px !important;
      }
  }

  @media (max-width: 576px) {
      .order-details .order-details-inner {
          width: 90vw;
          height: 65vh;
      }

      .order-details .order-details-inner div:first-of-type {
          flex-direction: column;
      }
  }

  @media (max-width: 376px) {
      .order-details .order-details-inner {
          width: 90vw;
          height: 65vh;
          padding: 5px !important;
      }

      .order-details .order-details-inner .product-detail .content .name {
          font-size: 12px !important;
      }
  }

</style>