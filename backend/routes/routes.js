// import express 
import express from "express";

// import functions from controller 
import {
    showProducts,
    showProductById,
    createProduct,
    updateProduct,
    deleteProduct,
    updateProductBuyController,
    getProductsTop5Controller,
    getProductsBot5Controller
} from "../controllers/product.js";

import {
    allUsers,
    showAUser,
    createAccount,
    showUserbyID,
    updatePassController,
    updateStatusController,
    updateUserController,
    getAllfromUserController
} from "../controllers/user.js";

import {
    showNumber,
    addNumber,
    updateNumberOfGuest,
    deleteNumber
} from "../controllers/guest.js";

import {
    getDateNoBillController,
    updateDateByID,
    insertDateByID,
    deleteDateByID,
    deleteTimeAndQuantityController
} from "../controllers/date.js";

import {
    getDateBillController,
    updateDateBillController,
    insertDateBillController,
    deleteDateBillController,
} from "../controllers/datebill.js";

import {
    getDateDetails,
    addDateDetails,
    updateDateDetails,
    deleteDateDetailsbyName,
    deleteDateDetails
} from "../controllers/datedetils.js";

import {
    addItems,
    getItem,
    updateItem,
    allItems,
    deleteItem,
    deleteItems
} from "../controllers/cart.js";

import {
    createBillDetails,
    getBillDetailsById,
    updateBillItem,
    deleteProductInBill
} from "../controllers/billdetails.js";

import {
    showNewestStatusId,
    createBillStatus, 
    getAllBillsByUser,
    getAllBillsByBill,
    getAllBills,
    updateBillStatus,
    updateStatusCancelController,
    updateBillNotes,
    updateBillAddress,
    updateBillPhone,
    cancelBillStatus,
    updateBillTotal,
    getBillFromDateToDateController
} from "../controllers/billstatus.js";

import {
    createCombo,
    getAllCombosByCombo,
    getAllCombo,
    showNewestComboId,
    updateCombo,
    deleteCombo,
} from "../controllers/combo.js"

import {
    createComboDetails,
    getComboDetailsById,
    deleteProductInCombo,
    deleteAllItemsInACombo,
    getProductinCombobyID
} from "../controllers/combodetails.js";

import {
    showPosts,
    showPostById,
    createPost,
    updatePost,
    deletePost,
    showNewestPostId,
    showImagesByPostId,
    createImage,
    deleteImage
} from "../controllers/post.js";

import {
    sendEmailStatusController,
    sendEmailUpdateController,
    sendEmailRequestController,
    sendForgotPasswordController
} from "../controllers/sendemail.js";

import { 
    MomoController 
} from "../controllers/momo.js";

import { 
    VnpayController,
    getVNPayController,
    insertVNPayController
} from "../controllers/vnpay.js";

import {
    getResetController,
    insertResetController,
    updateResetController,
    deleteResetController
} from "../controllers/reset.js";

// init express router
const router = express.Router();

////////////////////////// POST ////////////////////////////////
// newest post id
router.get("/api/post/new", showNewestPostId);

// get all post
router.get("/api/post", showPosts);

// get single post 
router.get("/api/post/:id", showPostById);

// create post
router.post("/api/post", createPost);

// update post 
router.put("/api/post/:id", updatePost);

// delete post
router.delete("/api/post/:id", deletePost);

// show Images By Post_Id
router.get("/api/postimage/:id", showImagesByPostId);

// create Image
router.post("/api/postimage", createImage);

//delete Image
router.delete("/api/postimage/:id", deleteImage);


////////////////////////// Product ////////////////////////////////


router.get("/api/productstop5", getProductsTop5Controller);

router.get("/api/productsbot5", getProductsBot5Controller);

// get all Product
router.get("/api/products", showProducts);

// get single Product 
router.get("/api/products/:id", showProductById);

// create Product
router.post("/api/products", createProduct);

// update Product 
router.put("/api/productsbuy/:id", updateProductBuyController);

router.put("/api/products/:id", updateProduct);

// delete Product
router.delete("/api/products/:id", deleteProduct);



////////////////////////// USER ////////////////////////////////

router.get("/api/users/all", allUsers);

router.get("/api/users/byid/:id", showUserbyID);

router.get("/api/users/:email", showAUser);

router.get("/api/users/allbill/:id", getAllfromUserController);

router.post("/api/users/", createAccount);

router.put("/api/users/pass", updatePassController);

router.put("/api/users/status", updateStatusController);

router.put("/api/users/", updateUserController);
///////////////////////// GUEST ////////////////////////////////
// get a number
router.get("/api/guestnumber/:id", showNumber);

//create number of guest
router.post("/api/guestnumber/",addNumber);

// update number to guest
router.put("/api/guestnumber/", updateNumberOfGuest);

// delete guest
router.delete("/api/guestnumber/:id", deleteNumber);


////////////////////////// DATE ////////////////////////////////

router.get("/api/date/:id", getDateNoBillController);
router.post("/api/date/", insertDateByID);
router.put("/api/date/", updateDateByID);
router.delete("/api/date/:id", deleteDateByID);
router.delete("/api/dateandquantity/:id", deleteTimeAndQuantityController);

////////////////////////// DATE BILL ////////////////////////////////

router.get("/api/datebill/:id", getDateBillController);
router.post("/api/datebill/", insertDateBillController);
router.put("/api/datebill/", updateDateBillController);
router.delete("/api/datebill/:id", deleteDateBillController);

////////////////////////// DATE DETAILS ////////////////////////////////
router.get("/api/datedetails/:id", getDateDetails);
router.post("/api/datedetails/", addDateDetails);
router.put("/api/datedetails/", updateDateDetails);
router.delete("/api/datedetails/detail/", deleteDateDetailsbyName);
router.delete("/api/datedetails/:id", deleteDateDetails);

////////////////////////// CART ////////////////////////////////
// add to cart
router.post("/api/cartItem", addItems);

// get a item in cart
router.get("/api/cartItem/:user_id/:product_id", getItem);

// get all items by user id
router.get("/api/cartItem/:id", allItems);

// update item qty
router.put("/api/cartItem/", updateItem);

// delete a item in cart
router.delete("/api/cartItem/:user_id/:product_id", deleteItem);

// delete all items in cart
router.delete("/api/cartItem/:id", deleteItems);



////////////////////////// Bill Details ////////////////////////////////
router.post("/api/billdetails", createBillDetails);
router.get("/api/billdetails/:id", getBillDetailsById);
router.put("/api/billdetails/", updateBillItem);
router.delete("/api/billdetails/all/:id", deleteAllItemsInACombo);
router.delete("/api/billdetails/:bill_id/:product_id", deleteProductInBill);


////////////////////////// Bill Status ////////////////////////////////
router.get("/api/billstatus/new", showNewestStatusId);
router.post("/api/billstatus/datetodate", getBillFromDateToDateController);
router.post("/api/billstatus", createBillStatus);
router.get("/api/billstatus/user/:id", getAllBillsByUser);
router.get("/api/billstatus/bill/:id", getAllBillsByBill);
router.get("/api/billstatus", getAllBills);
router.put("/api/billstatus/notes/", updateBillNotes);
router.put("/api/billstatus/address/", updateBillAddress);
router.put("/api/billstatus/phone/", updateBillPhone);
router.put("/api/billstatus/statuscancel/:id", updateStatusCancelController);
router.put("/api/billstatus/:id", updateBillStatus);
router.put("/api/billstatus/cancel/:id", cancelBillStatus);
router.put("/api/billstatus/billtotal/:id", updateBillTotal);


////////////////////////// Combo ////////////////////////////////
router.get("/api/combo/new", showNewestComboId);
router.post("/api/combo", createCombo);
router.get("/api/combo/:id", getAllCombosByCombo);
router.get("/api/combo", getAllCombo);
router.put("/api/combo/:id", updateCombo);
router.delete("/api/combo/:id", deleteCombo);

////////////////////////// Combo Details ////////////////////////////////
router.post("/api/combodetails", createComboDetails);
router.get("/api/combodetails/product/:id",getProductinCombobyID);
router.get("/api/combodetails/:id", getComboDetailsById);
router.delete("/api/combodetails/:combo_id/:product_id", deleteProductInCombo);

////////////////////////// Send Email ////////////////////////////////
router.post("/api/sendemail/status", sendEmailStatusController);
router.post("/api/sendemail/update", sendEmailUpdateController);
router.post("/api/sendemail/request", sendEmailRequestController);
router.post("/api/sendemail/reset-password", sendForgotPasswordController);

////////////////////////// MoMo ////////////////////////////////
router.post("/api/payment-online", MomoController);

////////////////////////// VN Pay ////////////////////////////////
router.post("/api/create_payment_vnpay", VnpayController);
router.get("/api/payment_vnpay", getVNPayController);
router.post("/api/payment_vnpay", insertVNPayController);

////////////////////////// Reset Pass ////////////////////////////////

router.post("/api/resetpass", insertResetController);

router.get("/api/resetpass/:id", getResetController);

router.put("/api/resetpass/", updateResetController);

router.delete("/api/resetpass/:id", deleteResetController);


// export default router
export default router;








