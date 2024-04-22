import { 
    getStaffNotInBillModel,
    getStaffInBillModel,
    getAStaffScheduleModel,
    insertStaffScheduleModel,
    updateStaffScheduleModel,
    deleteAStaffScheduleModel,
    deleteAllAStaffScheduleModel,
    deleteAllStaffScheduleByBillModel
} from "../models/StaffScheduleModel.js";

export const getStaffNotInBillController=(req,res)=>{
    const id = req.params.id;
    getStaffNotInBillModel(id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const getStaffInBillController=(req,res)=>{
    const id = req.params.id;
    getStaffInBillModel(id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const getAStaffScheduleModelController=(req,res)=>{
    const id = req.params.id;
    getAStaffScheduleModel(id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const insertStaffScheduleController=(req,res)=>{
    const data = req.body;
    insertStaffScheduleModel(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const updateStaffScheduleController=(req,res)=>{
    const data = req.body;
    updateStaffScheduleModel(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const deleteAStaffScheduleController=(req,res)=>{
    const data = req.body;
    deleteAStaffScheduleModel(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const deleteAllAStaffScheduleController=(req,res)=>{
    deleteAllAStaffScheduleModel(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const deleteAllStaffScheduleByBillController=(req,res)=>{
    deleteAllStaffScheduleByBillModel(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};