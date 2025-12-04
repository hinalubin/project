import mongoose, { Schema } from "mongoose";

const userschema=new Schema({
    name:{type:String,required:true},
    phone: { type: String, required: true },
    email: { type: String, required: true },
    commonKey: {
            type: Schema.Types.ObjectId,
            ref: "Login",
        },
});
const User = mongoose.model("User",userschema);
export default User;