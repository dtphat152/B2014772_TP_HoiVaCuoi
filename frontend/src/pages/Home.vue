<template>
    <vue-basic-alert :duration="300" :closeIn="4000" ref="alert" />
    <br><br><br><br><br><br><br>
     <div style="text-align: center;">
        <div class="container createpost">
            <button @click="toggleContainer" style="background-color: #FFF0F5; width: 100%; font-weight: bold;">Create</button>
        </div>
            <div v-if="showContainer" class="container" style="text-align: center;">
                <!-- Form for posting with file input -->
                <form @submit.prevent="submitPost">
                    <div>
                        <label class="font-weight-bold" for="postDescription">Mô tả:</label>
                        <!-- <textarea id="postDescription" v-model="postDescription"></textarea> -->
                        <textarea class="form-control" placeholder="Cảm nghĩ của bạn như thế nào? " 
                            style="width: 100%; height: 100px;"  v-model="postDescription" ></textarea>
                    </div>
                    <br>
                    <div>
                        <label class="font-weight-bold" for="postImages">Chọn hình ảnh:</label>
                        <br>
                        <input type="file" id="postImages" @change="handleFilesChange" multiple accept="image/*" />

                        <div v-if="selectedImages.length > 0">
                            <div v-for="(image, index) in selectedImages" :key="index">
                            <img :src="image" alt="Selected Image" style="max-width: 150px; max-height: 150px; margin-right: 10px; margin-top: 10px;" />
                            <button type="button" @click="deleteImage(index)">Xóa ảnh</button>
                            </div>
                        </div>
                    </div>
                    <br><hr>
                    <button class="btnContactSubmit" type="submit">Đăng bài</button>
                </form>
            </div>
        
    </div>
</template>

<script>
import VueBasicAlert from 'vue-basic-alert';
import axios from "axios";
import { mapState } from "vuex";
export default {
    name: "Home",

    data() {
        return {
            showContainer: false,
            selectedImages: [],
            postDescription: '',
        };
    },

    computed: {
          ...mapState(["user"]),

    },

    methods: {
        scrollToTop() {
            window.scrollTo(0, 0);
        },

        toggleContainer() {
            if (this.user) {
                this.showContainer = !this.showContainer;
            } else {
                this.$refs.alert.showAlert('warning', 'Sorry!', 'Login now to use this method!');
            }
        },

        handleFilesChange(event) {
            // Get the selected files
            const files = event.target.files;

            if (files.length > 0) {
                // Read the first file as data URL
                const reader = new FileReader();
                reader.onload = () => {
                this.selectedImages.push(reader.result);
                // Trigger reactivity
                this.selectedImages = [...this.selectedImages];
                };
                reader.readAsDataURL(files[0]);
            }
        },

        deleteImage(index) {
            this.selectedImages.splice(index, 1);
        },

        async sendPostID(PostID) {
            let postImage = {
                post_id: parseInt(PostID),
                image_url: this.selectedImages,
            }
            await axios.post("/postimage", postImage);
        },

        async submitPost() {
            // Send data to the server (e.g., using Axios)
            const postData = {
                user_id: parseInt(this.user.user_id),
                caption: this.postDescription,
                likes: 0,
            };

            let PostID = (await axios.get("/post/new")).data;
                if (PostID == "") {
                    PostID = 1
                } else {
                    PostID = parseInt(PostID.post_id) + 1
                }
          
            this.sendPostID(PostID);

            // Add your logic to send postData to the server
            console.log('Post data:', postData);
            try {
                await axios.post("/post", postData);
                this.$refs.alert.showAlert('success', 'Success!', 'Posted!');
            } catch (error) {
                console.error('Error submitting post:', error);
                this.$refs.alert.showAlert('error', 'Error!', 'An error occurred while submitting the post.');
            }

            // Reset form fields after submission
            this.selectedImages = [];
            this.postDescription = '';
        },
        
    },

    components: {
      VueBasicAlert
    }
};
</script>

<style scoped>

.createpost{
    width: 800px;
    background-color: #FFF0F5;
}

.btnContactSubmit
{
    width: 50%;
    border-radius: 1rem;
    padding: 1.5%;
    color: #000000;
    background-color: #FFF0F5;
    border: none;
    cursor: pointer;
}
</style>

