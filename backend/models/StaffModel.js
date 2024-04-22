// import connection
import db from "../config/database.js";


export const getStaffModel = (id,result) => {
    db.query("SELECT * FROM staff ",id, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const getStaffByBillModel = (id,result) => {
    db.query("SELECT * FROM staff WHERE bill_id = ?",id, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const insertStaffModel = (data,result) => {
    db.query("INSERT INTO staff SET ?",data, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};


// export const updateStaff = (data,result) => {
//     db.query("UPDATE staff SET date_date = ? WHERE bill_id = ?",[data.date_date, data.user_id], (err,results)=> {
//         if (err){
//             console.log(err);
//             result(err,null);
//         }else{
//             result(null,results);
//         }
//     });
// };


// export const deleteStaff = (id,result) => {
//     db.query("DELETE FROM staff WHERE bill_id = ?",[id], (err,results)=> {
//         if (err){
//             console.log(err);
//             result(err,null);
//         }else{
//             result(null,results);
//         }
//     });
// };
