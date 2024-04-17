<template>
    <div id="app">
        <div v-if="admin">
            <Sidebar />
            <router-view></router-view>
        </div>
        <div v-else>
            <NavBar />

            <div class="auth-wrapper">
                <div class="auth-inner">
                    <router-view></router-view>
                </div>
            </div>
            <FooterComponent v-if=" $route.path !== '/' " />
        </div>
    </div>
</template>

<script>
import Sidebar from './admin/component/Sidebar.vue';
import NavBar from './components/NavBar.vue';
import FooterComponent from './components/FooterComponent.vue';
import { mapActions } from 'vuex';
import { mapState } from 'vuex';
export default {
    name: 'App',
    components: {
        Sidebar,
        NavBar,
        FooterComponent
    },

    created() {
        this.getProductsData()
    },

    computed: {
        ...mapState(["admin"])
    },

    methods: {
        ...mapActions(["getProductsData"])
    }
}
</script>

<style>
@import "./assets/css/global_style.css";
</style>

