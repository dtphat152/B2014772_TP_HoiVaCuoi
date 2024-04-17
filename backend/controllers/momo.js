import crypto from 'crypto';
import https from 'https';

export const MomoController = (req, res) => {
    var partnerCode = "MOMO";
    var accessKey = "F8BBA842ECF85";
    var secretkey = "K951B6PE1waDMi640xX08PD3vg6EkVlz";
    var header = `TPno${req.body.bill_id}`;
    var requestId = header + new Date().getTime();
    // var requestId = data.bill_id;
    var orderId = requestId;
    var orderInfo = `TP Hỏi Cưới | #${req.body.bill_id}`;
    var redirectUrl = "http://localhost:8080/myorder";
    var ipnUrl = "http://localhost:8080/myorder";
    // var ipnUrl = redirectUrl = "https://webhook.site/454e7b77-f177-4ece-8236-ddf1c26ba7f8";
    var amount = req.body.bill_total;
    var requestType = "captureWallet"
    var extraData = ""; //pass empty value if your merchant does not have stores
    // console.log("BILL ID: ",req.body.bill_id);
    // console.log("BILL TOTAL: ",req.body.bill_total);
    //before sign HMAC SHA256 with format
    //accessKey=$accessKey&amount=$amount&extraData=$extraData&ipnUrl=$ipnUrl&orderId=$orderId&orderInfo=$orderInfo&partnerCode=$partnerCode&redirectUrl=$redirectUrl&requestId=$requestId&requestType=$requestType
    var rawSignature = "accessKey="+accessKey+"&amount=" + amount+"&extraData=" + extraData+"&ipnUrl=" + ipnUrl+"&orderId=" + orderId+"&orderInfo=" + orderInfo+"&partnerCode=" + partnerCode +"&redirectUrl=" + redirectUrl+"&requestId=" + requestId+"&requestType=" + requestType
    //puts raw signature
    // console.log("--------------------RAW SIGNATURE----------------")
    // console.log(rawSignature)
    //signature

    var signature = crypto.createHmac('sha256', secretkey)
        .update(rawSignature)
        .digest('hex');
    // console.log("--------------------SIGNATURE----------------")
    // console.log(signature)

    //json object send to MoMo endpoint
    const requestBody = JSON.stringify({
        partnerCode : partnerCode,
        accessKey : accessKey,
        requestId : requestId,
        amount : amount,
        orderId : orderId,
        orderInfo : orderInfo,
        redirectUrl : redirectUrl,
        ipnUrl : ipnUrl,
        extraData : extraData,
        requestType : requestType,
        signature : signature,
        lang: 'en'
    });
    //Create the HTTPS objects
    
    const options = {
        hostname: 'test-payment.momo.vn',
        port: 443,
        path: '/v2/gateway/api/create',
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Content-Length': Buffer.byteLength(requestBody)
        }
    }
    //Send the request and get the response
    const request = https.request(options, response => {
        // console.log(`Status: ${response.statusCode}`);
        // console.log(`Headers: ${JSON.stringify(response.headers)}`);
        response.setEncoding('utf8');
        let responseBody = '';
        response.on('data', (chunk) => {
            responseBody += chunk;
        });
        response.on('end', () => {
            // console.log('Response body: ');
            // console.log(responseBody);
            const payUrl = JSON.parse(responseBody).payUrl;
            // console.log('payUrl: ');
            // console.log(payUrl);
            res.json({ redirectUrl: payUrl });
        });
    });
    
    request.on('error', (e) => {
        console.error(`Problem with request: ${e.message}`);
    });
    
    // write data to request body
    // console.log("Sending request....")
    request.write(requestBody);
    request.end();

};