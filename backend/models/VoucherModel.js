import db from "../config/database.js";

export const getAllVoucherModel = (result) => {
    db.query("SELECT * FROM `voucher` JOIN `user` WHERE voucher.user_id = user.user_id", (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

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



export const updateValueVoucherModel = (data,result) => {
    db.query("UPDATE value_voucher SET vv_value = ? WHERE 1",data.vv_value, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};
export const getValueVoucherModel = (result) => {
    db.query("SELECT vv_value FROM `value_voucher` WHERE 1 ", (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};