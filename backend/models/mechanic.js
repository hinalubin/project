import { Schema } from "mongoose";

const mechanicschema = new Schema({
    mechanicName: { type: String, required: true },
    phone: { type: String, required: true },
    email: { type: String, required: true },
    Experience:{type:String,required:true},
    Location: {
        lat: { type: Number, required: true },
        long: { type: Number, required: true },
    },
    certificateimg: { type: String,required:true },
    commonKey: {
        type: Schema.Types.ObjectId,
        ref: "Login",
    },


});
const Mechanic = mongoose.model("Pickup", mechanicschema);
export default Mechanic;
