
import {
    getUserVoucherModel,
    inserVoucherModel,
    updateVoucherStatusModel,
} from "../models/VoucherModel.js";


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
