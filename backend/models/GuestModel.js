// import connection
import db from "../config/database.js";

// get all items by user id
export const getNumber = (id,result) => {
    db.query("SELECT guest_number FROM guest WHERE user_id = ?",[id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

// insert new guest
export const insertToGuest = (data,result) => {
    db.query("INSERT INTO guest SET ?",data, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

// update qty of a cart item
export const updateNumber = (data,result) => {
    db.query("UPDATE guest SET guest_number = ? WHERE user_id = ?",[data.guest_number, data.user_id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};


// delete all Items
export const deleteNumberByUser = (id,result) => {
    db.query("DELETE FROM guest WHERE user_id = ?",[id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};