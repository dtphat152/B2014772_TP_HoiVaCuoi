<template>
    <div class="shopping-cart-section">

        <div class="heading">
            <!-- <h3>Shopping cart</h3> -->
        </div>
        <section class="h-100 h-custom" style="background-color:none">
            <div class="container h-100" style="width: 1200px;">
                <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12">
                    <div class="card card-registration card-registration-2" 
                        style="background-color: #990099; opacity: 0.8;border-radius: 15px;">
                    <div class="card-body p-0">
                        <div class="row g-0">

                        <div class="col-lg-8">
                            <div class="p-5">
                            <div class="d-flex justify-content-between align-items-center mb-5">
                                <h1 class="fw-bold mb-0" style="color: #FF66CC; ">Dánh sách Dịch Vụ</h1>
                            </div>
                            <hr class="my-4">

                            <div class="" style="overflow-y: auto; height: 550px;">
                                <div style="width: 95%;">
                                <template v-for="(category, catIndex) in ['Khai Vị', 'Món Chính', 'Tráng Miệng']" :key="catIndex">
                                    <h3 class="mb-2 mb-2" style="color: white;">{{ category }}</h3>
                                    <div v-for="(f, index) in filterProducts" :key="index">
                                        <div v-if="f.product_category === category" class="row mb-1 d-flex justify-content-between align-items-center"
                                        style="background-color: #b300b3; border-radius: 15px;margin-left: 10px;">
                                            <!-- Content for each product -->
                                            <div class="col-md-2 col-lg-2 col-xl-2" style="padding-left: 0px;">
                                                <img :src="require(`../assets/images/${f.product_src}`)" alt="" class="cart-product-img" 
                                                style="width: 100px; border-radius: 10px;">
                                            </div>
                                            <div class="col-md-3 col-lg-3 col-xl-4">
                                                <h6 class="text-black mb-0">{{ f.product_name }}</h6>
                                                <h6>{{ formatCurrency(f.product_price) }}</h6>
                                            </div>
                                            <div class="col-md-3 col-lg-2 col-xl-2">
                                                <input type="number" id="number" v-model="itemQuantity[index]" @change="onQtyChange(index)"
                                                    class="form-control " min="0" max="1000" 
                                                    style="border: none; text-align: center; background: rgba(0, 0, 0, 0.3); color: white; border-radius: 10px;">
                                            </div>
                                            <div class="col-md-3 col-lg-2 col-xl-2">
                                                <h6 class="mb-0">{{ formatCurrency(calculateItemPrice(index)) }}</h6>
                                            </div>
                                            <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                                <button class="btn" @click="removeBtn(index)" 
                                                style="background: rgba(0, 0, 0, 0.3); color: white; border-radius: 10px;">
                                                    <i class="fa fa-trash"></i>
                                                </button>
                                            </div>
                                            
                                        </div>
                                        <!-- Form group for each product -->
                                        <div v-if="f.product_category === category" class="row mb-5" 
                                            style="background-color: #b300b3; margin-left: 10px; border-radius: 10px;">
                                            <div class="form-group col-10">
                                                <input type="text" placeholder="Ghi chú..." class="form-control" 
                                                    style="border: none; font-weight: bold; background-color: #b300b3; color: white;" 
                                                    v-model="itemNotes[index]"
                                                >
                                            </div>
                                            <div class="col-2 text-right mt-2">
                                                <button @click="updateItemNotes(index)" style="background-color: #e600e6;border-radius: 5px; padding: 2px; margin: 2px;">Lưu</button>
                                                <button @click="deleteNotes(index)" style="background-color: #e600e6; border-radius: 5px; padding: 2px;  margin: 2px;">Xóa</button>
                                            </div>
                                            <br>
                                        </div>
                                    </div>
                                   
                                    <hr class="my-4">
                                </template>
                                </div>
                            </div>


                        <div class="pt-5">
                            <router-link to="/booking" class="text-black-50"><i class="fa fa-arrow-left"></i>Continue shopping
                            </router-link>
                        </div>
                    </div>
                </div>

                    <div class="col-lg-4 bg-grey">
                        <div class="p-5">
                        <h3 class="fw-bold mb-5 mt-2 pt-1" style="color: #FF66CC; ">Summary</h3>
                        <hr class="my-4">
                        <div class="d-flex justify-content-between mb-4"></div>

                        <div class="form-group">
                            <textarea name="txtMsg" class="form-control" placeholder="Những điều bạn yêu cầu hoặc lưu ý" 
                                style="width: 100%; height: 100px; border: none;  background: rgba(0, 0, 0, 0.3); color: white; border-radius: 10px;" 
                                v-model="checkoutObj.notes" >
                            </textarea>
                        </div>
                        <div class="form-group">
                            <input type="text" name="coPhone" id="coPhone" placeholder="Phone number" class="form-control"
                            style="width: 100%; border: none; background: rgba(0, 0, 0, 0.3); color: white; border-radius: 10px; font-weight: bold;" v-model="checkoutObj.phone" />
                        </div>
                        <div class="form-group">
                            <input type="text" name="coAddress" id="coAddress" placeholder="Address..."
                            style="width: 100%; border: none;  background: rgba(0, 0, 0, 0.3); color: white; border-radius: 10px; font-weight: bold;" class="form-control" v-model="checkoutObj.address" />
                        </div>
                       
                        <hr class="my-4">
                        <div class="d-flex justify-content-between mb-5">
                            <h5 class="text-uppercase">Số lượng Bàn tiệc</h5>
                            <h5>{{ tableNum }} </h5>
                        </div>
                        <div class="d-flex justify-content-between mb-5">
                            <h5 class="text-uppercase">Giá mỗi Bàn (mâm)</h5>
                            <h5>{{ formatCurrency(PriceOfTable())}} </h5>
                        </div>
                        <div class="d-flex justify-content-between mb-5">
                            <h5 class="text-uppercase">Tổng chi phí</h5>
                            <h5>{{ formatCurrency(calculateSummaryPrice()) }}</h5>
                        </div>

                        <button type="button" @click="checkOutBtn()" class="btn btn-block font-weight-bold"  
                            style="background-color: #FF66CC; color: white; border-radius: 15px;">Gửi Đơn Hàng</button>
                        </div>
                    </div>
                    </div>
                </div>
                </div>
            </div>
            </div>
        </div>
        </section>
    </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";

export default {
    name: "Cart",
    data() {
        return {
            cartItem: [],
            itemQuantity: [],
            itemNotes: [],
            checkoutObj: {notes:"", phone: "", address: ""},
            dateID: '',
            tableNum: 0,
            tien: 100000
        };
    },

    created() {
        this.getAllCartItem();
        this.loadInfo();
        this.getDate();
        this.getNum();
    },

    computed: {
        ...mapState(["allProducts", "user"]),

        filterProducts: function () {
            return this.allProducts.filter((f) => this.matchID(f, this.cartItem));
        },

    },
    methods: {
        formatCurrency(amount) {
            if (!amount) return '';
            return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
        },

        matchID: function (product, cartArray) {
            return cartArray.includes(product.product_id);
        },
        async getAllCartItem() {
            if (this.user) {
                let existItem = await axios.get('/cartItem/' + this.user.user_id);
                existItem.data.forEach(element => {
                    this.cartItem.push(element.product_id);
                    this.itemQuantity.push(element.item_qty);
                    this.itemNotes.push(element.item_notes);
                });
            }
        },

        async loadInfo() {
            try {           

            this.checkoutObj = {
                phone: this.user.user_phone,
                address: this.user.user_address,
            };
            } catch (error) {
            console.error('Error fetching product:', error);
            }
        },

        async getDate() {
            try {
                const response = await axios.get('/date/' + this.user.user_id);
                if (response.data.length > 0) {
                    this.dateID = response.data[0].date_id;
                    // console.log('Ngày bắt đầu được trả về từ API:', this.dateStart);
                } else {
                    // console.log('Không có dữ liệu ngày bắt đầu từ API. Trả về một ngày mặc định.');
                    this.dateID =  '';
                }
            } catch (error) {
                console.error('Đã xảy ra lỗi khi lấy dữ liệu dateID:', error);
                this.dateID =  '';
            }
        },


        calculateItemPrice: function (index) {
            let a = 0;
            
                a = parseInt(this.filterProducts[index].product_price) * this.itemQuantity[index];
            
            return a;
        },

         PriceOfTable: function () {
            let subtotal = 0;
            let i = 0;
             while (i < this.itemQuantity.length) {
                if (this.filterProducts[i].product_category=="Khai Vị" || this.filterProducts[i].product_category=="Món Chính" || this.filterProducts[i].product_category=="Tráng Miệng") {
                    subtotal = subtotal + parseInt(this.filterProducts[i].product_price);
                }
                i = i + 1;
            }
            return subtotal;
        },

        calculateSummaryPrice: function () {
            let subtotal = 0;
            let i = 0;
            while (i < this.itemQuantity.length) {
                subtotal = subtotal + this.calculateItemPrice(i)
                i = i + 1
            }
            return subtotal;
        },

        async getNum() {
            if (this.user) {
                try {
                    await this.getDate();
                    let response = await axios.get(`/datedetails/${this.dateID}`);
                    let existNum = response.data;
                    if (existNum && existNum.length > 0) {
                        for ( let num of existNum ) this.tableNum += num.dd_guest;
                        this.tableNum = this.tableNum / 10;
                        console.log('Table:', this.tableNum);
                        // Cập nhật itemQuantity của các cartItem có product_category = 'Khai Vị'
                        this.setQuantity();
                    } else {
                        this.tableNum = 0;
                        console.log('Không có dữ liệu Số lượng bàn.');
                    }
                } catch (error) {
                    console.error('Lỗi khi lấy Số lượng bàn:', error);
                }
            }
        },

        async setQuantity(){
            try {
                this.itemQuantity.forEach((qty, index) => {
                            if (this.filterProducts[index].product_category === 'Khai Vị' 
                             || this.filterProducts[index].product_category === 'Món Chính'
                             || this.filterProducts[index].product_category === 'Tráng Miệng') {
                                this.itemQuantity[index] = this.tableNum;
                            }
                            let data = {
                                user_id: parseInt(this.user.user_id),
                                product_id: parseInt(this.cartItem[index]),
                                item_qty: this.itemQuantity[index],
                                item_notes: this.itemNotes[index]
                            };
                            axios.put("/cartItem/", data)
                        });
            } catch (error) {
                console.error('Lỗi khi cài Số Lượng:', error);
            }
        },

        async onQtyChange(i) {
            let data = {
                user_id: parseInt(this.user.user_id),
                product_id: parseInt(this.cartItem[i]),
                item_qty: this.itemQuantity[i],
                item_notes: this.itemNotes[i]
            };
            let confirmResult = window.confirm("Bạn có chắc chắn muốn thay đổi số lượng sản phẩm thành " + this.itemQuantity[i] + "?" );
            if (confirmResult) {
                await axios.put("/cartItem/", data)
            }
        },
        
        async updateNotes(i) {
            let data = {
                user_id: parseInt(this.user.user_id),
                product_id: parseInt(this.cartItem[i]),
                item_qty: this.itemQuantity[i],
                item_notes: this.itemNotes[i]
            };
            let confirmResult = window.confirm("Bạn có chắc chắn muốn thay đổi Ghi chú của sản phẩm?");
            if (confirmResult) {
                try {
                    await axios.put("/cartItem/", data);
                    console.log("Đã cập nhật Ghi chú thành công.");
                } catch (error) {
                    console.error("Đã xảy ra lỗi khi cập nhật Ghi chú:", error);
                }
            }
        },

        async deleteNotes(i) {
            let data = {
                user_id: parseInt(this.user.user_id),
                product_id: parseInt(this.cartItem[i]),
                item_qty: this.itemQuantity[i],
                item_notes: ""
            };
            let confirmResult = window.confirm("Bạn có chắc chắn muốn xóa bỏ Ghi chú của sản phẩm?");
            if (confirmResult) {
                try {
                    await axios.put("/cartItem/", data);
                    console.log("Đã xóa Ghi chú thành công.");
                } catch (error) {
                    console.error("Đã xảy ra lỗi khi xóa Ghi chú:", error);
                }
            }
        },

        async removeBtn(index) {
            await axios.delete("/cartItem/" + this.user.user_id + "/" + this.cartItem[index]);

            this.cartItem.splice(index, 1);
            this.itemQuantity.splice(index, 1);
        },

        async sendBillDetails(billId, productId, qty , notes) {
            let billDetails = {
                bill_id: parseInt(billId),
                product_id: parseInt(productId),
                item_qty: parseInt(qty),
                item_notes: notes,
            }

            await axios.post("/billdetails", billDetails);
        },

        async checkOutBtn() {
            let confirmResult = window.confirm("Xác Nhận Gửi Yêu Cầu" );
            if (confirmResult) {
                let billId = (await axios.get("/billstatus/new")).data;

                if (billId == "") {
                    billId = 1
                } else {
                    billId = parseInt(billId.bill_id) + 1
                }

                this.cartItem.forEach((productId, index) => {
                    this.sendBillDetails(billId, productId, this.itemQuantity[index], this.itemNotes[index])
                });

                var now = new Date();
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var hour = ("0" + (now.getHours())).slice(-2);
                var min = ("0" + (now.getMinutes())).slice(-2);
                var currentTime = day + "/" + month + "/" + now.getFullYear() + " - " + hour + ":" + min;


                let billStatus = {
                    bill_id: parseInt(billId),
                    user_id: parseInt(this.user.user_id),
                    date_id: this.dateID,
                    bill_phone: this.checkoutObj.phone,
                    bill_address: this.checkoutObj.address,
                    bill_when: currentTime,
                    bill_total: parseInt(this.calculateSummaryPrice()),
                    bill_notes: this.checkoutObj.notes,
                    bill_status: 1
                }

                axios.post("/billstatus", billStatus);
                axios.delete("/cartItem/" + this.user.user_id);

                this.cartItem = [];
                this.itemQuantity = [];

                this.$router.push("/myorder");
            }
        }


    }

}
</script>

<style></style>