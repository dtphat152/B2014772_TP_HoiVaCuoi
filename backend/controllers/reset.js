
import {
    getResetModel,
    insertResetModel,
    updateResetModel,
    deleteResetModel
} from "../models/ResetDataModel.js";


export const getResetController=(req,res)=>{
    getResetModel(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};


export const insertResetController=(req,res)=>{
    const data = req.body;
    insertResetModel(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const updateResetController=(req,res)=>{
    const data = req.body;
    updateResetModel(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const deleteResetController=(req,res)=>{
    deleteResetModel(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};
