import {
    insertBillDetails,
    getBillDetails,
    updateItemQty,
    deleteProduct
} from "../models/BillDetailsModel.js";

// create BillDetails
export const createBillDetails=(req,res)=>{
    const data = req.body;
    insertBillDetails(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// get BillDetails
export const getBillDetailsById=(req,res)=>{
    getBillDetails(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// update Item
export const updateBillItem=(req,res)=>{
    const data = req.body;
    updateItemQty(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const deleteProductInBill=(req,res)=>{
    const bill_id = req.params.bill_id;
    const product_id = req.params.product_id;
    deleteProduct(bill_id,product_id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};