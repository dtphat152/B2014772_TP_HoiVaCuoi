
import nodemailer from 'nodemailer';


export const sendEmailStatusModel = async (data) => {
    const transporter = nodemailer.createTransport({
        host: "smtp.gmail.com",
        port: 587,
        secure: false, // Use `true` for port 465, `false` for all other ports
        auth: {
          user: 'tphoivacuoi@gmail.com',
          pass: 'jogb saws jegz gftb',
        },
      });

    const info = await transporter.sendMail({
        from: '"TP - Hỏi và Cưới" <tphoivacuoi@gmail.com>', // sender address
        to: data.email, // list of receivers
        subject: "Trạng Thái Đơn Hàng", // Subject line
        text: "Trạng Thái", // plain text body
        html: data.content, // html body
    });

    return info;
};

export const sendEmailUpdateModel = async (data) => {
    const transporter = nodemailer.createTransport({
        host: "smtp.gmail.com",
        port: 587,
        secure: false, // Use `true` for port 465, `false` for all other ports
        auth: {
          user: 'tphoivacuoi@gmail.com',
          pass: 'jogb saws jegz gftb',
        },
      });

    const info = await transporter.sendMail({
        from: '"TP - Hỏi và Cưới" <tphoivacuoi@gmail.com>', // sender address
        to: data.email, // list of receivers
        subject: "Thông Tin Cập Nhật Đơn Hàng", // Subject line
        text: "Cập Nhật", // plain text body
        html: `${data.title}<br>${data.content}`, // html body
    });

    return info;
};

export const sendEmailRequestModel = async (data) => {
  const transporter = nodemailer.createTransport({
      host: "smtp.gmail.com",
      port: 587,
      secure: false, // Use `true` for port 465, `false` for all other ports
      auth: {
        user: 'tphoivacuoi@gmail.com',
        pass: 'jogb saws jegz gftb',
      },
    });

    const info = await transporter.sendMail({
      from: `"TP - Hỏi và Cưới" <tphoivacuoi@gmail.com>`, // sender address
      to: '"TP - Hỏi và Cưới" <tphoivacuoi@gmail.com>', // list of receivers
      subject: "Yêu Cầu Cập Nhật Đơn Hàng", // Subject line
      text: "Cập Nhật", // plain text body
      html: `${data.title}<br>${data.content}<br>${data.auth}`, // html body
  });

  return info;
};

