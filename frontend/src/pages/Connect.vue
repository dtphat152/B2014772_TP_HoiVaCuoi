<template>
  <vue-basic-alert :duration="300" :closeIn="2000" ref="alert" />
  
  <div class="home-container row justify-content-center">
    <div class="col-md-6 pt-5">
      <div class="pr-5 pt-5 pl-5">
        <div v-for="(p, index) in postList.slice().reverse()" :key="index">
            <div class="PostCard p-3 mt-3" style="background-color: #f2f2f2; border-radius: 20px;">
                <div class="row">
                    <div class="col-1" style="padding-left: 0 !important; margin-left: 20px;">
                        <img :src="p.post_user_avt" :style="{ width: '100%', heigth : '100%','border-radius': '50px',border: '5px solid #ffb3cc'}"/>
                    </div>
                    <div class="col-9 pt-1" style="padding-left: 0 !important;">
                        <h1 style="font-weight: 800;">{{ p.post_user_name }}</h1>
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
                <br>
                <div class="row">
                    <div class="col-12 px-5">
                      <i class="fa-solid fa-heart" :style="{'color' : p.post_check_love==1? '#ff99bb' : '#808080', fontSize : '35px'}" @click="love(p.post_id,p.post_check_love,index)"></i>
                      <i class="fa-solid fa-comment ml-4" :style="{'color' : this.comment[index]==true? '#ff99bb' : '#808080', fontSize : '35px'}" @click="seclectComment(index)"></i>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 px-5 pt-2">
                        <h5 style="font-weight: bold;">{{ p.post_total_love }} Yêu thích  {{ p.post_total_comment }} Bình luận</h5>
                    </div>
                    <div v-if="this.comment[index]==true" class="col-12 px-5 pt-2">
                      <div style="overflow-y: auto; max-height: 300px;">
                        <div style="width: 90%; margin-left: 5%;">
                          <div v-for="(c, i) in commentList[this.postList.length-index-1]" :key="i">
                            <div class="row mb-3">
                              <div class="col-2 text-right">
                                <img :src="c.user_avt" :style="{ width: '48.28px', heigth : '48.28px !important','border-radius': '50px',border: '5px solid #999999'}"/>
                              </div>
                              <div class="col-8" style="background-color: #e6e6e6; border-radius: 15px;">
                                  <div class="row">
                                    <div class="col-12"><h3 style="font-weight: 900;">{{ c.user_name }}</h3></div>
                                  </div>
                                  <div class="row">
                                    <div class="col-12"><h4 style="font-weight: bold;">{{ c.cm_content }} </h4></div>
                                  </div>
                              </div>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col-10 offset-1" style="padding-left: 0px !important;">
                              <div class="row">
                                <textarea name="" id="" style="background-color: #e6e6e6; border-radius: 15px; width: 82%; font-weight: 800; font-size: 15px; height: 40px; padding: 5px;"
                                  v-model="this.contentCmt"></textarea> 
                                <button class="btn" @click="sendCmt(p.post_id,index,i)" 
                                  style="background-color: #e6e6e6; border-radius: 15px; width: 10%; font-weight: 800; font-size: 15px; color: #ff99bb;">Gửi</button>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
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
import { mapState } from "vuex";
import axios from "axios";
import VueBasicAlert from 'vue-basic-alert';
export default {
  name: "Connect",
  data() {
    return {
      postList: [],
      commentList: [],
      comment: [],
      contentCmt: '',
    }
  },

  created() {
      this.getAllPost()
  },

  computed: {
    ...mapState(["user"]),
  },
  
  methods: {

    async getAllPost(){
      if (this.user){
        try {
          let rsp = await axios.get(`/post`);
          for (const post of rsp.data) {
            let loveRsp = await axios.get(`/love/${post.post_id}`);
            console.log("this.user.user_id: ",this.user.user_id)
            let total_love = loveRsp.data.total_love;
            let checkLoveRsp = await axios.get(`/love/check/${post.post_id}/${this.user.user_id}`)
            let checkLove = checkLoveRsp.data.check_love;

            let comment = await axios.get(`/comment/${post.post_id}`)
            this.commentList.push(comment.data);
            let cmtRsp = await axios.get(`/comment/total/${post.post_id}`);
            let total_comment = cmtRsp.data.total_comment;
            this.postList.push({
                post_id: post.post_id,
                post_user_avt: post.user_avt,
                post_user_name: post.user_name,
                post_when : post.post_when,
                post_cap : post.caption,
                post_info : post.info,
                post_img : post.image,
                post_total_love: total_love,
                post_check_love: checkLove,
                post_total_comment: total_comment
            });
            this.comment.push(false);
          }
          console.log(this.postList)
        } catch (error) {
            console.error('Error while fetching post:', error);
        }
      } else {
        try {
          let rsp = await axios.get(`/post`);
          for (const post of rsp.data) {
            let loveRsp = await axios.get(`/love/${post.post_id}`);
            let total_love = loveRsp.data.total_love;
            let comment = await axios.get(`/comment/${post.post_id}`)
            this.commentList.push(comment.data);
            let cmtRsp = await axios.get(`/comment/total/${post.post_id}`);
            let total_comment = cmtRsp.data.total_comment;
            this.postList.push({
                post_id: post.post_id,
                post_user_avt: post.user_avt,
                post_user_name: post.user_name,
                post_when : post.post_when,
                post_cap : post.caption,
                post_info : post.info,
                post_img : post.image,
                post_total_love: total_love,
                post_total_comment: total_comment
            });
            this.comment.push(false);
          }
          console.log(this.postList)
        } catch (error) {
            console.error('Error while fetching post:', error);
        }
      }
    },

    async love(post_id,check,index){
      if (this.user){
        if (check==0) {
          let data = {
            post_id : post_id,
            user_id : this.user.user_id
          }
          try {
            await axios.post(`/love`,data);
            this.postList[this.postList.length-index-1].post_check_love = 1;
            this.postList[this.postList.length-index-1].post_total_love = this.postList[this.postList.length-index-1].post_total_love + 1;
          } catch (error) {
            console.error("Error ",error)
          }
        } else {
          try {
            await axios.delete(`/love/${post_id}/${this.user.user_id}`);
            this.postList[this.postList.length-index-1].post_check_love = 0;
            this.postList[this.postList.length-index-1].post_total_love = this.postList[this.postList.length-index-1].post_total_love - 1;
          } catch (error) {
            console.error("Error ",error)
          }
        }
      } else this.$refs.alert.showAlert('warning', 'Xin lỗi!', 'Bạn chưa đăng nhập!')
    },

    seclectComment(index){
      this.comment[index] = !this.comment[index];
    },
    async sendCmt(p_id,index){
      if(this.user && this.contentCmt!=''){
        let data = {
          post_id: p_id,
          user_id: this.user.user_id,
          cm_content: this.contentCmt
        }
        try {
          await axios.post(`/comment`,data)
          let temp = {
            user_name: this.user.user_name,
            user_avt: this.user.user_avt,
            cm_content: this.contentCmt
          }
          this.commentList[this.postList.length-index-1].push(temp)
          // console.log(this.commentList[this.postList.length-index-1]);
          this.$refs.alert.showAlert('success', 'Thành công!', 'Cám ơn bạn đã bình luận!')
          this.contentCmt='';
        } catch (error) {
          console.error("Error ",error)
        }
      } else this.$refs.alert.showAlert('warning', 'Xin lỗi!', 'Hãy thử lại!')
    },
  },

  components: {
      VueBasicAlert
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
