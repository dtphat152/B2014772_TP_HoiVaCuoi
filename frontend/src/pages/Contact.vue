<template>
  <div class="home-container">
    <div class="text-center" style="overflow-y: auto; height: 600px; background-color: antiquewhite;">
      <div class="col-1" v-if="showFileInput">
        <i class="fa fa-camera-retro text-right pt-3" @click="openFileInput" style="font-size: 30px; color: #ffccdd;" aria-hidden="true"></i>
      </div>
      <input type="file" ref="fileInput" style="display: none;" @change="handleFileChange">
      <div class="row justify-content-center">
        <img v-if="images.length > 0" :src="images[0]" alt="Selected image" style="width: 300px;">
        <p v-else>Chưa có ảnh được chọn</p>
      </div>
      <button @click="uploadImages">Upload Images</button>
    </div>
  </div>
</template>

<script>


export default {
  name: "Contact",
  data() {
    return {
      images: [],
      showFileInput: true
    }
  },
  methods: {
    openFileInput() {
      this.$refs.fileInput.click();
    },
    handleFileChange() {
      const file = this.$refs.fileInput.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = () => {
          this.images = [reader.result];
        };
        reader.readAsDataURL(file);
      }
    },
    async uploadImages() {
      // Xử lý upload ảnh
    }
  }
}
</script>

<style>
.home-container {
  background-color: none;
  height: 97vh;
  width: 100%;
  top: 77px;
}
</style>
