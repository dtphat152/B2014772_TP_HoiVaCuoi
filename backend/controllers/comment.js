import { 
    getToltalCommentModel,
    getCommentModel,
    insertCommentModel,
 } from "../models/CommentModel.js";

 export const getToltalCommentController = (req, res) => {
    const id = req.params.id;
    getToltalCommentModel(id,(err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};

export const getCommentController = (req, res) => {
    const id = req.params.id;
    getCommentModel(id ,(err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};

export const insertCommentController = (req, res) => {
    const data = req.body;
    insertCommentModel(data, (err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};
