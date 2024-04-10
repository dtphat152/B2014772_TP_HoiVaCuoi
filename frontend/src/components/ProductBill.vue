<template>
    <div style="overflow-y: auto; height: 600px;">
        <div style="width: 95%;">
            <template v-for="(category, catIndex) in ['Khai Vị', 'Món Chính', 'Tráng Miệng']" :key="catIndex">
                <h3 class="mb-2 mb-2 font-weight-bold" style="color: #d35ea4;">{{ category }}</h3> 
                <div v-for="(f, index) in filterProducts" :key="index">
                    <div v-if="f.product_category === category" 
                    class="row mb-1 d-flex justify-content-between align-items-center" style="background-color: #990099; margin-left: 10px; border-radius: 10px;">
                        
                        <div class="col-md-2 col-lg-2 col-xl-2" style="padding-left: 0px;">
                            <img :src="require(`../assets/images/${f.product_src}`)" alt="" class="cart-product-img" 
                            style="width: 100px; border-radius: 10px; ">
                        </div>
                        <div class="col-md-3 col-lg-3 col-xl-4">
                            <h4 class="font-weight-bold mb-0" style="color: white;">{{ f.product_name }}</h4>
                            <h6 class="mb-0" style="color: white;">Đơn giá: {{ formatCurrency(f.product_price) }}</h6>
                        </div>
                        <div class="col-md-3 col-lg-2 col-xl-2">
                            <input type="number" id="number" v-model="item_qty[index]" @change="onQtyChange(index,f.product_name)"
                            class="form-control " min="0" max="1000" 
                            style="border: none; text-align: center; background:rgba(0, 0, 0, 0.3); border-radius: 10px; color: white;">
                        </div>
                        <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                            <button class="btn font-weight-bold" @click="removeBtn(f.product_name)" 
                             style="background-color: rgba(0, 0, 0, 0.3); color: aliceblue; border-radius: 10px;">
                                <i class="fa fa-trash"></i>
                            </button>
                        </div>
                        <hr class="my-4">
                    </div>
                    
                    <div v-if="f.product_category === category" class="row mb-5" style="background-color: #990099; margin-left: 10px; border-radius: 10px;">
                        <div class="form-group col-10">
                            <input type="text" placeholder="Ghi chú..." class="form-control" 
                            style="color: white; border: none; font-weight: bold; background-color: #990099;" v-model="itemNotes[index]">
                        </div>
                        <div class="col-2 text-right">
                        </div>
                        <br>
                    </div>
                </div>
                
                <hr class="my-4">
            
            </template> 

        </div>
    </div>
                            
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
export default {
    props: ['Bill'],
    name: "ProductBill",

    data() {
        return {
            allProductsInBill: [],
            item_qty: [],
            itemNotes: [],
            tablePrice:'',
        }
    },

    created(){
    
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

    watch: {
    filterProducts: {
        handler(newVal, oldVal) {
            // Kiểm tra xem newVal có khác oldVal (tức là filterProducts đã được cập nhật)
            if (newVal !== oldVal) {
                this.PriceOfTable();
            }
        },
        deep: true // Theo dõi sâu để nhận biết sự thay đổi của filterProducts
    }
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
                });
            }
        },

        async onQtyChange(i,name) {
            let data = {
                item_qty: this.item_qty[i],
            };
            let confirmResult = window.confirm("Thay đổi số lượng "+name+" thành " + this.item_qty[i] + "? Yêu cầu sẽ được gửi cho cửa hàng!" );
                if (confirmResult) {
                    let data1 = {
                        email: '',
                        title:`Đơn hàng #${this.Bill} được yêu cầu cập nhật!`,
                        content: `Nội dung: Thay đổi số lượng ${name} thành ${data.item_qty}.`,
                        auth: `Khách hàng `+ this.user.user_name +`.`,
                    }
                    try {
                        axios.post(`/sendemail/request`,data1);
                    } catch (error) {
                        console.error("Error Send email request:", error);
                    }            
                } 
        },

        async removeBtn(name) {
            let confirmResult = window.confirm("Xóa "+name+" ra khỏi đơn? Yêu cầu sẽ được gửi cho cửa hàng!" );
            if (confirmResult) {
                let data1 = {
                    email: '',
                    title:`Đơn hàng #${this.Bill} của bạn đã được cập nhật!`,
                    content: `Nội dung: Xóa ${name} ra khỏi đơn hàng.`,
                    auth: `Khách hàng `+ this.user.user_name +`.`,
                }
                try {
                    axios.post(`/sendemail/request`,data1);
                } catch (error) {
                    console.error("Error Send email request:", error);
                } 
            }
        },

        PriceOfTable: function () {
            let subtotal = 0;
            let i = 0;
            while (i < this.item_qty.length) { // Sửa lại thành this.item_qty
                if (this.filterProducts[i].product_category=="Khai Vị" || this.filterProducts[i].product_category=="Món Chính" || this.filterProducts[i].product_category=="Tráng Miệng") {
                    subtotal = subtotal + parseInt(this.filterProducts[i].product_price);
                }
                i = i + 1;
            }
            this.tablePrice = subtotal; 
            this.sendPriceToParent(); 
        },


        sendPriceToParent() {
            this.$emit('send-price', this.tablePrice); 
        },

    }
}
</script>
