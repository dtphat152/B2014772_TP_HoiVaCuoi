// import functions from Post and Image models
import {
    sendEmailStatusModel,
    sendEmailUpdateModel,
    sendEmailRequestModel,
    sendForgotPasswordModel
} from "../models/SendEmailModel.js";

export const sendEmailStatusController = (req, res) => {
    const data = req.body;
    sendEmailStatusModel(data, (err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};

export const sendEmailUpdateController = (req, res) => {
    const data = req.body;
    sendEmailUpdateModel(data, (err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};

export const sendEmailRequestController = (req, res) => {
    const data = req.body;
    sendEmailRequestModel(data, (err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};

export const sendForgotPasswordController = (req, res) => {
    const data = req.body;
    sendForgotPasswordModel(data, (err, results) => {
        if (err) {
            res.send(err);
        } else {
            res.json(results);
        }
    });
};
