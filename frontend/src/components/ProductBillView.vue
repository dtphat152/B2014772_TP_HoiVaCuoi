<template>
    <vue-basic-alert :duration="300" :closeIn="2000" ref="alert" />
    <div class="quick-view">
        <div class="quick-view-inner">
            <div class="row">
                <div class="col-2">
                   <slot></slot>
                </div>
                <div class="col-8 text-center">
                    <h1 style="font-weight: 900; color: #ff69b4;">Chi Tiết Đơn #{{ this.Bill }}</h1>
                </div>
                <div class="col-2 text-right">
                </div>   
            </div>

            <div style="overflow-y: auto; height: 600px;">
                <div style="width: 95%;">
                    <template v-for="(category, catIndex) in ['Khai Vị', 'Món Chính', 'Tráng Miệng','Thức Uống','Bàn Ghế','Rạp Che','Cổng Hoa','Sảnh Tiệc','Gia Tiên','Mâm Quả','Xe Hoa']" :key="catIndex">
                        <h3 class="mb-2 mb-2 font-weight-bold" style="color: #d35ea4;">{{ category }}</h3> 
                        <div v-for="(f, index) in filterProducts" :key="index">
                            <div v-if="f.product_category === category" 
                            class="row mb-1 d-flex justify-content-between align-items-center" style="background-color: #ffb3cc; margin-left: 10px; border-radius: 10px;">
                            
                                <div class="col-md-2 col-lg-2 col-xl-2" style="padding-left: 0px;">
                                    <img :src="f.product_src" alt="" class="cart-product-img" 
                                    style="width: 100px; border-radius: 10px; ">
                                </div>
                                <div class="col-md-3 col-lg-3 col-xl-4">
                                    <h4 class="font-weight-bold mb-0" style="color: #d35ea4;">{{ f.product_name }}</h4>
                                    <h6 class="mb-0" style="color: black; font-size: 15px;">Đơn giá: {{ formatCurrency(item_price[index]) }}</h6>
                                </div>
                                <div class="col-md-3 col-lg-2 col-xl-2">
                                    <input type="number" id="number" v-model="item_qty[index]"
                                    class="form-control " min="0" max="1000" 
                                    style="border: none; text-align: center; background:#f2f2f2; border-radius: 10px; color: black; font-weight: 900;">
                                </div>
                                
                                <hr class="my-4">
                            </div>
                            
                            <div v-if="f.product_category === category" class="row mb-5" style="background-color: #f2f2f2; margin-left: 10px; border-radius: 10px;">
                                <div class="form-group col-10">
                                    <input type="text" placeholder="Ghi chú..." class="form-control" 
                                    style="color: black; border: none; font-weight: bold; background-color: #f2f2f2;" v-model="itemNotes[index]">
                                </div>
                                <br>
                            </div>
                        </div>
                        
                        <hr class="my-4">
                    
                    </template> 

                </div>
            </div>
           
        </div>
    </div>

</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
import VueBasicAlert from 'vue-basic-alert';
export default {
    props: ['Bill'],
    name: "ProductBillView",

    data() {
        return {
            allProductsInBill: [],
            item_qty: [],
            itemNotes: [],
            item_price: [],
            tablePrice:'',
        }
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
                let data = (await axios.get('/billdetails/' + this.Bill)).data;
                data.forEach(element => {
                    this.allProductsInBill.push(element.product_id);
                    this.item_qty.push(element.item_qty)
                    this.itemNotes.push(element.item_notes)
                    this.item_price.push(element.product_price)
                });
            }
        },
    },

    components: {
        VueBasicAlert
    }
}
</script>

<style scoped>

.quick-view {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 9999;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    outline: none;
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}


.quick-view .quick-view-inner {
    width: 80%;
    height: 80%;
    background-color: #f2f2f2;
    padding: 32px !important;
    border: none; /* Clear border */
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); /* Add shadow for better visibility */
    border-radius: 20px;
}

.quick-view .quick-view-inner h2 {
    margin: 0;
    font-size: 32px;
    color: #ef87aa;
    margin-bottom: 20px;
}



.quick-view .quick-view-inner .product-detail .content {
    margin-top: 20px;
    font-size: 12px;
    width: 100%;
}

.quick-view .quick-view-inner .product-detail .content p:first-of-type {
    font-size: 16px;
    color: #ef87aa;
}

.quick-view .quick-view-inner .product-detail .content p span {
    font-size: 14px;
    color: black;
}

.quick-view .quick-view-inner .price {
    margin-top: 30px;
    font-size: 16px;
}

@media (max-width: 768px) {
    .quick-view .quick-view-inner {
        width: 80vw;
        height: 60vh;
    }

    .quick-view .quick-view-inner h2 {
        font-size: 20px;
    }

    .quick-view .quick-view-inner .product-detail .content .desc,
    .quick-view .quick-view-inner .product-detail .content .name span {
        font-size: 12px !important;
    }

    .quick-view .quick-view-inner .product-detail .content .name {
        font-size: 14px !important;
    }
}

@media (max-width: 576px) {
    .quick-view .quick-view-inner {
        width: 90vw;
        height: 65vh;
    }

    .quick-view .quick-view-inner div:first-of-type {
        flex-direction: column;
    }
}

@media (max-width: 376px) {
    .quick-view .quick-view-inner {
        width: 90vw;
        height: 65vh;
        padding: 5px !important;
    }

    .quick-view .quick-view-inner .product-detail .content .name {
        font-size: 12px !important;
    }
}

</style>
