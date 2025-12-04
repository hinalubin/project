import bcrypt from "bcrypt";
import Mechanic from "../models/mechanic.js";
import Login from "../models/login.js";

export const registerMechanic = async (req, res) => {
  try {
    const { mechanicName, phone, email, password, experience } = req.body;

    if (!mechanicName || !phone || !email || !password || !experience ) {
      return res.status(400).json({ message: "All fields are required" });
    }

    const existing = await Login.findOne({ userName: email });
    if (existing) {
      return res.status(409).json({ message: "Email already exists" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const login = await Login.create({
      userName: email,
      passWord: hashedPassword,
      role: "mechanic",
    });

    const mechanic = await Mechanic.create({
      mechanicName,
      phone,
      email,
      Experience:experience,
    //   location: {
    //     lat: Number(location.lat),
    //     lng: Number(location.lng),
    //   },
      certificateimg: req.file ? req.file.path : null,
      commonKey: login._id,
    });

    return res.status(201).json({
      message: "Mechanic registered successfully",
      data: mechanic,
    });

  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};


// mechanic home

export const getMechanicHome = async (req, res) => {
  try {
    const { loginId } = req.params;
    const mech = await Mechanic.findOne({ commonKey: loginId });

    if (!mech) return res.status(404).json({ message: "Mechanic not found" });

    return res.status(200).json({ data: mech });

  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};


/* ------------------ Get bookings assigned to mechanic ------------------ */
export const getMechanicBookings = async (req, res) => {
  try {
    const { mechanicId } = req.params;
    if (!mechanicId) return res.status(400).json({ message: "mechanicId required" });

    const bookings = await Booking.find({
      mechanicId: mechanicId,
      status: { $in: ["assigned", "accepted", "on_the_way"] },
    })
      .populate("userId")
      .populate("serviceCenterId")
      .sort({ createdAt: -1 });

    return res.status(200).json({ data: bookings });
  } catch (err) {
    console.error("getMechanicBookings:", err);
    return res.status(500).json({ message: err.message });
  }
};

/* ------------------ Mechanic accept/reject booking ------------------ */
export const mechanicUpdateBooking = async (req, res) => {
  try {
    const { bookingId } = req.params;
    const { action } = req.body; // "accept" | "reject" | "on_the_way" | "completed"

    if (!bookingId || !action) return res.status(400).json({ message: "bookingId & action required" });

    const valid = ["accept", "reject", "on_the_way", "completed"];
    if (!valid.includes(action)) return res.status(400).json({ message: "Invalid action" });

    const update = {};
    if (action === "accept") update.status = "accepted";
    if (action === "reject") update.status = "rejected";
    if (action === "on_the_way") update.status = "on_the_way";
    if (action === "completed") update.status = "completed";
    update.updatedAt = new Date();

    const booking = await Booking.findByIdAndUpdate(bookingId, update, { new: true });

    return res.status(200).json({ message: `Booking ${action}`, booking });
  } catch (err) {
    console.error("mechanicUpdateBooking:", err);
    return res.status(500).json({ message: err.message });
  }
};