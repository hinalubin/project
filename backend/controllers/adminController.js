// controllers/adminController.js
import Login from "../models/loginModel.js";
import UserData from "../models/userModel.js";
import Mechanic from "../models/mechanicModel.js";
import ServiceCenter from "../models/serviceCenterModel.js";
import Pickup from "../models/pickupModel.js"
import Booking from "../models/bookingModel.js";


/* ------------------ View all users ------------------ */
export const viewAllUsers = async (req, res) => {
  try {
    const users = await UserData.find().sort({ createdAt: -1 });
    return res.status(200).json({ data: users });
  } catch (err) {
    console.error("viewAllUsers:", err);
    return res.status(500).json({ message: err.message });
  }
};

/* ------------------ View all mechanics ------------------ */
export const viewAllMechanics = async (req, res) => {
  try {
    const mechanics = await Mechanic.find().sort({ createdAt: -1 });
    return res.status(200).json({ data: mechanics });
  } catch (err) {
    console.error("viewAllMechanics:", err);
    return res.status(500).json({ message: err.message });
  }
};

/* ------------------ View all service centers ------------------ */
export const viewAllServiceCenters = async (req, res) => {
  try {
    const centers = await ServiceCenter.find().sort({ createdAt: -1 });
    return res.status(200).json({ data: centers });
  } catch (err) {
    console.error("viewAllServiceCenters:", err);
    return res.status(500).json({ message: err.message });
  }
};

/* ------------------ View all pickup partners ------------------ */
export const viewAllPickupPartners = async (req, res) => {
  try {
    const pickups = await Pickup.find().sort({ createdAt: -1 });
    return res.status(200).json({ data: pickups });
  } catch (err) {
    console.error("viewAllPickupPartners:", err);
    return res.status(500).json({ message: err.message });
  }
};

/* ------------------ Approve or reject an account (login) ------------------ */
export const approveAccount = async (req, res) => {
  try {
    const { loginId } = req.params;
    const { verified } = req.body; // true | false
    if (typeof verified !== "boolean") return res.status(400).json({ message: "verified(boolean) required" });

    const login = await Login.findByIdAndUpdate(loginId, { verified }, { new: true });
    if (!login) return res.status(404).json({ message: "Login entry not found" });

    return res.status(200).json({ message: `Account ${verified ? "approved" : "rejected"}`, login });
  } catch (err) {
    console.error("approveAccount:", err);
    return res.status(500).json({ message: err.message });
  }
};

/* ------------------ Delete any account (and linked profile) ------------------ */
export const deleteAccount = async (req, res) => {
  try {
    const { loginId } = req.params;
    if (!loginId) return res.status(400).json({ message: "loginId required" });

    const login = await Login.findById(loginId);
    if (!login) return res.status(404).json({ message: "Login not found" });

    // Remove linked profile by role
    const role = login.role;
    if (role === "user") {
      await UserData.findOneAndDelete({ commonKey: loginId });
    } else if (role === "mechanic") {
      await Mechanic.findOneAndDelete({ commonKey: loginId });
    } else if (role === "service_center") {
      await ServiceCenter.findOneAndDelete({ commonKey: loginId });
    } else if (role === "pickup_partner") {
      await Pickup.findOneAndDelete({ commonKey: loginId });
    }

    // delete bookings created by user if needed (optional)
    // await Booking.deleteMany({ userId: someId });

    await Login.findByIdAndDelete(loginId);

    return res.status(200).json({ message: "Account deleted" });
  } catch (err) {
    console.error("deleteAccount:", err);
    return res.status(500).json({ message: err.message });
  }
};

/* ------------------ Admin: view all bookings ------------------ */
export const adminListBookings = async (req, res) => {
  try {
    const bookings = await Booking.find()
      .populate("userId")
      .populate("serviceCenterId")
      .populate("mechanicId")
      .populate("pickupPartnerId")
      .sort({ createdAt: -1 });

    return res.status(200).json({ data: bookings });
  } catch (err) {
    console.error("adminListBookings:", err);
    return res.status(500).json({ message: err.message });
  }
};