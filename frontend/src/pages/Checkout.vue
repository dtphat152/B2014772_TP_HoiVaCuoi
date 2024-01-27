<template>
    <div class="container" style="width: 500px; margin-top: 50px; border: 1px solid #ddd;  border-radius: 8px;">
        <div class="checkout-form-container">
            <form @submit="handleSubmit" novalidate autocomplete="off" >
                <div class="pt-5" v-if="user">
                    <h1 style="color: #FF66CC;">Your Order</h1>
                    <h4>Total: <span>${{ calculateSummaryPrice() }}</span></h4>
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
                <h4>Payment Method</h4>
                <div class="form-check-inline">
                    <label class="form-check-label">
                        <input type="radio" class="form-check-input" name="payment" v-model="checkoutObj.paymentMethod" value="cash"><span>Cash</span>
                    </label>
                </div>
                <div class="form-check-inline">
                    <label class="form-check-label">
                        <input type="radio" class="form-check-input" name="payment" v-model="checkoutObj.paymentMethod" value="card"><span>Card (Visa)</span>
                    </label>
                </div>
                <br>
                <div v-if="checkoutObj.paymentMethod == 'card'">
                    <br>
                    <h6>Card number</h6>
                        <div class="form-group">
                            <input type="text" name="coCardNum" placeholder="Enter your card number" id="coCardNum"
                                    class="form-control" v-model="cardObj.number" size="16" maxlength="16" />
                                <p class="error-mess" v-if="errorObj.numErr.length > 0">{{ errorObj.numErr[0] }}</p>
                        </div>
                    <h6>Name</h6>
                        <div class="form-group">
                            <input v-upcase type="text" name="coCardName" placeholder="Enter the name in your card "
                                id="coCardName" class="form-control" v-model="cardObj.name" />
                            <p class="error-mess" v-if="errorObj.nameErr.length > 0">{{ errorObj.nameErr[0] }}</p>
                        </div>
                    <h6>Expiry Date</h6>
                        <div class="form-group" >
                            <div class="form-control" style="border: none; margin-left: 0; padding-left: 0;">
                                <input
                                    style="position: absolute;  background: #999999;"
                                    type="month" name="coCardEx" id="coCardEx" v-model="cardObj.expiryDate"
                                    @click="availableTime()" />
                            </div>
                            <p class="error-mess" v-if="errorObj.exDateErr.length > 0">{{ errorObj.exDateErr[0] }}</p>
                        </div>
                        <h6>CVV</h6>
                        <div class="form-group">
                            <input type="text" name="coCardCvv" placeholder="CVV" id="coCardCvv" class="form-control"
                                v-model="cardObj.cvv" />
                            <p class="error-mess" v-if="errorObj.cvvErr.length > 0">{{ errorObj.cvvErr[0] }}</p>
                        </div>

                </div>
                <br>
                <div v-if="user" class="form-group">
                    <!-- <input type="submit" value="CONFIRM & PAY" class="btn-info p-2" 
                        :disabled="filterProducts.length ? false : true" /> -->
                    <button type="submit" value="CONFIRM & PAY" @click="checkOutBtn()" class="btn btn-block btn-lg"  style="background-color: #FFF0F5; "
                            data-mdb-ripple-color="dark" :disabled="filterProducts.length ? false : true" >Check out</button>
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
            checkoutObj: { phone: "", address: "", paymentMethod: "" },
            cardObj: { number: "", name: "", expiryDate: "", cvv: "" },
            errorObj: { phoneErr: [], addressErr: [], payErr: [], numErr: [], nameErr: [], exDateErr: [], cvvErr: [] },
            cartItem: [],
            itemQuantity: [],
        }
    },

    created() {
        this.getAllCartItem();
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
                subtotal = subtotal + parseInt(this.filterProducts[i].product_price) * this.itemQuantity[i]
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
                });
            }
        },

        resetCheckErr: function () {
            this.errorObj.phoneErr = [];
            this.errorObj.addressErr = [];
            this.errorObj.payErr = [];
            this.errorObj.numErr = [];
            this.errorObj.nameErr = [];
            this.errorObj.exDateErr = [];
            this.errorObj.cvvErr = [];
        },

        checkEmptyErr: function () {
            for (var typeErr in this.errorObj) {
                if (this.errorObj[typeErr].length != 0) {
                    return false;
                }
            }
            return true;
        },

        inputUpcase: function (e) {
            e.target.value = e.target.value.toUpperCase()
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

            // Card validate
            if (!this.checkoutObj.paymentMethod) {
                this.errorObj.payErr.push('Selecting payment method is required');
            }
            else if (this.checkoutObj.paymentMethod == "card") {
                if (!this.cardObj.number) {
                    this.errorObj.numErr.push('Entering card number is required');
                }
                else {
                    if (!this.cardObj.number.startsWith('4')) {
                        this.errorObj.numErr.push('Visa card numbers must start with 4');
                    }

                    if (this.cardObj.number.length != 16) {
                        this.errorObj.numErr.push('Visa card numbers must have exactly 16 digits');
                    }

                    if (!/[0-9]{16}/.test(this.cardObj.number)) {
                        this.errorObj.numErr.push('Visa card numbers can only contain numbers');
                    }
                }

                if (!this.cardObj.name) {
                    this.errorObj.nameErr.push('Entering name is required');
                }
                else {
                    if (!/^[A-Za-z]+$/.test(this.cardObj.name.replace(/\s/g, ""))) {
                        this.errorObj.nameErr.push('A name can only contain letters');
                    }
                }

                if (!this.cardObj.expiryDate) {
                    this.errorObj.exDateErr.push('Entering expiry date is required');
                }


                if (!this.cardObj.cvv) {
                    this.errorObj.cvvErr.push('Entering cvv code is required');
                }
                else {
                    if (this.cardObj.cvv.length != 3) {
                        this.errorObj.cvvErr.push('Cvv code must have exactly 3 digits');
                    }

                    if (!/[0-9]{3}/.test(this.cardObj.cvv)) {
                        this.errorObj.cvvErr.push('Cvv code can only contain numbers');
                    }
                }
            } else if (this.checkoutObj.paymentMethod == "cash") {
                this.cardObj.number = "";
                this.cardObj.name = "";
                this.cardObj.expiryDate = "";
                this.cardObj.cvv = "";

                this.errorObj.numErr = [];
                this.errorObj.nameErr = [];
                this.errorObj.exDateErr = [];
                this.errorObj.cvvErr = [];
            }
        },

        isPaid: function () {
            if (this.checkoutObj.paymentMethod == "cash") {
                return "false"
            }
            else if (this.checkoutObj.paymentMethod == "card") {
                return "true"
            }
        },

        async sendBillDetails(billId, productId, qty) {
            let billDetails = {
                bill_id: parseInt(billId),
                product_id: parseInt(productId),
                item_qty: parseInt(qty)
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
                    this.sendBillDetails(billId, productId, this.itemQuantity[index])
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
                    bill_when: currentTime,
                    bill_method: this.checkoutObj.paymentMethod,
                    bill_total: parseInt(this.calculateSummaryPrice()),
                    bill_paid: this.isPaid(),
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

<script setup>
// enables v-focus in templates
const vUpcase = {
    mounted(el) {
        el.style.textTransform = "uppercase";
    }
}
</script>

<style>
.error-mess{
    color: red;
}
</style>