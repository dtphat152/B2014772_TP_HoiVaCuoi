<template>
    <aside class="sidebar">
      <div class="sidebar-header">
        <router-link to="/admin/adminHome">
          <h2 class="font-weight-bold">TP - Hỏi và Cưới</h2>
          <h5 class="pt-2">Admin Panel</h5>
        </router-link>
      </div>
      <div class="sidebar-menu">
        <ul>
          <li><router-link to="/admin/dashboard"><h2>Dashboard</h2></router-link></li>
          <li><router-link to="/admin/productmanager"><h2>Product</h2></router-link></li>
          <li><router-link to="/admin/combomanager"><h2>Combo</h2></router-link></li>
          <li><router-link to="/admin/order"><h2>Orders</h2></router-link></li>
        </ul>
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
    width: 250px;
    height: 100vh; /* Đặt chiều cao là 100% của viewport */
    position: fixed; /* Giữ sidebar cố định trong trang */
    top: 0; /* Vị trí bắt đầu từ đỉnh trang */
    left: 0; /* Vị trí bắt đầu từ bên trái của trang */
    background-color: #e085a3;
    color: #fff;
  }
  
  .sidebar-header {
    padding: 20px;
    text-align: center;
    background-color: #db7093;
  }
  
  .sidebar-menu ul {
    list-style: none;
    padding: 0;
    margin-left: 10px;
  }
  
  .sidebar-menu ul li {
    padding: 10px 20px;
    border-bottom: 1px solid #d2b9b9;
  }
  
  .sidebar-menu ul li a {
    color: #faebf0;
    font-weight: bold;
    text-decoration: none;
  }
  </style>
  