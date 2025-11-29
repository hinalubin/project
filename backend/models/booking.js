
import mongoose from "mongoose";

const bookingSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "UserData",
      required: true,
    },

   
    type: {
      type: String,
      enum: ["mechanic", "pickup", "service_center"],
      required: true,
    },

    // If USER selected a service center
    serviceCenterId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "ServiceCenter",
      default: null,
    },

    // Mechanic assigned by service center OR chosen directly by user
    mechanicId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Mechanic",
      default: null,
    },

    // Pickup partner selected by user
    pickupPartnerId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Pickup",
      default: null,
    },

    problemDescription: {
      type: String,
      default: "",
    },

    problemImage: {
      type: String, // uploaded file path
      default: null,
    },

    userLocation: {
      lat: { type: Number, required: true },
      lng: { type: Number, required: true },
    },

    status: {
      type: String,
      enum: [
        "pending",      // user created booking
        "assigned",     // service center assigned mechanic
        "accepted",     // mechanic/pickup accepted
        "on_the_way",   // mechanic/pickup enroute
        "completed",    // job done
        "rejected",     // mechanic/pickup rejected
        "cancelled",    // cancelled by admin or user
      ],
      default: "pending",
    },
  },
  { timestamps: true } // adds createdAt, updatedAt
);
const Booking= mongoose.model("Booking", bookingSchema);
export default Booking