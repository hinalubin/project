import bcrypt from "bcrypt";
import pickup from "../models/pickup.js";
import Login from "../models/login.js";

export const registerPickupPartner = async (req, res) => {
  console.log(req.body);
  
  
  try {
    const { name, phone, email, password, vehicleNumber, location } = req.body;

    if (!name || !phone || !email || !password || !vehicleNumber || !location) {
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
      role: "pickup_partner",
    });

    const partner = await pickup.create({
      pickupname:name,
      phone,
      email,
      vehicleno:vehicleNumber,
      Location: {
        lat: Number(location.lat),
        long: Number(location.lng),
      },
      certificateimg: req.file ? req.file.path : null,
      commonKey: login._id,
    });

    return res.status(201).json({
      message: "Pickup partner registered successfully",
      data: partner,
    });

  } catch (error) {
    console.log(error);
    
    return res.status(500).json({ message: error.message });
  }
};

export const getPickupPartnerHome = async (req, res) => {
  try {
    const { loginId } = req.params;

    if (!loginId) {
      return res.status(400).json({ message: "Login ID is required" });
    }

    // Find pickup partner using login id (commonKey)
    const partner = await Pickup.findOne({ commonKey: loginId });

    if (!partner) {
      return res.status(404).json({ message: "Pickup partner not found" });
    }

    return res.status(200).json({
      message: "Pickup partner home data fetched successfully",
      data: partner,
    });

  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: error.message });
  }
};

/* ------------------ Get bookings for pickup partner ------------------ */
export const getPickupBookings = async (req, res) => {
  try {
    const { pickupId } = req.params;
    if (!pickupId) return res.status(400).json({ message: "pickupId required" });

    const bookings = await Booking.find({
      pickupPartnerId: pickupId,
      status: { $in: ["pending", "assigned", "accepted", "on_the_way"] },
    })
      .populate("userId")
      .populate("serviceCenterId")
      .sort({ createdAt: -1 });

    return res.status(200).json({ data: bookings });
  } catch (err) {
    console.error("getPickupBookings:", err);
    return res.status(500).json({ message: err.message });
  }
};

/* ------------------ Pickup accept/reject booking ------------------ */
export const pickupUpdateBooking = async (req, res) => {
  try {
    const { bookingId } = req.params;
    const { action } = req.body; // accept | reject | on_the_way | completed

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
    console.error("pickupUpdateBooking:", err);
    return res.status(500).json({ message: err.message });
  }
};


export const getVerifiedPickupPartners = async (req, res) => {
  try {
    // Step 1: Find verified pickup partner logins
    const verifiedLogins = await Login.find({
      role: "pickup_partner",
      verified: true
    }).select("_id");

    const verifiedIds = verifiedLogins.map(login => login._id);

    // Step 2: Find pickup partners whose commonKey matches verified IDs
    const pickups = await Pickup.find({
      commonKey: { $in: verifiedIds }
    });

    return res.status(200).json({
      message: "Verified pickup partners fetched successfully",
      data: pickups
    });

  } catch (err) {
    console.error("getVerifiedPickupPartners:", err);
    return res.status(500).json({ message: err.message });
  }
};