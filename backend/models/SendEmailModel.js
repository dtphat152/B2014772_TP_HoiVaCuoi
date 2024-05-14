
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
        html: `
        <html>
          <head>
              <style>
                  body {
                      font-family: Arial, sans-serif;
                  }
                  .container {
                      width: 100%;
                      max-width: 1000px;
                      margin: 0 auto;
                      padding: 20px;
                      background-color: #f9f9f9;
                      border-radius: 25px;
                  }
                  h1 {
                      color: #ff1493;
                      text-align: center;
                  }
                  h3 {
                      color: #666;
                      padding-left: 20px;
                  }
                  #thank {
                      text-align: end;
                      padding-left: 0px !important;
                  }
                  img {
                      width: 100%;
                      border-radius: 25px;
                  }
              </style>
          </head>
          <body>
              <div class="container">	
                  <h1>TP Hỏi và Cưới</h1>
                  <h2>Kính chào quý khách hàng!</h2>
                  <h2>${data.content}</h2>
                  <img src="https://i.pinimg.com/originals/ec/29/20/ec29206e60920c53e29c0520e5179bd1.jpg" alt="">
                  <h2 id="thank">Cửa hàng xin chân thành cám ơn!</h2>
              </div>
          </body>
      </html>
        `,
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
        html: `
        <html>
          <head>
              <style>
                  body {
                      font-family: Arial, sans-serif;
                  }
                  .container {
                      width: 100%;
                      max-width: 1000px;
                      margin: 0 auto;
                      padding: 20px;
                      background-color: #f9f9f9;
                      border-radius: 25px;
                  }
                  h1 {
                      color: #ff1493;
                      text-align: center;
                  }
                  h3 {
                      color: #666;
                      padding-left: 20px;
                  }
                  #thank {
                      text-align: end;
                      padding-left: 0px !important;
                  }
              </style>
          </head>
          <body>
              <div class="container">	
                  <h1>TP Hỏi và Cưới</h1>
                  <h2>Trân trọng thông báo đến quý khách hàng!</h2>
                  <h2>Nội dung:</h2>
                  <h3>${data.title}</h3>
                  <h3>${data.content}</h3>
                  <h2 id="thank">Cửa hàng xin chân thành cám ơn!</h2>
              </div>
          </body>
      </html>
    `, 
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
      html: `
      <html>
        <head>
            <style>
                body {
                    font-family: Arial, sans-serif;
                }
                .container {
                    width: 100%;
                    max-width: 1000px;
                    margin: 0 auto;
                    padding: 20px;
                    background-color: #f9f9f9;
                    border-radius: 25px;
                }
                h1 {
                    color: #ff1493;
                    text-align: center;
                }
                h3 {
                    color: #666;
                    padding-left: 20px;
                }
            </style>
        </head>
        <body>
            <div class="container">	
                <h1>TP Hỏi và Cưới</h1>
                <h2>Thông báo từ khách hàng ${data.auth}</h2>
                <h2>Nội dung:</h2>
                <h3>${data.title}</h3>
                <h3>${data.content}</h3>
            </div>
        </body>
    </html>
      `, 
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
      const resetLink = `http://localhost:8080/resetpassword/${data.id}z${data.resetToken}`;

      // Chuẩn bị nội dung email
      const mailOptions = {
          from: '"TP - Hỏi và Cưới" <tphoivacuoi@gmail.com>', // sender address
          to: data.email, // list of receivers
          subject: 'Reset Password',
          html: `
          <html>
            <head>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                    }
                    .container {
                        width: 100%;
                        max-width: 1000px;
                        margin: 0 auto;
                        padding: 20px;
                        background-color: #f9f9f9;
                        border-radius: 25px;
                    }
                    h1 {
                        color: #ff1493;
                        text-align: center;
                    }
                    h3 {
                        color: #666;
                        padding-left: 20px;
                    }
                    #thank {
                        text-align: end;
                        padding-left: 0px !important;
                    }
                </style>
            </head>
            <body>
                <div class="container">	
                    <h1>TP Hỏi và Cưới</h1>
                    <h2>Thay đổi Mật Khẩu dành cho quý khách hàng!</h2>
                    <h2>Vui lòng nhấn vào link sau để thay đổi mật khẩu:</h2>
                    <h3><a href="${resetLink}">${resetLink}</a></h3>
                    <h3>OTP: ${data.OTP}</h3>
                    <h2 id="thank">Cửa hàng xin chân thành cám ơn!</h2>
                </div>
            </body>
        </html>
          `
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
