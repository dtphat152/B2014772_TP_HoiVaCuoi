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
                    <br>
                    <div class="row d-flex justify-content-center" style="margin-top: 0px;">
                        <br>
                        <div class="col-8" style="width: 150px;">
                        <br>
                        <div class="row d-flex justify-content-center">
                            <div class="col-7 form-group py-0">
                                <label style="width: 100%; padding: 0;" for="startDateInput">
                                <h2 class="text-center" style="color: #FF0099; font-weight: 900;">Ngày Tổ Chức Tiệc Cưới</h2>
                                </label>
                                <input type="date" class="form-control" id="startDateInput" v-model="formattedStartDate"
                                style="border: none; text-align: center; background: #ffb3cc; border-radius: 10px; font-weight: 900; font-size: 15px;" >
                                <br>
                            </div>
                        </div>
                        <div class="py-0" style="text-align: center;">
                            <button type="button" class="btn" style="background-color: #FFC0CB; color: black; border-radius: 10px; font-weight: 900;" 
                            @click="submitDate">Xác Nhận
                            </button>
                        </div>
                        </div>
                    </div>
                    <br><br>
                </div>
                <div class="col-2 d-flex justify-content-start"></div>
                <br>
            </div>
        </div>

        <div style="margin-top: 50px; width: 60%; margin-left: 20%; background-color: #f2f2f2; opacity: 0.9; border-radius: 25px;">
            <div class="row">
                <div class="col-2 d-flex justify-content-end"> </div>
                <div class="col-8">
                    <br>
                    <div class="row d-flex justify-content-center" style="margin-top: 0px;">
                    <br>
                        <div class="col-8 form-group text-center" style="width: 150px;">
                            <br>
                            
                                <h2  style="color: #FF0099; font-weight: 900;">Số lượng Khách và Thời Gian </h2>
                                <div v-if="this.selectedNum!=0" class="row d-flex justify-content-center pt-2">
                                    <div class="col-3 offset-3"><h5  style="color: #FF0099;">Thời Gian</h5></div>
                                    <div class="col-3"><h5 style="color: #FF0099;">Số Khách</h5></div>
                                    <div class="col-3"></div>
                                </div>
                                <div v-else>
                                    <br>
                                    <h5 style="color: #ef87aa;"></h5>
                                    <button type="button" class="btn font-weight-bold" @click="incNum()"
                                    style="background-color: #FFC0CB; border-color: none; color: back; margin-bottom: 10px; border: #808080; border-radius: 10px;" >
                                        <i class="fa fa-plus" style="color: black;"></i> Thêm suất
                                    </button>
                                </div>

                                <div v-for="index in selectedNum" :key="index" style="padding-bottom: 2px;">
                                    <div class="row d-flex justify-content-center align-items-center pt-2">
                                        <div class="col-3 text-right">
                                            <h5 style="color: #FF0099;">Suất thứ {{ index }} :</h5>
                                        </div>
                                        <div class="col-3">
                                            <input type="time" :id="'time-' + index" v-model="selectedTime[index]" 
                                            style=" background: #ffb3cc; border-radius: 10px; padding: 4px; font-size: 15px;">
                                        </div>
                                        <div class="col-3">
                                            <input title="Số Khách" type="number" :id="'number-' + index" class="form-control " min="0" max="1000" 
                                            v-model="selectedGuest[index]" style="border: none; text-align: center; background: #ffb3cc; border-radius: 10px; font-size: 15px; font-weight: 900;">
                                        </div>
                                        
                                        <div class="col-3">
                                            <button class="btn" @click="removeBtn(this.selectedId[index],index)"
                                            style="background-color: #ffb3cc; border-radius: 10px; color: #404040;" >
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>   
                                </div>
                                
                                
                                <div v-if="this.selectedNum!=0" style="text-align: center; padding-bottom: 12px; padding-top: 1px;">
                                    <div class="pt-5">
                                    <button type="button" class="btn" @click="incNum()"
                                    style="background-color: #FFC0CB; border-color: none; color: back; margin-bottom: 10px; border: #808080; border-radius: 10px; font-weight: 900;" >
                                        <i class="fa fa-plus" style="color: black;"></i> Thêm suất
                                    </button>
                                    </div>
                                    <button type="button" class="btn" 
                                        style="background-color: #FFC0CB; color: black; border-radius: 10px; font-weight: 900;" @click="submit">Xác Nhận
                                    </button>
                                </div>
                                
                        </div>
                    </div>
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

            perPage: 24,
            pageNum: 0,
            previousCategoryClicked: "",
            
            isComponentsVisible: false,

            comp_page: 1,

            timecolor: '#FF0099',

            selectedDate: { date: null },
            checkDate: true,

            selectedNum: 0,
            guestTotal: 0,
            selectedId: [],
            selectedGuest: [],
            selectedTime: [],
            dateID: '',
            checkGetMeatSet : true,

        };
    },

    created() {
        this.$store.dispatch('autoUpdateProductsData'); // Gọi action để bắt đầu cập nhật tự động
        this.Time();
        this.getDate();
    },

    mounted(){
        this.getMeatSet();  
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
        },

        formattedStartDate: {
          get() {
            // Chuyển đổi giá trị ngày từ đối tượng Date sang chuỗi có định dạng "yyyy-MM-dd"
            return this.selectedDate.date ? this.formatDate(this.selectedDate.date) : null;
          },
          set(value) {
            // Chuyển đổi giá trị ngày từ chuỗi có định dạng "yyyy-MM-dd" sang đối tượng Date
            this.selectedDate.date = value ? new Date(value) : null;
          },
        },
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

        async getDate() {
            if (this.user) {
                try {
                let existDate = await axios.get('/date/' + this.user.user_id);
                if (existDate.data.length > 0) {
                    this.selectedDate.date = new Date(existDate.data[0].date_date);  
                } else {
                    // Gán giá trị mặc định nếu không có dữ liệu
                    this.selectedDate.date = new Date('');
                    console.log('Không có dữ liệu ngày tháng.');
                }
                } catch (error) {
                console.error('Lỗi khi lấy ngày tháng:', error);
                }
            }
        },
        formatDate(date) {
            if (date) {
                const year = date.getFullYear();
                let month = date.getMonth() + 1;
                let day = date.getDate();

                month = month < 10 ? `0${month}` : month;
                day = day < 10 ? `0${day}` : day;

                // Trả về chuỗi có định dạng "yyyy-MM-dd"
                return `${year}-${month}-${day}`;
            }
            return null;
        },
        formatDateToSubmit(date) {
            if (date) {
                const year = date.getFullYear();
                let month = date.getMonth() + 1;
                let day = date.getDate();

                month = month < 10 ? `0${month}` : month;
                day = day < 10 ? `0${day}` : day;

                // Trả về chuỗi có định dạng "yyyy-MM-dd"
                return `${month}-${day}-${year}`;
            }
            return null;
        },
        async submitDate() {
            if (this.user) {
                const today = new Date();
                const yesterday = new Date(today);
                yesterday.setDate(yesterday.getDate() - 1);

                if (this.selectedDate.date < yesterday) {
                    this.$refs.alert.showAlert('error', 'Vui lòng chọn lại ngày khác!', 'Bạn đã chọn ngày ở quá khứ!');
                    return;
                }
                // Kiểm tra ngày không quá xa sau 2 tháng
                const twoMonthsLater = new Date(today);
                twoMonthsLater.setMonth(twoMonthsLater.getMonth() + 2);

                if (this.selectedDate.date.getTime() > twoMonthsLater.getTime()) {
                    this.$refs.alert.showAlert('error', 'Vui lòng chọn lại ngày khác!', 'Ngày quá xa sau 2 tháng!');
                    return;
                }

                let dateSelect = {
                date_date: this.formatDateToSubmit(this.selectedDate.date),
                user_id: parseInt(this.user.user_id),
                };

                try {
                let existDate = await axios.get('/date/' + this.user.user_id);

                if (existDate.data.length > 0) {
                    await axios.put("/date", dateSelect);
                    this.$refs.alert.showAlert('success', 'Thành công!', 'Ngày Tổ Chức đã được thay đổi!');
                } else {
                    await axios.post("/date", dateSelect);
                    this.$refs.alert.showAlert('success', 'Success!', 'Ngày Tổ Chức đã được lưu lại!');
                }
                } catch (error) {
                console.error('Error submitting date:', error);
                this.$refs.alert.showAlert('error', 'Error!', 'Lỗi khi xác nhận ngày Tổ chức!');
                }
            } else {
                this.$refs.alert.showAlert('warning', 'Xin lỗi!', 'Bạn chưa đăng nhập!');
            }
        },

        async incNum() {
            await this.getDate2()
            if (this.user) {
                if (this.dateID != ''){
                    this.selectedNum++;
                    this.checkGetMeatSet = false;
                } else this.$refs.alert.showAlert('error', 'Xin Lỗi!', 'Hãy chọn ngày Tổ chức trước!')
            } else {
                this.$refs.alert.showAlert('error', 'Xin Lỗi!', 'Bạn chưa đăng nhập!')
            }
        },

        async getNum(){
            if (this.dateID){
                let response = await axios.get(`/datedetailsnobill/${this.dateID}`);
                if(response.data.length > 0){
                    let data = response.data;
                    this.selectedNum = data.length;
                }
            }
        },

        async getDate2() {
            if (this.user) {
                try {
                    const response = await axios.get('/date/' + this.user.user_id);
                    if (response.data.length > 0) {
                        this.dateID = response.data[0].date_id;
                    } else {
                        this.dateID =  '';
                    }
                } catch (error) {
                    console.error('Đã xảy ra lỗi khi lấy dữ liệu dateID:', error);
                    this.dateID =  '';
                }
            }
        },

        async getMeatSet() {
            if (this.user) {
                await this.getDate2();
                await this.getNum();
                if(this.dateID != '') {
                    this.guestTotal=0;
                    for (let index = 1; index <= this.selectedNum; index++) {
                        try {
                            let response = await axios.get(`/datedetailsnobill/${this.dateID}`);
                            if(response.data.length > 0){
                                let data = response.data;
                                if (data && data.length >= index) {
                                    this.selectedId[index] = data[index - 1].dd_id;
                                    this.selectedTime[index] = data[index - 1].dd_time;
                                    this.selectedGuest[index] = data[index - 1].dd_guest;
                                    this.guestTotal += this.selectedGuest[index];
                                } else {
                                    this.selectedId[index] = '';
                                    this.selectedTime[index] = ''; 
                                    this.selectedGuest[index] = ''; 
                                }
                            }
                        } catch (error) {
                        
                            console.error('Lỗi khi lấy dữ liệu từ API:', error);
                        }
                    }
                }
            }
        },

        async removeBtn(id,index) {
            let confirmResult = window.confirm("Xác Nhận Hủy Suất Thứ " + index);
            if (confirmResult) {
                try {
                    let response = await axios.delete(`/datedetails/detail/${id}`); 
                    if (response.status >= 200 && response.status < 300) {
                        console.log("Xóa thành công");
                        this.$refs.alert.showAlert('success', 'Success!', 'Đã xóa suất đãi tiệc!');
                        this.selectedTime.splice(index, 1);
                        this.selectedGuest.splice(index, 1);
                        this.selectedNum--;
                        await this.getMeatSet();
                    } else {
                        console.error("Xóa không thành công, mã trạng thái: ", response.status);
                    }
                } catch (error) {
                    console.error("Lỗi khi thực hiện xóa: ", error);
                }
            }
        },


        async submit() {
            await this.getDate2();
            if (this.dateID != ''){
                if(this.checkGetMeatSet == false){
                    let response = await axios.get(`/datedetailsnobill/${this.dateID}`);
                    let data = response.data;
                    let templenght = data.length + 1;
                    for (let index = templenght; index <= this.selectedNum; index++) {
                        let data = {
                            date_id: this.dateID,
                            dd_name: index,
                            dd_time: this.selectedTime[index],
                            dd_guest: this.selectedGuest[index],
                        };
                        if (this.selectedGuest[index] <= 0 || this.selectedGuest[index] > 1000) {
                            this.$refs.alert.showAlert('error', 'Xin Lỗi!', 'Số lượng khách mời không hợp lệ (Hãy chọn dưới 1000 người)!')
                            return;
                        }
                        axios.post('/datedetails/', data)
                        .then(response => {
                            console.log('Dữ liệu đã được submit thành công:', response.data);
                        })
                        .catch(error => {
                            console.error('Lỗi khi submit dữ liệu:', error);
                        });
                    }
                    this.$refs.alert.showAlert('success', 'Thành Công!', 'Suất đãi tiệc đã được lưu lại!');
                    this.checkGetMeatSet = true;
                } else {

                    for (let index = 1; index <= this.selectedNum; index++) {
                        let data = {
                            date_id: this.dateID,
                            dd_name: index,
                            dd_time: this.selectedTime[index],
                            dd_guest: this.selectedGuest[index],
                        };
                        if (this.selectedGuest[index] <= 0 || this.selectedGuest[index] > 1000) {
                            this.$refs.alert.showAlert('error', 'Xin Lỗi!', 'Số lượng khách mời không hợp lệ (Hãy chọn dưới 1000 người)!')
                            return;
                        }
                        axios.put('/datedetails/', data)
                        .then(response => {
                            console.log('Dữ liệu đã được chỉnh sửa thành công:', response.data);
                            console.log(data);
                        })
                        .catch(error => {
                            console.error('Lỗi khi chỉnh sửa dữ liệu:', error);
                        });
                    }
                    this.$refs.alert.showAlert('success', 'Thành Công!', 'Suất đãi khách đã được cập nhật!');
                }
                await this.getMeatSet();
                
            } else this.$refs.alert.showAlert('error', 'Xin Lỗi!', 'Hãy chọn ngày Tổ chức trước!')
        }

    },
    components: { VueBasicAlert, QuickView, Combo }
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
