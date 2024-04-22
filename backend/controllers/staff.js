import {
    getStaffModel,
    getStaffByBillModel,
    insertStaffModel,
} from "../models/StaffModel.js";

export const getStaffController=(req,res)=>{
    getStaffModel((err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

export const getStaffByBillController=(req,res)=>{
    const id = req.params.id;
    getStaffByBillModel(id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};




// export const insertStaffController=(req,res)=>{
//     const data = req.body;
//     insertStaffModel(data,(err,results)=> {
//         if (err) {
//             res.send(err);
//         }else {
//             res.json(results);
//         }
//     });
// };

export const insertStaffController = (req, res) => {
    const dataArray = req.body; // Mảng JSON chứa dữ liệu nhân viên

    // Duyệt qua mảng JSON và thêm từng bản ghi vào cơ sở dữ liệu
    dataArray.forEach(data => {
        insertStaffModel(data, (err, result) => {
            if (err) {
                res.send(err);
            } else {
                console.log("Staff inserted successfully:", result);
            }
        });
    });

    res.send("Insertion completed");
};

// export const updateDateBillController=(req,res)=>{
//     const data = req.body;
//     updateDate(data,(err,results)=> {
//         if (err) {
//             res.send(err);
//         }else {
//             res.json(results);
//         }
//     });
// };


// export const deleteDateBillController=(req,res)=>{
//     deleteDate(req.params.id,(err,results)=> {
//         if (err) {
//             res.send(err);
//         }else {
//             res.json(results);
//         }
//     });
// };
