import vehicleModel from "../models/vehicleModel.js";

export const registerVehicle = async (req, res) => {
  console.log(req.body);
  
  try {
    const { userId, brand, model, year, vehicleNumber, fuelType ,vehicleType} = req.body;

    if (!userId || !brand || !model || !vehicleNumber || !fuelType|| !vehicleType) {
      return res.status(400).json({ message: "Required fields missing" });
    }

    // Check duplicate plate number
    const exists = await vehicleModel.findOne({ vehicleNumber });
    if (exists) {
      return res.status(409).json({ message: "Vehicle already registered with this plate number" });
    }

    const vehicle = await vehicleModel.create({
      userId,
      brand,
      model,
      year,
      vehicleNumber,
      fuelType,
      vehicleType
    });

    res.status(201).json({
      message: "Vehicle registered successfully",
      data: vehicle
    });

  } catch (error) {
    console.error("registerVehicle:", error);
    res.status(500).json({ message: error.message });
  }
};
export const getUserVehicles = async (req, res) => {
  try {
    const { userId } = req.params;
    console.log(userId,"userrriddddddddddddddddddddddddddddd");
    

    const vehicles = await vehicleModel.find({ userId });

    res.status(200).json({ data: vehicles });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};


export const deleteVehicle = async (req, res) => {
  try {
    const { vehicleId } = req.params;

    if (!vehicleId) {
      return res.status(400).json({ message: "vehicleId is required" });
    }

    const vehicle = await Vehicle.findById(vehicleId);

    if (!vehicle) {
      return res.status(404).json({ message: "Vehicle not found" });
    }

    await Vehicle.findByIdAndDelete(vehicleId);

    return res.status(200).json({
      message: "Vehicle deleted successfully"
    });

  } catch (err) {
    console.error("deleteVehicle:", err);
    res.status(500).json({ message: err.message });
  }
};