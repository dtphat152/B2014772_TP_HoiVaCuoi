import db from "../config/database.js";

export const getUserVoucherModel = (id,result) => {
    db.query("SELECT * FROM voucher WHERE user_id = ?",id, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const inserVoucherModel = (data,result) => {
    db.query("INSERT INTO voucher SET ?",data, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

export const updateVoucherStatusModel = (data,result) => {
    try {
    db.query(`UPDATE voucher SET vc_status = ? WHERE vc_id = ?`,[data.vc_status,data.vc_id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
    } catch (error) { console.error('Error update Voucher Status Model:', error); }
};