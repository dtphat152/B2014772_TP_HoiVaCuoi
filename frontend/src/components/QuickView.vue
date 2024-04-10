<template>
    <vue-basic-alert :duration="300" :closeIn="2000" ref="alert" />

    <div class="quick-view">
        name: {{ selectedProduct.product_name }}
        <div class="quick-view-inner">
            <div class="row">
                <div class="col-2">
                   <slot></slot>
                </div>
                <div class="col-8 text-center">
                    <h1 style="font-weight: bold; color: #ff69b4;">{{ selectedProduct[0].product_name }}</h1>
                </div>
                <div class="col-2 text-right">
                    <button class="btn" style="background-color: #ffe6ea; border-radius: 10px; color: #40bf77;" 
                    @click="addToCart(selectedProduct[0].product_name)">
                        <h3 style="font-weight: bold;">Thêm Vào Giỏ</h3>
                    </button>
                </div>   
            </div>
            <br>
            <div class="row">
                <div class="col-8 ">
                    <img :src="require(`../assets/images/${selectedProduct[0].product_src}`)" style="width: 100%; border-radius: 15px;"/>
                </div>
                <div class="col-4" style="background-color: #ffe6ea; border-radius: 15px;">
                    
                    <div class="row m-4 " style="">
                        <div class="col-12 text-center" style="background-color: white; border-radius: 15px;">
                            <h4 class="font-weight-bold">{{ formatCurrency(selectedProduct[0].product_price) }}</h4> 
                        </div>
                    </div>
                    <div class="row m-4 " style="">
                        <div class="col-12" style="background-color: white; border-radius: 15px;">
                            <h4>{{selectedProduct[0].product_desc}}</h4>
                        </div>
                    </div>
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
    props: ['product'],
    name: "QuickView",

    data() {
        return {
            qty: 1,
        }
    },

    created(){
        
    },

    computed: {
        ...mapState(["allProducts", "user"]),
        selectedProduct: function () {
            return this.allProducts.filter((f) => parseInt(f.product_id) == parseInt(this.product));
        },
    },

    methods: {
        
        formatCurrency(amount) {
          if (!amount) return '';
          return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
        },
        
        async addToCart(name) {
            if (this.user) {
            
                let existItem = await axios.get('/cartItem/' + parseInt(this.user.user_id) + '/' + parseInt(this.product));
                if (existItem.data.length > 0) {
                    let data = {
                        user_id: parseInt(this.user.user_id),
                        product_id: parseInt(this.product),
                        item_qty: parseInt(this.qty) + parseInt(existItem.data[0].item_qty),
                        item_notes: '',
                    };
                    await axios.put("/cartItem/", data)
                    this.$refs.alert.showAlert('success', 'Cám Ơn!', 'Đã thêm '+name+' vào Giỏ!');

                } else {
                    let data = {
                        user_id: parseInt(this.user.user_id),
                        product_id: parseInt(this.product),
                        item_qty: 1,
                        item_notes: '',
                    };
                    await axios.post("/cartItem/", data)
                    this.$refs.alert.showAlert('success', 'Cám Ơn!', 'Sản Phẩm được thêm thành công!')
                }
            } else  this.$refs.alert.showAlert('error', 'Xin Lỗi!', 'Bạn chưa đăng nhập!');
        }
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
    background-color: #ffccff;
    padding: 32px;
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
