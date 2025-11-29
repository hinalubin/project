import mongoose, { Schema } from "mongoose";

const pickupSchema = new Schema({
    pickupname: { type: String, required: true },
    phone: { type: String, required: true },
    email: { type: String, required: true },
    vehicleno:{type:String,required:true},
    Location: {
        lat: { type: Number, required: true },
        long: { type: Number, required: true },
    },
    certificateimg: { type: String ,required:true},
    commonKey: {
        type: Schema.Types.ObjectId,
        ref: "Login",
    },


});
const pickup = mongoose.model("Pickup", pickupSchema);
export default Pickup;
