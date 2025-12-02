import Login from "../models/login.js";
import bcrypt from "bcrypt";

export const loginUser = async (req, res) => {
  console.log(req.body);
  
  try {
    const { email, password } = req.body;

    // Check empty fields
    if (!email || !password) {
      return res.status(400).json({ message: "Email and password are required" });
    }

    // Check if user exists
    const user = await Login.findOne({ userName: email });
    if (!user) {
      return res.status(404).json({ message: "No user found with this email" });
    }

    // Check if verified
    if (!user.verified) {
      return res.status(403).json({ message: "Account not verified" });
    }

    // Compare password
    const match = await bcrypt.compare(password, user.passWord);
    if (!match) {
      return res.status(401).json({ message: "Invalid password" });
    }

    return res.status(200).json({
      message: "Login successful",
      role: user.role,
      verified: user.verified,
      id: user._id
    });

  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};