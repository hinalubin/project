import Login from "../models/login.js";
import UserData from "../models/user.js";
import bcrypt from "bcrypt";
// import Booking from "../models/bookig.js"
export const userReg = async (req, res) => {
  console.log('hittttttttttttttt');

  
  console.log(req.body);

  try {
    const { name, email, phone, password } = req.body;

    // Validate fields
    if (!name || !email || !phone || !password ) {
      return res.status(400).json({ message: "All fields are required" });
    }

    // if (!location.lat || !location.lng) {
    //   return res.status(400).json({ message: "Location lat & lng are required" });
    // }


    const existingUser = await Login.findOne({ userName: email });
    if (existingUser) {
      return res.status(409).json({ message: "User already exists" });
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Create login entry
    const loginData = await Login.create({
      userName: email,
      passWord: hashedPassword,
      role: "user",
    });

    // Create user entry
    const user = await UserData.create({
      name,
      email,
      phone,
      // location: {
      //   lat: location.lat,
      //   lng: location.lng
      // },
      commonKey: loginData._id,
    });

    return res.status(201).json({
      message: "User registered successfully",
      user: {
        name: user.name,
        email: user.email,
        phone: user.phone,
        location: user.location,
        loginId: loginData._id
      }
    });

  } catch (error) {
    console.error("Error creating user:", error);
    return res.status(500).json({ message: error.message });
  }
};

// home
export const getUserHome = async (req, res) => {
  try {
    const { loginId } = req.params;
    const user = await UserData.findOne({ commonKey: loginId });

    if (!user) return res.status(404).json({ message: "User not found" });

    return res.status(200).json({ data: user });

  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

// get nearestr service senter
export const getNearestServiceCenters = async (req, res) => {
  try {
    const { lat, lng, limit = 10 } = req.query;
    if (!lat || !lng) return res.status(400).json({ message: "lat & lng required" });

    const centers = await ServiceCenter.find();
    const withDistance = centers.map((c) => {
      const d = haversineDistance(
        Number(lat),
        Number(lng),
        Number(c.location?.lat ?? 0),
        Number(c.location?.lng ?? 0)
      );
      return { center: c, distanceKm: d };
    });

    withDistance.sort((a, b) => a.distanceKm - b.distanceKm);

    return res.status(200).json({ data: withDistance.slice(0, Number(limit)) });
  } catch (err) {
    console.error("getNearestServiceCenters:", err);
    return res.status(500).json({ message: err.message });
  }
};
/* ------------------ Create booking (user) ------------------ */
// export const createBooking = async (req, res) => {
//   try {
//     const {
//       userId,
//       type, // "mechanic" | "pickup" | "service_center"
//       serviceCenterId,
//       mechanicId,
//       pickupPartnerId,
//       description,
//       userLocation, // { lat, lng }
//     } = req.body;

//     if (!userId || !type || !userLocation) {
//       return res.status(400).json({ message: "userId, type and userLocation are required" });
//     }

//     const booking = await Booking.create({
//       userId: mongoose.Types.ObjectId(userId),
//       type,
//       serviceCenterId: serviceCenterId ? mongoose.Types.ObjectId(serviceCenterId) : null,
//       mechanicId: mechanicId ? mongoose.Types.ObjectId(mechanicId) : null,
//       pickupPartnerId: pickupPartnerId ? mongoose.Types.ObjectId(pickupPartnerId) : null,
//       problemDescription: description || "",
//       userLocation,
//       status: "pending",
//       createdAt: new Date(),
//       updatedAt: new Date(),
//     });

//     // Optionally: emit notification to target (service center / mechanic / pickup)
//     return res.status(201).json({ message: "Booking created", booking });
//   } catch (err) {
//     console.error("createBooking:", err);
//     return res.status(500).json({ message: err.message });
//   }
// };

/* ------------------ User booking history ------------------ */
export const getUserBookings = async (req, res) => {
  try {
    const { userId } = req.params;
    if (!userId) return res.status(400).json({ message: "userId required" });

    const bookings = await Booking.find({ userId: userId })
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


export const getVerifiedServiceCenters = async (req, res) => {
  try {
    // Step 1: Find logins where role = service_center and verified = true
    const verifiedLogins = await Login.find({ 
      role: "service_center", 
      verified: true 
    }).select("_id");

    // Extract only login IDs
    const verifiedIds = verifiedLogins.map(login => login._id);

    // Step 2: Find service centers where commonKey matches a verified login
    const centers = await ServiceCenter.find({
      commonKey: { $in: verifiedIds }
    });

    return res.status(200).json({
      message: "Verified service centers fetched successfully",
      data: centers
    });

  } catch (err) {
    console.error("getVerifiedServiceCenters:", err);
    return res.status(500).json({ message: err.message });
  }
};