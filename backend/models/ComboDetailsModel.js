// import connection
import db from "../config/database.js";

// insert Combo Details
export const insertComboDetails = (data,result) => {
    db.query("INSERT INTO combodetails SET ?",data, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};


// get Combo Details
export const getComboDetails = (id,result) => {
    db.query("SELECT * FROM combodetails WHERE combo_id = ?",id, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};


export const deleteProduct = (id,product,result) => {
    db.query("DELETE FROM combodetails WHERE combo_id = ? AND product_id = ?",[id,product], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};


export const deleteAllProduct = (id,result) => {
    db.query("DELETE FROM combodetails WHERE combo_id = ?",[id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

//getProductinCombobyID
export const getProductinCombo = (id,result) => {
    db.query(`SELECT *
            FROM combodetails cd JOIN product p ON cd.product_id = p.product_id 
            WHERE cd.combo_id = ?;`, [id], (err,results)=> {
                if (err){
                    console.log(err);
                    result(err,null);
                }else{
                    result(null,results);
                }
            });
};