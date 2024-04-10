import { 
    insertCombo,
    getCombosByCombo,
    getAll,
    updateComboById,
    deleteComboById,
    getNewestComboId,
 } from "../models/ComboModel.js";

// create Combo
export const createCombo=(req,res)=>{
    const data = req.body;
    insertCombo(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// get Combo
export const getAllCombosByCombo=(req,res)=>{
    getCombosByCombo(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// get newest Combo id
export const showNewestComboId=(req,res)=>{
    getNewestComboId((err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// get all Combo
export const getAllCombo=(req,res)=>{
    getAll((err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// update Combo
export const updateCombo=(req,res)=>{
    const data = req.body;
    const id = req.params.id;
    updateComboById(data,id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};


// delete Combo
export const deleteCombo=(req,res)=>{
    const id = req.params.id;
    deleteComboById(id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};


