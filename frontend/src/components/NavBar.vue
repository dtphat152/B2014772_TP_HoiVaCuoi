<template>
    <div class="header row py-3 d-flex justify-content-between">
        <div class="col-md-4">
                <router-link @click="scrollToTop()" to="/">
                    <div class="row">
                        <div class="col-6 text-right pr-1">
                            <h1 class="font-weight-bold pt-2 pl-2" style="color: #FF0099;">TP</h1>
                        </div>
                        <div class="col-6 text-left pt-3 pl-0">
                            <h5 class="font-weight-bold pt-2 pl-2" style="color: #FF0099;">Hỏi và Cưới</h5>
                        </div>
                    </div>
                </router-link>
        </div>
        <div class="col-md-4 text-center pt-4">
            <nav class="navbar row pt-2" >
                <div class="col-3" ><router-link @click="scrollToTop()" to="/">
                    <h4 class="font-weight-bold" style="color: #FF66CC;">Home</h4></router-link>
                </div>
                <div class="col-3"><router-link @click="scrollToTop()" to="/product">
                    <h4 class="font-weight-bold" style="color: #FF66CC;">Booking</h4></router-link>
                </div>
                <div class="col-3"><router-link @click="scrollToTop()" to="/contact">
                    <h4 cclass="font-weight-bold" style="color: #FF66CC;">Contact</h4></router-link>
                </div>
                <div class="col-3"><router-link @click="scrollToTop()" to="/about">
                    <h4 class="font-weight-bold" style="color: #FF66CC;">About</h4></router-link>
                </div>
            </nav>  
        </div>
        <div class="col-md-4 text-center">

            <div class="row">
                <div class="col-6 text-right pt-1">
                    <router-link @click="scrollToTop()" to="cart">
                        <div class="fas fa-shopping-cart fa-3x" style="color: #FF0099;"></div>
                    </router-link>
                </div>
                <div v-if="!user" class="col-6 text-left pt-2">
                    <router-link @click="scrollToTop()" to="/login">
                        <button class=" rounded-lg font-weight-bold p-2" style="background-color: #FF66CC;">Login</button>
                    </router-link>
                    <router-link @click="scrollToTop()" to="/register">
                        <button class=" rounded-lg font-weight-bold p-2 ml-1" style="background-color: #FF66CC;">Register</button>
                    </router-link>
                </div>

                <div v-else class="col-6 text-left pt-2">
                    <router-link @click="scrollToTop()" to="/myorder">
                        <button class=" rounded-lg font-weight-bold p-2" style="background-color: #FF66CC;">My Orders</button>
                    </router-link>
                    <router-link @click="handleLogout" to="/">
                        <button class=" rounded-lg font-weight-bold p-2 ml-1" style="background-color: #FF66CC;">Logout</button>
                    </router-link>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { mapState, mapMutations } from "vuex";
export default {
    name: 'NavBar',

    computed: {
        ...mapState(["user"])
    },

    methods: {
        ...mapMutations(["setUser"]),

        scrollToTop() {
            window.scrollTo(0, 0);
        },

        handleLogout: function () {
            this.setUser("");
        }

    }
}
</script>

<style>
.header {
    position: sticky;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;
    background: #fff;
    /* box-shadow: 0 1rem 1rem rgba(0, 0, 0, 0.05);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 2rem 9%; */
}

.router-link-exact-active h4 {
    text-decoration: underline; /* Gạch chân */
    text-decoration-thickness: 2px; /* Độ dày của gạch chân */
    text-underline-offset: 2px; /* Khoảng cách giữa văn bản và gạch chân */
    text-decoration-color: #FF66CC; /* Màu sắc của gạch chân */
}

</style>