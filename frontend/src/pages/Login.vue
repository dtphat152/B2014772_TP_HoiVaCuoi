<template>
    <div class="login-container text-center"> 
        <div v-if="showLogin" class="login-form-container">
            <form id="loginForm" @submit="handleSubmit" novalidate autocomplete="off">
                <h3>Đăng Nhập</h3>

                <div v-if="errors.length" class="error-box">
                    <ul>
                        <li v-for="error in errors" :key="error">{{ error }}</li>
                    </ul>
                </div>


                <div class="form-group">
                    <input type="email" id="uEmail" name="uEmail" class="form-control" placeholder="Email của bạn..."
                        v-model="loginObj.email" />
                </div>

                <div class="form-group">
                    <input type="password" id="uPass" name="uPass" class="form-control"
                        placeholder="Mật khẩu..." v-model="loginObj.pass" />
                </div>

                <div class="form-group">
                    <input type="submit" value="Đăng Nhập" class="ounded-lg p-3 mt-2" 
                    style="background-color: #ef87aa; border-radius: 15px; font-weight: bold;">
                    <p>Bạn chưa có tài khoản? <router-link @click="scrollToTop()" to="/register" style="color: #ef87aa;">Tạo Mới
                        </router-link>
                    </p>         
                </div>  
                <div class="text-center" style="background-color: #990099;">
                        <button style="background-color: #990099; font-weight: bold; color: #ef87aa;"
                        @click="openResetPass()"><h4>Quên Mật Khẩu</h4></button>
                </div>
            </form>
        </div>

        <div v-if="!showLogin" class="login-form-container">
            <form id="loginForm" @submit="sendForgotPass" novalidate autocomplete="off">
                <h3>Quên Mật Khẩu</h3>
                <h4 class="px-3">Chúng tôi sẽ gửi Mail cho bạn để thực hiện đặt lại mật khẩu.</h4>
                <div v-if="errors.length" class="error-box">
                    <ul>
                        <li v-for="error in errors" :key="error">{{ error }}</li>
                    </ul>
                </div>

                <div class="form-group">
                    <input type="email" id="uEmail" name="uEmail" class="form-control" placeholder="Email của bạn..."
                        v-model="loginObj.email" />
                </div>

                <div class="form-group">
                    <input type="submit" value="Gửi Yêu Cầu" class="ounded-lg p-3 mt-2" 
                    style="background-color: #ef87aa; border-radius: 15px; font-weight: bold;">        
                </div>  
                <div class="text-center" style="background-color: #990099;">
                        <button style="background-color: #990099; font-weight: bold; color: #ef87aa;"
                        @click="openResetPass()"><h4>Trở Về</h4></button>
                </div>
                <h3 v-if="sendSuccess">Vui lòng kiểm tra Mail!</h3>
            </form>
        </div>
    </div>
</template>


<script>
import axios from "axios";
import { mapMutations } from "vuex";
import CryptoJS from 'crypto-js';

export default {
    name: 'Login',

    data() {
        return {
            loginObj: { email: "", pass: "" },
            matchUser: undefined,
            errors: [],
            showLogin: true,
            sendSuccess: false,
        }
    },

    methods: {
        ...mapMutations(["setUser"]),

        scrollToTop() {
            window.scrollTo(0, 0);
        },

        openResetPass(){
            this.showLogin = !this.showLogin;
        },

        async sendForgotPass(e) {
            this.errors = [];

            if (!this.loginObj.email) {
                this.errors.push("Bạn phải nhập Email");
            }
            else {
                if (!/[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$/.test(this.loginObj.email)) {
                    this.errors.push('Email không hợp lệ');
                }
            }

            if (!this.errors.length == 0) {
                e.preventDefault();
            }
            else {
                e.preventDefault();
                try {
                    let rsp = await axios.get('/users/' + this.loginObj.email);
                    let user_id = rsp.data.user_id;
                    console.log("user_id: " + user_id);

                    const hashedData = CryptoJS.SHA256(this.loginObj.email).toString();
                    console.log("Hash: " + hashedData);

                    let data = {
                        id: user_id,
                        email: this.loginObj.email,
                        resetToken: hashedData,
                    };
                    console.log("Data: ", JSON.stringify(data));
                    this.sendSuccess = true;
                    try {
                        await axios.post(`/sendemail/reset-password`, data);
                    } catch (error) {
                        console.error("Error in send email reset password", error);
                    }
                } catch (error) {
                    console.error("Error in sendForgotPass function:", error);
                }
            }
        },


        async getMatchUser(email) {
            let data = await axios.get('/users/' + email);
            this.matchUser = data.data;
        },

        async handleSubmit(e) {
            this.errors = [];

            if (!this.loginObj.email) {
                this.errors.push("Bạn phải nhập Email");
            }
            else {
                if (!/[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$/.test(this.loginObj.email)) {
                    this.errors.push('Email không hợp lệ');
                }
            }

            if (!this.loginObj.pass) {
                this.errors.push('Mật Khẩu không được bỏ trống');
            }

            if (!this.errors.length == 0) {
                e.preventDefault();
            }
            else {
                e.preventDefault();
                await this.getMatchUser(this.loginObj.email);
                if (!this.matchUser) {
                    this.errors.push("Mật khẩu không đúng!")
                }
                else {
                    if (this.matchUser.user_password === this.loginObj.pass) {
                        this.matchUser.user_password = "";
                        this.setUser(this.matchUser);
                        this.$router.push("/");
                    }
                    else {
                        this.errors.push("Mật khẩu không đúng!")
                    }
                }
            }
        }

    }

}
</script>

<style scoped>
.login-container {
    padding: 2rem 9%;
}

.login-container .login-form-container {
    height: 50vh;
}

.login-container .login-form-container form {
    background: #990099; 
    opacity: 0.8;
    position: absolute;
    top: 40%;
    left: 50%;
    transform: translate(-50%, -50%);
    max-width: 40rem;
    width: 100%;
    box-shadow: 0 1rem 1rem rgba(0, 0, 0, 0.05);
    border: 0.1rem solid rgba(0, 0, 0, 0.2);
    padding: 2rem;
    border-radius: 15px;
    animation: fadeUp .4s linear;
}

.login-container .login-form-container form h3 {
    padding-bottom: 1rem;
    font-size: 2rem;
    font-weight: bolder;
    text-transform: uppercase;
    color: #130f40;
    margin: 0;
}

.login-container .login-form-container form .form-control {
    margin: .7rem 0;
    border-radius: 15px;
    background: rgba(0, 0, 0, 0.3);
    padding: 2rem 1.2rem;
    font-size: 1.6rem;
    color: white;
    /* font-weight: bold; */
    text-transform: none;
    width: 100%;
    border: none;
}

.login-container .login-form-container form .btn {
    margin-bottom: 1rem;
    margin-top: 1rem;
    width: 100%;
}

.login-container .login-form-container form p {
    padding-top: 1rem;
    font-size: 1.5rem;
    color: #fff9fa;
    margin: 0;
}

.login-container .login-form-container form p a:hover {
    color: #130f40;
    text-decoration: underline;
}

.login-container .login-form-container form .error-box {
    background-color: #fff9fa;
    box-sizing: border-box;
    border: 2px solid rgba(255, 66, 79, .2);
    border-radius: 2px;
    font-size: 12px;
    margin-bottom: 20px;
}

.login-container .login-form-container form .error-box ul {
    list-style-type: none;
    margin: 0;
    padding: 10px 0px;
}

.login-container .login-form-container form .error-box ul li {
    padding-left: 10px;
    color: rgb(182, 0, 0);
}
</style>