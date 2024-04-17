import { createWebHistory, createRouter } from "vue-router";
import Login from '../pages/Login.vue';
import Register from '../pages/Register.vue';
import ResetPassword from '../pages/ResetPassword.vue';
import Home from '../pages/Home.vue';
import About from '../pages/About.vue';
import Product from '../pages/Product.vue';
import Contact from '../pages/Contact.vue';
import Cart from '../pages/Cart.vue';
import Checkout from '../pages/Checkout.vue';
import Thank from '../pages/Thank.vue';
import MyOrder from '../pages/MyOrder.vue';
import Admin from '../admin/Admin.vue';
import AdminHome from '../admin/AdminHome.vue';
import Dashboard from '../admin/Dashboard.vue';
import ProductManager from '../admin/ProductManager.vue';
import Order from '../admin/Order.vue';
import ComboManager from "../admin/ComboManager.vue";
import AddProduct from '../admin/AddProduct.vue';
import AddTempProduct from '../admin/AddTempProduct.vue';
import AddCombo from '../admin/AddCombo.vue';
import EditProduct from '../admin/EditProduct.vue';
import EditCombo from '../admin/EditCombo.vue';
const routes = [
  {
    path: "/",
    name: "Home",
    component: Home, 
  },
  {
    path: "/about",
    name: "About",
    component: About,
  },
  {
    path: "/booking",
    name: "Product",
    component: Product,
  },
  {
    path: "/contact",
    name: "Contact",
    component: Contact,
  },
  {
    path: "/cart",
    name: "Cart",
    component: Cart,
  },
  {
    path: "/login",
    name: "Login",
    component: Login,
  },
  {
    path: '/resetpassword/:hash',
    name: 'ResetPassword',
    component: ResetPassword,
  },
  {
    path: "/register",
    name: "Register",
    component: Register,
  },
  {
    path: "/checkout",
    name: "Checkout",
    component: Checkout,
  },
  {
    path: "/thank",
    name: "Thank",
    component: Thank,
  },
  {
    path: "/myorder",
    name: "MyOrder",
    component: MyOrder,
  },
  {
    path: "/admin",
    name: "Admin",
    component: Admin,
  },
  {
    path: "/admin/adminHome",
    name: "AdminHome",
    component: AdminHome,
  },
  {
    path: "/admin/productmanager",
    name: "ProductManager",
    component: ProductManager,
  },
  {
    path: "/admin/dashboard",
    name: "Dashboard",
    component: Dashboard,
  },
  {
    path: "/admin/order",
    name: "Order",
    component: Order,
  },
  {
    path: "/admin/combomanager",
    name: "ComboManager",
    component: ComboManager,
  },
  {
    path: "/admin/addproduct",
    name: "AddProduct",
    component: AddProduct,
  },
  {
    path: "/admin/addtempproduct",
    name: "AddTempProduct",
    component: AddTempProduct,
  },
  {
    path: "/admin/addcombo",
    name: "AddCombo",
    component: AddCombo,
  },
  {
    path: "/admin/editproduct/:id",
    name: "EditProduct",
    component: EditProduct,
    props: true
  },
  {
    path: "/admin/editcombo/:id",
    name: "EditCombo",
    component: EditCombo,
    props: true
  },
  {
    path: '/:pathMatch(.*)*',
    component: Home,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;