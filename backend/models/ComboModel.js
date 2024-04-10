// import connection
import db from "../config/database.js";


// insert combo
export const insertCombo = (data,result) => {
    db.query("INSERT INTO combo SET ?",data, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};


// get all combo
export const getCombosByCombo = (id,result) => {
    db.query("SELECT * FROM combo WHERE combo_id = ?",id, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }
        else{
            result(null,results);
        }
    });
};

// get newest Combo
export const getNewestComboId = (result) => {
    db.query("SELECT combo_id FROM combo ORDER BY combo_id DESC LIMIT 0, 1", (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }
        else{
            result(null,results[0]);
        }
    });
};

// get all combo
export const getAll = (result) => {
    db.query("SELECT * FROM combo", (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }
        else{
            result(null,results);
        }
    });
};

// update combo
export const updateComboById = (data,id,result) => {
    db.query("UPDATE combo SET combo_name = ?, combo_price = ? ,combo_desc = ? WHERE combo_id = ?",
    [data.combo_name, data.combo_price, data.combo_desc, id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const deleteComboById = (id,result) => {
    db.query("DELETE FROM combo WHERE combo_id = ?",[id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};


