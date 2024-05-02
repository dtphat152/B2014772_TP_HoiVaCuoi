<template>
    <vue-basic-alert :duration="300" :closeIn="4000" ref="alert" />
   
  
    <div  class="" style="background-color: none !important;  padding-bottom: 130px;">
        <div class="row" style="padding-top: 50px;">
            <div class="col-2">
            </div>
            <div class="col-4">
                <h1>TP Hỏi và Cưới</h1>
                <hr class="my-4" style="background-color: #ff69b4;">
                <h4 style="font-weight: 800; color: #808080;">Chúng tôi hiểu rằng mỗi cặp đôi mang trong mình những mong muốn và mong đợi riêng cho ngày cưới của mình. Đó là lý do tại sao chúng tôi cam kết cung cấp dịch vụ chất lượng, đảm bảo rằng mỗi chi tiết trong ngày cưới của bạn được tổ chức một cách hoàn hảo và đặc biệt. </h4>
                <div class="row" style="padding-top: 50px !important;">
                    <div class="col-2 text-center">
                        <router-link @click="scrollToTop()" to="/booking">
                            <i class="fa fa1 fa-sticky-note" aria-hidden="true" style="color: white;"></i>
                            <h6 class="text-center p-2" style="color: #808080; font-weight: 900;">Đặt Hàng</h6>
                        </router-link>
                    </div>
                    <div class="col-2 text-center">
                        <router-link @click="scrollToTop()" to="/connect">
                            <i class="fa1 fa-solid fa-link py-4" style="color: white; font-size: 40px;"></i>
                            <h6 class="text-center p-2" style="color: #808080; font-weight: 900;">Kết Nối</h6>
                        </router-link>
                    </div>
                    <div class="col-2 text-center">
                        <router-link @click="scrollToTop()" to="/about">
                            <i class="fa1 fa-solid fa-building px-4" style="color: white;"></i>
                            <h6 class="text-center p-2" style="color: #808080; font-weight: 900;">Chúng Tôi</h6>
                        </router-link>
                    </div>
                    <!-- <div class="col-2 text-center">
                            <i class="fa1 fa-regular fa-message" style="color: white;" @click="chatBox()"></i>
                            <h6 class="text-center p-2" style="color: #808080; font-weight: 900;">Giải Đáp</h6>
                    </div> -->
                </div>
            </div>
            <div class="col-4">
                <img v-if="currentImage === 'wedding_circle1'" 
                    :src="require(`../assets/images/home/wedding_circle1.jpg`)" 
                    :style="{ width: '120%', 'border-radius': '10px'}"
                    class="animated fadeIn"/>

                <img v-else-if="currentImage === 'wedding_circle2'" 
                    :src="require(`../assets/images/home/wedding_circle2.jpg`)" 
                    :style="{ width: '120%', 'border-radius': '10px'}"
                    class="animated fadeIn"/>

                <img v-else 
                    :src="require(`../assets/images/home/wedding_circle3.jpg`)" 
                    :style="{ width: '120%', 'border-radius': '10px'}"
                    class="animated fadeIn"/>
            </div>
            <div class="col-2 d-flex flex-column ">
                <div class="mt-auto">
                    <div class="row justify-content-start mb-2">
                        <div class="rounded-circle text-center p-2">
                            <i class="fa fa2 fa-envelope" aria-hidden="true"></i>
                        </div>
                    </div>
                    <div class="row justify-content-start mb-2">
                        <div class="rounded-circle text-center p-2">
                            <i class="fab fa2 fa-facebook" aria-hidden="true"></i>
                        </div>
                    </div>
                    <div class="row justify-content-start mb-2">
                        <div class="rounded-circle text-center p-2">
                            <i class="fab fa2 fa-youtube" aria-hidden="true"></i>
                        </div>
                    </div>
                    <br>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col2 offset-10">
                <button @click="inc(800)" style="background: none; border: none;" class="zoom-light">
                    <i class="fa-regular fa-circle-down" style="font-size: 55px; color: #ff99a8;"></i>
                </button>
            </div>
        </div>
    </div>



    <div style="background-color: none !important; padding-bottom: 50px;">
        <div class="row">
            <div class="col-2 offset-1">
                <button @click="scrollToTop()" style="background: none; border: none;" class="zoom-light mr-3">
                    <i class="fa-regular fa-circle-up" style="font-size: 40px; color: #ff99a8;"></i>
                </button>
                <button @click="inc(1950)" style="background: none; border: none;" class="zoom-light">
                    <i class="fa-regular fa-circle-down" style="font-size: 40px; color: #ff99a8;"></i>
                </button>
            </div>
            <div class="col-6">
                <h3 class="text-center">Có Thể Phù Hợp Với Bạn</h3>
            </div>
        </div>
        
        <div class="col-sm-10 offset-1 mt-5 ">
            <div class="row">
                <div class="col-md-3 pl-3 pr-3" v-for="(f, index) in filterProducts" :key="index">   
                    <div class="card mb-5">
                        <div class="row card__title">
                            <div class="col-2 mr-2 btn" style="background-color: #ffb3cc;" >
                            </div>
                            <div class="col-9 text-lg-right pr-0"><h4>{{ f.product_name }}</h4></div>
                        </div>
                        <div class="card__body d-flex justify-content-center">
                            <img :src="f.product_src" 
                                :style="{ width: '100%', height: '230px', 'border-radius': '10px'}"/>
                            
                        </div>
                        <div class="card__footer">
                            <div class="recommend">
                            <p>{{f.product_category }}</p>
                            <h4>{{ formatCurrency(f.product_price)}}</h4>
                            </div>
                            <div class="">
                                <button class="btn" style="background-color: #ffb3cc; border-radius: 15px;" 
                                    @click="addToCart(f.product_name,f.product_id)">
                                    <h4 class="font-weight-bold" style="color: black;">Thêm vào Giỏ</h4>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-1 offset-11">
                    <button @click="scrollToTop()" style="background: none; border: none;" class="zoom-light mr-3">
                        <i class="fa-regular fa-circle-up" style="font-size: 40px; color: #ff99a8;"></i>
                    </button>
                    <button @click="inc(1950)" style="background: none; border: none;" class="zoom-light">
                        <i class="fa-regular fa-circle-down" style="font-size: 40px; color: #ff99a8;"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>



    <div style="background-color: none !important;">
        <div class="row">
            <div class="col-2 offset-1">
                <button @click="scrollToTop()" style="background: none; border: none;" class="zoom-light mr-3">
                    <i class="fa-regular fa-circle-up" style="font-size: 40px; color: #ff99a8;"></i>
                </button>
                <button @click="inc(3000)" style="background: none; border: none;" class="zoom-light">
                    <i class="fa-regular fa-circle-down" style="font-size: 40px; color: #ff99a8;"></i>
                </button>
            </div>
            <div class="col-6">
                <h3 class="text-center">Dịch Vụ Nổi Bật</h3>
            </div>
        </div>
        
        <div class="col-sm-10 offset-1 mt-5 ">
            <div class="row">
                <div class="col-md-3 pl-3 pr-3" v-for="(f, index) in filterTopProducts" :key="index">   
                    <div class="card mb-5">
                        <div class="row card__title">
                            <div class="col-2 mr-2 btn" style="background-color: #ffb3cc;" >
                            </div>
                            <div class="col-9 text-lg-right pr-0"><h4>{{ f.product_name }}</h4></div>
                        </div>
                        <div class="card__body d-flex justify-content-center">
                            <img :src="f.product_src" 
                                :style="{ width: '100%', height: '230px', 'border-radius': '10px'}"/>
                            
                        </div>
                        <div class="card__footer">
                            <div class="recommend">
                            <p>{{f.product_category }}</p>
                            <h4>{{ formatCurrency(f.product_price)}}</h4>
                            </div>
                            <div class="">
                                <button class="btn" style="background-color: #ffb3cc; border-radius: 15px;" 
                                    @click="addToCart(f.product_name,f.product_id)">
                                    <h4 class="font-weight-bold" style="color: black;">Thêm vào Giỏ</h4>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-1 offset-11">
                    <button @click="scrollToTop()" style="background: none; border: none;" class="zoom-light mr-3">
                        <i class="fa-regular fa-circle-up" style="font-size: 40px; color: #ff99a8;"></i>
                    </button>
                    <button @click="inc(3000)" style="background: none; border: none;" class="zoom-light">
                        <i class="fa-regular fa-circle-down" style="font-size: 40px; color: #ff99a8;"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>


    
</template>

<script>
import VueBasicAlert from 'vue-basic-alert';
import axios from "axios";
import { mapState } from "vuex";

export default {
    name: "Home",

    data() {
        return {
            page: 1,
            images: ['wedding_circle1', 'wedding_circle2', 'wedding_circle3'],
            currentImageIndex: 0,
            productRecommend: [],
            topProduct: [],
        };
    },

    computed: {
        ...mapState(["allProducts","user"]),

        filterProducts: function () {
            return this.allProducts.filter((f) => this.matchID(f, this.productRecommend));
        },

        filterTopProducts: function () {
            return this.topProduct
        },

        currentImage() {
            return this.images[this.currentImageIndex];
        }
    },

    mounted() {
        this.getProductRecommend();
        this.getTopProduct();
        // Kiểm tra xem script Kommunicate đã được tải chưa
        if (!window.kommunicate) {
            // Nếu chưa được tải, thêm script vào trang
            (function(d, m){
                var kommunicateSettings = {"appId":"fd1cc1a862ae4f2bc125423232a0a2d5","popupWidget":true,"automaticChatOpenOnNavigation":true};
                var s = document.createElement("script"); s.type = "text/javascript"; s.async = true;
                s.src = "https://widget.kommunicate.io/v2/kommunicate.app";
                var h = document.getElementsByTagName("head")[0]; h.appendChild(s);
                window.kommunicate = m; m._globals = kommunicateSettings;
            })(document, window.kommunicate || {});
        }

        setInterval(() => {
            this.currentImageIndex = (this.currentImageIndex + 1) % this.images.length;
        }, 3000);
    },


    methods: {

        formatCurrency(amount) {
            if (!amount) return '';
            return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
        },

        matchID: function (product, productRecommend) {
            return productRecommend.includes(product.product_id);
        },
        async getProductRecommend() {
            if (this.user) {
                let rsp = await axios.get('/recomentdation/' + this.user.user_id)
                this.productRecommend = rsp.data;
            } else {
                let rsp = await axios.get('/recomentdation/' + 0)
                this.productRecommend = rsp.data;
            }
        },

        async getTopProduct() {
            let rsp = await axios.get('/productstop8')
            this.topProduct = rsp.data;
        },

        scrollToTop() {
            window.scrollTo(0, 0);
        },
        inc(y) {
            window.scrollTo(0, y);
        },
        async addToCart(name,product) {
            if (this.user) {
                let existItem = await axios.get('/cartItem/' + parseInt(this.user.user_id) + '/' + parseInt(product));
                if (existItem.data.length > 0) {
                    this.$refs.alert.showAlert('warning', 'Xin Lỗi!', 'Bạn Đã thêm '+name+' vào giỏ trước đó!');
                } else {
                    let data = {
                        user_id: parseInt(this.user.user_id),
                        product_id: parseInt(product),
                        item_qty: 1,
                        item_notes: '',
                    };
                    await axios.post("/cartItem/", data)
                    let data1 = {
                        product_buy: 1,
                    }
                    try {
                        await axios.put(`/productsbuy/${product}`, data1)
                    } catch (error) {
                        console.error('Error in put product buy ',error);
                    }
                    this.$refs.alert.showAlert('success', 'Cám Ơn!', 'Đã thêm '+name+' vào Giỏ!')
                }
            } else  this.$refs.alert.showAlert('error', 'Xin Lỗi!', 'Bạn chưa đăng nhập!');
            this.showQuickView=false;
        },
        
        
    },

    components: {
      VueBasicAlert
    }
};
</script>

<style scoped>

.home-container {
    background-color: none;
    width: 100%;
    position: fixed; 
    top: 77px;
}

h1 {
    padding-top: 100px;
    color: #ff69b4;
    font-weight: bold;
    font-size: 50px;
    text-shadow: 2px 2px 4px rgba(255, 255, 255, 0.7); /* Tạo hiệu ứng chữ nổi */
    
}

h3 {
    color: #ff69b4;
    font-weight: bold;
    font-size: 30px;
    text-shadow: 2px 2px 4px rgba(255, 255, 255, 0.7); /* Tạo hiệu ứng chữ nổi */
}


h5 {
    padding-top: 40px;
    color: black;
    font-weight: bold;
}

.fa1 {
    background-color: #ff99a8;
    text-align: center;
    padding: 5px;
    border-radius: 25px;
    padding: 10px;
    font-size: 50px;
    color: #e6e6e6;
    opacity: 0.4;
}

.col-4 img {
  max-width: 100%;
  max-height: 100%;
}

rounded-circle text-center p-2 {
    background-color: #ff99a8;
    padding: 5px;
}

.fa2 {
    background-color: #ff99a8;
    text-align: center;
    padding: 5px;
    border-radius: 25px;
    padding: 10px;
    font-size: 20px;
    width: 40px;
    height: 40px;
    color: #e6e6e6;
    opacity: 0.4;
}


.card{
        box-shadow: 0 1px 1px #d9d9d9;
        border-radius: 25px;
        background-color: #f2f2f2; 
        opacity: 0.9;
        
        transition: transform 0.2s ease;

        .card__title{
            display: flex;
            align-items: center;
            padding: 30px 30px;
            
            h4{
            flex: 0 1 200px;
            text-align: right;
            margin: 0;
            color: black;
            font-family: sans-serif;
            font-weight: 600;
            text-transform: uppercase;
            }
            
            .icon{
            flex: 1 0 10px;
            padding: 10px 10px;
            transition: 200ms;
            }
        }
        
        .card__body{
            padding: 0 20px;
            display: flex;
            flex-flow: row no-wrap;
            margin-bottom: 25px;
        }
        
        .card__footer{
            padding: 30px 40px;
            display: flex;
            flex-flow: row no-wrap;
            align-items: center;
            position: relative;
            
            &::before{
            content: "";
            position: absolute;
            display: block;
            top: 0;
            left: 40px;
            width: calc(100% - 40px);
            height: 3px;
            background: #115dd8;
            background: linear-gradient(to right, #FF0099 0%,#FF0099 20%,#ffb3cc 20%,#ffb3cc 100%);
            }
            
            .recommend{
                flex: 1 0 10px;
                
                p{
                    margin: 0;
                    font-family: "Montserrat", sans-serif;
                    text-transform: uppercase;
                    font-weight: 600;
                    font-size: 14px;
                    color: black;
                }
                
                h4{
                    margin: 0;
                    font-size: 20px;
                    font-family: "Montserrat", sans-serif;
                    font-weight: 600;
                    text-transform: uppercase;
                    color: #FF0099;
                }
            
            }
        }
    }

    .card:hover {
      transform: scale(1.01); /* Hoặc bất kỳ giá trị zoom nào bạn muốn */
      background-color: #d9d9d9;
    }

</style>

