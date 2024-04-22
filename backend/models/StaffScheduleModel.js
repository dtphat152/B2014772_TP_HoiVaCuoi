// import connection
import db from "../config/database.js";


export const getStaffNotInBillModel = (id,result) => {
    db.query(`
    SELECT staff_id, staff_name, staff_email 
    FROM staff
    WHERE staff_id NOT IN (
        SELECT DISTINCT s.staff_id
        FROM staff_schedule ss
        JOIN staff s ON ss.staff_id = s.staff_id
        WHERE ss.bill_id = ?
    );
    `, [id] , (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const getStaffInBillModel = (id,result) => {
    db.query(`
    SELECT DISTINCT s.staff_id, s.staff_name, s.staff_email 
    FROM staff_schedule ss
    JOIN staff s ON ss.staff_id = s.staff_id
    WHERE ss.bill_id = ?;
    `, [id] , (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const getAStaffScheduleModel = (id,result) => {
    db.query(`SELECT * FROM staff_schedule WHERE staff_id = ?;`, [id] , (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const insertStaffScheduleModel = (data,result) => {
    db.query("INSERT INTO staff_schedule SET ?",data, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

export const updateStaffScheduleModel = (data,result) => {
    db.query("UPDATE staff_schedule SET ss_date = ? , ss_time = ? WHERE staff_id = ?;",[data.ss_date, data.ss_time, data.staff_id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

export const deleteAStaffScheduleModel = (data,result) => {
    db.query("DELETE FROM staff_schedule WHERE staff_id = ? AND ss_time = ?;",[data.date_id, data.ss_time], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};


export const deleteAllAStaffScheduleModel = (id,result) => {
    db.query("DELETE FROM staff_schedule WHERE staff_id = ?",[id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};

export const deleteAllStaffScheduleByBillModel = (id,result) => {
    db.query("DELETE FROM staff_schedule WHERE bill_id = ?",[id], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results);
        }
    });
};