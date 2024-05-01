import db from "../config/database.js";

export const createData = (result) => {
    db.query("SELECT b.user_id, bd.product_id FROM `billdetails` as bd JOIN `billstatus` as b WHERE b.bill_id = bd.bill_id; ", (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const total_product = (result) => {
    db.query("SELECT COUNT(*) AS total_product FROM `product`;", (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};