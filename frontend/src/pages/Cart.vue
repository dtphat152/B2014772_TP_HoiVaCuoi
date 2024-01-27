<template>
    <div class="shopping-cart-section">

        <div class="heading">
            <!-- <h3>Shopping cart</h3> -->
        </div>
        <section class="h-100 h-custom" style="background-color:none">
            <div class="container py-5 h-100" style="width: 1000px;">
                <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12">
                    <div class="card card-registration card-registration-2" style="border-radius: 15px;">
                    <div class="card-body p-0">
                        <div class="row g-0">

                        <div class="col-lg-8">
                            <div class="p-5">
                            <div class="d-flex justify-content-between align-items-center mb-5">
                                <h1 class="fw-bold mb-0" style="color: #FF66CC; ">Dánh sách Dịch Vụ</h1>
                            </div>
                            <hr class="my-4">
                            <div>
                                <h2 class="mb-2">Khai Vị:</h2>
                                <div v-for="(f, index) in filterProducts" :key="index">
                                    <div v-if="f.product_category == 'Khai Vị'" class="row mb-4 d-flex justify-content-between align-items-center">
                                        <div class="col-md-2 col-lg-2 col-xl-2">
                                        <img :src="require(`../assets/images/${f.product_src}`)" alt=""
                                                class="cart-product-img" style="width: 100px;"/>
                                        </div>
                                        <div class="col-md-3 col-lg-3 col-xl-4">
                                            <h6 class="text-muted">{{ f.product_category }}</h6>
                                            <h6 class="text-black mb-0">{{ f.product_name }}</h6>
                                        </div>
                                        <div class="col-md-2 col-lg-2 col-xl-2"></div>
                                        <div class="col-md-3 col-lg-2 col-xl-2 ">
                                            <h6 class="mb-0">Đơn giá: {{ f.product_price }} x {{ tableNum }}</h6>
                                            <h6 class="mb-0"> {{ calculateItemPrice(index) }} vnd </h6>
                                        </div>
                                        <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                            <button class="btn" @click="removeBtn(index)">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </div>
                                        <hr class="my-4">
                                    </div>
                                </div>
                                <br>
                                <hr class="my-4">
                            </div>  
                            <div>
                                <h2 class="mb-2">Món Chính:</h2>
                                <div v-for="(f, index) in filterProducts" :key="index">
                                    <div v-if="f.product_category == 'Món Chính'" class="row mb-4 d-flex justify-content-between align-items-center">
                                        <div class="col-md-2 col-lg-2 col-xl-2">
                                        <img :src="require(`../assets/images/${f.product_src}`)" alt=""
                                                class="cart-product-img" style="width: 100px;"/>
                                        </div>
                                        <div class="col-md-3 col-lg-3 col-xl-4">
                                            <h6 class="text-muted">{{ f.product_category }}</h6>
                                            <h6 class="text-black mb-0">{{ f.product_name }}</h6>
                                        </div>
                                        <div class="col-md-2 col-lg-2 col-xl-2"></div>
                                        <div class="col-md-3 col-lg-2 col-xl-2 ">
                                            <h6 class="mb-0">Đơn giá: {{ f.product_price }} x {{ tableNum }}</h6>
                                            <h6 class="mb-0"> {{ calculateItemPrice(index) }} vnd </h6>
                                        </div>
                                        <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                            <button class="btn" @click="removeBtn(index)">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </div>
                                        <hr class="my-4">
                                    </div>
                                </div>
                                <br>
                                <hr class="my-4">
                            </div>  
                            <div>
                                <h2 class="mb-2">Tráng Miệng:</h2>
                                <div v-for="(f, index) in filterProducts" :key="index">
                                    <div v-if="f.product_category == 'Tráng Miệng'" class="row mb-4 d-flex justify-content-between align-items-center">
                                        <div class="col-md-2 col-lg-2 col-xl-2">
                                        <img :src="require(`../assets/images/${f.product_src}`)" alt=""
                                                class="cart-product-img" style="width: 100px;"/>
                                        </div>
                                        <div class="col-md-3 col-lg-3 col-xl-4">
                                            <h6 class="text-muted">{{ f.product_category }}</h6>
                                            <h6 class="text-black mb-0">{{ f.product_name }}</h6>
                                        </div>
                                        <div class="col-md-2 col-lg-2 col-xl-2"></div>
                                        <div class="col-md-3 col-lg-2 col-xl-2 ">
                                            <h6 class="mb-0">Đơn giá: {{ f.product_price }} x {{ tableNum }}</h6>
                                            <h6 class="mb-0"> {{ calculateItemPrice(index) }} vnd </h6>
                                        </div>
                                        <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                            <button class="btn" @click="removeBtn(index)">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </div>
                                        <hr class="my-4">
                                    </div>
                                </div>
                                <br>
                                <hr class="my-4">
                            </div>  
                            <div>
                                <h2 class="mb-2">Rạp Che:</h2>
                                <div v-for="(f, index) in filterProducts" :key="index">
                                    <div v-if="f.product_category == 'Rạp Che'" class="row mb-4 d-flex justify-content-between align-items-center">
                                        <div class="col-md-2 col-lg-2 col-xl-2">
                                        <img :src="require(`../assets/images/${f.product_src}`)" alt=""
                                                class="cart-product-img" style="width: 100px;"/>
                                        </div>
                                            <div class="col-md-3 col-lg-3 col-xl-4">
                                            <h6 class="text-muted">{{ f.product_category }}</h6>
                                            <h6 class="text-black mb-0">{{ f.product_name }}</h6>
                                            </div>
                                        <div class="col-md-2 col-lg-2 col-xl-2 d-flex">
                                            <input type="number" id="iQuantity" class="form-control item-quantity"
                                                :value="itemQuantity[index]" min="1" max="1000"
                                                @change="onQtyChange($event, index)">
                                        </div>
                                        <div class="col-md-3 col-lg-2 col-xl-2">
                                            <h6 class="mb-0">Đơn giá: {{ f.product_price }} x {{ itemQuantity[index] }}</h6>
                                            <h6 class="mb-0"> {{ calculateItemPrice(index) }} vnd </h6>
                                        </div>
                                        <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                            <button class="btn" @click="removeBtn(index)">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </div>
                                        <hr class="my-4">
                                    </div>
                                </div>
                                <br>
                                <hr class="my-4">
                            </div>  
                            <div>
                                <h2 class="mb-2">Sảnh Tiệc:</h2>
                                <div v-for="(f, index) in filterProducts" :key="index">
                                    <div v-if="f.product_category == 'Sảnh Tiệc'" class="row mb-4 d-flex justify-content-between align-items-center">
                                        <div class="col-md-2 col-lg-2 col-xl-2">
                                        <img :src="require(`../assets/images/${f.product_src}`)" alt=""
                                                class="cart-product-img" style="width: 100px;"/>
                                        </div>
                                            <div class="col-md-3 col-lg-3 col-xl-4">
                                            <h6 class="text-muted">{{ f.product_category }}</h6>
                                            <h6 class="text-black mb-0">{{ f.product_name }}</h6>
                                            </div>
                                        <div class="col-md-2 col-lg-2 col-xl-2 d-flex">
                                            <input type="number" id="iQuantity" class="form-control item-quantity"
                                                :value="itemQuantity[index]" min="1" max="1000"
                                                @change="onQtyChange($event, index)">
                                        </div>
                                        <div class="col-md-3 col-lg-2 col-xl-2">
                                            <h6 class="mb-0">Đơn giá: {{ f.product_price }} x {{ itemQuantity[index] }}</h6>
                                            <h6 class="mb-0"> {{ calculateItemPrice(index) }} vnd </h6>
                                        </div>
                                        <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                            <button class="btn" @click="removeBtn(index)">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </div>
                                        <hr class="my-4">
                                    </div>
                                </div>
                                <br>
                                <hr class="my-4">
                            </div>  
                            <div>
                                <h2 class="mb-2">Sân Khấu:</h2>
                                <div v-for="(f, index) in filterProducts" :key="index">
                                    <div v-if="f.product_category == 'Sân Khấu'" class="row mb-4 d-flex justify-content-between align-items-center">
                                        <div class="col-md-2 col-lg-2 col-xl-2">
                                        <img :src="require(`../assets/images/${f.product_src}`)" alt=""
                                                class="cart-product-img" style="width: 100px;"/>
                                        </div>
                                            <div class="col-md-3 col-lg-3 col-xl-4">
                                            <h6 class="text-muted">{{ f.product_category }}</h6>
                                            <h6 class="text-black mb-0">{{ f.product_name }}</h6>
                                            </div>
                                        <div class="col-md-2 col-lg-2 col-xl-2 d-flex">
                                            <input type="number" id="iQuantity" class="form-control item-quantity"
                                                :value="itemQuantity[index]" min="1" max="1000"
                                                @change="onQtyChange($event, index)">
                                        </div>
                                        <div class="col-md-3 col-lg-2 col-xl-2">
                                            <h6 class="mb-0">Đơn giá: {{ f.product_price }} x {{ itemQuantity[index] }}</h6>
                                            <h6 class="mb-0"> {{ calculateItemPrice(index) }} vnd </h6>
                                        </div>
                                        <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                            <button class="btn" @click="removeBtn(index)">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </div>
                                        <hr class="my-4">
                                    </div>
                                </div>
                                <br>
                                <hr class="my-4">
                            </div>  
                            <div>
                                <h2 class="mb-2">Gia Tiên:</h2>
                                <div v-for="(f, index) in filterProducts" :key="index">
                                    <div v-if="f.product_category == 'Gia Tiên'" class="row mb-4 d-flex justify-content-between align-items-center">
                                        <div class="col-md-2 col-lg-2 col-xl-2">
                                        <img :src="require(`../assets/images/${f.producguestt_src}`)" alt=""
                                                class="cart-product-img" style="width: 100px;"/>
                                        </div>
                                            <div class="col-md-3 col-lg-3 col-xl-4">
                                            <h6 class="text-muted">{{ f.product_category }}</h6>
                                            <h6 class="text-black mb-0">{{ f.product_name }}</h6>
                                            </div>
                                        <div class="col-md-2 col-lg-2 col-xl-2 d-flex">
                                            <input type="number" id="iQuantity" class="form-control item-quantity"
                                                :value="itemQuantity[index]" min="1" max="1000"
                                                @change="onQtyChange($event, index)">
                                        </div>
                                        <div class="col-md-3 col-lg-2 col-xl-2">
                                            <h6 class="mb-0">Đơn giá: {{ f.product_price }} x {{ itemQuantity[index] }}</h6>
                                            <h6 class="mb-0"> {{ calculateItemPrice(index) }} vnd </h6>
                                        </div>
                                        <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                            <button class="btn" @click="removeBtn(index)">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </div>
                                        <hr class="my-4">
                                    </div>
                                </div>
                                <br>
                                <hr class="my-4">
                            </div> 
                            <div>
                                <h2 class="mb-2">Mâm Quả:</h2>
                                <div v-for="(f, index) in filterProducts" :key="index">
                                    <div v-if="f.product_category == 'Mâm Quả'" class="row mb-4 d-flex justify-content-between align-items-center">
                                        <div class="col-md-2 col-lg-2 col-xl-2">
                                        <img :src="require(`../assets/images/${f.product_src}`)" alt=""
                                                class="cart-product-img" style="width: 100px;"/>
                                        </div>
                                            <div class="col-md-3 col-lg-3 col-xl-4">
                                            <h6 class="text-muted">{{ f.product_category }}</h6>
                                            <h6 class="text-black mb-0">{{ f.product_name }}</h6>
                                            </div>
                                        <div class="col-md-2 col-lg-2 col-xl-2 d-flex">
                                            <input type="number" id="iQuantity" class="form-control item-quantity"
                                                :value="itemQuantity[index]" min="1" max="1000"
                                                @change="onQtyChange($event, index)">
                                        </div>
                                        <div class="col-md-3 col-lg-2 col-xl-2">
                                            <h6 class="mb-0">Đơn giá: {{ f.product_price }} x {{ itemQuantity[index] }}</h6>
                                            <h6 class="mb-0"> {{ calculateItemPrice(index) }} vnd </h6>
                                        </div>
                                        <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                            <button class="btn" @click="removeBtn(index)">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </div>
                                        <hr class="my-4">
                                    </div>
                                </div>
                                <br>
                                <hr class="my-4">
                            </div> 
                            <div>
                                <h2 class="mb-2">Xe Hoa:</h2>
                                <div v-for="(f, index) in filterProducts" :key="index">
                                    <div v-if="f.product_category == 'Xe Hoa'" class="row mb-4 d-flex justify-content-between align-items-center">
                                        <div class="col-md-2 col-lg-2 col-xl-2">
                                        <img :src="require(`../assets/images/${f.product_src}`)" alt=""
                                                class="cart-product-img" style="width: 100px;"/>
                                        </div>
                                            <div class="col-md-3 col-lg-3 col-xl-4">
                                            <h6 class="text-muted">{{ f.product_category }}</h6>
                                            <h6 class="text-black mb-0">{{ f.product_name }}</h6>
                                            </div>
                                        <div class="col-md-2 col-lg-2 col-xl-2 d-flex">
                                            <input type="number" id="iQuantity" class="form-control item-quantity"
                                                :value="itemQuantity[index]" min="1" max="1000"
                                                @change="onQtyChange($event, index)">
                                        </div>
                                        <div class="col-md-3 col-lg-2 col-xl-2">
                                            <h6 class="mb-0">Đơn giá: {{ f.product_price }} x {{ itemQuantity[index] }}</h6>
                                            <h6 class="mb-0"> {{ calculateItemPrice(index) }} vnd </h6>
                                        </div>
                                        <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                            <button class="btn" @click="removeBtn(index)">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </div>
                                        <hr class="my-4">
                                    </div>
                                </div>
                                <br>
                                <hr class="my-4">
                            </div> 
                            <div>
                                <h2 class="mb-2">Áo Cưới:</h2>
                                <div v-for="(f, index) in filterProducts" :key="index">
                                    <div v-if="f.product_category == 'Áo Cưới'" class="row mb-4 d-flex justify-content-between align-items-center">
                                        <div class="col-md-2 col-lg-2 col-xl-2">
                                        <img :src="require(`../assets/images/${f.product_src}`)" alt=""
                                                class="cart-product-img" style="width: 100px;"/>
                                        </div>
                                            <div class="col-md-3 col-lg-3 col-xl-4">
                                            <h6 class="text-muted">{{ f.product_category }}</h6>
                                            <h6 class="text-black mb-0">{{ f.product_name }}</h6>
                                            </div>
                                        <div class="col-md-2 col-lg-2 col-xl-2 d-flex">
                                            <input type="number" id="iQuantity" class="form-control item-quantity"
                                                :value="itemQuantity[index]" min="1" max="1000"
                                                @change="onQtyChange($event, index)">
                                        </div>
                                        <div class="col-md-3 col-lg-2 col-xl-2">
                                            <h6 class="mb-0">Đơn giá: {{ f.product_price }} x {{ itemQuantity[index] }}</h6>
                                            <h6 class="mb-0"> {{ calculateItemPrice(index) }} vnd </h6>
                                        </div>
                                        <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                            <button class="btn" @click="removeBtn(index)">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </div>
                                        <hr class="my-4">
                                    </div>
                                </div>
                                <br>
                                <hr class="my-4">
                            </div> 
                            <div>
                                <h2 class="mb-2">Vest Cưới:</h2>
                                <div v-for="(f, index) in filterProducts" :key="index">
                                    <div v-if="f.product_category == 'Vest Cưới'" class="row mb-4 d-flex justify-content-between align-items-center">
                                        <div class="col-md-2 col-lg-2 col-xl-2">
                                        <img :src="require(`../assets/images/${f.product_src}`)" alt=""
                                                class="cart-product-img" style="width: 100px;"/>
                                        </div>
                                            <div class="col-md-3 col-lg-3 col-xl-4">
                                            <h6 class="text-muted">{{ f.product_category }}</h6>
                                            <h6 class="text-black mb-0">{{ f.product_name }}</h6>
                                            </div>
                                        <div class="col-md-2 col-lg-2 col-xl-2 d-flex">
                                            <input type="number" id="iQuantity" class="form-control item-quantity"
                                                :value="itemQuantity[index]" min="1" max="1000"
                                                @change="onQtyChange($event, index)">
                                        </div>
                                        <div class="col-md-3 col-lg-2 col-xl-2">
                                            <h6 class="mb-0">Đơn giá: {{ f.product_price }} x {{ itemQuantity[index] }}</h6>
                                            <h6 class="mb-0"> {{ calculateItemPrice(index) }} vnd </h6>
                                        </div>
                                        <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                            <button class="btn" @click="removeBtn(index)">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </div>
                                        <hr class="my-4">
                                    </div>
                                </div>
                                <br>
                                <hr class="my-4">
                            </div> 
                            <div>
                                <h2 class="mb-2">Áo Dài:</h2>
                                <div v-for="(f, index) in filterProducts" :key="index">
                                    <div v-if="f.product_category == 'Áo Dài'" class="row mb-4 d-flex justify-content-between align-items-center">
                                        <div class="col-md-2 col-lg-2 col-xl-2">
                                        <img :src="require(`../assets/images/${f.product_src}`)" alt=""
                                                class="cart-product-img" style="width: 100px;"/>
                                        </div>
                                            <div class="col-md-3 col-lg-3 col-xl-4">
                                            <h6 class="text-muted">{{ f.product_category }}</h6>
                                            <h6 class="text-black mb-0">{{ f.product_name }}</h6>
                                            </div>
                                        <div class="col-md-2 col-lg-2 col-xl-2 d-flex">
                                            <input type="number" id="iQuantity" class="form-control item-quantity"
                                                :value="itemQuantity[index]" min="1" max="1000"
                                                @change="onQtyChange($event, index)">
                                        </div>
                                        <div class="col-md-3 col-lg-2 col-xl-2">
                                            <h6 class="mb-0">Đơn giá: {{ f.product_price }} x {{ itemQuantity[index] }}</h6>
                                            <h6 class="mb-0"> {{ calculateItemPrice(index) }} vnd </h6>
                                        </div>
                                        <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                            <button class="btn" @click="removeBtn(index)">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </div>
                                        <hr class="my-4">
                                    </div>
                                </div>
                                <br>
                                <hr class="my-4">
                            </div> 
                            <div>
                                <h2 class="mb-2">Khác:</h2>
                                <div v-for="(f, index) in filterProducts" :key="index">
                                    <div v-if="f.product_category == 'Khác'" class="row mb-4 d-flex justify-content-between align-items-center">
                                        <div class="col-md-2 col-lg-2 col-xl-2">
                                        <img :src="require(`../assets/images/${f.product_src}`)" alt=""
                                                class="cart-product-img" style="width: 100px;"/>
                                        </div>
                                            <div class="col-md-3 col-lg-3 col-xl-4">
                                            <h6 class="text-muted">{{ f.product_category }}</h6>
                                            <h6 class="text-black mb-0">{{ f.product_name }}</h6>
                                            </div>
                                        <div class="col-md-2 col-lg-2 col-xl-2 d-flex">
                                            <input type="number" id="iQuantity" class="form-control item-quantity"
                                                :value="itemQuantity[index]" min="1" max="1000"
                                                @change="onQtyChange($event, index)">
                                        </div>
                                        <div class="col-md-3 col-lg-2 col-xl-2">
                                            <h6 class="mb-0">Đơn giá: {{ f.product_price }} x {{ itemQuantity[index] }}</h6>
                                            <h6 class="mb-0"> {{ calculateItemPrice(index) }} vnd </h6>
                                        </div>
                                        <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                            <button class="btn" @click="removeBtn(index)">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </div>
                                        <hr class="my-4">
                                    </div>
                                </div>
                                <br>
                                <hr class="my-4">
                            </div> 
                            


                        <div class="pt-5">
                            <router-link to="/menu" class="text-black-50"><i class="fa fa-arrow-left"></i>Continue shopping
                            </router-link>
                        </div>
                    </div>
                </div>

                    <div class="col-lg-4 bg-grey">
                        <div class="p-5">
                        <h3 class="fw-bold mb-5 mt-2 pt-1" style="color: #FF66CC; ">Summary</h3>
                        <hr class="my-4">
                        <div class="d-flex justify-content-between mb-4">
                            <h5 class="text-uppercase">items: {{ filterProducts.length.toString() }}</h5>
                        </div>
                        <div v-for="(f, index) in filterProducts" :key="index">
                            <h5 class="text-uppercase mb-3 pl-4">{{ f.product_name }}</h5>
                        </div>
                      
                        <hr class="my-4">
                        <div class="d-flex justify-content-between mb-5">
                            <h5 class="text-uppercase">Số lượng Bàn tiệc</h5>
                            <h5>{{ tableNum }} </h5>
                        </div>
                        <div class="d-flex justify-content-between mb-5">
                            <h5 class="text-uppercase">Giá mỗi Bàn (mâm)</h5>
                            <h5>{{ PriceOfTable() }} vnd </h5>
                        </div>
                        <div class="d-flex justify-content-between mb-5">
                            <h5 class="text-uppercase">Tổng chi phí</h5>
                            <h5>{{ calculateSummaryPrice() }} vnd</h5>
                        </div>

                        <button type="button"  @click="checkOutBtn()" class="btn btn-block btn-lg"  style="background-color: #FFF0F5; "
                            data-mdb-ripple-color="dark">Check out</button>

                        </div>
                    </div>
                    </div>
                </div>
                </div>
            </div>
            </div>
        </div>
        </section>
    </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
export default {
    name: "Cart",

    data() {
        return {
            cartItem: [],
            itemQuantity: [],
            tableNum: 0,
        };
    },

    created() {
        this.getAllCartItem();
        this.getNum();
    },

    computed: {
        ...mapState(["allProducts", "user"]),

        filterProducts: function () {
            return this.allProducts.filter(
                (f) => this.matchID(f, this.cartItem)
            );
        },
    },

    methods: {
        matchID: function (product, cartArray) {
            let temp = "";
            cartArray.forEach(element => {
                if (parseInt(product.product_id) == element) {
                    temp = product
                }
            });
            return temp
        },

        calculateItemPrice: function (index) {
            let a = 0;
            if ( this.filterProducts[index].product_category=="Khai Vị" || this.filterProducts[index].product_category=="Món Chính" || this.filterProducts[index].product_category=="Tráng Miệng") {
                a = parseInt(this.filterProducts[index].product_price) * this.tableNum;
            } else {
                a = parseInt(this.filterProducts[index].product_price) * this.itemQuantity[index];
            }
            return a;
        },

         PriceOfTable: function () {
            let subtotal = 0;
            let i = 0;
             while (i < this.itemQuantity.length) {
                if (this.filterProducts[i].product_category=="Khai Vị" || this.filterProducts[i].product_category=="Món Chính" || this.filterProducts[i].product_category=="Tráng Miệng") {
                    subtotal = subtotal + parseInt(this.filterProducts[i].product_price);
                }
                i = i + 1;
            }
            return subtotal;
        },

        calculateSummaryPrice: function () {
            let subtotal = 0;
            let i = 0;
            while (i < this.itemQuantity.length) {
                subtotal = subtotal + parseInt(this.filterProducts[i].product_price) * this.itemQuantity[i]
                i = i + 1
            }
            return subtotal;
        },

        async getNum() {
            if (this.user) {
            try {
                let existNum = await axios.get('/guestnumber/' + this.user.user_id);
                
                if (existNum.data && existNum.data.length > 0) {
                this.tableNum = existNum.data[0].guest_number /10;  
                console.log('Table:', this.tableNum);
                } else {
                // Gán giá trị mặc định nếu không có dữ liệu
                this.tableNum = 0;
                console.log('Không có dữ liệu Số lượng bàn.');
                }
            } catch (error) {
                console.error('Lỗi khi lấy Số lượng bàn:', error);
            }
            }
        },

        async onQtyChange(e, i) {
            if (e.target.value < 1) {
                e.target.value = 1
                this.itemQuantity[i] = 1
            } else {
                this.itemQuantity[i] = e.target.value;
            }

            let data = {
                user_id: parseInt(this.user.user_id),
                product_id: parseInt(this.cartItem[i]),
                item_qty: this.itemQuantity[i]
            };
            await axios.put("/cartItem/", data)
        },

        checkOutBtn: function () {
            this.$router.push("/checkout");
        },

        async removeBtn(index) {
            await axios.delete("/cartItem/" + this.user.user_id + "/" + this.cartItem[index]);

            this.cartItem.splice(index, 1);
            this.itemQuantity.splice(index, 1);
        },

        async getAllCartItem() {
            if (this.user) {
                let existItem = await axios.get('/cartItem/' + this.user.user_id);
                existItem.data.forEach(element => {
                    this.cartItem.push(element.product_id);
                    this.itemQuantity.push(element.item_qty);
                });
            }
        }


    }

}
</script>

<style></style>