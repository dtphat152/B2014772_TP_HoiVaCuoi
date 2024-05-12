import db from "../config/database.js";

export const getToltalLoveModel = (id,result) => {
    db.query(`
    SELECT COUNT(*) as total_love FROM love WHERE post_id=?; 
    `, id , (err, results) => {
        if (err) {
            console.log(err);
            result(err, null);
        } else {
            result(null, results[0]);
        }
    });
};

export const checkUserLoveModel = (pid,uid,result) => {
    db.query(`
    SELECT COUNT(*) as check_love FROM love WHERE post_id=? AND user_id=? 
    `, [pid,uid] , (err, results) => {
        if (err) {
            console.log(err);
            result(err, null);
        } else {
            result(null, results[0]);
        }
    });
};

export const insertLoveModel = (data, result) => {
    db.query("INSERT INTO love SET ?", data, (err, results) => {
        if (err) {
            console.log(err);
            result(err, null);
        } else {
            result(null, results[0]);
        }
    });
};

export const unLoveModel = (pid, uid, result) => {
    db.query("DELETE FROM love WHERE post_id=? AND user_id=?", [pid,uid] , (err, results) => {
        if (err) {
            console.log(err);
            result(err, null);
        } else {
            result(null, results[0]);
        }
    });
};