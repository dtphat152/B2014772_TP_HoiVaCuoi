// import connection
import db from "../config/database.js";

// get all Products
export const getProducts = (result) => {
    db.query("SELECT * FROM product", (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

// get single Products
export const getProductById = (id,result) => {
    db.query("SELECT * FROM product WHERE product_id = ?",[id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

export const getProductByMota = (id,result) => {
    db.query("SELECT * FROM `product` WHERE product_mota = ?",[id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

// insert Product
export const insertProduct = (data,result) => {
    db.query("INSERT INTO product SET ?",data, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

// update Product
export const updateProductById = (data,id,result) => {
    db.query("UPDATE product SET product_name = ?, product_price = ? ,product_desc = ?, product_category = ?, product_src = ?, product_style = ?, product_mota = ? WHERE product_id = ?",
    [data.product_name, data.product_price, data.product_desc, data.product_category, data.product_src, data.product_style, data.product_mota, id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const updateProductBuyModel = (data,id,result) => {
    db.query("UPDATE product SET product_buy = product_buy + ? WHERE product_id = ?",
    [data.product_buy, id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const getProductsTop5 = (result) => {
    db.query("SELECT * FROM product ORDER BY product_buy DESC LIMIT 5; ", (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const getProductsTop8 = (result) => {
    db.query("SELECT * FROM product ORDER BY product_buy DESC LIMIT 8; ", (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const getProductsBot5 = (result) => {
    db.query("SELECT * FROM product WHERE product_style = '' ORDER BY product_buy ASC LIMIT 5; ", (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};


// delete Product
export const deleteProductById = (id,result) => {
    db.query("DELETE FROM product WHERE product_id = ?",[id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};