<template>
    <vue-basic-alert :duration="300" :closeIn="4000" ref="alert" />
   
    <transition
        enter-active-class=" animate__bounceInLeft"
        leave-active-class=" animate__bounceOutLeft"
    >
        <div v-if="this.page==1" class="home-container" style="background-color: none !important;">
            <div class="row" style="padding-top: 50px;">
                <div class="col-2">
                </div>
                <div class="col-4">
                    <h1>TP Hỏi và Cưới</h1>
                    <hr class="my-4" style="background-color: #ff69b4;">
                    <h5 style="font-weight: 900; color: #808080;">Chúng tôi hiểu rằng mỗi cặp đôi mang trong mình những mong muốn và mong đợi riêng biệt về ngày cưới của mình. Đó là lý do tại sao chúng tôi cam kết cung cấp dịch vụ tùy chỉnh và chuyên nghiệp, đảm bảo rằng mỗi chi tiết trong ngày cưới của bạn được tổ chức một cách hoàn hảo và đặc biệt. </h5>
                    <div class="row" style="padding-top: 50px !important;">
                        <div class="col-2 text-center">
                            <router-link @click="scrollToTop()" to="/booking">
                                <i class="fa fa1 fa-sticky-note" aria-hidden="true" style="color: white;"></i>
                                <h6 class="text-center p-2" style="color: #808080; font-weight: 900;">Đặt Hàng</h6>
                            </router-link>
                        </div>
                        <div class="col-2 text-center">
                            <router-link @click="scrollToTop()" to="/contact">
                                <i class="fa fa1 fa-phone-square" aria-hidden="true" style="color: white;"></i>
                                <h6 class="text-center p-2" style="color: #808080; font-weight: 900;">Liên Hệ</h6>
                            </router-link>
                        </div>
                        <div class="col-2 text-center">
                            <router-link @click="scrollToTop()" to="/about">
                                <i class="fa fa1 fa-university" aria-hidden="true" style="color: white;"></i>
                                <h6 class="text-center p-2" style="color: #808080; font-weight: 900;">Chúng Tôi</h6>
                            </router-link>
                        </div>
                        <div class="col-2 text-center">
                                <i class="fa1 fa-regular fa-message" style="color: white;" @click="chatBox()"></i>
                                <h6 class="text-center p-2" style="color: #808080; font-weight: 900;">Giải Đáp</h6>
                        </div>
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
                    <button @click="inc()" style="background: none; border: none;" class="zoom-light">
                        <span class="carousel-control-next-icon" style="background-color: #ff99a8;padding: 30px; border-radius: 20px; opacity: 0.6;"></span>
                    </button>
                </div>
            </div>
        </div>
    </transition>

    <transition
        enter-active-class=" animate__bounceInRight"
        leave-active-class="  animate__bounceOutRight"
    >
        <div v-if="this.page==2" class="home-container" style="background-color: none !important;">
            <h1 class="text-center">Home 2</h1>
            <div class="row">
                <div class="col-8"></div>
                <div class="col-4">
                    
                </div>
            </div>
            
        </div>
    </transition>

    <footer v-if="fasle">

    </footer>
    
</template>

<script>
import VueBasicAlert from 'vue-basic-alert';
// import axios from "axios";
import { mapState } from "vuex";

export default {
    name: "Home",

    data() {
        return {
            page: 1,
            images: ['wedding_circle1', 'wedding_circle2', 'wedding_circle3'],
            currentImageIndex: 0,
        };
    },

    computed: {
        ...mapState(["user"]),

        currentImage() {
            return this.images[this.currentImageIndex];
        }
    },

    mounted() {
        // Bắt sự kiện lăn chuột xuống
        window.addEventListener('wheel', this.handleScroll);

        setInterval(() => {
            this.currentImageIndex = (this.currentImageIndex + 1) % this.images.length;
        }, 5000);

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

        // Gỡ bỏ bắt sự kiện khi component bị hủy
        window.removeEventListener('wheel', this.handleScroll);
    },


    beforeUnmount() {
        // Gỡ bỏ bắt sự kiện khi component bị hủy
        window.removeEventListener('wheel', this.handleScroll);
    },

    methods: {
        scrollToTop() {
            window.scrollTo(0, 0);
        },

        handleScroll(event) {
        // Kiểm tra nếu người dùng đang lăn chuột xuống
        if (event.deltaY > 0) {
            this.inc();
        }
        if (event.deltaY < 0) {
            this.pre();
        }
        },
        inc() {
        // Mở div bằng cách đặt showDiv thành true
        if (this.page<2) this.page += 1;
        
        },
        pre() {
        // Mở div bằng cách đặt showDiv thành true
            if (this.page>1) this.page -= 1;
        }
        
        
    },

    components: {
      VueBasicAlert
    }
};
</script>

<style scoped>

.home-container {
    background-color: none;
    height: 92vh;
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

.chatbox {
    width: 100%; /* Đặt chiều rộng là 100% của phần tử mẹ */
    height: 536px; /* Đặt chiều cao là 500px */
    border: 10px solid #f1b3bc; /* Đặt đường viền 1px, màu xám */
    border-radius: 20px; /* Đặt góc cong 10px */
    opacity: 0.8;
}

</style>

