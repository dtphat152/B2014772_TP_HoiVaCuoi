// using nodemon so that you do not need to type node index.js every time new code saved

// import express - is for building the Rest apis
import express from "express";

// import body-parser - helps to parse the request and create the req.body object
import bodyParser from "body-parser";

// import cors - provides Express middleware to enable CORS with various options, connect frontend
import cors from "cors";

// import routes
import router from "./routes/routes.js";

// init express
const app = express();

// use express json
app.use(express.json({ limit: '50mb' }));
app.use(express.urlencoded({ limit: '50mb', extended: true }));

//use cors
app.use(cors({
  origin: 'http://localhost:8080', // Replace with the origin of your Vue.js app
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true,
  optionsSuccessStatus: 204,
}));

app.options('*', cors());

// use router
app.use(router);


app.get('/', function(req, res){
    res.json({ message: 'Welcome to tpstore api' });
});

// PORT
const PORT = process.env.PORT || 8081;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});

