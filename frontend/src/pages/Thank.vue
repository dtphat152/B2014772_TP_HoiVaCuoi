<template>
    <div class="thank-container text-center">
        <h1>Chân Thành Cám Ơn</h1>

        <div v-if="this.OrderInfo!='' && this.TransactionStatus=='00' " class="thank-letter p-5">
            <h4 v-none>{{ this.OrderInfo }} Thành Công!</h4>
        </div>

        <div v-if="this.orderInfo!='' && this.message=='Successful.'" class="thank-letter p-5">
            <h4 v-none>{{ this.orderInfo }} Thành Công!</h4>
        </div>

        <div v-else class="thank-letter p-5">
            <h4 v-none>Vì đã chọn chúng tôi!</h4>
        </div>

        <div class="row justify-content-center">
            <div class="col-1 text-center">
                <router-link @click="scrollToTop()" to="/booking">
                    <i class="fa fa1 fa-home" aria-hidden="true" style="color: white;"></i>
                    <h6 class="text-center font-weight-bold p-2" style="color: white;">Trang Chủ</h6>
                </router-link>
            </div>
            <div class="col-1 text-center">
                <router-link @click="scrollToTop()" to="/booking">
                    <i class="fa fa1 fa-sticky-note" aria-hidden="true" style="color: white;"></i>
                    <h6 class="text-center font-weight-bold p-2" style="color: white;">Đặt Hàng</h6>
                </router-link>
            </div>
            <div class="col-1 text-center">
                <router-link @click="scrollToTop()" to="/contact">
                    <i class="fa fa1 fa-phone-square" aria-hidden="true"></i>
                    <h6 class="text-center font-weight-bold p-2" style="color: white;">Liên Hệ</h6>
                </router-link>
            </div>
            <div class="col-1 text-center">
                <router-link @click="scrollToTop()" to="/about">
                    <i class="fa fa1 fa-university" aria-hidden="true"></i>
                    <h6 class="text-center font-weight-bold p-2" style="color: white;">Chúng Tôi</h6>
                </router-link>
            </div>
        </div>

    </div>
</template>


<script>
import axios from "axios";

export default {
    name: 'Thank',

    data() {
        return {
            Amount: null,
            BankCode: null,
            BankTranNo: null,
            CardType: null,
            OrderInfo: null,
            PayDate: null,
            ResponseCode: null,
            TmnCode: null,
            TransactionNo: null,
            TransactionStatus: null,
            TxnRef: null,
            SecureHash: null,

            orderId: null,
            requestId: null,
            amount: null,
            orderInfo: null,
            transId: null,
            message: null,
            payType: null,

            voucher_value: 0
        };
    },

    mounted() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('vnp_Amount')) {
            this.Amount = urlParams.get('vnp_Amount');
            this.BankCode = urlParams.get('vnp_BankCode');
            this.BankTranNo = urlParams.get('vnp_BankTranNo');
            this.CardType = urlParams.get('vnp_CardType');
            this.OrderInfo = urlParams.get('vnp_OrderInfo');
            this.PayDate = urlParams.get('vnp_PayDate');
            this.ResponseCode = urlParams.get('vnp_ResponseCode');
            this.TmnCode = urlParams.get('vnp_TmnCode');
            this.TransactionNo = urlParams.get('vnp_TransactionNo');
            this.TransactionStatus = urlParams.get('vnp_TransactionStatus');
            this.TxnRef = urlParams.get('vnp_TxnRef');
            this.SecureHash = urlParams.get('vnp_SecureHash');
        } else if (urlParams.has('amount')) {
            this.orderId = urlParams.get('orderId');
            this.requestId = urlParams.get('requestId');
            this.amount = urlParams.get('amount');
            this.orderInfo = urlParams.get('orderInfo');
            this.transId = urlParams.get('transId');
            this.message = urlParams.get('message');
            this.payType = urlParams.get('payType');
        } 
       
        if (this.Amount!='' && this.TransactionStatus=='00') this.sendInfoPayment();
        if (this.amount!='' && this.message=='Successful.') this.sendMoMoPayment();

        this.getVoucher();
    },

    
    methods: {
        async getVoucher(){
            let rsp = await axios.get(`/voucher/value`)
            this.voucher_value = rsp.data.vv_value
        },

        async sendInfoPayment() {
            console.log("sendInfoPayment");

            if (this.TransactionStatus === '00') {
                try {
                    const paymentData = {
                    Amount: this.Amount,
                    BankCode: this.BankCode,
                    BankTranNo: this.BankTranNo,
                    CardType: this.CardType,
                    OrderInfo: this.OrderInfo,
                    PayDate: this.PayDate,
                    ResponseCode: this.ResponseCode,
                    TmnCode: this.TmnCode,
                    TransactionNo: this.TransactionNo,
                    TransactionStatus: this.TransactionStatus,
                    TxnRef: this.TxnRef,
                    SecureHash: this.SecureHash,
                    };
                    await axios.post('/payment_vnpay', paymentData);

                    const id = this.extractIdFromTxnRef(this.TxnRef);
                    console.log("ID: ",id);
                    try {
                        await axios.put(`/billstatus/${id}`);
                        console.log("Bill status updated successfully!");
                        // try {
                        //     let mailData = {
                        //         email: 'tphoivacuoi@gmail.com',
                        //         content: this.OrderInfo+' đã hoàn thành!',
                        //     }
                        //     await axios.post('/sendemail/status', mailData);
                        // } catch (error) {
                        //     console.error("Error send mail:", error);
                        // }
                        if (this.OrderInfo.includes('Kết Sổ')){
                            await this.getVoucher()
                            let rsp = await axios.get(`/billstatus/bill/${id}`)
                            console.log("RSP: ",rsp.data);
                            console.log("this.voucher_value: ",this.voucher_value);
                            let total = rsp.data.bill_total
                            let user_id = rsp.data.user_id
                            if (total>=10000000) {
                                let voucher = {
                                    user_id: user_id,
                                    vc_value: this.voucher_value,
                                    vc_status:1
                                }
                                console.log("VC: ",voucher)
                                try {
                                    await axios.post(`/voucher`,voucher)
                                } catch (error) {
                                    console.error('Error in crate voucher',error)
                                }
                            }
                        }
                    } catch (error) {
                        console.error("Error updating bill status:", error);
                    }
                } catch (error) {
                    console.error("Error sending payment information:", error);
                }
            } else {
            window.confirm("Giao Dịch Không Thành Công (Transaction Failed)");
            }
        },


        extractIdFromTxnRef(txnRef, startChar = 'o', endChar = 'i') {
            const startIndex = txnRef.indexOf(startChar) + 1;
            const endIndex = txnRef.indexOf(endChar);

            if (startIndex === 0 || endIndex === -1) {
            return ''; 
            }

            return txnRef.substring(startIndex, endIndex);
        },

        async sendMoMoPayment(){
            console.log('sendMoMoPayment');
            const id = this.extractIdFromTxnRef(this.requestId);
            console.log("ID: ",id);
            try {
                await axios.put(`/billstatus/${id}`);
                console.log("Bill status updated successfully!");
                // try {
                //     let mailData = {
                //         email: 'tphoivacuoi@gmail.com',
                //         content: this.OrderInfo+' đã hoàn thành!',
                //     }
                //     await axios.post('/sendemail/status', mailData);
                // } catch (error) {
                //     console.error("Error send mail:", error);
                // }
                if (this.orderInfo.includes('Kết Sổ')){
                            let rsp = await axios.get(`/billstatus/bill/${id}`)
                            let total = rsp.data.bill_total
                            let user_id = rsp.data.user_id
                            if (total>=10000000) {
                                let voucher = {
                                    user_id: user_id,
                                    vc_value: this.voucher_value,
                                    vc_status:1
                                }
                                console.log("VC: ",voucher)
                                try {
                                    await axios.post(`/voucher`,voucher)
                                } catch (error) {
                                    console.error('Error in crate voucher',error)
                                }
                            }
                        }
            } catch (error) {
                console.error("Error updating bill status:", error);
            }
        }
    },

}
</script>


<style scoped>

.thank-container {
    padding: 2rem 9%;
    height: 55vh;
}

h1 {
    padding-top: 100px;
    color: #ff69b4;
    font-weight: 900;
    font-size: 50px;
}

h4{
    color: black;
    opacity: 0.3;
    font-weight: 900;
}

.fa1 {
    background-color: #ff99a8;
    text-align: center;
    padding: 5px;
    border-radius: 25px;
    padding: 10px;
    font-size: 50px;
    color: #e6e6e6;
    opacity: 0.4;
}
</style>