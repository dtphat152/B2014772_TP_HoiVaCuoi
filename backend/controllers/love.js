import { 
    getToltalLoveModel,
    checkUserLoveModel,
    insertLoveModel,
    unLoveModel
 } from "../models/LoveModel.js";

 export const getToltalLoveController = (req, res) => {
    const id = req.params.id;
    getToltalLoveModel(id,(err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};

export const checkUserLoveController = (req, res) => {
    const pid = req.params.pid;
    const uid = req.params.uid;
    checkUserLoveModel(pid,uid,(err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};

export const insertLoveController = (req, res) => {
    const data = req.body;
    insertLoveModel(data, (err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};

export const unLoveController = (req, res) => {
    const pid = req.params.pid;
    const uid = req.params.uid;
    unLoveModel(pid,uid,(err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};