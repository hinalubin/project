import mongoose, { Schema } from "mongoose";

const mechanicschema = new Schema({
    mechanicName: { type: String, required: true },
    phone: { type: String, required: true },
    email: { type: String, required: true },
    Experience:{type:String,required:true},
    
    certificateimg: { type: String,required:true },
    commonKey: {
        type: Schema.Types.ObjectId,
        ref: "Login",
    },


});
const Mechanic = mongoose.model("Mechanic", mechanicschema);
export default Mechanic;
