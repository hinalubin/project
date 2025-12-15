import express from "express";
import { registerVehicle, getUserVehicles, deleteVehicle } from "../controllers/vehicleController.js";

const router = express.Router();

router.post("/register", registerVehicle);
router.get("/:userId", getUserVehicles);
router.delete("/:vehicleId", deleteVehicle);

export default router;