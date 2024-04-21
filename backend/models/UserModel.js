// import connection
import db from "../config/database.js";

// get all user
export const getAllUser = (result) => {
    db.query("SELECT * FROM user", (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};


// get single user
export const getUserByEmail = (data,result) => {
    db.query("SELECT * FROM user WHERE user_email = ?",[data], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

export const getUserByID = (id,result) => {
    db.query("SELECT * FROM user WHERE user_id = ?",id, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

export const getAllfromUserModel = (id,result) => {
    db.query(`
        SELECT *
        FROM billstatus bs
        JOIN datebill db ON bs.date_id = db.date_id
        WHERE bs.user_id = ?;
        `,id, (err,results)=> {
            if (err){
                console.log(err);
                result(err,null);
            }else{
                result(null,results);
            }
        }
    );
};



// insert User
export const insertUser = (data,result) => {
    db.query("INSERT INTO user SET ?",data, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

export const updatePassModel = (data,result) => {
    try {
    db.query("UPDATE user SET user_password=? WHERE user_id = ?",[data.user_password,data.user_id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
    } catch (error) { console.error('Error sending email:', error); }
};

export const updateUserModel = (data,result) => {
    try {
    db.query(`UPDATE user 
    SET 
      user_name=?, 
      user_email=?, 
      user_phone=?, 
      user_address=? 
    WHERE user_id = ?`,[data.user_name,data.user_email,data.user_phone,data.user_address,data.user_id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
    } catch (error) { console.error('Error sending email:', error); }
};

export const updateStatusModel = (data,result) => {
    try {
    db.query("UPDATE user SET user_status=? WHERE user_id = ?",[data.user_status,data.user_id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
    } catch (error) { console.error('Error sending email:', error); }
};









