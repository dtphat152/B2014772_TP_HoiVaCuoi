import multer from "multer";
import path from "path";
import db from "../config/database.js";
import express from "express";
import fs from 'fs';

const router = express.Router();

var storage = multer.diskStorage({
    destination: (req, file, callBack) => {
        callBack(null, './uploads/')     // './uploads/' directory name where save the file
    },
    filename: (req, file, callBack) => {
        callBack(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname))
    }
  })
  
  var upload = multer({
    storage: storage
  });

router.post("/api/uploading/useravt/:id", upload.single('image'), (req, res) => {
    if (!req.file) {
        console.log("No file upload");
    } else {
        console.log(req.file.filename)
        var id = req.params.id;
        var imgsrc = 'http://localhost:8081/uploads/' + req.file.filename
        var insertData = "UPDATE user SET user_avt=? WHERE user_id= ?"
        db.query(insertData, [imgsrc,id], (err, result) => {
            if (err) throw err
            console.log("file uploaded")
        res.send(imgsrc);
        })
    }
});



router.put("/api/uploading/useravt", (req, res) => {
    const oldImagePath = req.body.old; 
    fs.unlink(oldImagePath, (err) => {
        if (err) {
            console.error('Error deleting old image:', err);
        } else {
            console.log('Old image deleted successfully');
        }
    });
});


// router.post("/api/uploading", upload.array('images', 10), (req, res) => {
//     if (!req.files || req.files.length === 0) {
//         console.log("No files uploaded");
//     } else {
//         req.files.forEach((file) => {
//             console.log(file.filename);
//             var imgsrc = 'http://localhost:8081/uploads/' + file.filename; // Sử dụng file.filename thay vì req.file.filename
//             var insertData = "INSERT INTO users_file(file_src)VALUES(?)";
//             db.query(insertData, [imgsrc], (err, result) => {
//                 if (err) throw err;
//                 console.log("file uploaded");
//             });
//         });
//         res.send('Images have been uploaded successfully');
//     }
// });


export default router;