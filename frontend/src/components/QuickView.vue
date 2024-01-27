<template>
    <vue-basic-alert :duration="300" :closeIn="2000" ref="alert" />

    <div class="quick-view">
        <div class="quick-view-inner" v-for="f in selectedProduct" :key="f">
            
            <div class="product-detail d-flex">
                <div class="image">
                    <img :src="require(`../assets/images/${f.product_src}`)" alt="" />
                </div>
                <div class="content">
                    <h2 class="d-flex justify-content-between" style="color: #FF66CC; font-size: larger;">{{ f.product_name }}
                        <slot></slot>
                    </h2>
                    <p class="desc">{{ f.product_desc }}</p>
                    <p class="money">Giá: {{ parseFloat(f.product_price) }} vnd</p>
                    <!-- <div class="qty">
                        <label for="qty">Quantity:</label>
                        <input type="number" name="qty" id="qty" :value="qty" min="1" max="100"
                            @change="onQtyChange($event)" />
                    </div> -->
                    <!-- <button class="btn" @click="addToCart">Add to cart</button> -->
                    <div v-if="user"> 
                        <button type="button" class="btn" @click="addToCart"> Add</button>
                    </div>

                    <div v-else> 
                        <button type="button" class="btn" @click="canNotAddToCart"> Add</button>
                    </div>


                    <!-- <div v-else class="quick-view">
                        <div class="quick-view-inner">
                            <h2 class="d-flex justify-content-between">Please login to use this method
                                <slot></slot>
                            </h2>
                            <div class="link-to-login" style="text-align: center; margin-top: 120px;">
                                <router-link class="btn" to="/login" style="padding: 28px; font-size: 24px">login now
                                </router-link>
                            </div>
                        </div>
                    </div> -->
                    
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

    computed: {
        ...mapState(["allProducts", "user"]),
        selectedProduct: function () {
            return this.allProducts.filter((f) => parseInt(f.product_id) == parseInt(this.product));
        }
    },

    methods: {
        onQtyChange: function (e) {
            if (e.target.value < 1) {
                e.target.value = 1;
                this.qty = e.target.value;
            } else {
                this.qty = e.target.value;
            }
        },
        async canNotAddToCart() {
            this.$refs.alert.showAlert('warning', 'Sorry!', 'Login now to use this method!')
        },
        
        async addToCart() {
            let existItem = await axios.get('/cartItem/' + parseInt(this.user.user_id) + '/' + parseInt(this.product));

            if (existItem.data.length == 1) {
                let data = {
                    user_id: parseInt(this.user.user_id),
                    product_id: parseInt(this.product),
                    item_qty: parseInt(this.qty) + parseInt(existItem.data[0].item_qty)
                };
                await axios.put("/cartItem/", data)
                this.$refs.alert.showAlert('success', 'Thank you!', 'Add To Cart Successfully !')

            } else {
                let data = {
                    user_id: parseInt(this.user.user_id),
                    product_id: parseInt(this.product),
                    item_qty: 1
                };

                await axios.post("/cartItem/", data)
                this.$refs.alert.showAlert('success', 'Thank you!', 'Add To Cart Successfully !')
            }
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
    z-index: 99;
    display: flex;
    align-items: center;
    justify-content: center;
}

.quick-view .quick-view-inner {
    width: 1500px;
    height: 600px;
    background-color: #FFF0F5;
    border-radius: 15px;
    padding-top: 0;
    padding-right: 30;
}



.quick-view .quick-view-inner .product-detail .image img {
    height: 600px;
    margin-right: 20px;
    border-radius: 15px;
}

.quick-view .quick-view-inner .product-detail .content {
    margin-top: 20px;
    padding-right: 30px;
    font-size: 20px;
    width: 100%;
}

.quick-view .quick-view-inner .product-detail .content p span {
    margin-left: 5px;
    text-decoration: line-through;
    opacity: 0.5;
}

.quick-view .quick-view-inner .product-detail .content div label {
    margin-right: 10px;
}

.quick-view .quick-view-inner .product-detail .content .btn {
    margin-top: 20px;
    float: right;
}

.btn{
    
            cursor: pointer;
            border: 1px solid #FFF0F5;
            padding: 14px 30px;
            border-radius: 200px;
            color: #000000;
            background: #FF0099;
            font-weight: 600;
            font-family: "Open Sans", sans-serif;
            font-size: 16px;
            transition: 200ms;
            
            &:hover{
            background-color: white;
            color: #FF0099;
          
        }
}

@media (max-width: 768px) {

    .quick-view .quick-view-inner {
        width: 50vw;
        height: 40vh;

    }

    .quick-view .quick-view-inner h2 {
        font-size: 20px;
    }

    .quick-view .quick-view-inner .btn {
        font-size: 10px;
        padding: 0.3rem 0.9rem;
    }

    .quick-view .quick-view-inner .product-detail .image img {
        height: 12rem;
        margin: 30px;
        margin-left: 0px;

    }

    .quick-view .quick-view-inner .product-detail .content .desc {
        font-size: 12px;
    }

    .quick-view .quick-view-inner .product-detail .content .qty {
        font-size: 12px;
    }

    .link-to-login {
        margin-top: 20px !important;
    }
}

@media (max-width: 576px) {
    .quick-view .quick-view-inner {
        width: 90vw;
        height: 40vh;
    }

    .link-to-login {
        margin-top: 50px !important;
    }

    .link-to-login>a {
        padding: 20px !important;
        font-size: 18px !important;
    }

}
</style>
