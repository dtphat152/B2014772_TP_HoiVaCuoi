// import connection
import db from "../config/database.js";

// get newest Bill Status
export const getNewestId = (result) => {
    db.query("SELECT bill_id FROM billstatus ORDER BY bill_id DESC LIMIT 0, 1", (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }
        else{
            result(null,results[0]);
        }
    });
};

// insert Bill Status
export const insertBillStatus = (data,result) => {
    db.query("INSERT INTO billstatus SET ?",data, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

// get all Bills Status
export const getBillsByUser = (id,result) => {
    db.query("SELECT * FROM billstatus WHERE user_id = ?",id, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }
        else{
            result(null,results);
        }
    });
};

export const getBillStatusByUserModel = (id,result) => {
    db.query("SELECT bill_status FROM billstatus WHERE user_id = ?",id, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }
        else{
            result(null,results);
        }
    });
};


// get all Bills Status
export const getBillsByBill = (id,result) => {
    db.query("SELECT * FROM billstatus WHERE bill_id = ?",id, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }
        else{
            result(null,results[0]);
        }
    });
};

// get all Bills Status
export const getAll = (result) => {
    db.query("SELECT * FROM billstatus", (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }
        else{
            result(null,results);
        }
    });
};


export const updateTotal = (data,id,result) => {
    db.query("UPDATE billstatus SET bill_total = ? WHERE bill_id = ?",[data.bill_total, id], (err,results)=> {
        if (err){
            console.error("Error updating bill total:", err);
            result(err,null);
        }else{
            console.log("Successfully updated bill total:", results);
            result(null,results);
        }
    });
};


export const updateStatus = (id,result) => {
    db.query("UPDATE billstatus SET bill_status = bill_status + 1  WHERE bill_id = ?",id, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const updateStatusCancelModel = (id,result) => {
    db.query("UPDATE billstatus SET bill_status = bill_status - 1  WHERE bill_id = ?",id, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const updateNotes = (data,result) => {
    db.query("UPDATE billstatus SET bill_notes = ? WHERE bill_id = ?",[data.bill_notes, data.bill_id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const updateAddress = (data,result) => {
    db.query("UPDATE billstatus SET bill_address = ? WHERE bill_id = ?",[data.bill_address, data.bill_id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const updatePhone = (data,result) => {
    db.query("UPDATE billstatus SET bill_phone = ? WHERE bill_id = ?",[data.bill_phone, data.bill_id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const cancelStatus = (id,result) => {
    db.query("UPDATE billstatus SET bill_status = 0  WHERE bill_id = ?",id, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const getBillFromDateToDateModel = (data,result) => {
    db.query(`SELECT * 
            FROM billstatus bs
            INNER JOIN datebill db ON bs.date_id = db.date_id
            WHERE STR_TO_DATE(db.date_date, '%m-%d-%Y') >= ? 
            AND STR_TO_DATE(db.date_date, '%m-%d-%Y') <= ? 
            ORDER BY STR_TO_DATE(db.date_date, '%m-%d-%Y') ASC;`,[data.start, data.end], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            console.log('Date: ',data.start);
            console.log(data.end);
            result(null,results);
        }
    });
};