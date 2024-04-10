// import connection
import db from "../config/database.js";

// get date by user id
export const getDate = (id,result) => {
    db.query("SELECT * FROM date WHERE user_id = ?",[id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const insertDate = (data,result) => {
    db.query("INSERT INTO date SET ?",data, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};


// update date
export const updateDate = (data,result) => {
    db.query("UPDATE date SET date_date = ? WHERE user_id = ?",[data.date_date, data.user_id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};


// delete date
export const deleteDate = (id,result) => {
    db.query("DELETE FROM date WHERE user_id = ?",[id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};