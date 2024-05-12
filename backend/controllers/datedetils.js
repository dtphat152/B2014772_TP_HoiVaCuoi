// import functions from User model

import {
    getAllDateDetails,
    getDateDetailsNobill,
    insertToDateDetails,
    updatedatedetails,
    deleteItemIndatedetails,
    deleteAllItemsByID
} from "../models/DateDetailsModel.js";


// get date
export const getDateDetails=(req,res)=>{
    const id = req.params.id;
    getAllDateDetails(id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const getDateDetailsNobillController=(req,res)=>{
    const id = req.params.id;
    getDateDetailsNobill(id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// add to cart
export const addDateDetails=(req,res)=>{
    const data = req.body;
    insertToDateDetails(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};


// update Item
export const updateDateDetails=(req,res)=>{
    const data = req.body;
    updatedatedetails(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};


// delete a item in cart
export const deleteDateDetailsbyName=(req,res)=>{
    deleteItemIndatedetails(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// delete all items in cart
export const deleteDateDetails=(req,res)=>{
    deleteAllItemsByID(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};
