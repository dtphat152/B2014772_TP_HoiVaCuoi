<template>
    <div class="container_manager" style="width: 100%; padding-left: 260px; padding-right: 10px;">
        <div class="row d-flex justify-content-between mt-5 ">
            <div class="col-2">
                <h1>Manager</h1>
            </div>
            <div class="col-5 input-group mb-3">
                <input type="text" class="form-control" v-model="productObj.name" placeholder="Search . . .">
                <div class="input-group-append">
                    <button class="btn " type="submit">Search</button>
                </div>
            </div>
            <div class="col-2">
                <router-link to='AddProduct'>
                    <h4 class="font-weight-bold text-success d-flex justify-content-lg-end">+ Add </h4>
                </router-link>
            </div>
            <div class="col-1"></div>
        </div>

        <br> 
        
        <hr style="background-color: #FFF0F5; height: 3px;">
                <div class="row d-flex justify-content-center">
                    <div class="btn-group btn-group-lg ">
                        <button type="button" class="btn but01 mx-1 rounded-lg" value="all" @click="filterProductBtn($event)">All</button>
                        <button type="button" class="btn but01 mx-1 rounded-lg" value="Khai Vị" @click="filterProductBtn($event)">Khai Vị</button>
                        <button type="button" class="btn but01 mx-1 rounded-lg" value="Món Chính" @click="filterProductBtn($event)">Món Chính</button>
                        <button type="button" class="btn but01 mx-1 rounded-lg" value="Tráng Miệng" @click="filterProductBtn($event)">Tráng Miệng</button>
                        <button type="button" class="btn but01 mx-1 rounded-lg" value="Rạp Che" @click="filterProductBtn($event)">Rạp Che</button>
                        <button type="button" class="btn but01 mx-1 rounded-lg" value="Sảnh Tiệc" @click="filterProductBtn($event)">Sảnh Tiệc</button>
                        <button type="button" class="btn but01 mx-1 rounded-lg" value="Ban Nhạc" @click="filterProductBtn($event)">Ban Nhạc</button>
                        <button type="button" class="btn but01 mx-1 rounded-lg" value="MC" @click="filterProductBtn($event)">MC</button>
                        <button type="button" class="btn but01 mx-1 rounded-lg" value="Gia Tiên" @click="filterProductBtn($event)">Gia Tiên</button>
                        <button type="button" class="btn but01 mx-1 rounded-lg" value="Sân Khấu" @click="filterProductBtn($event)">Sân Khấu</button>
                        <button type="button" class="btn but01 mx-1 rounded-lg" value="Mâm Quả" @click="filterProductBtn($event)">Mâm Quả</button>
                        <button type="button" class="btn but01 mx-1 rounded-lg" value="Xe Hoa" @click="filterProductBtn($event)">Xe Hoa</button>
                        <button type="button" class="btn but01 mx-1 rounded-lg" value="Áo Cưới" @click="filterProductBtn($event)">Áo Cưới</button>
                        <button type="button" class="btn but01 mx-1 rounded-lg" value="Trang Điểm" @click="filterProductBtn($event)">Trang Điểm</button>
                        <button type="button" class="btn but01 mx-1 rounded-lg" value="Ghi Hình" @click="filterProductBtn($event)">Ghi Hình</button>
                    </div>
                </div>
        <br>
                <div v-if="calculatePages > 1" class="row" style="margin-top: 30px;">
                    <div class=" col-2">
                        <button type="button" class="btn but01 fa fa-arrow-left" v-if="pageNum != 0" @click="previous()"> Back </button>
                        <button type="button" class="btn btn-light" v-else > Back </button>
                    </div>
                    <div class="col-10 text-right">
                        <button type="button" class="btn " v-if="pageNum != calculatePages - 1" @click="next()" >
                            Next <span class="fa fa-arrow-right"></span>
                        </button>
                        <button type="button" class="btn but01 btn-light" v-else > Next </button>
                    </div>
                    
                </div>
                
        <div v-for="(f, index) in currentPageItems" :key="index">
            <div class="row pt-5">
                <div class="col-2 image">
                    <img :src="require(`../assets/images/${f.product_src}`)" alt="" style="height: 100px; width: 150px;"/>
                </div>
                <div class="col-8 pl-5">
                    <h5>{{ f.product_category }}</h5>
                    <div class="d-flex justify-content-between">
                        <h3>{{ f.product_name }} </h3>
                        
                    </div>
                    
                        <div class="d-flex justify-content-between" >
                            <p style="padding-right: 30px;">{{ f.product_desc }}</p>
                            
                        </div>
                    <div class="">
                        {{ formatCurrency(f.product_price) }}
                        
                    </div>
                </div>
                <div class="col-2 d-flex justify-content-center mt-5 ">
                    <router-link :to="{ name:'EditProduct',params:{id: f.product_id} }">
                        <button class="btn-warning p-2 px-4 rounded-lg" @click="sendItem(index)">Edit</button>
                    </router-link>
                    <button class="btn-danger p-2 rounded-lg" style="height: fit-content;" @click="deleteItem(index)">Delete</button>
                </div>
            </div>
            <hr>
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
                this.previousCategoryClicked.target.style.background = "#17a2b8";
            }
            this.productObj.category = e.target.value;
            this.previousCategoryClicked = e;
            e.target.style.background = "#057835fa";
        },
        
        sendItem: function (index) {
            this.sendId = parseInt(this.currentPageItems[index].product_id);
        },

        deleteItem: function (index){
            axios.delete("products/"+`${this.currentPageItems[index].product_id}`);
            alert('Deleted!')
        },
    }
};
</script>

<style>
.but01 {
    background-color: #d35ea4;
    color: #fff;
    font-weight: bold;
}

h1 {
    font-weight: bold;
    color: #d35ea4;
}
</style>