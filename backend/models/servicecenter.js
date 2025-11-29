import mongoose, { Schema } from "mongoose";

const serviceSchema=new Schema({
    centerName:{type:String,required:true},
    ownerName:{type:String,required:true},
    phone:{type:String,required:true},
    email:{type:String,required:true},
    Location:{
        lat:{type:Number,required:true},
        long:{type:Number,required:true},
    },
    certificateimg:{type:String,required:true},
    commonKey:{
        type:Schema.Types.ObjectId,
        ref:"Login",
    },


});
const Servicecenter=mongoose.model("Service",serviceSchema);
export default Servicecenter;