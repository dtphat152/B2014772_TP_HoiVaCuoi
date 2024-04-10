<template>
    
    <div class="container" style="width: 500px; margin-top: 50px; border: 1px solid #ddd;  border-radius: 8px;">
        <div class="checkout-form-container">
            <form @submit="handleSubmit" novalidate autocomplete="off" >
                <div class="pt-5" v-if="user">
                    <h1 style="color: #FF66CC; background-color: #FFF0F5;">{{ this.user.user_name }}'s Order</h1> 
                    <h4>Total: <span>${{ calculateSummaryPrice() }}</span></h4> 
                    <h5>SDT: {{ this.user.user_phone }}</h5>
                    <h4>Date: <span>{{  this.dateStart  }}  to  {{ this.dateEnd }}</span></h4>
                </div>
                <hr style="border-color: #ef87aa;">
                <div class="form-group details-group">
                    <h4>Shipping Details</h4>
                    <div class="form-group">
                        <input type="text" name="coPhone" id="coPhone" placeholder="Phone number" class="form-control"
                            v-model="checkoutObj.phone" />
                        <p class="error-mess" v-if="errorObj.phoneErr.length > 0">{{ errorObj.phoneErr[0] }}</p>
                    </div>

                    <div class="form-group">
                        <input type="text" name="coAddress" id="coAddress" placeholder="Address..."
                            class="form-control" v-model="checkoutObj.address" />
                        <p class="error-mess" v-if="errorObj.addressErr.length > 0">{{ errorObj.addressErr[0] }}</p>
                    </div>
                </div>


                <div v-if="user" class="form-group">
                    <button type="submit" value="submit">Check Out</button>
                </div>
            </form>
        </div>
    </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
export default {
    name: "Checkout",

    data() {
        return {
            checkoutObj: { phone: "", address: ""},
            errorObj: { phoneErr: [], addressErr: [] },
            cartItem: [],
            itemQuantity: [],
            itemNotes: [],
            dateStart: '',
            dateEnd: '',
            guestNumber: 0,
        }
    },

    created() {
        this.getAllCartItem();
    },

    async mounted() {
        this.getDateStart(this.user.user_id);
        this.getDateEnd(this.user.user_id); 
        this.getGuestNumber(this.user.user_id);
    },

    computed: {
        ...mapState(["allProducts", "user"]),

        filterProducts: function () {
            return this.allProducts.filter(
                (f) => this.matchID(f, this.cartItem)
            );
        },
    },

    methods: {

        async getDateStart(id) {
            try {
                const response = await axios.get('/date/' + id);
                if (response.data.length > 0) {
                    this.dateStart = response.data[0].date_start;
                    console.log('Ngày bắt đầu được trả về từ API:', this.dateStart);
                } else {
                    console.log('Không có dữ liệu ngày bắt đầu từ API. Trả về một ngày mặc định.');
                    this.dateStart =  '';
                }
            } catch (error) {
                console.error('Đã xảy ra lỗi khi lấy dữ liệu ngày bắt đầu:', error);
                this.dateStart =  '';
            }
        },

        async getGuestNumber(id) {
            try {
                const response = await axios.get('/guestnumber/' + id);
                if (response.data.length > 0) {
                    this.guestNumber = response.data[0].guest_number;
                    console.log('Số lượng khách được trả về từ API:', this.guestNumber);
                } else {
                    console.log('Không có dữ liệu Số lượng khách từ API.');
                    this.guestNumber =  0;
                }
            } catch (error) {
                console.error('Đã xảy ra lỗi khi lấy dữ liệu Số lượng khách:', error);
                this.guestNumber =  0;
            }
        },

        async getDateEnd(id) {
            try {
                const response = await axios.get('/date/' + id);
                if (response.data.length > 0) {
                    this.dateEnd = response.data[0].date_end;
                    console.log('Ngày bắt đầu được trả về từ API:', this.dateEnd);
                } else {
                    console.log('Không có dữ liệu ngày bắt đầu từ API. Trả về một ngày mặc định.');
                    this.dateEnd =  '';
                }
            } catch (error) {
                console.error('Đã xảy ra lỗi khi lấy dữ liệu ngày bắt đầu:', error);
                this.dateEnd =  '';
            }
        },


        formatDate(date) {
        if (date) {
            const year = date.getFullYear();
            let month = date.getMonth() + 1;
            let day = date.getDate();

            month = month < 10 ? `0${month}` : month;
            day = day < 10 ? `0${day}` : day;

            // Trả về chuỗi có định dạng "yyyy-MM-dd"
            return `${year}-${month}-${day}`;
        }

        return null;
        },
        
        availableTime: function () {
            var now = new Date();
            var currentMonth = ("0" + (now.getMonth() + 1)).slice(-2);

            var minRange = now.getFullYear() + "-" + currentMonth;
            var maxRange = (now.getFullYear() + 10) + "-" + currentMonth;

            document.getElementById("coCardEx").setAttribute("min", minRange);
            document.getElementById("coCardEx").setAttribute("max", maxRange);
        },

        matchID: function (product, cartArray) {
            let temp = "";
            cartArray.forEach(element => {
                if (parseInt(product.product_id) == element) {
                    temp = product
                }
            });
            return temp
        },

        calculateSummaryPrice: function () {
            let subtotal = 0;
            let i = 0;
            while (i < this.itemQuantity.length) {
                if ( this.filterProducts[i].product_category=="Khai Vị" || this.filterProducts[i].product_category=="Món Chính" || this.filterProducts[i].product_category=="Tráng Miệng") {
                    subtotal = subtotal + parseInt(this.filterProducts[i].product_price) * this.guestNumber
                } else {
                    subtotal = subtotal + parseInt(this.filterProducts[i].product_price) * this.itemQuantity[i]
                }
                i = i + 1
            }
            return subtotal;
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

        resetCheckErr: function () {
            this.errorObj.phoneErr = [];
            this.errorObj.addressErr = [];
        },

        checkEmptyErr: function () {
            for (var typeErr in this.errorObj) {
                if (this.errorObj[typeErr].length != 0) {
                    return false;
                }
            }
            return true;
        },

        checkForm: function () {
            this.resetCheckErr();

            // Phone validate
            if (!this.checkoutObj.phone) {
                this.errorObj.phoneErr.push('Entering phone number is required');
            }
            else {
                if (!this.checkoutObj.phone.startsWith('0')) {
                    this.errorObj.phoneErr.push('Phone numbers must start with 0..');
                }

                if (this.checkoutObj.phone.length != 10) {
                    this.errorObj.phoneErr.push('Phone numbers must have exactly 10 digits');
                }

                if (!/[0-9]{10}/.test(this.checkoutObj.phone)) {
                    this.errorObj.phoneErr.push('Phone numbers can only contain numbers');
                }
            }

            // Address validate
            if (!this.checkoutObj.address) {
                this.errorObj.addressErr.push('Entering address is required');
            }
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

        async handleSubmit(e) {
            this.checkForm();

            if (!this.checkEmptyErr()) {
                e.preventDefault();
            } else {
                e.preventDefault();
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
                    bill_phone: this.checkoutObj.phone,
                    bill_address: this.checkoutObj.address,
                    date_start: this.dateStart,
                    date_end: this.dateEnd,
                    bill_when: currentTime,
                    bill_method: this.checkoutObj.paymentMethod,
                    bill_total: parseInt(this.calculateSummaryPrice()),
                    bill_notes: "true",
                    bill_status: 1
                }

                axios.post("/billstatus", billStatus);
                axios.delete("/cartItem/" + this.user.user_id);

                this.cartItem = [];
                this.itemQuantity = [];

                this.$router.push("/thank");

            }
        }
    }
};
</script>

<style>
</style>