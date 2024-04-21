
import nodemailer from 'nodemailer';
import crypto from 'crypto';

export const sendEmailStatusModel = async (data) => {
    const transporter = nodemailer.createTransport({
        host: "smtp.gmail.com",
        port: 587,
        secure: false, // Use `true` for port 465, `false` for all other ports
        auth: {
          user: 'tphoivacuoi@gmail.com',
          pass: 'cpnw qlgs nusd nldp ',
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
          pass: 'cpnw qlgs nusd nldp ',
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
        pass: 'cpnw qlgs nusd nldp ',
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


export const sendForgotPasswordModel = async (data) => {
  try {
      // Khởi tạo transporter với các thông tin cần thiết
      const transporter = nodemailer.createTransport({
          host: "smtp.gmail.com",
          port: 587,
          secure: false, // false for other ports
          auth: {
            user: 'tphoivacuoi@gmail.com',
            pass: 'cpnw qlgs nusd nldp ',
          }
      });   

      // Tạo URL reset password 
      const resetLink = `http://localhost:8080/resetpassword/${data.id}${data.resetToken}`;

      // Chuẩn bị nội dung email
      const mailOptions = {
          from: '"TP - Hỏi và Cưới" <tphoivacuoi@gmail.com>', // sender address
          to: data.email, // list of receivers
          subject: 'Reset Password',
          html: `<p>Vui lòng nhấn vào link sau để thay đổi mật khẩu của bạn:</p>
                 <a href="${resetLink}">${resetLink}</a><br> 
                 <p>OTP: ${data.OTP}</p>`
      };

      // Gửi email
      const info = await transporter.sendMail(mailOptions);
      // console.log('Email sent: ' + info.response);
      return { success: true, message: 'Reset password email sent successfully' };
  } catch (error) {
      console.error('Error sending email:', error);
      return { success: false, message: 'Failed to send reset password email' };
  }
};
