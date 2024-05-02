// import functions from Product model

import {
    getProducts,
    getProductById,
    getProductByMota,
    insertProduct,
    updateProductById,
    deleteProductById,
    updateProductBuyModel,
    getProductsTop5,
    getProductsTop8,
    getProductsBot5
} from "../models/ProductModel.js";

// get all Products
export const showProducts=(req,res)=>{
    getProducts((err,results)=> {
        if (err) {
            res.status(500).json({ error: "Lỗi Nội Server" });
        }else {
            res.json(results);
        }
    });
};


// get single Product
export const showProductById=(req,res)=>{
    getProductById(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const showProductByMota=(req,res)=>{
    getProductByMota(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// create Product
export const createProduct=(req,res)=>{
    const data = req.body;
    insertProduct(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// update Product
export const updateProduct=(req,res)=>{
    const data = req.body;
    const id = req.params.id;
    updateProductById(data,id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const updateProductBuyController=(req,res)=>{
    const data = req.body;
    const id = req.params.id;
    console.log('data', data.product_buy);
    console.log('id', id);
    updateProductBuyModel(data,id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const getProductsTop5Controller=(req,res)=>{
    getProductsTop5((err,results)=> {
        if (err) {
            res.status(500).json({ error: "Lỗi Nội Server" });
        }else {
            res.json(results);
        }
    });
};

export const getProductsTop8Controller=(req,res)=>{
    getProductsTop8((err,results)=> {
        if (err) {
            res.status(500).json({ error: "Lỗi Nội Server" });
        }else {
            res.json(results);
        }
    });
};

export const getProductsBot5Controller=(req,res)=>{
    getProductsBot5((err,results)=> {
        if (err) {
            res.status(500).json({ error: "Lỗi Nội Server" });
        }else {
            res.json(results);
        }
    });
};

// delete Product
export const deleteProduct=(req,res)=>{
    const id = req.params.id;
    deleteProductById(id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};