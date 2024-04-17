import {
    getNewestId,
    insertBillStatus,
    getBillsByUser,
    getBillsByBill,
    getAll,
    updateStatus,
    updateStatusCancelModel,
    updateNotes,
    updateAddress,
    updatePhone,
    cancelStatus,
    updateTotal
} from "../models/BillStatusModel.js";

// get newest Bill Status
export const showNewestStatusId=(req,res)=>{
    getNewestId((err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// create BillStatus
export const createBillStatus=(req,res)=>{
    const data = req.body;
    insertBillStatus(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// get Bills Status
export const getAllBillsByUser=(req,res)=>{
    getBillsByUser(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// get Bills Status
export const getAllBillsByBill=(req,res)=>{
    getBillsByBill(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// get Bills Status
export const getAllBills=(req,res)=>{
    getAll((err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};


// update Status
export const updateBillStatus=(req,res)=>{
    updateStatus(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const updateStatusCancelController=(req,res)=>{
    updateStatusCancelModel(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// update Notes
export const updateBillNotes=(req,res)=>{
    const data = req.body;
    updateNotes(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const updateBillAddress=(req,res)=>{
    const data = req.body;
    updateAddress(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const updateBillPhone=(req,res)=>{
    const data = req.body;
    updatePhone(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// cancel Status
export const cancelBillStatus=(req,res)=>{
    cancelStatus(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const updateBillTotal = (req, res) => {
    const data = req.body;
    const id = req.params.id;
    updateTotal(data, id ,(err, results) => {
        if (err) {
            console.error('Error updating bill total:', err);
            res.status(500).json({ error: 'Internal server error' });
        } else {
            console.log('Bill total updated successfully');
            res.status(200).json({ message: 'Bill total updated successfully' });
        }
    });
};