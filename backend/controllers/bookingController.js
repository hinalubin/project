// controllers/bookingController.js
// import Booking from "../models/bookingModel.js";
import mongoose from "mongoose";
import Booking from "../models/bookigModel.js";

/* ---------------------------------------------------------
   CREATE BOOKING  (USER)
--------------------------------------------------------- */
export const createBooking = async (req, res) => {
  try {
    const {
      userId,
      type, // "mechanic" | "pickup" | "service_center"
      serviceCenterId,
      mechanicId,
      pickupPartnerId,
      description,
      userLocation
    } = req.body;

    if (!userId || !type || !userLocation) {
      return res.status(400).json({ message: "userId, type & userLocation required" });
    }

    const booking = await Booking.create({
      userId: mongoose.Types.ObjectId(userId),
      type,
      serviceCenterId: serviceCenterId ? mongoose.Types.ObjectId(serviceCenterId) : null,
      mechanicId: mechanicId ? mongoose.Types.ObjectId(mechanicId) : null,
      pickupPartnerId: pickupPartnerId ? mongoose.Types.ObjectId(pickupPartnerId) : null,
      problemDescription: description || "",
      userLocation,
      status: "pending"
    });

    return res.status(201).json({
      message: "Booking created successfully",
      data: booking
    });
  } catch (err) {
    console.error("createBooking:", err);
    return res.status(500).json({ message: err.message });
  }
};

/* ---------------------------------------------------------
   GET BOOKING BY ID
--------------------------------------------------------- */
export const getBookingById = async (req, res) => {
  try {
    const { bookingId } = req.params;

    const bookingdata = await Booking.findById(bookingId)
      .populate("userId")
      .populate("serviceCenterId")
      .populate("mechanicId")
      .populate("pickupPartnerId");

    if (!bookingdata) return res.status(404).json({ message: "Booking not found" });

    return res.status(200).json({ data: bookingdata });
  } catch (err) {
    console.error("getBookingById:", err);
    return res.status(500).json({ message: err.message });
  }
};

/* ---------------------------------------------------------
   UPDATE BOOKING STATUS (Any role)
   Valid: pending, assigned, accepted, on_the_way, completed, rejected, cancelled
--------------------------------------------------------- */
export const updateBookingStatus = async (req, res) => {
  try {
    const { bookingId } = req.params;
    const { status } = req.body;

    if (!status) return res.status(400).json({ message: "status required" });

    const validStatus = [
      "pending",
      "assigned",
      "accepted",
      "on_the_way",
      "completed",
      "rejected",
      "cancelled"
    ];

    if (!validStatus.includes(status)) {
      return res.status(400).json({ message: "Invalid booking status" });
    }

    const bookingdata = await Booking.findByIdAndUpdate(
      bookingId,
      { status, updatedAt: new Date() },
      { new: true }
    );

    if (!bookingdata) return res.status(404).json({ message: "Booking not found" });

    return res.status(200).json({ message: "Status updated", data: bookingdata });
  } catch (err) {
    console.error("updateBookingStatus:", err);
    return res.status(500).json({ message: err.message });
  }
};

/* ---------------------------------------------------------
   LIST ALL BOOKINGS (Admin or Dashboard)
   Filters: /booking?status=accepted&type=mechanic
--------------------------------------------------------- */
export const listBookings = async (req, res) => {
  try {
    const { status, type } = req.query;

    const filter = {};
    if (status) filter.status = status;
    if (type) filter.type = type;

    const bookings = await Booking.find(filter)
      .populate("userId")
      .populate("serviceCenterId")
      .populate("mechanicId")
      .populate("pickupPartnerId")
      .sort({ createdAt: -1 });

    return res.status(200).json({ data: bookings });
  } catch (err) {
    console.error("listBookings:", err);
    return res.status(500).json({ message: err.message });
  }
};

/* ---------------------------------------------------------
   USER BOOKINGS
--------------------------------------------------------- */
export const getUserBookings = async (req, res) => {
  try {
    const { userId } = req.params;

    const bookings = await Booking.find({ userId })
      .populate("serviceCenterId")
      .populate("mechanicId")
      .populate("pickupPartnerId")
      .sort({ createdAt: -1 });

    return res.status(200).json({ data: bookings });
  } catch (err) {
    console.error("getUserBookings:", err);
    return res.status(500).json({ message: err.message });
  }
};

/* ---------------------------------------------------------
   SERVICE CENTER BOOKINGS
--------------------------------------------------------- */
export const getServiceCenterBookings = async (req, res) => {
  try {
    const { serviceCenterId } = req.params;

    const bookings = await Booking.find({
      serviceCenterId,
      status: { $in: ["pending", "assigned", "accepted", "on_the_way"] }
    })
      .populate("userId")
      .populate("mechanicId")
      .sort({ createdAt: -1 });

    return res.status(200).json({ data: bookings });
  } catch (err) {
    console.error("getServiceCenterBookings:", err);
    return res.status(500).json({ message: err.message });
  }
};

/* ---------------------------------------------------------
   ASSIGN MECHANIC (Service Center)
--------------------------------------------------------- */
export const assignMechanic = async (req, res) => {
  try {
    const { bookingId } = req.params;
    const { mechanicId } = req.body;

    if (!mechanicId)
      return res.status(400).json({ message: "mechanicId is required" });

    const booking = await Booking.findByIdAndUpdate(
      bookingId,
      {
        mechanicId: mongoose.Types.ObjectId(mechanicId),
        status: "assigned",
        updatedAt: new Date()
      },
      { new: true }
    );

    return res.status(200).json({
      message: "Mechanic assigned successfully",
      data: booking
    });
  } catch (err) {
    console.error("assignMechanic:", err);
    return res.status(500).json({ message: err.message });
  }
};

/* ---------------------------------------------------------
   MECHANIC ACCEPT / REJECT / ON THE WAY / COMPLETED
--------------------------------------------------------- */
export const mechanicAction = async (req, res) => {
  try {
    const { bookingId } = req.params;
    const { action } = req.body;

    const allowed = ["accept", "reject", "on_the_way", "completed"];
    if (!allowed.includes(action))
      return res.status(400).json({ message: "Invalid action" });

    const statusMapping = {
      accept: "accepted",
      reject: "rejected",
      on_the_way: "on_the_way",
      completed: "completed"
    };

    const booking = await Booking.findByIdAndUpdate(
      bookingId,
      { status: statusMapping[action], updatedAt: new Date() },
      { new: true }
    );

    return res.status(200).json({
      message: `Booking ${action}`,
      data: booking
    });
  } catch (err) {
    console.error("mechanicAction:", err);
    return res.status(500).json({ message: err.message });
  }
};

/* ---------------------------------------------------------
   PICKUP PARTNER ACTIONS (ACCEPT / REJECT / ON THE WAY / COMPLETED)
--------------------------------------------------------- */
export const pickupAction = async (req, res) => {
  try {
    const { bookingId } = req.params;
    const { action } = req.body;

    const allowed = ["accept", "reject", "on_the_way", "completed"];
    if (!allowed.includes(action))
      return res.status(400).json({ message: "Invalid action" });

    const statusMapping = {
      accept: "accepted",
      reject: "rejected",
      on_the_way: "on_the_way",
      completed: "completed"
    };

    const booking = await Booking.findByIdAndUpdate(
      bookingId,
      { status: statusMapping[action], updatedAt: new Date() },
      { new: true }
    );

    return res.status(200).json({
      message: `Booking ${action}`,
      data: booking
    });
  } catch (err) {
    console.error("pickupAction:", err);
    return res.status(500).json({ message: err.message });
  }
};

/* ---------------------------------------------------------
   MECHANIC BOOKINGS
--------------------------------------------------------- */
export const getMechanicBookings = async (req, res) => {
  try {
    const { mechanicId } = req.params;

    const bookings = await Booking.find({
      mechanicId,
      status: { $in: ["assigned", "accepted", "on_the_way"] }
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

/* ---------------------------------------------------------
   PICKUP PARTNER BOOKINGS
--------------------------------------------------------- */
export const getPickupBookings = async (req, res) => {
  try {
    const { pickupPartnerId } = req.params;

    const bookings = await Booking.find({
      pickupPartnerId,
      status: { $in: ["pending", "accepted", "on_the_way"] }
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