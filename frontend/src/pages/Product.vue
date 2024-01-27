<template>
    <div class="sticky-top" style="background-color: white;top: 60px;">
        
        <div class="input-group" style="width: fit-content; margin: 0 auto;">
                    <input type="text" class="form-control" v-model="productObj.name" style="" placeholder="Search . . .">
                    <div class="input-group-append">
                        <button class="btn border" style="background-color: ; height: 25px;" type="submit">Go</button>
                    </div>
        </div>
        <br>
        <div class="heading" style="background-color: #FFF0F5;">
            <br>
            
            <div class="row d-flex">
                <div class="col-10 offset-1 btn-group btn-group-lg pl-4">
                        <button type="button" class="btn rounded-lg mx-1 " value="all" @click="filterProductBtn($event)">Trang Chính</button>
                        <button type="button" class="btn rounded-lg mx-1 " value="Khai Vị" @click="filterProductBtn($event)">Khai Vị</button>
                        <button type="button" class="btn rounded-lg mx-1 " value="Món Chính" @click="filterProductBtn($event)">Món Chính</button>
                        <button type="button" class="btn rounded-lg mx-1 " value="Tráng Miệng" @click="filterProductBtn($event)">Tráng Miệng</button>
                        <button type="button" class="btn rounded-lg mx-1 " value="Rạp Che" @click="filterProductBtn($event)">Rạp Che</button>
                        <button type="button" class="btn rounded-lg mx-1 " value="Sảnh Tiệc" @click="filterProductBtn($event)">Sảnh Tiệc</button>
                        <button type="button" class="btn rounded-lg mx-1 " value="Sân Khấu" @click="filterProductBtn($event)">Sân Khấu</button>
                        <button type="button" class="btn rounded-lg mx-1 " value="Gia Tiên" @click="filterProductBtn($event)">Gia Tiên</button>
                        <button type="button" class="btn rounded-lg mx-1 " value="Mâm Quả" @click="filterProductBtn($event)">Mâm Quả</button>
                        <button type="button" class="btn rounded-lg mx-1 " value="Xe Hoa" @click="filterProductBtn($event)">Xe Hoa</button>
                        <button type="button" class="btn rounded-lg mx-1 " value="Áo Cưới" @click="filterProductBtn($event)">Áo Cưới</button>
                        <button type="button" class="btn rounded-lg mx-1 " value="" @click="filterProductBtn($event)">Vest Cưới</button>
                        <button type="button" class="btn rounded-lg mx-1 " value="" @click="filterProductBtn($event)">Áo Dài</button>
                        <button type="button" class="btn rounded-lg mx-1 " value="" @click="filterProductBtn($event)">Khác</button>
                    </div>
            </div>     
        </div>
    </div>

    <div v-if="filterProducts.length == numberOfProducts" class="col -4 offset-0">
        <Date></Date>
        <br>
        <Guest></Guest>
    </div>
    <div class="sticky-top mt-5" style="top: 165px; z-index: 90; background-color: white;">
        <h1 style="text-align: center; margin-bottom: 0px; color: #ef87aa; font-weight:bold">Dịch Vụ</h1>
        <div v-if="calculatePages > 1" class="row pagebtn">
                <div class="offset-1 col-1">
                    <button type="button" class="btn fa fa-arrow-left" style="background-color: #FFF0F5;" v-if="pageNum != 0" @click="previous()"> Back </button>
                    <button type="button" class="btn btn-light" v-else > Back </button>
                </div>
                <div class="col-8">

                </div>
                <div class="col-1 text-right">
                    <button type="button" class="btn" style="background-color: #FFF0F5;" v-if="pageNum != calculatePages - 1" @click="next()" >
                        Next <span class="fa fa-arrow-right"></span> </button>
                    <button type="button" class="btn btn-light" v-else > Next </button>
            </div>
        </div>
    </div>

        <div class="row">
            <div class="col-sm-10 offset-1 mt-5 border-header">
                <div class="row">

                </div>
                <br> <br>
                    <div class="row box-container">
            
                        <div class="col-md-3 pl-3 pr-3"
                            v-for="(f, index) in currentPageItems" :key="index"
                        >
                                <div class="card mb-5" @click="showItem(index)">
                                    <div class="row card__title">
                                        <div class="col-2 mr-2 btn" style="background-color: #FF66CC;" >
                                        </div>
                                        <div class="col-9 text-lg-right pr-0"><h4>{{ f.product_name }}</h4></div>
                                    </div>
                                    <div class="card__body d-flex justify-content-center">
                                        <img :src="require(`../assets/images/${f.product_src}`)" style="height: 200px; width: 300px;"/>
                                        
                                    </div>
                                    <div class="card__footer">
                                        <div class="recommend">
                                        <p>Price: </p>
                                        <h4>{{f.product_price}} vnd</h4>
                                        </div>
                                        <div class="action">
                                            <button type="button">Details</button>
                                        </div>
                                    </div>
                                </div>
                        </div>
                        

                        <div v-if="!filterProducts.length" class="col -4 offset-0">
                            <div class="box text-center">
                                <div class="image">
                                    <img src="../assets/images/notfound.jpg" alt="" />
                                </div>
                                <div class="content">
                                    <h1 style="color: #17a2b8;">No Product!</h1>
                                </div>
                            </div>
                        </div>
                    </div>
                <br>
                    
                <QuickView v-if="showQuickView" :product="sendId">
                    <button class="btn" @click="closeView">X</button>
                </QuickView>
            </div>
        </div>
    
</template>

<script>
import Date from "@/components/Date.vue"
import Guest from "@/components/Guest.vue"
import QuickView from "@/components/QuickView.vue";
import { mapState } from "vuex";
export default {
    name: "Menu",

    data() {
        return {
            productObj: { name: "", category: "", price: ""},

            showQuickView: false,
            sendId: null,

            perPage: 8,
            pageNum: 0,
            previousCategoryClicked: "",
            
        };
    },

    created() {
        this.$store.dispatch('autoUpdateProductsData'); // Gọi action để bắt đầu cập nhật tự động
    },

    computed: {
        ...mapState(["allProducts"]),

        numberOfProducts() {
            // Sử dụng property length của mảng để lấy số lượng sản phẩm
            return this.allProducts.length;
        },
        filterProducts: function () {
            return this.allProducts.filter( (f) => f.product_name.toLowerCase().match(this.productObj.name.toLowerCase()) &&
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
        set(val) {
            this.pageNum = val;
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
                this.previousCategoryClicked.target.style.color = "#000000";
            }
            this.productObj.category = e.target.value;
            this.previousCategoryClicked = e;
            e.target.style.color = "#FF0099";
        },
        
        
        showItem: function (index) {
            this.sendId = parseInt(this.currentPageItems[index].product_id);
            this.showQuickView = !this.showQuickView;
        },

        closeView: function () {
            this.showQuickView = !this.showQuickView;
        },
    },
    components: { QuickView , Date , Guest}
};
</script>

<style>
    * {
        text-transform: none !important;
    }

    .card{
        border-radius: 15px;
    }

    .border-header{
        border: 5px solid transparent; 
        border-image: linear-gradient(to right, #FFF0F5 0%, #FFF0F5 40%, transparent 40%, transparent 60%, #FFF0F5 60%, #FFF0F5 100%) 2 0 0 0;
    }

    .pagebtn {
        button{
            cursor: pointer;
            border: 1px solid #d52ea0;
            padding: 5px 30px;
            border-radius: 200px;
            color: #000000;
            font-weight: 600;
            font-size: 13px;
            transition: 200ms;
            
            &:hover{
            background: #fff;
            color: #FF0099;
            }
        }
        
    }

    .card{
    box-shadow: 0 6px 6px rgba(#000, 0.3);
    transition: 200ms;
    background: #fff;
    
    .card__title{
        display: flex;
        align-items: center;
        padding: 30px 40px;
        
        h4{
        flex: 0 1 200px;
        text-align: right;
        margin: 0;
        color: #252525;
        font-family: sans-serif;
        font-weight: 600;
        text-transform: uppercase;
        }
        
        .icon{
        flex: 1 0 10px;
        padding: 10px 10px;
        transition: 200ms;
        }
    }
    
    .card__body{
        padding: 0 40px;
        display: flex;
        flex-flow: row no-wrap;
        margin-bottom: 25px;
    }
    
    .card__footer{
        padding: 30px 40px;
        display: flex;
        flex-flow: row no-wrap;
        align-items: center;
        position: relative;
        
        &::before{
        content: "";
        position: absolute;
        display: block;
        top: 0;
        left: 40px;
        width: calc(100% - 40px);
        height: 3px;
        background: #115dd8;
        background: linear-gradient(to right, #FF0099 0%,#FF0099 20%,#ddd 20%,#ddd 100%);
        }
        
        .recommend{
        flex: 1 0 10px;
        
        p{
            margin: 0;
            font-family: "Montserrat", sans-serif;
            text-transform: uppercase;
            font-weight: 600;
            font-size: 14px;
            color: #555;
        }
        
        h4{
            margin: 0;
            font-size: 20px;
            font-family: "Montserrat", sans-serif;
            font-weight: 600;
            text-transform: uppercase;
            color: #FF0099;
        }
        }
        
        .action{
        button{
            cursor: pointer;
            border: 1px solid #FFF0F5;
            padding: 14px 30px;
            border-radius: 200px;
            color: #000000;
            background: #FFF0F5;
            font-weight: 600;
            font-family: "Open Sans", sans-serif;
            font-size: 16px;
            transition: 200ms;
            
            &:hover{
            background: #fff;
            color: #FF0099;
            }
        }
        }
    }
    }
</style>
