// import functions from User model

import {
    getDate,
    updateDate,
    insertDate,
    deleteDate,
} from "../models/DateBillModel.js";

export const getDateBillController=(req,res)=>{
    const id = req.params.id;
    getDate(id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};




export const insertDateBillController=(req,res)=>{
    const data = req.body;
    insertDate(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};



export const updateDateBillController=(req,res)=>{
    const data = req.body;
    updateDate(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};


export const deleteDateBillController=(req,res)=>{
    deleteDate(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};
