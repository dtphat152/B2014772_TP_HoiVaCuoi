<template>
    <div class="container_order">
        <div class="row p-5" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; margin: 0 1px;">
            <h1>Posts Manager</h1>
        </div>
        <br>
        <div class="p-5" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; height: 785px;">  
           <div class="row justify-content-center">
                <div class="col-7">
                    <div class="pr-5 pl-5">
                        <div class="" style="overflow-y: auto; height: 730px; background-color: #f2f2f2; border-radius: 20px;">
                            <div style="width: 90%; margin-left: 4%;">
                                <div v-for="(p, index) in postList.slice().reverse()" :key="index">
                                    <div class="PostCard p-3 mt-3" style="background-color: #ffccdd; border-radius: 20px;">
                                        <div class="row">
                                            <div class="col-1 ml-4" style="padding-left: 0 !important;">
                                                <img :src="p.post_user_avt" :style="{ width: '100%', heigth : '100%','border-radius': '50px',border: '5px solid #ffb3cc'}"/>
                                            </div>
                                            <div class="col-9 pt-1" style="padding-left: 0 !important;">
                                                <h1 style="font-weight: 900;">{{ p.post_user_name }}</h1>
                                                <h5 style="font-weight: 800;">{{p.post_when}}</h5>
                                            </div>
                                            <div class="col-1 text-right pt-2">
                                                <i v-if="p.post_hide==0" @click="hidePost(postList.length-index-1)" class="fa fa-lock" aria-hidden="true" style="font-size: 25px;"></i>
                                                <i v-if="p.post_hide!=0" @click="hidePost(postList.length-index-1)" class="fa fa-unlock-alt" aria-hidden="true" style="font-size: 25px;"></i>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-12 px-5 py-1">
                                                <h3 style="font-weight: 800;">{{ p.post_cap }}</h3>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-12 px-5">
                                                <h4 style="font-weight: bold;">{{ p.post_info }}</h4>
                                            </div>
                                        </div>
                                        <div class="row" v-if="p.post_img!=''">
                                            <div class="col-12 px-5">
                                                <img :src="p.post_img" alt="Selected image" style="width: 100%; border-radius: 10px;">
                                            </div>
                                        </div>
                                        <br>
                                    </div>     
                                </div>
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
export default {
    name: 'PostsManager',

    data() {
        return {
            postList: [],
        }
    },

    created() {
        this.getAllPost()
    },

    watch: {
        
    },

    methods: {
        async getAllPost(){
            try {
                let rsp = await axios.get(`/post/admin`);
                this.postList = rsp.data.map(post => ({
                    post_id : post.post_id,
                    post_user_avt: post.user_avt,
                    post_user_name: post.user_name,
                    post_when : post.post_when,
                    post_cap : post.caption,
                    post_info : post.info,
                    post_img : post.image,
                    post_hide : post.hide,
                }));
            } catch (error) {
                console.error('Error while fetching bill info:', error);
            }
        },
        async hidePost(index){
            if(this.postList[index].post_hide == 0) {
                let data = {
                    caption: this.postList[index].post_cap,
                    hide: 2
                }
                await axios.put(`/post/${this.postList[index].post_id}`,data)
                this.postList[index].post_hide = 2
            } else {
                let data = {
                    caption: this.postList[index].post_cap,
                    hide: 0
                }
                await axios.put(`/post/${this.postList[index].post_id}`,data)
                this.postList[index].post_hide = 0
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