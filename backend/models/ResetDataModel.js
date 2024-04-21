// import connection
import db from "../config/database.js";


export const getResetModel = (id,result) => {
    db.query("SELECT * FROM reset WHERE user_id = ?",[id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const insertResetModel = (data,result) => {
    db.query("INSERT INTO reset SET ?",data, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

export const updateResetModel = (data,result) => {
    db.query("UPDATE reset SET resetToken = ? , OTP = ?, timeLimit = ? WHERE user_id = ?",[data.resetToken, data.OTP, data.timeLimit, data.user_id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const deleteResetModel = (id,result) => {
    db.query("DELETE FROM reset WHERE user_id = ?",[id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};