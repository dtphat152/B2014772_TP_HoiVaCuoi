// import connection
import db from "../config/database.js";

// insert Bill Details
export const insertBillDetails = (data,result) => {
    db.query("INSERT INTO billdetails SET ?",data, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};


// get Bill Details
export const getBillDetails = (id,result) => {
    db.query("SELECT * FROM billdetails WHERE bill_id = ?",id, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const getRefundInBillModel = (id,result) => {
    db.query("SELECT * FROM billdetails WHERE bill_id = ? AND refund <> 0",id, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

// update qty of a cart item
export const updateItemQty = (data,result) => {
    db.query("UPDATE billdetails SET item_qty = ?, item_notes = ? WHERE bill_id = ? AND product_id = ?",[data.item_qty, data.item_notes, data.bill_id, data.product_id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const updateRefundModel = (data,result) => {
    db.query("UPDATE billdetails SET refund = ?, value_refund = ? WHERE bill_id = ? AND product_id = ?",[data.refund, data.value_refund, data.bill_id, data.product_id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const deleteProduct = (id,product,result) => {
    db.query("DELETE FROM billdetails WHERE bill_id = ? AND product_id = ?",[id,product], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

///////////////////////////////refund//////////////////////////

// export const insertRefundModel = (data,result) => {
//     db.query("INSERT INTO refund SET ?",data, (err,results)=> {
//         if (err){
//             console.log(err);
//             result(err,null);
//         }else{
//             result(null,results[0]);
//         }
//     });
// };


// // get Bill Details
// export const getRefundModel = (id,result) => {
//     db.query("SELECT * FROM refund WHERE bill_id = ?",id, (err,results)=> {
//         if (err){
//             console.log(err);
//             result(err,null);
//         }else{
//             result(null,results);
//         }
//     });
// };

// // update qty of a cart item
// export const updateRefundModel = (data,result) => {
//     db.query("UPDATE refund SET quantiry = ? WHERE bill_id = ? AND product_id = ?",[data.quantiry, data.bill_id, data.product_id], (err,results)=> {
//         if (err){
//             console.log(err);
//             result(err,null);
//         }else{
//             result(null,results);
//         }
//     });
// };


