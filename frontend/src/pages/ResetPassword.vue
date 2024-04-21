<template>
    <div v-if="!checkOTP" class="reset-pass-container">
        <div class="reset-pass-form-container">
            <form id="resetOTPForm" @submit="handleSubmitOTP" novalidate autocomplete="off">
                <h3>Đổi Mật Khẩu</h3>
                <div class="form-group">
                    <label for="OTP">OTP:</label> 
                    <input type="text" name="OTP" placeholder="Mã OTP đính kèm trong Mail của bạn" id="OTP"
                        class="form-control" v-model="this.otpInput" />
                </div>
                <div class="form-group">
                    <input type="submit" value="Kiểm Tra" class="p-3 mt-2" 
                        style="background-color: #ef87aa; border-radius: 15px; font-weight: bold;" />
                </div>
            </form>
        </div>
    </div>
    <div v-if="checkOTP" class="reset-pass-container">
        <div class="reset-pass-form-container">
            <form id="resetPassForm" @submit="handleSubmit" novalidate autocomplete="off">
                <h3>Đổi Mật Khẩu</h3>
                <div class="form-group">
                    <label for="uPass">Mật Khẩu Tài Khoản:</label> 

                    <input type="password" name="uPass" placeholder="Lớn hơn hoặc bằng 8 kí tự và phải có ít nhất một kí tự đặc biệt" id="uPass"
                        class="form-control" v-model="this.pass" />
                    <p class="error-mess" v-if="errorObj.passErr.length > 0">{{ errorObj.passErr[0] }}</p>
                </div>

                <div class="form-group">
                    <label for="uPassConfirm">Nhập Lại Mật Khẩu:
                    </label>
                    <input type="password" name="uPassConfirm" placeholder="Nhập lại Mật Khẩu phía trên" id="uPassConfirm"
                        class="form-control" v-model="this.confirm" />
                    <p class="error-mess" v-if="errorObj.confirmErr.length > 0">{{ errorObj.confirmErr[0] }}</p>
                </div>

                <div class="form-group">
                    <input type="submit" value="Cập Nhật" class="p-3 mt-2" 
                        style="background-color: #ef87aa; border-radius: 15px; font-weight: bold;" />
                </div>
            </form>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
export default {
    name: "ResetPassword",

    data() {
        return {
            otpInput: '',
            pass: '',
            confirm: '',
            checkOTP: false,
            errorObj: { passErr: [], confirmErr: [], },
            user_id: '',
        }
    },

    created() {
        const hash = this.$route.params.token;
        this.user_id = hash.substring(0,1);
    },

    methods: {

        async handleSubmitOTP(e) {
            e.preventDefault();
            console.log('otp: ',this.user_id);
            let rsp = await axios.get(`/resetpass/${this.user_id}`);
            if (rsp.data.length > 0) {
                let otp = rsp.data[0].OTP;
                console.log('otp: ',otp);
                console.log('otpInput',this.otpInput);
                if ( this.otpInput === otp ) {
                    this.checkOTP = true;
                } else window.confirm('OTP Không Chính Xác');
            } else window.confirm('OTP Không Chính Xác');
        },


        async handleSubmit(e) {
            e.preventDefault();
            if ( this.pass === this.confirm ) {
                let data = {
                    user_id: this.user_id,
                    user_password: this.pass,
                }
                console.log("Data: ", JSON.stringify(data));

                try {
                    await axios.put("/users/", data);
                } catch (error) {
                    console.error("Error in PUT ",error);
                }
                this.$router.push("/login");
            }
        }
    },

};
</script>


<style scoped>
.reset-pass-container {
    padding: 2rem 9%;
}

.reset-pass-container .reset-pass-form-container form {
    position: relative;
    left: 50%;
    transform: translate(-50%, 0%);
    max-width: 70rem;
    width: 100%;
    background: #ffb6c1; 
    opacity: 0.8;
    box-shadow: 0 1rem 1rem rgba(0, 0, 0, 0.05);
    border: 0.1rem solid rgba(0, 0, 0, 0.2);
    padding: 2rem;
    border-radius: 15px;
    animation: fadeUp 0.4s linear;
}

.reset-pass-container .reset-pass-form-container form h3 {
    padding-bottom: 1rem;
    font-size: 2rem;
    text-transform: uppercase;
    color: #130f40;
    margin: 0;
}

.reset-pass-container .reset-pass-form-container form .form-control {
    margin: 0.7rem 0;
    border-radius: 15px;
    background: rgba(0, 0, 0, 0.3);
    padding: 2rem 1.2rem;
    font-size: 1.6rem;
    color: #130f40;
    text-transform: none;
    width: 100%;
    border: none;
}

.reset-pass-container .reset-pass-form-container form label {
    font-size: 2rem;
    margin: 0;
    padding: 0;
}

.reset-pass-container .reset-pass-form-container form span {
    font-size: 18px;
    padding-left: 5px;
    padding-right: 40px;
}

.reset-pass-container .reset-pass-form-container form .btn {
    margin: 1rem 0;
    width: 100%;
    text-align: center;
}

.reset-pass-container .reset-pass-form-container form p {
    padding-top: 1rem;
    font-size: 1.5rem;
    color: #fff9fa;
    margin: 0;
}

.reset-pass-container .reset-pass-form-container form p a {
    color: #ff69b4;
}

.reset-pass-container .reset-pass-form-container form p a:hover {
    color: #130f40;
    text-decoration: underline;
}

.reset-pass-container .reset-pass-form-container form .form-group {
    margin: 0;
}

.reset-pass-container .reset-pass-form-container form .form-group .error-mess {
    font-size: 1.5rem;
    position: relative;
    color: #17a2b8;
    margin: 0;
    padding: 0;
}
</style>
