<template>
    <div style="overflow-y: auto; height: 600px;">
        <div style="width: 95%;">
            <template v-for="(category, catIndex) in ['Khai Vị', 'Món Chính', 'Tráng Miệng','Thức Uống','Bàn Ghế','Rạp Che','Cổng Hoa','Sảnh Tiệc','Gia Tiên','Mâm Quả','Xe Hoa']" :key="catIndex">
                <h3 class="mb-2 mb-2" style="color: #d35ea4; font-weight: 900;">{{ category }}</h3>
                <div v-for="(f, index) in item_name" :key="index">
                    <div v-if="item_category[index] === category" 
                    class="row mb-1 d-flex justify-content-between align-items-center" style="background-color: #f08faf; margin-left: 10px; border-radius: 10px;">
                        
                        <div class="col-md-2 col-lg-2 col-xl-2" style="padding-left: 0px;">
                            <img :src="item_src[index]" alt="" class="cart-product-img" 
                            style="width: 100px; border-radius: 10px; ">
                        </div>
                        <div class="col-md-3 col-lg-3 col-xl-4">
                            <h4 class="text-black mb-0" style="color: #660066; font-weight: 900;">{{ f }}</h4>
                            <h5 class="mb-0" style="font-weight: 900;">Đơn giá: {{ formatCurrency(item_price[index]) }}</h5>
                        </div>
                        <div class="col-md-3 col-lg-2 col-xl-2">
                            <input type="number" id="number" v-model="item_qty[index]" @change="onQtyChange(index,f)"
                            class="form-control " min="0" max="1000" 
                            style="border: none; text-align: center; background: #d3d3d3; border-radius: 10px; color: black; font-weight: 900;">
                        </div>
                        <div class="col-md-2 col-lg-2 col-xl-2 text-end">
                            <div class="row">
                                <button class="btn" @click="removeBtn(index,f)" style="background-color: #d3d3d3; color: black; border-radius: 10px;">
                                    <i class="fa fa-trash"></i>
                                </button>
                                <div class="row ml-3" v-if="item_category[index]=='Thức Uống' && this.Bill[2]>=3">
                                    <button class="btn" @click="refundBtn(index,f)" style="background-color: #d3d3d3; color: black; border-radius: 10px;">
                                        <i class="fa-solid fa-rotate-right"></i>
                                    </button>
                                    <input type="number" id="number" v-model="quantity[index]" class="form-control " min="0" max="1000"
                                    style="border: none; text-align: center; background: #d3d3d3; border-radius: 10px; color: black; font-weight: 900; width: 60px;">
                                </div>         
                            </div>
                        </div>
                        <hr class="my-4">
                    </div>
                    
                    <div v-if="f.product_category === category" class="row mb-5" style="background-color: #f08faf; margin-left: 10px; border-radius: 10px;">
                        <div class="form-group col-10">
                            <input type="text" placeholder="Ghi chú..." class="form-control" 
                            style="border: none; font-weight: bold; background-color: #f08faf;" v-model="itemNotes[index]">
                        </div>
                        <div class="col-2 text-right">
                            <button @click="updateItemNotes(index,f)" style="background-color: #f08faf; padding: 5px;">Cập Nhật</button>
                            <button @click="deleteNotes(index,f)" style="background-color: #f08faf; padding: 5px;">Xóa</button>
                        </div>
                        <br>
                    </div>
                </div>
                
                <hr class="my-4">
            </template> 

        </div>
    </div>
                            
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
export default {
    props: ['Bill'],
    name: "ProductBill",

    data() {
        return {
            allProductsInBill: [],
            item_qty: [],
            itemNotes: [],
            item_price: [],
            tablePrice: '',
            item_category: [],
            item_name: [],
            item_src: [],
            quantity: [],
        }
    },

    created(){
        this.showEmail()
    },

    mounted() {
        this.getAllProducts();
    },

    computed: {
        ...mapState(["allProducts"]),

        filterProducts: function () {
            return this.allProducts.filter(
                (f) => this.matchID(f, this.allProductsInBill)
            );
        },
    },


    methods: {
        showEmail(){
            console.log("Email: "+this.Bill[1]);
        },

        setQuantity(selectedGuest,tableNum){
            let maxElement = 0
            if (selectedGuest.length > 0) {
                maxElement = Math.max(...selectedGuest);
            } else {
                maxElement = 0
            }
            try {
                this.item_qty.forEach((qty, index) => {
                    if (this.filterProducts[index].product_category === 'Khai Vị' 
                        || this.filterProducts[index].product_category === 'Món Chính'
                        || this.filterProducts[index].product_category === 'Tráng Miệng') {
                        this.item_qty[index] = tableNum;
                    }
                    if (this.filterProducts[index].product_category === 'Rạp Che' ) {
                        // if (this.item_qty[index] < Math.ceil(tableNum / 2)) 
                        this.item_qty[index] = Math.ceil(maxElement / 20);
                    }
                    if (this.filterProducts[index].product_category === 'Bàn Ghế' ) {
                        this.item_qty[index] =Math.ceil(maxElement/10);
                    }
                    if (this.filterProducts[index].product_category === 'Thức Uống' ) {
                        this.item_qty[index] = tableNum;
                    }
                    let data = {
                        bill_id: parseInt(this.Bill[0]),
                        product_id: parseInt(this.filterProducts[index].product_id),
                        item_qty: this.item_qty[index],
                        item_notes: this.itemNotes[index]
                    };
                    axios.put("/billdetails/", data);
                    let billdata = { 
                        bill_total: parseInt(this.calculateSummaryPrice()),
                    };      
                    axios.put(`/billstatus/billtotal/${this.Bill[0]}`, billdata);
                    console.log("Successfully updated bill total:", billdata);
                    this.$emit('childEvent');
                });
            } catch (error) {
                console.error('Lỗi khi cài Số Lượng:', error);
            }
        },

        formatCurrency(amount) {
          if (!amount) return '';
          return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
        },
        
        matchID: function (product, cartArray) {
            return cartArray.includes(product.product_id);
        },

        async getAllProducts() {
            if (this.Bill[0]) {
                let data = (await axios.get('/billdetails/' + this.Bill[0])).data;
                data.forEach(element => {
                    this.allProductsInBill.push(element.product_id);
                    this.item_qty.push(element.item_qty);
                    this.item_price.push(element.product_price);
                    this.item_name.push(element.product_name)
                    this.item_category.push(element.product_category)
                    this.item_src.push(element.product_src)
                    this.itemNotes.push(element.item_notes);
                    this.quantity.push(element.refund);
                });
            }
        },


        async onQtyChange(i,name) {

            let data = {
                bill_id: parseInt(this.Bill[0]),
                product_id: parseInt(this.allProductsInBill[i]),
                item_qty: this.item_qty[i],
                item_notes: this.itemNotes[i]
            };
            let confirmResult = window.confirm("Bạn có chắc chắn muốn thay đổi số lượng "+name+" thành " + this.item_qty[i] + "?" );
                if (confirmResult) {
                    await axios.put("/billdetails/", data);
                    let billdata = { 
                        bill_total: parseInt(this.calculateSummaryPrice()),
                    };      
                    try {
                        await axios.put(`/billstatus/billtotal/${this.Bill[0]}`, billdata);
                        console.log("Successfully updated bill total:", billdata);
                        this.$emit('childEvent');
                        let data1 = {
                            email: this.Bill[1],
                            title:`Đơn hàng #${this.Bill[0]} của bạn đã được cập nhật!`,
                            content: `Nội dung: Thay đổi số lượng ${name} thành ${data.item_qty}.`,
                        }
                        try {
                            axios.post(`/sendemail/update`,data1);
                        } catch (error) {
                            console.error("Error Send email update:", error);
                        }    
                    } catch (error) {
                        console.error("Error updating bill total:", error);
                    } 
                } 
        },

        async removeBtn(index,name) {
            let confirmResult = window.confirm("Bạn có chắc chắn muốn xóa "+name+" ra khỏi đơn?" );
            if (confirmResult) {
                try {
                    await axios.delete("/billdetails/" + this.Bill[0] + "/" + this.allProductsInBill[index]);
                    console.log("Successfully removed product in bill:", this.Bill[0] , this.allProductsInBill[index]);
                } catch (error) {
                    console.error("Error remove product in bill:", error);
                }
                this.allProductsInBill.splice(index, 1);
                this.item_qty.splice(index, 1);

                let billdata = { 
                    bill_total: parseInt(this.calculateSummaryPrice()),
                };      
                try {
                    await axios.put(`/billstatus/billtotal/${this.Bill[0]}`, billdata);
                    console.log("Successfully updated bill total:", billdata);
                    this.$emit('childEvent');
                    let data1 = {
                        email: this.Bill[1],
                        title:`Đơn hàng #${this.Bill[0]} của bạn đã được cập nhật!`,
                        content: `Nội dung: Xóa ${name} ra khỏi đơn hàng.`,
                    }
                    try {
                        axios.post(`/sendemail/update`,data1);
                    } catch (error) {
                        console.error("Error Send email update:", error);
                    } 
                } catch (error) {
                    console.error("Error updating bill total:", error);
                }
            }
        },
        
        async refundBtn(index,name) {
            if (this.quantity[index] > this.item_qty[index]) window.confirm("Số lượng hoàn trả không được lớn hơn số lượng đặt hàng!");
            else {
                let confirmResult = window.confirm("Bạn muốn hoàn trả "+name+" với số lượng "+this.quantity[index]+"?" );
                if (confirmResult) {
                    try {
                        let data = {
                            bill_id: this.Bill[0],
                            product_id: this.allProductsInBill[index],
                            refund: this.quantity[index],
                            value_refund : parseInt(this.item_price[index]) * this.quantity[index]
                        }
                        await axios.put("/billdetails/refund", data); 
                        console.log("Successfully add product to refund:", this.Bill[0] , this.allProductsInBill[index], this.quantity[index], data.value_refund);
                    } catch (error) {
                        console.error("Error add product to refund:", error);
                    }
                    let amount = parseInt(this.item_price[index]) * this.quantity[index];
                    console.log(amount)
                    let billdata = { 
                        bill_total: parseInt(this.calculateSummaryPrice() - amount),
                    };      
                    console.log(billdata.bill_total)
                    try {
                        await axios.put(`/billstatus/billtotal/${this.Bill[0]}`, billdata);
                        console.log("Successfully updated bill total:", billdata);
                        this.$emit('childEvent');
                    } catch (error) {
                        console.error("Error updating bill total:", error);
                    }
                }
            }
        },

        async updateItemNotes(i,name) {
            let data = {
                bill_id: parseInt(this.bill[0]),
                product_id: parseInt(this.allProductsInBill[i]),
                item_qty: this.item_qty[i],
                item_notes: this.itemNotes[i]
            };
            let confirmResult = window.confirm("Bạn có chắc chắn muốn thay đổi Ghi chú của "+name+"?");
            if (confirmResult) {
                try {
                    await axios.put("/billdetails/", data);
                    console.log("Đã cập nhật Ghi chú thành công.");

                } catch (error) {
                    console.error("Đã xảy ra lỗi khi cập nhật Ghi chú:", error);
                }
            }
        },

        async deleteNotes(i,name) {
            let data = {
                bill_id: parseInt(this.bill[0]),
                product_id: parseInt(this.allProductsInBill[i]),
                item_qty: this.item_qty[i],
                item_notes: ""
            };
            let confirmResult = window.confirm("Bạn có chắc chắn muốn xóa bỏ Ghi chú của "+name+"?");
            if (confirmResult) {
                try {
                    await axios.put("/billdetails/", data);
                    console.log("Đã xóa Ghi chú thành công.");
                } catch (error) {
                    console.error("Đã xảy ra lỗi khi xóa Ghi chú:", error);
                }
            }
        },

        calculateItemPrice: function (index) {
            let a = parseInt(this.item_price[index]) * this.item_qty[index];
            return a;
        },

        calculateSummaryPrice: function () {
            let subtotal = 0;
            let i = 0;
            while (i < this.item_qty.length) {
                subtotal = subtotal + this.calculateItemPrice(i)
                i = i + 1
            }
            return subtotal;
        },

    }
}
</script>