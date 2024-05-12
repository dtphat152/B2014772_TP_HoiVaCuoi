import db from "../config/database.js";

export const getToltalCommentModel = (id,result) => {
    db.query(`
    SELECT COUNT(*) as total_comment FROM comment WHERE post_id=?; 
    `, id , (err, results) => {
        if (err) {
            console.log(err);
            result(err, null);
        } else {
            result(null, results[0]);
        }
    });
};

export const getCommentModel = (id, result) => {
    db.query("SELECT cm_id, post_id, cm_content, user_name, user_avt FROM comment JOIN user WHERE comment.user_id = user.user_id AND comment.post_id = ?", id ,(err, results) => {
        if (err) {
            console.log(err);
            result(err, null);
        } else {
            result(null, results);
        }
    });
};

export const insertCommentModel = (data, result) => {
    db.query("INSERT INTO comment SET ?", data, (err, results) => {
        if (err) {
            console.log(err);
            result(err, null);
        } else {
            result(null, results[0]);
        }
    });
};

