import { createApp } from 'vue';

import 'bootstrap/dist/css/bootstrap.min.css';
import '@fortawesome/fontawesome-free/css/all.min.css';
import 'bootstrap-vue/dist/bootstrap-vue.css';
import App from './App.vue';
import router from './router';
import store from './store';
import '@/axios';

createApp(App).use(router).use(store).mount('#app');
