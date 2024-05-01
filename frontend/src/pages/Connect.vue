<template>
  <div class="home-container row justify-content-center">
    <div class="col-md-6 pt-5">
      <div class="pr-5 pt-5 pl-5">
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
            </div> 
            <br>    
        </div>
      </div>
    </div>
  </div>
</template>

<script>

import axios from "axios";
export default {
  name: "Connect",
  data() {
    return {
      postList: [],
    }
  },

  created() {
      this.getAllPost()
  },

  methods: {
    async getAllPost(){
      try {
          let rsp = await axios.get(`/post`);
          this.postList = rsp.data.map(post => ({
              post_user_avt: post.user_avt,
              post_user_name: post.user_name,
              post_when : post.post_when,
              post_cap : post.caption,
              post_info : post.info,
              post_img : post.image,
          }));
      } catch (error) {
          console.error('Error while fetching bill info:', error);
      }
    },
  }
}
</script>

<style>
.home-container {
  background-color: none;
  min-height: 97vh;
  width: 100%;
  top: 77px;
}
</style>
