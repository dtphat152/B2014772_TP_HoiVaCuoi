<template>
   <div class="header row py-3 d-flex justify-content-between" style="padding-bottom: 10px !important; padding-top: 0px !important;">
    <div class="col-md-4 mt-2">
        <router-link @click="scrollToTop()" to="/">
            <div class="row">
                <div class="col-6 text-right pr-1">
                    <h1 class="pt-2 pl-2" style="color: #d35ea4; font-weight: 900;">TP</h1>
                </div>
                <div class="col-6 text-left pt-4 pl-0">
                    <h5 class=" pt-2 pl-2" style="color: #d35ea4; font-weight: 900;">Hỏi và Cưới</h5>
                </div>
            </div>
        </router-link>
    </div>
    <div class="col-md-4 text-center pt-4">
        <nav class="navbar row pt-2">
            <div class="col-lg-3 col-md-6 col-6">
                <router-link @click="scrollToTop()" to="/">
                    <h2 class="" style="color: #ff69b4; font-weight: 900;">Trang Chủ</h2>
                </router-link>
            </div>
            <div class="col-lg-3 col-md-6 col-6">
                <router-link @click="scrollToTop()" to="/booking">
                    <h2 class="" style="color: #ff69b4; font-weight: 900;">Đặt Hàng</h2>
                </router-link>
            </div>
            <div class="col-lg-3 col-md-6 col-6">
                <router-link @click="scrollToTop()" to="/connect">
                    <h2 class="" style="color: #ff69b4; font-weight: 900;" >Kết Nối</h2>
                </router-link>
            </div>
            <div class="col-lg-3 col-md-6 col-6">
                <router-link @click="scrollToTop()" to="/about">
                    <h2 class="" style="color: #ff69b4; font-weight: 900;">Chúng Tôi</h2>
                </router-link>
            </div>
        </nav>
    </div>
    <div class="col-md-4 pt-3">
        <div class="row">
            <div v-if="user" class="col-5 pr-0 text-right">
                <router-link @click="scrollToTop()" to="profile">
                    <img :src="this.user.user_avt" :style="{ width: '44px', 'border-radius': '30px', border: '5px solid #d35ea4'}"/> 
                </router-link>
            </div>
            <div v-else class="col-5"></div>
            <div class="col-1 text-right pl-3">
                <router-link @click="scrollToTop()" to="cart">
                    <div style="position: relative;">
                        <button class="btn" style="background-color: #d35ea4; border-radius: 20px;">
                            <i class="fas fa-shopping-bag fa-3x" style="color: #FFF0F5;"></i>
                        </button>
                        <span v-if="user" class="badge badge-pill" 
                            style="position: absolute; top:23px; right: -28px; padding: 5px 10px 0px 10px !important; background-color: white; color: red;">
                           <h5 style="font-weight: 900;"> {{ this.cartItem.length.toString() }} </h5> 
                        </span>
                        <span v-if="!user" class="badge badge-pill" 
                            style="position: absolute; top:23px; right: -28px; padding: 5px 10px 0px 10px !important; background-color: white; color: red;">
                           <h5 style="font-weight: 900;"> {{ 0 }} </h5> 
                        </span>
                    </div>
                </router-link>
            </div>
            <div v-if="!user" class="col-6 text-left pt-2">
                <router-link @click="scrollToTop()" to="login">
                    <button class=" btn p-2" style="background-color: #d35ea4; color: white; border-radius: 10px; font-weight: 800; font-size: 12px;">Đăng Nhập</button>
                </router-link>
                <router-link @click="scrollToTop()" to="/register">
                    <button class=" btn  p-2 ml-2" style="background-color: #d35ea4; color: white; border-radius: 10px; font-weight: 800; font-size: 12px;">Đăng Ký</button>
                </router-link>
            </div>
            <div v-else class="col-6 text-left pt-2">
                <router-link @click="scrollToTop()" to="/myorder">
                    <button class=" btn p-2" style="background-color: #d35ea4; color: white; border-radius: 10px; font-weight: 800; font-size: 12px;">Đơn Hàng</button>
                </router-link>
                <router-link @click="handleLogout" to="/">
                    <button class=" btn p-2 ml-2" style="background-color: #d35ea4; color: white; border-radius: 10px; font-weight: 800; font-size: 12px;">Đăng Xuất</button>
                </router-link>
            </div>
        </div>
    </div>
    
</div>

    
</template>

<script>
import axios from "axios";
import { mapState, mapMutations } from "vuex";

export default {
    name: 'NavBar',

    data() {
        return {
            cartItem: [],
        };
    },

    created() {
        this.getAllCartItem(); // Lấy cartItem lần đầu tiên
        setInterval(() => {
            this.getAllCartItem(); // Lấy cartItem mỗi giây
        }, 1000);
    },


    computed: {
        ...mapState(["user","allProducts"]),
        filterProducts: function () {
            return this.allProducts.filter(
                (f) => this.matchID(f, this.cartItem)
            );
        },
    },

    methods: {
        ...mapMutations(["setUser"]),
        matchID: function (product, cartArray) {
            let temp = "";
            cartArray.forEach(element => {
                if (parseInt(product.product_id) == element) {
                    temp = product;
                }
            });
            return temp;
        },

        async getAllCartItem() {
            if (this.user) {
                let existItem = await axios.get('/cartItem/' + this.user.user_id);
                this.cartItem = existItem.data.map(element => element.product_id);
            }
        },

        scrollToTop() {
            window.scrollTo(0, 0);
        },

        handleLogout: function () {
            this.setUser("");
        }
    },

    watch: {
        // Watcher cho biến user
        user: function(newVal, oldVal) {
            // Kiểm tra sự thay đổi và gọi lại phương thức để cập nhật cartItem
            if (newVal !== oldVal) {
                this.getAllCartItem();
            }
        }
    }
}
</script>

<style scoped>
.header {
    position: sticky;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;
    background: white;

}

.router-link-exact-active h2 {
    transform: scale(1.3);
}

</style>