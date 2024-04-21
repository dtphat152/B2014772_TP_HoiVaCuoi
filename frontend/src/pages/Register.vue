<template>
    <div class="register-container">
        <div class="register-form-container">
            <form id="registerForm" @submit="handleSubmit" novalidate autocomplete="off">
                <h1 style="font-weight: 900;color: #d35ea4;">Tạo Tài Khoản</h1>

                <div class="form-group">
                    <label for="uName">Họ và Tên:
                    </label>
                    <input type="text" name="uName" placeholder="Họ Và Tên" id="uName" class="form-control"
                        v-model="registerObj.name" />
                    <p class="error-mess" v-if="errorObj.nameErr.length > 0">{{ errorObj.nameErr[0] }}</p>
                </div>

                <div class="form-group">
                    <label for="uEmail">Địa Chỉ Email:
                    </label>
                    <input type="email" name="uEmail" placeholder="example@gmail.com" id="uEmail" class="form-control"
                        v-model="registerObj.email" />
                    <p class="error-mess" v-if="errorObj.emailErr.length > 0">{{ errorObj.emailErr[0] }}</p>
                </div>

                <div class="form-group">
                    <label for="uPass">Mật Khẩu Tài Khoản:</label> 
                    <input type="password" name="uPass" placeholder="Lớn hơn hoặc bằng 8 kí tự và phải có ít nhất một kí tự đặc biệt" id="uPass"
                        class="form-control" v-model="registerObj.pass" />
                    <p class="error-mess" v-if="errorObj.passErr.length > 0">{{ errorObj.passErr[0] }}</p>
                </div>

                <div class="form-group">
                    <label for="uPassConfirm">Nhập Lại Mật Khẩu:
                    </label>
                    <input type="password" name="uPassConfirm" placeholder="Nhập lại Mật Khẩu phía trên" id="uPassConfirm"
                        class="form-control" v-model="registerObj.confirm" />
                    <p class="error-mess" v-if="errorObj.confirmErr.length > 0">{{ errorObj.confirmErr[0] }}</p>
                </div>

                <div class="form-group">
                    <label for="uPhone">Số Điện Thoại:
                    </label>
                    <input type="tel" name="uPhone" placeholder="vd: 0987654321" id="uPhone"
                        class="form-control" v-model="registerObj.phone" />
                    <p class="error-mess" v-if="errorObj.phoneErr.length > 0">{{ errorObj.phoneErr[0] }}</p>
                </div>

                <div class="form-group">
                    <label for="uAddress">Địa Chỉ:
                    </label>
                    <textarea type="text" name="uAddress" placeholder="Địa chỉ của bạn" id="uAddress"
                        class="form-control" v-model="registerObj.address" ></textarea>
                </div>

                

                <div class="form-group">
                    <input type="submit" value="Đăng Ký" class="p-3 mt-2" 
                        style="background-color: #ef87aa; border-radius: 15px; font-weight: 900; font-size: 20px;" />
                    <p>Bạn đã có tài khoản? <router-link @click="scrollToTop()" to="/login">Đăng Nhập</router-link>
                    </p>
                </div>
            </form>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
export default {
    name: "Register",

    data() {
        return {
            registerObj: { name: "", email: "", pass: "", confirm: "", phone: "", address: "" },
            errorObj: { nameErr: [], emailErr: [], passErr: [], confirmErr: [], phoneErr: [],  },
            matchUser: undefined,

        }
    },

    methods: {
        async getMatchUser(email) {
            let data = await axios.get('/users/' + email);
            this.matchUser = data.data;
        },

        scrollToTop() {
            window.scrollTo(0, 0);
        },


        resetCheckErr: function () {
            this.errorObj.nameErr = [];
            this.errorObj.emailErr = [];
            this.errorObj.passErr = [];
            this.errorObj.confirmErr = [];
            this.errorObj.phoneErr = [];
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

            // Name validate
            if (!this.registerObj.name) {
                this.errorObj.nameErr.push("Họ Tên Không Được Bỏ Trống");
            }
            else {
                if (!/^[A-Za-z]+$/.test(this.registerObj.name.replace(/\s/g, ""))) {
                    this.errorObj.nameErr.push('Tên Chỉ Có Thể Chứa Các Chữ Cái');
                }
            }

            // Email validate
            if (!this.registerObj.email) {
                this.errorObj.emailErr.push("Email Không Được Bỏ Trống");
            }
            else {
                if (!/[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$/.test(this.registerObj.email)) {
                    this.errorObj.emailErr.push('Email Không Hợp Lệ');
                }
            }

            // Pass validate
            if (!this.registerObj.pass) {
                this.errorObj.passErr.push('Mật Khẩu Không Được Bỏ Trống');
            }
            else {
                if (!/[!@#$%^&*]/.test(this.registerObj.pass)) {
                    this.errorObj.passErr.push('Mật khẩu phải chứa ít nhất 1 ký tự đặc biệt');
                }

                if (this.registerObj.pass.length < 8) {
                    this.errorObj.passErr.push('Mật khẩu phải nhiều hơn hoặc bằng 8 ký tự');
                }
            }

            // Confirm Pass validate
            if (!this.registerObj.confirm) {
                this.errorObj.confirmErr.push('Xác nhận mật khẩu là bắt buộc');
            }
            else {
                if (this.registerObj.pass !== this.registerObj.confirm) {
                    this.errorObj.confirmErr.push('Xác nhận mật khẩu phải trùng với mật khẩu');
                }
            }


            // Phone validate
            if (!this.registerObj.phone) {
                this.errorObj.phoneErr.push('Số Điện Thoại Không Được Bỏ Trống');
            }
            else {
                if (!this.registerObj.phone.startsWith('0')) {
                    this.errorObj.phoneErr.push('Số Điện Thoại Không Hợp Lệ');
                }

                if (this.registerObj.phone.length != 10) {
                    this.errorObj.phoneErr.push('Số điện thoại phải có chính xác 10 chữ số');
                }

                if (!/[0-9]{11}/.test(this.registerObj.phone)) {
                    this.errorObj.phoneErr.push('Số điện thoại chỉ có thể chứa số');
                }
            }

            
        },

        async handleSubmit(e) {
            this.checkForm();

            if (!this.checkEmptyErr()) {
                e.preventDefault();
            } else {
                e.preventDefault();
                await this.getMatchUser(this.registerObj.email);
                if (this.matchUser) {
                    this.errorObj.emailErr.push("Account already exist")
                }
                else {
                    let data = {
                        user_name: this.registerObj.name,
                        user_email: this.registerObj.email,
                        user_phone: this.registerObj.phone,
                        user_password: this.registerObj.pass,
                        user_address: this.registerObj.address,
                        user_img: 'user.jpg',
                        user_status: 'active',
                    }
                    await axios.post("/users/", data);
                    this.$router.push("/login");
                }
            }
        }
    },

};
</script>


<style scoped>
.register-container {
    padding: 2rem 9%;
}

.register-container .register-form-container form {
    position: relative;
    left: 50%;
    transform: translate(-50%, 0%);
    max-width: 70rem;
    width: 100%;
    background: #ffb3cc; 
    opacity: 0.8;
    box-shadow: 0 1rem 1rem rgba(0, 0, 0, 0.05);
    border: 0.1rem solid rgba(0, 0, 0, 0.2);
    padding: 2rem;
    border-radius: 15px;
    animation: fadeUp 0.4s linear;
}

.register-container .register-form-container form h3 {
    padding-bottom: 1rem;
    font-size: 2rem;
    text-transform: uppercase;
    color: #130f40;
    margin: 0;
}

.register-container .register-form-container form .form-control {
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

.register-container .register-form-container form label {
    font-size: 2rem;
    margin: 0;
    padding: 0;
}

.register-container .register-form-container form span {
    font-size: 18px;
    padding-left: 5px;
    padding-right: 40px;
}

.register-container .register-form-container form .btn {
    margin: 1rem 0;
    width: 100%;
    text-align: center;
}

.register-container .register-form-container form p {
    padding-top: 1rem;
    font-size: 1.5rem;
    color: #fff9fa;
    margin: 0;
}

.register-container .register-form-container form p a {
    color: #ff69b4;
}

.register-container .register-form-container form p a:hover {
    color: #130f40;
    text-decoration: underline;
}

.register-container .register-form-container form .form-group {
    margin: 0;
}

.register-container .register-form-container form .form-group .error-mess {
    font-size: 1.5rem;
    position: relative;
    color: #17a2b8;
    margin: 0;
    padding: 0;
}
</style>
