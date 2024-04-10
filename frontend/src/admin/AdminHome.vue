<template>
    <div class="background">
      <Sidebar /> <!-- Component for the menu -->
      <div class="content">
        <router-view /> <!-- Component for displaying the content of child pages -->
      </div>
    </div>
  </template>
  
  <script>
  import Sidebar from './component/Sidebar.vue'; // Import the Sidebar component
  export default {
    name: 'AdminHome',

    components: {
      Sidebar
    }
  };
  </script>

<style scoped>
.background {
  background-image: url('D:\Luan_Van\TP_HoiVaCuoi\frontend\src\assets\images\bg.jpg'); /* Đường dẫn của hình ảnh */
  background-size: cover; /* Hiển thị hình ảnh sao cho nó bao phủ hoàn toàn phần nền */
  background-position: center; /* Canh chỉnh hình ảnh giữa trang */
  height: 100vh; /* Đảm bảo chiều cao của hình ảnh bằng với kích thước của trang */
}

.content {
    padding-left: 250px; /* Đảm bảo nội dung không bị chồng lên phần Sidebar */
    padding-top: 20px; /* Để giữ khoảng cách từ trên xuống */
}
</style>