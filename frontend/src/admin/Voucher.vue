<template>
    <div class="container_order">
        <div class="row p-5" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; margin: 0 1px;">
            <h1>Voucher Manager</h1>
        </div>
        <br>
        <div class="p-5" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; height: 785px;">
           
           <div class="row justify-content-center">
                <div class="col-10 p-5">
                    <div style="border-radius: 20px; background-color: white; height: 680px;">
                        <div class="row">
                            <div class="col-1">
                                <i v-if="this.opt!=1" class="fa-solid fa-bars pl-4 pt-3" style="font-size: 20px;" @click="showOption(1)"></i>
                                <i v-else class="fa-solid fa-chevron-left pl-4 pt-3" style="font-size: 20px;" @click="showOption(1)"></i>
                            </div>
                            <div class="col-4 offset-3">
                                <h2 v-if="this.opt!=1" class="text-center" style="font-weight: 900;">Voucher List</h2>
                            </div>
                            <div class="col-4 d-flex justify-content-end pr-5">
                                <button v-if="this.opt!=1" @click="setFilter(1)" class="btn mt-2 py-0" style="background-color: #008B8B; border-radius: 10px;">
                                    <h5 :style="{'color' : filter==1 ? '#fff' : 'black' , 'font-weight' : '900'}">Chưa sử dụng</h5>
                                </button>
                                <button v-if="this.opt!=1" @click="setFilter(2)" class="btn mt-2 py-0 ml-2" style="background-color: #40bf77; border-radius: 10px;">
                                    <h5 :style="{'color' : filter==2 ? '#fff' : 'black' , 'font-weight' : '900'}">Đang sử dụng</h5>
                                </button>
                                <button v-if="this.opt!=1" @click="setFilter(0)" class="btn mt-2 py-0 ml-2" style="background-color: #DAA520; border-radius: 10px;">
                                    <h5 :style="{'color' : filter==0 ? '#fff' : 'black' , 'font-weight' : '900'}">Đã sử dụng</h5>
                                </button>
                            </div>
                        </div>
                        <br><hr style="width: 80%; margin-left: 10%;">
                        <div v-if="opt==0" style="overflow-y: auto; height: 600px; ">
                            <div style="width: 90%; margin-left: 5%;">
                                <div v-for="(v, index) in filterVoucher" :key="index">
                                    <div class="row justify-content-center" 
                                    :style="{ 
                                        'background-color' : '#ffb3cc', 
                                        'margin-left': '10px', 
                                        'border-radius': '25px', 
                                        'padding': '5px'
                                    }">
                                        <div class="col-2">
                                            <h2 class="text-center pt-3 text-left" style="font-weight: 900;">{{ index+1 }}</h2>
                                        </div>
                                        <div class="col-5">
                                            <h1 style=" font-weight: 900; color: #228B22;">{{ formatCurrency(v.vc_value) }}</h1> 
                                            <h5 v-if="v.vc_status==0" style="font-weight: 900;">Đã sử dụng</h5>
                                            <h5 v-if="v.vc_status==1" style="font-weight: 900;">Chưa sử dụng</h5>
                                            <h5 v-if="v.vc_status==2" style="font-weight: 900;">Đang sử dụng</h5>
                                        </div>
                                        <div class="col-4 pl-0 pt-3">
                                            <h3 style=" font-weight: 900;">{{ v.user_name }}</h3> 
                                            <h5 style="text-transform: none;">{{ v.user_email }}</h5>
                                        </div>
                                        <div class="col-1 align-content-center" style="">
                                            <!-- <i class="fa fa-caret-right" aria-hidden="true" style="font-size: 15px;"></i> -->
                                            <i class="fa-solid fa-circle-info" style="font-size: 15px;"></i>
                                        </div>
                                    </div>
                                    <br>
                                </div>
                            </div>
                        </div>
                        <div v-if="opt==1">
                            <div class="row mx-5">
                                <div class="col-8 p-3 offset-2" style="background-color: #e6e6e6; border-radius: 20px;">
                                    <h3 class="text-center" style="font-weight: 900; color: #228B22;">Voucher Value</h3>
                                    <br>
                                    <h4 class="text-center" style="font-weight: 800;">Giá trị voucher tặng khách hàng sau khi giao dịch thành công</h4>
                                    <input type="number" v-model="this.value" class="text-center" style="width: 40%; margin-left: 30%; border-radius: 15px; font-size: 20px;"><br><br>
                                    <h4 v-if="this.value!=''" class="text-center" style="font-weight: 800; color: #228B22;">( {{ formatCurrency(this.value) }} )</h4>
                                    <button class="btn" @click="changeValueVoucher()" 
                                        style="width: 20%; margin-left: 40%; background-color: #ffb3cc; border-radius: 10px; font-weight: 800;">Submit</button>
                                </div>
                                <div class="col-2"></div>
                            </div>
                        </div>
                    </div>
                </div>
           </div>

        </div>
    </div>
</template>

<script>
import axios from "axios";
import { mapState,mapMutations } from "vuex";
export default {
    name: 'VoucherManager',

    data() {
        return {
           voucherList: [],
           filter: 2,
           opt: 0,
           value: 0
        }
    },

    created() {
        this.getVoucherList(); 
        this.value = this.voucher_value;
    },

    computed: {
        ...mapState(["voucher_value"]),

        filterVoucher() {
            return this.voucherList.filter((v)=> v.vc_status==this.filter)
        }
    },

    methods: {
        ...mapMutations(["setVoucherValue"]),

        formatCurrency(amount) {
            if (!amount) return '';
            return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
        },

        async getVoucherList() {
            try {
                let rsp = await axios.get(`/voucher`);
                this.voucherList = rsp.data.map(voucher => ({
                    vc_id: voucher.vc_id,
                    vc_value: voucher.vc_value,
                    vc_status: voucher.vc_status,
                    user_id: voucher.user_id,
                    user_name: voucher.user_name,
                    user_email: voucher.user_email,
                }));
                console.log('user: ',this.voucherList)
            } catch (error) {
                console.error('Error while fetching users:', error);
            }
        },

        setFilter(now){
            this.filter=now
        },

        showOption(val){
            if (this.opt==0) this.opt=val; else this.opt=0;
        },

        async changeValueVoucher(){
            let ok = window.confirm('Đổi giá trị voucher thành '+this.value)
            if (ok){
                let data = {
                    vv_value: this.value
                }
                try {
                    await axios.put(`/voucher/value`,data)
                } catch (error) {
                    console.error('Error while put voucher:', error);
                }
                this.setVoucherValue(this.value);
            }
            
        },


    }
}

</script>

<style scoped>

h1 {
    font-weight: 900;
    color: #d35ea4;
}

.container_order{
    margin-left: 220px; 
    margin-right: 20px; 
    margin-top: 10px;
    top: 0;
    height: 98vh;  
    opacity: 0.8;
    border-radius: 20px;
 }

  form {
    width: 100%;
    background: #ffb3cc; 
    opacity: 0.8;
    box-shadow: 0 1rem 1rem rgba(0, 0, 0, 0.05);
    border: 0.1rem solid rgba(0, 0, 0, 0.2);
    padding: 2rem;
    padding-bottom: 5px;
    border-radius: 15px;
    animation: fadeUp 0.4s linear;
}

 form h3 {
    padding-bottom: 1rem;
    font-size: 2rem;
    text-transform: uppercase;
    color: #130f40;
    margin: 0;
}

 form .form-control {
    margin: 0.7rem 0;
    border-radius: 15px;
    background: #f2f2f2;
    padding: 2rem 1.2rem;
    font-size: 1.6rem;
    color: black;
    font-weight: 900;
    text-transform: none;
    width: 100%;
    border: none;
}

 form label {
    font-size: 2rem;
    margin: 0;
    padding: 0;
}


</style>