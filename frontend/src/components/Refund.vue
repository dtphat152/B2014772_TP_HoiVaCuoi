<template>
    <div style="overflow-y: auto; height: 600px;">
        <div style="width: 95%;">
            <template v-for="(category, catIndex) in ['Thức Uống']" :key="catIndex">
                <h2 class="mb-2 mb-2 font-weight-bold mt-2" style="color: black;">Dịch Vụ Đã Được Hoàn Trả</h2> 
                <br>
                <div v-for="(f, index) in filterProducts" :key="index">
                    <div v-if="f.product_category === category" 
                    class="row mb-1 d-flex justify-content-between align-items-center" style="background-color: #f2f2f2; margin-left: 10px; border-radius: 10px;">
                        <div class="col-md-2 col-lg-2 col-xl-2" style="padding-left: 0px;">
                            <img :src="f.product_src" alt="" class="cart-product-img" 
                            style="width: 100px; border-radius: 10px; ">
                        </div>
                        <div class="col-md-3 col-lg-3 col-xl-4">
                            <h4 class="font-weight-bold mb-0" style="color: #d35ea4;">{{ f.product_name }}</h4>
                            <h6 class="mb-0" style="color: black; font-size: 15px;">Đơn giá: {{ formatCurrency(f.product_price) }}</h6>
                        </div>
                        <div class="col-md-3 col-lg-2 col-xl-2">
                            <input type="number" id="number" v-model="item_qty[index]" @change="onQtyChange(index,f.product_name)"
                            class="form-control " min="0" max="1000" readonly
                            style="border: none; text-align: center; background:#ffb3cc; border-radius: 10px; color: black; font-weight: 900;">
                        </div>
                        <div class="col-md-4 col-lg-3 col-xl-3 text-end">
                            <h4 class="font-weight-bold mb-0" style="color: #d35ea4;">{{ formatCurrency(this.price[index]) }}</h4>
                        </div>
                    </div>
                    <hr class="my-4">
                </div>            
            </template> 

        </div>
    </div>
                            
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
export default {
    props: ['Bill'],
    name: "Refund",

    data() {
        return {
            allProductsInBill: [],
            item_qty: [],
            price: [],
        }
    },

    created(){
    
    },

    mounted() {
        this.getAllProducts();
    },

    computed: {
        ...mapState(["allProducts","user"]),

        filterProducts: function () {
            return this.allProducts.filter(
                (f) => this.matchID(f, this.allProductsInBill)
            );
        },

    },

    methods: {
        formatCurrency(amount) {
          if (!amount) return '';
          return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
        },
        
        matchID: function (product, cartArray) {
            return cartArray.includes(product.product_id);
        },

        async getAllProducts() {
            if (this.Bill) {
                let data = (await axios.get('/billdetails/refund/' + this.Bill)).data;
                data.forEach(element => {
                    this.allProductsInBill.push(element.product_id);
                    this.item_qty.push(element.refund)
                    this.price.push(element.value_refund)
                });

            }
        },
    }
}
</script>
