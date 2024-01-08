import express, { json } from "express";
import dotenv from "dotenv";
import connectDB from "./config/database.js";
import cors from "cors";
import router from "./routes/url.js";

const main = express();

dotenv.config();

const DATABASE_URL = process.env.DATABASE_URL || "mongodb://127.0.0.1";
connectDB(DATABASE_URL);

main.use(express.json());

// main.use(function (req, res, next) {
//   res.header("Access-Control-Allow-Origin", "http://localhost:56926");
//   res.header(
//     "Access-Control-Allow-Headers",
//     "Origin, X-Requested-With, Content-Type, Accept"
//   );
//   next();
// });

main.use(cors());

main.use("/api", router);

const port = process.env.PORT;
main.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
