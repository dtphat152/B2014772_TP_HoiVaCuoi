<template>
    <vue-basic-alert :duration="300" :closeIn="2000" ref="alert" />
    <div class="py-4" style="background-color: #e6e6e6; width: 100%; border-radius: 15px; z-index: 90; box-shadow: 0 2px 2px #d9d9d9; 
        position: fixed; top: 66px;"> 
        <div class="row d-flex">
            <div class="col-10 offset-1 btn-group btn-group-lg pl-4">
                <button type="button" class="btn btnheadingmennu mx-1 " 
                :style="{color: timecolor}" style="border-radius: 10px; padding: 5px;" value="time" @click="filterProductBtn($event)">Thời Gian</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="combo" @click="filterProductBtn($event)">Combo</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="all" @click="filterProductBtn($event)">Tất Cả</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Khai Vị" @click="filterProductBtn($event)">Khai Vị</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Món Chính" @click="filterProductBtn($event)">Món Chính</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Tráng Miệng" @click="filterProductBtn($event)">Tráng Miệng</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Thức Uống" @click="filterProductBtn($event)">Thức Uống</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Bàn Ghế" @click="filterProductBtn($event)">Bàn Ghế</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Rạp Che" @click="filterProductBtn($event)">Rạp Che</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Cổng Hoa" @click="filterProductBtn($event)">Cổng Hoa</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Sảnh Tiệc" @click="filterProductBtn($event)">Sảnh Tiệc</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Gia Tiên" @click="filterProductBtn($event)">Gia Tiên</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Mâm Quả" @click="filterProductBtn($event)">Mâm Quả</button>
                <button type="button" class="btn btnheadingmennu mx-1 " style="border-radius: 10px; padding: 5px;" value="Xe Hoa" @click="filterProductBtn($event)">Xe Hoa</button>
            </div>
        </div>     
    </div>
    
    <div  v-if="this.productObj.category == 'time' && filterProducts.length==0  " 
        style="margin-top: 150px;">

        <div style="width: 60%; margin-left: 20%; background-color: #f2f2f2; opacity: 0.9; border-radius: 25px; box-shadow: 0 1px 1px #999999;">
        
            <div class="row">
                <div class="col-2 d-flex justify-content-end"></div>
                <div class="col-8"> 
                    <Date></Date>
                </div>
                <div class="col-2 d-flex justify-content-start"></div>
                <br>
            </div>
        </div>

        <div style="margin-top: 50px; width: 60%; margin-left: 20%; background-color: #f2f2f2; opacity: 0.9; border-radius: 25px;">
            <div class="row">
                <div class="col-2 d-flex justify-content-end"> </div>
                <div class="col-8">
                    <DateDetails></DateDetails>
                </div>
                <div class="col-2 d-flex justify-content-start"></div>
                <br>
            </div>
        </div>
    </div>

    <div v-if="this.productObj.category == 'combo' && filterProducts.length==0">
            <Combo></Combo>
    </div>
    
    <div v-if="this.productObj.category != 'time' && this.productObj.category != 'combo'" >
        <div class="sticky-top" style="top: 135px; z-index: 90; background-color: none; padding-top: 10px; padding-bottom: 10px; ">
            
            <div class="row d-flex justify-content-center">
                
            </div>
            <div class="row pt-2 pagebtn">
                <div class="offset-1 col-1">
                    <div v-if="calculatePages > 1"> 
                        <button v-if="pageNum != 0" @click="previous" style="background: none; border: none; ">
                            <span class="fa fa-chevron-circle-left" 
                                style="background-color: #b3b3b3; color: #f2f2f2; padding: 5px; border-radius: 10px;">
                            </span>
                        </button> 
                    </div>
                </div>
                <div class="col-2"></div>
                <div class="col-4 mt-1">
                    <div class="row" v-if="this.productObj.category=='all' || this.productObj.category=='Khai Vị' || this.productObj.category=='Món Chính' || this.productObj.category=='Tráng Miệng'">
                        <div class="col-7 offset-1 input-group">
                            <input type="text" style="border-radius: 15px; background-color: #b3b3b3; border: none; opacity: 0.8; color: black;" 
                                v-model="productObj.name" id="formControlLg" class="form-control form-control-lg" placeholder="Search . . ."/>
                            <div class="p-2 px-3 ml-3" type="submit" style="background-color: #b3b3b3; border: none; opacity: 0.8; border-radius: 15px;">
                                <i class="fa fa-search"></i>
                            </div>
                        </div>
                        <div class="col-4" style="padding-left: 0 !important;">
                            <button class="btn rounded-circle p-2 px-3" style="border: none; background-color: #b3b3b3; font-weight: 900;" @click="sortPrice('asc')">
                                <i class="fa-solid fa-sort-up"></i>
                            </button>
                            <button class="btn rounded-circle p-2 px-3 ml-3" style="border: none; background-color: #b3b3b3; font-weight: 900;" @click="sortPrice('desc')">
                                <i class="fa-solid fa-sort-down"></i>
                            </button>
                            <button class="btn rounded-circle p-2 px-3 ml-3" style="border: none; background-color: #b3b3b3; font-weight: 900;" @click="selectedMota('á')">Á</button>
                            <button class="btn rounded-circle p-2 px-2 ml-3" style="border: none; background-color: #b3b3b3; font-weight: 900;" @click="selectedMota('âu')">Âu</button>
                        </div>
                    </div>
                    <div class="row" v-else>
                        <div class="col-7 offset-2 input-group" style="padding-left: 0 !important;"> 
                            <input type="text" style="border-radius: 15px; background-color: #b3b3b3; border: none; opacity: 0.8; color: black;" 
                                v-model="productObj.name" id="formControlLg" class="form-control form-control-lg" placeholder="Search . . ."/>
                            <div class="p-2 px-3 ml-3" type="submit" style="background-color: #b3b3b3; border: none; opacity: 0.8; border-radius: 15px;">
                                <i class="fa fa-search"></i>
                            </div>
                        </div>
                        <div class="col-3" style="padding-left: 0 !important;">
                            <button class="btn rounded-circle p-2 px-3" style="border: none; background-color: #b3b3b3; font-weight: 900;" @click="sortPrice('asc')">
                                <i class="fa-solid fa-sort-up"></i>
                            </button>
                            <button class="btn rounded-circle p-2 px-3 ml-3" style="border: none; background-color: #b3b3b3; font-weight: 900;" @click="sortPrice('desc')">
                                <i class="fa-solid fa-sort-down"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-2"></div>
                <div class="col-1 text-right">
                    <div v-if="calculatePages > 1"> 
                        <button v-if="pageNum != calculatePages - 1" @click="next" style="background: none; border: none; ">
                            <span class="fa fa-chevron-circle-right" 
                                style="background-color: #b3b3b3; color: #f2f2f2; padding: 5px; border-radius: 10px;">
                            </span>
                        </button> 
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row" style="margin-top: 20px;">
            <div class="col-sm-10 offset-1 mt-5 ">
                <div class="row">

                </div>
                <br> <br>
                    <div class="row box-container">
            
                        <div class="col-md-3 pl-3 pr-3"
                            v-for="(f, index) in currentPageItems" :key="index"
                        >   
                                <div class="card mb-5" @click="showItem(index)">
                                    <div class="row card__title">
                                        <div class="col-2 mr-2 btn" style="background-color: #ffb3cc;" >
                                        </div>
                                        <div class="col-9 text-lg-right pr-0"><h4>{{ f.product_name }}</h4></div>
                                    </div>
                                    <div class="card__body d-flex justify-content-center">
                                        <img :src="f.product_src" 
                                            :style="{ width: '100%', height: '230px', 'border-radius': '10px'}"/>
                                        
                                    </div>
                                    <div class="card__footer">
                                        <div class="recommend">
                                        <p>Price: </p>
                                        <h4>{{ formatCurrency(f.product_price)}}</h4>
                                        </div>
                                        <div class="">
                                            <button class="btn" style="background-color: #ffb3cc; border-radius: 15px;" 
                                                @click="addToCart(f.product_name,f.product_id)">
                                                <h4 class="font-weight-bold" style="color: black;">Thêm vào Giỏ</h4>
                                            </button>
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
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                <br>
                    
                
            </div>
        </div>
        
    </div>

    <QuickView v-if="showQuickView" :product="sendId">
        <button  style="color: black; background-color: #ffb3ff; border-radius: 15px; padding: 5px;" @click="closeView"><h4>Trở Về</h4></button>
    </QuickView>

</template>

<script>
import Date from "@/components/Date.vue"
import DateDetails from "@/components/DateDetails.vue"
import Combo from "@/components/Combo.vue"
import QuickView from "@/components/QuickView.vue";
import { mapState } from "vuex";
import axios from "axios";
import VueBasicAlert from 'vue-basic-alert';
export default {
    name: "Product",

    data() {
        return {
            productObj: { name: "", category: "", price: "",mota: ""},
            sortByPrice: '',
            showQuickView: false,
            sendId: null,

            perPage: 12,
            pageNum: 0,
            previousCategoryClicked: "",
            
            isComponentsVisible: false,

            comp_page: 1,

            timecolor: '#FF0099',

        };
    },

    created() {
        this.$store.dispatch('autoUpdateProductsData'); // Gọi action để bắt đầu cập nhật tự động
        this.Time();
    },

    computed: {
        ...mapState(["allProducts","user"]),

        filterProducts() {
            let filteredProducts = this.allProducts.filter(f =>
                f.product_name.toLowerCase().match(this.productObj.name.toLowerCase()) &&
                (f.product_category.match(this.productObj.category) || this.productObj.category == "all") &&
                f.product_style != 'Món Tùy Chọn' && (f.product_mota.match(this.productObj.mota))
            );
            if (this.sortByPrice!=''){
                filteredProducts.sort((a, b) => {
                    if (this.sortByPrice === 'asc') {
                        return a.product_price - b.product_price; // Sắp xếp tăng dần
                    } else {
                        return b.product_price - a.product_price; // Sắp xếp giảm dần
                    }
                });
            }
            
            return filteredProducts;
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
        },

        imageHeight() {
            return `calc(100% * 2 / 3)`;
        }
    },
    methods: {
        formatCurrency(amount) {
          if (!amount) return '';
          return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
        },

        selectedMota(mota){
            this.productObj.mota = mota;
        },  

        sortPrice(value){
            this.sortByPrice = value;
        },

        set(val) {
            this.pageNum = val;
        },
        next() {
            this.pageNum++;
        },
        previous() {
            this.pageNum--;
        },

        Time() {
            this.productObj.category = 'time';
        },
        
        filterProductBtn: function (e) {
            this.pageNum = 0;
            if (e.target.value == 'time') { this.timecolor = '#FF0099';} else 
            this.timecolor = '#948c8c';
            if (this.productObj.category != e.target.value && this.previousCategoryClicked != "") {
                this.previousCategoryClicked.target.style.color = "#948c8c";
            }
            this.productObj.category = e.target.value;
            this.previousCategoryClicked = e;
            e.target.style.color = "#FF0099";
            this.productObj.mota = "";
            this.sortByPrice = "";
        },

        async addToCart(name,product) {
            if (this.user) {
                let existItem = await axios.get('/cartItem/' + parseInt(this.user.user_id) + '/' + parseInt(product));
                if (existItem.data.length > 0) {
                    this.$refs.alert.showAlert('warning', 'Xin Lỗi!', 'Bạn Đã thêm '+name+' vào giỏ trước đó!');
                } else {
                    let data = {
                        user_id: parseInt(this.user.user_id),
                        product_id: parseInt(product),
                        item_qty: 1,
                        item_notes: '',
                    };
                    await axios.post("/cartItem/", data)
                    let data1 = {
                        product_buy: 1,
                    }
                    try {
                        await axios.put(`/productsbuy/${product}`, data1)
                    } catch (error) {
                        console.error('Error in put product buy ',error);
                    }
                    this.$refs.alert.showAlert('success', 'Cám Ơn!', 'Đã thêm '+name+' vào Giỏ!')
                }
            } else  this.$refs.alert.showAlert('error', 'Xin Lỗi!', 'Bạn chưa đăng nhập!');
            this.showQuickView=false;
        },
                
        showItem: function (index) {
            this.sendId = parseInt(this.currentPageItems[index].product_id);
            this.showQuickView = !this.showQuickView;
        },

        closeView: function () {
            this.showQuickView = !this.showQuickView;
        },
    },
    components: { VueBasicAlert, QuickView , Date, DateDetails, Combo }
};
</script>

<style scoped>
    * {
        text-transform: none !important;
    }
    
    #myElement {
        animation: none !important;
    }

    .btnheadingmennu{
        background-color: #ffb3cc;
        color: #948c8c; /* Màu chữ */
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
        box-shadow: 0 1px 1px #d9d9d9;
        border-radius: 25px;
        background-color: #f2f2f2; 
        opacity: 0.9;
        
        transition: transform 0.2s ease;

        .card__title{
            display: flex;
            align-items: center;
            padding: 30px 30px;
            
            h4{
            flex: 0 1 200px;
            text-align: right;
            margin: 0;
            color: black;
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
            padding: 0 20px;
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
            background: linear-gradient(to right, #FF0099 0%,#FF0099 20%,#ffb3cc 20%,#ffb3cc 100%);
            }
            
            .recommend{
                flex: 1 0 10px;
                
                p{
                    margin: 0;
                    font-family: "Montserrat", sans-serif;
                    text-transform: uppercase;
                    font-weight: 600;
                    font-size: 14px;
                    color: black;
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
        }
    }

    .card:hover {
      transform: scale(1.01); /* Hoặc bất kỳ giá trị zoom nào bạn muốn */
      background-color: #e6e6e6;
    }

    
</style>
