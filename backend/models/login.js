import mongoose, { Schema } from "mongoose";

const loginSchema = new Schema({
    userName: { type: String, required: true },
    passWord: { type: String, required: true },
    roll: { type: String, default: "user" },
    verified: { type: Boolean, default: true }

});
const Login=mongoose.model("Login",loginSchema);
export default Login;