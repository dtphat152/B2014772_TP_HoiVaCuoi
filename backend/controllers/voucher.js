
import {
    getAllVoucherModel,
    getUserVoucherModel,
    inserVoucherModel,
    updateVoucherStatusModel,
    updateValueVoucherModel,
    getValueVoucherModel
} from "../models/VoucherModel.js";


export const getAllVoucherController=(req,res)=>{
    getAllVoucherModel((err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
}

export const getUserVoucherController=(req,res)=>{
    const id = req.params.id;
    getUserVoucherModel(id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const insertVoucherController=(req,res)=>{
    const data = req.body;
    inserVoucherModel(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const updateVoucherStatusController=(req,res)=>{
    const data = req.body;
    updateVoucherStatusModel(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};




export const updateValueVoucherController=(req,res)=>{
    const data = req.body;
    updateValueVoucherModel(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};
export const getValueVoucherController=(req,res)=>{
    getValueVoucherModel((err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
}