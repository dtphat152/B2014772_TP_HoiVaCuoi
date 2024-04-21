<template>
    <aside class="sidebar">
      <div class="sidebar-header">
        <router-link to="/admin/adminHome">
          <h2 class="font-weight-bold" style="color: #d35ea4;">TP - Hỏi Cưới</h2>
          <h5 class="pt-2" style="color: #fff; font-weight: bold;">Admin Panel</h5>
        </router-link>
      </div>
      <hr style="width: 80%; margin-left: 10%;">
      <br>
      <div class="menu">
          <div class="row">  
            <button class="btn">
              <router-link to="/admin/dashboard"><h2>Dashboard</h2></router-link>
            </button>
          </div>
          <div class="row">
            <button class="btn">
              <router-link to="/admin/order"><h2>Orders</h2></router-link>
            </button>
          </div>
      </div>
      <div class="menu2 mt-3">
        <div class="row">  
          <button class="btn">
            <router-link to="/admin/productmanager"><h2>Product</h2></router-link>
          </button>
        </div>
        <div class="row">
          <button class="btn">
            <router-link to="/admin/combomanager"><h2>Combo</h2></router-link>
          </button>
        </div>
        <div class="row">
          <button class="btn">
            <router-link to="/admin/usermanager"><h2>User</h2></router-link>
          </button>
        </div>
      </div>
    </aside>
  </template>
  
  <script>
  export default {
    name: 'Sidebar'
  };
  </script>
  
  <style scoped>
  .sidebar {
    width: 200px;
    height: 98vh; /* Đặt chiều cao là 100% của viewport */
    position: fixed; /* Giữ sidebar cố định trong trang */
    top: 0; /* Vị trí bắt đầu từ đỉnh trang */
    left: 0; /* Vị trí bắt đầu từ bên trái của trang */
    background-color: #f2f2f2;
    box-shadow: 0 1px 1px #999999;
    opacity: 1;
    font-weight: 900;
    color: #fff;
    border-radius: 20px;
    margin: 10px 10px 10px 10px;
  }
  
  .sidebar-header {
    padding: 20px;
    text-align: center;
    margin: 5px 5px 20px 5px;
    border-radius: 20px;
    background-color: #ffb3cc;
    
  }
  
  .menu {
    background-color: #d3d3d3;
    margin: 0px 10px;
    border-radius: 20px;
  }

  .menu .btn {
    padding: 5px;
    width: 100%;
    margin: 5px 20px;
    border-radius: 20px;
  }

  .menu .btn h2{ 
    color: white; font-weight: 900;
  }

  .menu2 {
    background-color: #d3d3d3;
    margin: 0px 10px;
    border-radius: 20px;
  }

  .menu2 .btn {
    padding: 5px;
    width: 100%;
    margin: 5px 20px;
    border-radius: 20px;
  }

  .menu2 .btn h2{ 
    color: white; font-weight: 900;
  }

  .router-link-exact-active h2 {
    color: #d35ea4 !important;
    transform: scale(1.2);
}

  </style>
  