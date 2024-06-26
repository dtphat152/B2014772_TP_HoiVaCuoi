// import functions from User model

import {
    getDateNoBill,
    updateDate,
    insertDate,
    deleteDate,
    deleteTimeAndQuantityModel
} from "../models/DateModel.js";

export const getDateNoBillController=(req,res)=>{
    const id = req.params.id;
    getDateNoBill(id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// get all Items
export const getDateByID=(req,res)=>{
    const id = req.params.id;
    getDate(id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// create Date
export const insertDateByID=(req,res)=>{
    const data = req.body;
    insertDate(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};


// update Item
export const updateDateByID=(req,res)=>{
    const data = req.body;
    updateDate(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// delete all items in cart
export const deleteDateByID=(req,res)=>{
    deleteDate(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const deleteTimeAndQuantityController=(req,res)=>{
    deleteTimeAndQuantityModel(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};