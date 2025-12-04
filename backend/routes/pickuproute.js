import express from "express"

import upload from "../multer/upload.js"
import { registerPickupPartner } from "../controllers/pickupController.js"
const router =  express.Router()


router.post('/register',upload.single("img"),registerPickupPartner)

export default router