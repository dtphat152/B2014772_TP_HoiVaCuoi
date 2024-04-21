<template>
    <div class="background">
      <Sidebar /> <!-- Component for the menu -->
      <div class="content">
        <router-view /> 

        <div class="pt-4">
          <div class="p-5 mr-3 row d-flex justify-content-between" style="border-radius: 20px; background-color: #ffe6ee; opacity: 1;">
            <h1>Admin Panel</h1>
          </div>
          <br>
          <div class="p-5 mr-5" style="border-radius: 20px; background-color: #ffe6ee; opacity: 1; height: 770px;"> 
            <h1 class="text-center" style="padding-top: 180px; font-size: 200px; opacity: 0.6;">TP</h1>
            <h1 class="text-center" style="font-size: 200px; opacity: 0.6;">Hỏi Và Cưới</h1>
          </div>
        </div>

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
  /* background-image: url('D:\Luan_Van\TP_HoiVaCuoi\frontend\src\assets\images\bg.jpg'); Đường dẫn của hình ảnh */
  background-size: cover; /* Hiển thị hình ảnh sao cho nó bao phủ hoàn toàn phần nền */
  background-position: center; /* Canh chỉnh hình ảnh giữa trang */
  height: 100vh; /* Đảm bảo chiều cao của hình ảnh bằng với kích thước của trang */
}

.content {
    padding-left: 250px; /* Đảm bảo nội dung không bị chồng lên phần Sidebar */
    padding-top: 0px;
    margin-top: 0px;
}

h1 {
    font-weight: bold;
    color: #ff69b4;
    font-weight: 900 !important;
}
</style>