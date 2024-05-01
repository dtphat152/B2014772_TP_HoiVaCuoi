<template>
    <div class="">
        <div class="">
            <div class=" row d-flex justify-content-between">
                <div class="col-2"> <slot></slot> </div>
                <div class="col-6 input-group mb-3">
                    <input style="border-radius: 10px; background-color: #ffe6ea;" type="text" class="form-control" v-model="productObj.name" placeholder="Search . . .">
                    <div class="input-group-append">
                        <button class="btn ml-3" type="submit" style="background-color: #FFF0F5; border-radius: 15px;"><i class="fa fa-search"></i></button>
                    </div>
                </div>
                <div class="col-2 text-right" v-if="$route.path === '/admin/order'">
                    <router-link to='AddTempProduct'>
                        <button  class="btn" 
                            style="background-color: #ffe6ea; border-radius: 10px; color: #40bf77;">
                           <i class="fa fa-plus-circle" style="color: #40bf77;"></i> Thêm Mới 
                        </button>
                    </router-link>
                </div>
                
                <div class="col-2 text-right" v-else>
                    <router-link :to="{ path: '/admin/AddTempProduct' }">
                        <button  class="btn" 
                            style="background-color: #ffe6ea; border-radius: 10px; color: #40bf77;">
                           <i class="fa fa-plus-circle" style="color: #40bf77;"></i> Thêm Mới
                        </button>
                    </router-link>
                </div>
                
            </div>
            
            <div class="" style="overflow-y: auto; height: 570px;">
                <div style="width: 95%;">
                    <div  v-for="(f, index) in filterProducts" :key="index">
                        <div class="row" style="background-color: #f08faf; margin-left: 10px; border-radius: 10px;">
                            <div class="col-2 image pl-0 mr-4">
                                <img :src="require(`../../assets/images/${f.product_src}`)" alt="" 
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
                                    style="border: none; text-align: center; background: #d3d3d3; border-radius: 10px; color: black; font-weight: 900;"
                                >
                            </div>
                            <div class="col-2 d-flex justify-content-center mt-5 ">
                                <button v-if="$route.path === '/admin/order'" 
                                class="btn p-2 " style="height: fit-content; border-radius: 10px; background-color: #40bf77;" 
                                @click="addToBill(index,f.product_name)">Add to Bill</button>
                                <button v-else
                                class="btn p-2 " style="height: fit-content; border-radius: 10px; background-color: #660066; color: white;" 
                                @click="addToCombo(index)">Add to Combo</button>
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
        ...mapState(["allProducts"]),

        filterProducts: function () {
            return this.allProducts.filter((f) => f.product_name.toLowerCase().match(this.productObj.name.toLowerCase()))
        },

        currentRoute() {
            return this.$route.path;
        }
        
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
            console.log(this.ID[0])
            let rsp = await axios.get(`/billdetails/${this.ID[0]}`);
            const productIds = rsp.data.map(item => item.product_id);
            console.log(productIds)
            if (productIds.includes(parseInt(this.filterProducts[i].product_id))) window.confirm('Sản Phẩm đã có trong đơn trước đó!')
            else {
                if (this.itemQuantity[i]) {
                    let confirmResult = window.confirm("Bạn muốn thêm " + this.filterProducts[i].product_name + " với số lượng " + this.itemQuantity[i] + "?");
                    if (confirmResult) {
                        let billDetails = {
                            bill_id: parseInt(this.ID[0]),
                            product_id: parseInt(this.filterProducts[i].product_id),
                            item_qty: parseInt(this.itemQuantity[i])
                        };
                        try {
                            await axios.post("/billdetails", billDetails);
                            console.log("Successfully added to bill:", billDetails);
                            // Kích hoạt sự kiện và truyền thông tin sản phẩm đã thêm
                            this.$emit('productAdded');
                            let billdata = { 
                                bill_total: this.ID[2] + parseInt(this.filterProducts[i].product_price*this.itemQuantity[i]),
                            };
                            await axios.put(`/billstatus/billtotal/${this.ID[0]}`, billdata);
                            let data1 = {
                                email: this.ID[1],
                                title:`Đơn hàng #${this.ID[0]} của bạn đã được cập nhật!`,
                                content: `Nội dung: Thêm mới ${name} vào đơn hàng của bạn với số lượng ${billDetails.item_qty}.`,
                            }
                            try {
                                console.log(data1)
                                // axios.post(`/sendemail/update`,data1);
                            } catch (error) {
                                console.error("Error Send email update:", error);
                            }     

                        } catch (error) {
                            console.error("Error updating bill total:", error);
                        }  
                    }
                } else {
                    window.confirm("Hãy chọn số lượng");
                }
            }
        },

        async addToCombo(i){
                let confirmResult = window.confirm("Bạn muốn thêm " + this.filterProducts[i].product_name +" vào Combo?");
                if (confirmResult) {
                    let ComboDetails = {
                        combo_id: parseInt(this.ID[0]),
                        product_id: parseInt(this.filterProducts[i].product_id),
                    };
                    try {
                        await axios.post("/combodetails", ComboDetails);
                        console.log("Successfully added to combo:", ComboDetails);
                        // Kích hoạt sự kiện và truyền thông tin sản phẩm đã thêm
                        this.$emit('productAdded');
                    } catch (error) {
                        console.error("Error updating combo total:", error);
                    }
                }
        },


    }
}
</script>
