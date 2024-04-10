import {
    insertComboDetails,
    getComboDetails,
    deleteProduct,
    deleteAllProduct,
    getProductinCombo
} from "../models/ComboDetailsModel.js";

// create ComboDetails
export const createComboDetails=(req,res)=>{
    const data = req.body;
    insertComboDetails(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// get ComboDetails
export const getComboDetailsById=(req,res)=>{
    getComboDetails(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};


export const deleteProductInCombo=(req,res)=>{
    const Combo_id = req.params.Combo_id;
    const product_id = req.params.product_id;
    deleteProduct(Combo_id,product_id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};


export const deleteAllItemsInACombo=(req,res)=>{
    const id = req.params.id;
    deleteAllProduct(id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};


export const getProductinCombobyID=(req,res)=>{
    const id = req.params.id;
    getProductinCombo(id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};