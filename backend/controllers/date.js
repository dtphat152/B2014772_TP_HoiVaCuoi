// import functions from User model

import {
    getDate,
    updateDate,
    insertDate,
    deleteDate,
} from "../models/DateModel.js";

// get all Items
export const getDateByID=(req,res)=>{
    getDate(req.params.id,(err,results)=> {
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
