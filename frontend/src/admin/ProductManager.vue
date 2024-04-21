<template>
    <div class="container_manager">
        <div class="row d-flex justify-content-between p-5 mx-1" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; ">
            <div class="col-3">
                <h1>Product Manager</h1>
            </div>
            <div class="col-6 input-group">
                <input style="border-radius: 10px; background-color: #ffb3cc;" type="text" class="form-control" v-model="productObj.name" placeholder="Search . . .">
                <div class="input-group-append">
                    <button class="btn ml-3 mb-2" type="submit" style="background-color: #ffb3cc; border-radius: 15px;"><i class="fa fa-search"></i></button>
                </div>
            </div>
            <div class="col-3">
                <router-link to='AddProduct'>
                    <h4 class="font-weight-bold text-success d-flex justify-content-lg-end">+ Add </h4>
                </router-link>
            </div>
            
        </div>

        <br> 
        
        <!-- <hr style="background-color: #FFF0F5; height: 3px;"> -->

        <div class="row d-flex mx-1 p-4" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999; ">
            <div class="col-10 offset-1 btn-group btn-group-lg pl-4">
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="all" @click="filterProductBtn($event)">Tất Cả</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Khai Vị" @click="filterProductBtn($event)">Khai Vị</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Món Chính" @click="filterProductBtn($event)">Món Chính</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Tráng Miệng" @click="filterProductBtn($event)">Tráng Miệng</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Rạp Che" @click="filterProductBtn($event)">Rạp Che</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Sảnh Tiệc" @click="filterProductBtn($event)">Sảnh Tiệc</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Sân Khấu" @click="filterProductBtn($event)">Sân Khấu</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Gia Tiên" @click="filterProductBtn($event)">Gia Tiên</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Mâm Quả" @click="filterProductBtn($event)">Mâm Quả</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Xe Hoa" @click="filterProductBtn($event)">Xe Hoa</button>
            </div>
        </div>   
        <br>

        <div class="p-5" style="border-radius: 20px; background-color: #f2f2f2;box-shadow: 0 1px 1px #999999;  height: 695px;">
            <div class="row pt-2 pagebtn">
                <div class="col-2 text-left">
                    <div v-if="calculatePages > 1"> 
                        <button v-if="pageNum != 0" @click="previous" style="background: none; border: none; ">
                            <span class="fa fa-chevron-circle-left" 
                                style="background-color: #ffe6ea; color: #990099; padding: 5px; border-radius: 10px;">
                            </span>
                        </button> 
                    </div>
                </div>
                <div class="col-2"></div>
                <div class="col-4 input-group mt-1"></div>
                <div class="col-2"></div>
                <div class="col-2 text-right">
                    <div v-if="calculatePages > 1"> 
                        <button v-if="pageNum != calculatePages - 1" @click="next" style="background: none; border: none; ">
                            <span class="fa fa-chevron-circle-right" 
                                style="background-color: #ffe6ea; color: #990099; padding: 5px; border-radius: 10px;">
                            </span>
                        </button> 
                    </div>
                </div>
            </div>
            <hr>
            <div style="overflow-y: auto; height: 580px;">
                <div style="width: 95%; margin-left: 2%;">
                    <div v-for="(f, index) in currentPageItems" :key="index">
                        <div class="row" style="background-color: #ffb3cc; box-shadow: 0 1px 1px #ff99bb; border-radius: 20px;">
                            <div class="col-2 pr-0">
                                <img :src="require(`../assets/images/${f.product_src}`)" alt="" 
                                 style="height: 100%; width: 150px; border-radius: 20px;"/>
                            </div>
                            <div class="col-8 pl-5">
                                <h5 style="font-weight: 900;">{{ f.product_category }}</h5>
                                <div class="d-flex justify-content-between">
                                    <h3 style="font-weight: 900;">{{ f.product_name }} </h3>
                                    
                                </div>
                                
                                    <div class="d-flex justify-content-between" >
                                        <h6 style="padding-right: 30px; font-weight: 700;">{{ f.product_desc }}</h6>
                                        
                                    </div>
                                <div class="">
                                    <h5 style="font-weight: 900;">{{ formatCurrency(f.product_price) }}</h5>
                                    
                                </div>
                            </div>
                            <div class="col-2 d-flex justify-content-center mt-5 ">
                                <router-link :to="{ name:'EditProduct',params:{id: f.product_id} }">
                                    <button class="btn-warning p-2 px-4 rounded-lg" @click="sendItem(index)">Edit</button>
                                </router-link>
                                <button class="btn-danger p-2 rounded-lg" style="height: fit-content;" @click="deleteItem(index,f.product_name)">Delete</button>
                            </div>
                        </div>
                        <hr>
                    </div>  
                </div>  
            </div>  
        </div>          
    </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
export default {
    name: "ProductManager",

    data() {
        return {
            productObj: { name: "", category: "", price: ""},
            sendId: null,
            perPage: 6,
            pageNum: 0,
            previousCategoryClicked: "",
            
        };
    },

    created() {
        this.$store.dispatch('autoUpdateProductsData'); // Gọi action để bắt đầu cập nhật tự động
    },

    computed: {
        ...mapState(["allProducts"]),
        
        filterProducts: function () {
            return this.allProducts.filter((f) => f.product_name.toLowerCase().match(this.productObj.name.toLowerCase()) &&
                (f.product_category.match(this.productObj.category) || this.productObj.category == "all" || this.productObj.category == ""))
        },
        currentPageItems: function () {
            return this.filterProducts.slice(this.pageNum * this.perPage, this.pageNum * this.perPage + this.perPage);
        },
        calculatePages: function () {
            if (this.filterProducts.length % this.perPage != 0) {
                return Math.floor((this.filterProducts.length) / this.perPage) + 1;
            }
            else {
                return this.filterProducts.length / this.perPage;
            }
        }        
    },

    methods: {
        formatCurrency(amount) {
          if (!amount) return '';
          return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
        },

        next() {
            this.pageNum++;
        },
        previous() {
            this.pageNum--;
        },

        filterProductBtn: function (e) {
            this.pageNum = 0;
            if (this.productObj.category != e.target.value && this.previousCategoryClicked != "") {
                this.previousCategoryClicked.target.style.color = "#948c8c";
            }
            this.productObj.category = e.target.value;
            this.previousCategoryClicked = e;
            e.target.style.color = "#FF0099";
        },
        
        sendItem: function (index) {
            this.sendId = parseInt(this.currentPageItems[index].product_id);
        },

        deleteItem: function (index,name){
            let confirm = window.confirm("Xóa "+name+"?")
            if (confirm){
                axios.delete("products/"+`${this.currentPageItems[index].product_id}`);
            }           
        },
    }
};
</script>

<style scoped>

    .but01 {
        background-color: #d35ea4;
        color: #fff;
        font-weight: bold;
    }

    h1 {
        font-weight: 900;
        color: #d35ea4;
    }

    .container_manager{
        margin-left: 220px; 
        margin-right: 20px; 
        margin-top: 10px;
        top: 0;
        height: 98vh;  
        opacity: 0.8;
        border-radius: 20px;
    }

    .btnheadingmennu{
        background-color: #ffb3cc;
        color: black; /* Màu chữ */
        font-weight: 900;
        padding: 15px 32px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 2px;
        cursor: pointer;
        box-shadow: 0 8px 6px -6px rgb(221, 141, 141);
        transition: transform 0.2s ease;
    }

    .btnheadingmennu:hover {
        transform: scale(1.5); /* Hoặc bất kỳ giá trị zoom nào bạn muốn */
        background-color: #ff99aa ;
    }

</style>