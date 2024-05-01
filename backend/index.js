import express from "express";
import bodyParser from "body-parser";
import cors from "cors";
import router from "./routes/routes.js";
import uploads from "./uploads/uploads.js";
import recommend from "./recommendation/routes.js";

import path from "path";
import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  next();
});

const corsOptions ={
  origin: '*', 
  credentials: true,  
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'HEAD', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Origin', 'X-Requested-With', 'Accept', 'x-client-key', 'x-client-token', 'x-client-secret', 'Authorization'],
  optionSuccessStatus: 200,
  // Tắt CORS preflight request cho các yêu cầu đến 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html'
  preflightContinue: false
}

app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

app.use(cors(corsOptions));

app.use(router);
app.use(uploads);
app.use(recommend);

const PORT = process.env.PORT || 8081;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});
