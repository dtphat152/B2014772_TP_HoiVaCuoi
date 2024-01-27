// import functions from Post and Image models
import {
    getPosts,
    getPostById,
    insertPost,
    updatePostById,
    deletePostById,
    getNewestId,
    getImagesByPostId,
    insertImage,
    deleteImageById,
} from "../models/PostModel.js";

// get all Posts
export const showPosts = (req, res) => {
    getPosts((err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};

// get single Post
export const showPostById = (req, res) => {
    getPostById(req.params.id, (err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};

// create Post
export const createPost = (req, res) => {
    const data = req.body;
    insertPost(data, (err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};

// update Post
export const updatePost = (req, res) => {
    const data = req.body;
    const id = req.params.id;
    updatePostById(data, id, (err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};

// delete Post
export const deletePost = (req, res) => {
    const id = req.params.id;
    deletePostById(id, (err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};

export const showNewestPostId=(req,res)=>{
    getNewestId((err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// get all Images by Post ID
export const showImagesByPostId = (req, res) => {
    const postId = req.params.postId;
    getImagesByPostId(postId, (err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};

// insert Image
export const createImage = (req, res) => {
    const data = req.body;
    insertImage(data, (err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};

// delete Image
export const deleteImage = (req, res) => {
    const imageId = req.params.imageId;
    deleteImageById(imageId, (err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};
