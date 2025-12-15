import mongoose from "mongoose";

const vehicleSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "UserData",
    required: true
  },
  brand: {
    type: String,
    required: true
  },
  model: {
    type: String,
    required: true
  },
 
  year: {
    type: Number
  },
  vehicleNumber: {
    type: String,
    required: true,
    unique: true
  },
  fuelType: {
    type: String,
    // enum: ["petrol", "diesel", "electric", "cng", "hybrid"],
    required: true
  },
   vehicleType: {
    type: String,
     required: true
    
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

export default mongoose.model("Vehicle", vehicleSchema);