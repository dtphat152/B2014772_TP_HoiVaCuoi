<template>
    <div class=" py-3">
        <div class="">
            <div class=" row d-flex justify-content-between">
                <div class="col-2"> <slot></slot> </div>
                <div class="col-6 input-group mb-3">
                    <input style="border-radius: 10px; background-color: #ffe6ea;" type="text" class="form-control" v-model="productObj.name" placeholder="Search . . .">
                    <div class="input-group-append">
                        <button class="btn ml-3" type="submit" style="background-color: #FFF0F5; border-radius: 15px;"><i class="fa fa-search"></i></button>
                    </div>
                </div>
                <div class="col-2 text-right"></div>
            </div>
            
            <div class="" style="overflow-y: auto; height: 543px;">
                <div style="width: 95%;">
                    <div  v-for="(f, index) in filterProducts" :key="index">
                        <div class="row" style="background-color: #fff; margin-left: 10px; border-radius: 10px;">
                            <div class="col-2 image pl-0 mr-4">
                                <img :src="f.product_src" alt="" 
                                style="height: 100px; width: 150px; border-radius: 10px;"/>
                            </div>
                            <div class="col-5 pl-5" style="padding-top: 20px;">
                                <h5>{{ f.product_category }}</h5>
                                <div class="">
                                    <h3>{{ f.product_name }} </h3>
                                </div>
                                <div class="">
                                    <h5>{{ formatCurrency(f.product_price) }}</h5>
                                </div>
                            </div>
                            <div class="col-md-2 col-lg-2 col-xl-2 d-flex justify-content-center mt-5">
                                <input type="number" id="iQuantity" class="form-control item-quantity"
                                    v-model="itemQuantity[index]" min="1" max="1000"
                                    @change="onQtyChange($event, index)"
                                    style="border: none; text-align: center; background: #ffb3cc; border-radius: 10px; color: black; font-weight: 900;"
                                >
                            </div>
                            <div class="col-2 d-flex justify-content-center mt-5 ">
                                <button
                                class="btn p-2 " style="height: fit-content; border-radius: 10px; background-color: #40bf77;" 
                                @click="addToBill(index,f.product_name)">Add to Bill</button>
                            </div>
                        </div>
                        <hr>
                    </div>    
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
export default {
    props: ['ID'],
    name: "ProductOrder",

    data() {
        return {
            productObj: { name: ""},
            itemQuantity: [],
        }
    },

    created() {
     
    },

    computed: {
        ...mapState(["allProducts", "user"]),

        filterProducts: function () {
            return this.allProducts.filter((f) => 
                f.product_name.toLowerCase().includes(this.productObj.name.toLowerCase()) ||
                f.product_category.toLowerCase().includes(this.productObj.name.toLowerCase())
            );
        },
        
    },


    methods: {
        formatCurrency(amount) {
          if (!amount) return '';
          return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
        },

        onQtyChange(e, i) {
            if (e.target.value < 1) {
                e.target.value = 1
                this.itemQuantity[i] = 1
            } else {
                this.itemQuantity[i] = e.target.value;
            }
        },


        async addToBill(i,name){
            
            if (this.itemQuantity[i]) {
                let confirmResult = window.confirm("Bạn muốn thêm " + this.filterProducts[i].product_name + " với số lượng " + this.itemQuantity[i] + "? Yêu cầu sẽ được gửi đến cửa hàng!");
                if (confirmResult) {                
                    let data1 = {
                        email: '',
                        title:`Đơn hàng #${this.ID} được yêu cầu cập nhật!`,
                        content: `Nội dung: Thêm mới ${name} với số lượng ${this.itemQuantity[i]}.`,
                        auth: `Khách hàng `+this.user.user_name+`.`,
                    }
                    try {
                        axios.post(`/sendemail/request`,data1);
                    } catch (error) {
                        console.error("Error Send email update:", error);
                    }     
                }
            } 
            
        },


    }
}
</script>
