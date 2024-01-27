// import express 
import express from "express";
// import functions from controller 
import {
    showProducts,
    showProductById,
    createProduct,
    updateProduct,
    deleteProduct,
} from "../controllers/product.js";

import {
    showAUser,
    createAccount
} from "../controllers/user.js";

import {
    showNumber,
    addNumber,
    updateNumberOfGuest,
    deleteNumber
} from "../controllers/guest.js";

import {
    getDateByID,
    updateDateByID,
    insertDateByID,
    deleteDateByID  
} from "../controllers/date.js"

import {
    addItems,
    getItem,
    updateItem,
    allItems,
    deleteItem,
    deleteItems
} from "../controllers/cart.js";

import {
    createBillDetails,getBillDetailsById
} from "../controllers/billdetails.js";

import {
    showNewestStatusId,
    createBillStatus, 
    getAllBillsByUser,
    getAllBillsByBill,
    getAllBills,
    updateBillStatus,
    updateBillPaid,
    cancelBillStatus
} from "../controllers/billstatus.js";

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

// init express router
const router = express.Router();

////////////////////////// POST ////////////////////////////////

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

// newest post id
router.delete("/api/post/new", showNewestPostId);
// show Images By Post_Id
router.get("/api/postimage/:id", showImagesByPostId);

// create Image
router.post("/api/postimage", createImage);

//delete Image
router.delete("/api/postimage/:id", deleteImage);


////////////////////////// Product ////////////////////////////////
// get all Product
router.get("/api/products", showProducts);

// get single Product 
router.get("/api/products/:id", showProductById);

// create Product
router.post("/api/products", createProduct);

// update Product 
router.put("/api/products/:id", updateProduct);

// delete Product
router.delete("/api/products/:id", deleteProduct);



////////////////////////// USER ////////////////////////////////
// get all user
router.get("/api/users/:email", showAUser);

// create account
router.post("/api/users/", createAccount);

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

// get date by user id
router.get("/api/date/:id", getDateByID);

// update date
router.post("/api/date/", insertDateByID);

// update date
router.put("/api/date/", updateDateByID);

// delete date in cart
router.delete("/api/date/:id", deleteDateByID);


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



////////////////////////// Bill Status ////////////////////////////////
router.get("/api/billstatus/new", showNewestStatusId);
router.post("/api/billstatus", createBillStatus);
router.get("/api/billstatus/user/:id", getAllBillsByUser);
router.get("/api/billstatus/bill/:id", getAllBillsByBill);
router.get("/api/billstatus", getAllBills);
router.put("/api/billstatus/:id", updateBillStatus);
router.put("/api/billstatus/paid/:id", updateBillPaid);
router.put("/api/billstatus/cancel/:id", cancelBillStatus);





// export default router
export default router;








