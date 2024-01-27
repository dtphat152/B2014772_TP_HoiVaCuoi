// import connection
import db from "../config/database.js";

// get all Posts
export const getPosts = (result) => {
    db.query("SELECT * FROM post", (err, results) => {
        if (err) {
            console.log(err);
            result(err, null);
        } else {
            result(null, results);
        }
    });
};

// get single Post
export const getPostById = (id, result) => {
    db.query("SELECT * FROM post WHERE post_id = ?", [id], (err, results) => {
        if (err) {
            console.log(err);
            result(err, null);
        } else {
            result(null, results[0]);
        }
    });
};

// insert Post
export const insertPost = (data, result) => {
    db.query("INSERT INTO post SET ?", data, (err, results) => {
        if (err) {
            console.log(err);
            result(err, null);
        } else {
            result(null, results[0]);
        }
    });
};

// update Post
export const updatePostById = (data, id, result) => {
    db.query(
        "UPDATE post SET caption = ?, likes = ? WHERE post_id = ?",
        [data.caption, data.likes, id],
        (err, results) => {
            if (err) {
                console.log(err);
                result(err, null);
            } else {
                result(null, results);
            }
        }
    );
};

// delete Post
export const deletePostById = (id, result) => {
    db.query("DELETE FROM post WHERE post_id = ?", [id], (err, results) => {
        if (err) {
            console.log(err);
            result(err, null);
        } else {
            result(null, results);
        }
    });
};

export const getNewestId = (result) => {
    db.query("SELECT post_id FROM post ORDER BY post_id DESC LIMIT 0, 1", (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }
        else{
            result(null,results[0]);
        }
    });
};

// get all Images by Post ID
export const getImagesByPostId = (postId, result) => {
    db.query("SELECT * FROM postimage WHERE post_id = ?", [postId], (err, results) => {
        if (err) {
            console.log(err);
            result(err, null);
        } else {
            result(null, results);
        }
    });
};

// insert Image
export const insertImage = (data, result) => {
    db.query("INSERT INTO postimage SET ?", data, (err, results) => {
        if (err) {
            console.log(err);
            result(err, null);
        } else {
            result(null, results[0]);
        }
    });
};

// delete Image by Image ID
export const deleteImageById = (imageId, result) => {
    db.query("DELETE FROM postimage WHERE image_id = ?", [imageId], (err, results) => {
        if (err) {
            console.log(err);
            result(err, null);
        } else {
            result(null, results);
        }
    });
};
