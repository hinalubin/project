import ServiceCenter from "../models/serviceCenterModel.js";
import Login from "../models/loginModel.js";
import bcrypt from "bcrypt";

export const registerServiceCenter = async (req, res) => {
  try {
    const { centerName, ownerName, phone, email, password, location } = req.body;

    if (!centerName || !ownerName || !phone || !email || !password || !location) {
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
      role: "service_center"
    });

    const serviceCenter = await ServiceCenter.create({
      centerName,
      ownerName,
      phone,
      email,
      location: {
        lat: Number(location.lat),
        lng: Number(location.lng),
      },
      certificateImg: req.file ? req.file.path : null,
      commonKey: login._id,
    });

    return res.status(201).json({
      message: "Service center registered successfully",
      data: serviceCenter,
    });

  } catch (error) {
    console.error("Error registering service center:", error);
    return res.status(500).json({ message: error.message });
  }
};

// home
export const getServiceCenterHome = async (req, res) => {
  try {
    const { loginId } = req.params;
    const sc = await ServiceCenter.findOne({ commonKey: loginId });

    if (!sc) return res.status(404).json({ message: "Service center not found" });

    return res.status(200).json({ data: sc });

  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};