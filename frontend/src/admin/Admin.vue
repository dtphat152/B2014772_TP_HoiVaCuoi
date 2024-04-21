<template>
    <div class="admin-container">
        <div class="admin-form-container">
            <form id="adminForm" @submit="handleSubmit" novalidate autocomplete="off">
                <h3>ADMIN</h3>

                <div v-if="errors.length" class="error-box">
                    <ul>
                        <li v-for="error in errors" :key="error">{{ error }}</li>
                    </ul>
                </div>
                <div class="form-group">
                    <input type="text" id="adminKey" name="adminKey" class="form-control"
                        placeholder="enter admin user name" v-model="adminObj.name" />
                </div>
                <div class="form-group">
                    <input type="password" id="uPass" name="uPass" class="form-control"
                        placeholder="enter admin password" v-model="adminObj.pass" />
                </div>

                <div class="form-group">
                    <input type="submit" value="admin access" class="btn" style="background-color: #FFC0CB; color: black; border-radius: 10px;">
                </div>
            </form>
        </div>
    </div>
</template>


<script>
import { mapMutations } from "vuex";
export default {
    name: 'Admin',

    data() {
        return {
            adminObj: { name:"", pass: "" },
            keyname: "p",
            keypass: "p",
            errors: [],
        }
    },

    methods: {
        ...mapMutations(["setAdmin"]),

        handleSubmit(e) {
            this.errors = [];
            if (!this.adminObj.pass) {
                this.errors.push('Password is required');
            }

            if (!this.errors.length == 0) {
                e.preventDefault();
            }
            else {
                e.preventDefault();
                if (this.adminObj.pass === this.keypass && this.adminObj.name === this.keyname) {
                    this.setAdmin("admin");
                    this.$router.push("/admin/adminHome");
                }
                else {
                    this.errors.push("Admin password wrong!")
                }

            }
        }
    }
}
</script>

<style scoped>
.admin-container {
    padding: 2rem 9%;
}

.admin-container .admin-form-container {
    height: 50vh;
}

.admin-container .admin-form-container form {
    background: #ffb6c1; 
    opacity: 0.8;
    position: absolute;
    top: 30%;
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

.admin-container .admin-form-container form h3 {
    padding-bottom: 1rem;
    font-size: 2rem;
    font-weight: bolder;
    text-transform: uppercase;
    color: #130f40;
    margin: 0;
}

.admin-container .admin-form-container form .form-control {
    margin: .7rem 0;
    border-radius: .5rem;
    background: rgba(0, 0, 0, 0.3);
    padding: 2rem 1.2rem;
    font-size: 1.6rem;
    color: #130f40;
    text-transform: none;
    width: 100%;
    border: none;
}

.admin-container .admin-form-container form .btn {
    margin-bottom: 1rem;
    margin-top: 1rem;
    width: 100%;
}

.admin-container .admin-form-container form p {
    padding-top: 1rem;
    font-size: 1.5rem;
    color: #666;
    margin: 0;
}

.admin-container .admin-form-container form p a {
    color: #27ae60;
}

.admin-container .admin-form-container form p a:hover {
    color: #130f40;
    text-decoration: underline;
}

.admin-container .admin-form-container form .error-box {
    background-color: #fff9fa;
    box-sizing: border-box;
    border: 2px solid rgba(255, 66, 79, .2);
    border-radius: 2px;
    font-size: 12px;
    margin-bottom: 20px;
}

.admin-container .admin-form-container form .error-box ul {
    list-style-type: none;
    margin: 0;
    padding: 10px 0px;
}

.admin-container .admin-form-container form .error-box ul li {
    padding-left: 10px;
    color: rgb(182, 0, 0);
}
</style>