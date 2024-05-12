import {createStore} from "vuex"
import axios from "axios"

const store = createStore({
    state() {
        return {
            allProducts: [],
            user: undefined,
            admin: undefined,
            voucher_value: null
        }
    },
    mutations: {
        setProductsData(state, payload){
            state.allProducts = payload;
        },
        setUser(state, payload){
            state.user = payload;
        },
        setAdmin(state, payload){
            state.admin = payload;
        },
        setVoucherValue(state, value) {
          state.voucher_value = value;
        }
    },
    actions: {
      autoUpdateProductsData({ dispatch }) {
        setInterval(() => {
            dispatch('getProductsData'); // Gọi action để lấy dữ liệu từ server
          }, 1000); // Gọi lại action mỗi 1000ms (1 giây)
      },

      async getProductsData(context){
        await axios.get('/products')
          .then(function (response) {
            context.commit("setProductsData", response.data);
          })
          .catch(function (error) {
            console.log(error);
          });
      },
    }
})

export default store;