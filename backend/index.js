import express from "express"
import mongoose from "mongoose"
import cors from "cors"
import router from "./routes/userroute"
const app = express()
mongoose.connect("mongodb://localhost:27017/Mechconnect").then(
    () => { console.log("Mongo db connected successfully") }
).catch((err) => { console.log("db connection error", err) })


app.use(cors({
    origin: "*"
}))

app.use('/user',userroute)
app.listen(5000, "0.0.0.0", () => { console.log("server running on port 5000") })