<template>
    <aside class="sidebar">
      <div class="sidebar-header">
        <router-link to="/admin/adminHome">
          <h2 class="font-weight-bold" style="color: #d35ea4;">TP - Hỏi Cưới</h2>
          <h5 class="pt-2" style="color: #fff; font-weight: bold;">Admin Panel</h5>
        </router-link>
      </div>
      <div class="menu">
        
          <div class="row">  
            <button class="btn">
              <router-link to="/admin/dashboard"><h2>Dashboard</h2></router-link>
            </button>
          </div>
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
              <router-link to="/admin/order"><h2>Orders</h2></router-link>
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
    background-color: rgba(117, 0, 164, 0.38);
    opacity: 1;
    font-weight: bold;
    color: #fff;
    border-radius: 20px;
    margin: 10px 10px 10px 10px;
  }
  
  .sidebar-header {
    padding: 20px;
    text-align: center;
    margin: 5px 5px 20px 5px;
    border-radius: 10px;
    background-color: #4d004d;
    
  }
  
  .memu li {
    background-color: #fff;
  }

  .menu .btn {
    width: 100%;
    margin: 5px 20px;
    background-color: #660066;
    border-radius: 10px 0px;
    color: #fff !important;
  }

  .menu .btn h2{ 
    color: #990099; font-weight: bold;
  }

  .router-link-exact-active h2 {
    color: #d35ea4 !important;
    transform: scale(1.2);
}

  </style>
  