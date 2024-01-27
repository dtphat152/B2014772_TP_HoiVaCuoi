// import functions from Guest model

import {
    getNumber,
    insertToGuest,
    updateNumber,
    deleteNumberByUser
} from "../models/GuestModel.js";

// get all Items
export const showNumber=(req,res)=>{
    getNumber(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// add to guest
export const addNumber=(req,res)=>{
    const data = req.body;
    insertToGuest(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// update guest
export const updateNumberOfGuest=(req,res)=>{
    const data = req.body;
    updateNumber(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};



// delete all items in cart
export const deleteNumber=(req,res)=>{
    deleteNumberByUser(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};
