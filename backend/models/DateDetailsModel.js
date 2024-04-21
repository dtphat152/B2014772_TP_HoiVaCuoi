// import connection
import db from "../config/database.js";


// get a items by user id, date id
export const getAllDateDetails = (id,result) => {
    db.query(`SELECT *
            FROM datedetails dd JOIN datebill d ON dd.date_id = d.date_id 
            WHERE dd.date_id = ?;`, [id] , (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

// insert new item to datedetails
export const insertToDateDetails = (data,result) => {
    db.query("INSERT INTO datedetails SET ?",data, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

// update qty of a datedetails item
export const updatedatedetails = (data,result) => {
    db.query("UPDATE datedetails SET dd_time = ? , dd_guest = ? WHERE date_id = ? AND dd_name = ?;",[data.dd_time, data.dd_guest, data.date_id, data.dd_name], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};


// delete datedetails item
export const deleteItemIndatedetails = (data,result) => {
    db.query("DELETE FROM datedetails WHERE date_id = ? AND dd_name = ?;",[data.date_id, data.dd_name], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

// delete all Items
export const deleteAllItemsByID = (id,result) => {
    db.query("DELETE FROM datedetails WHERE dd_id = ?",[id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};