import express from "express"
import {  registerServiceCenter } from "../controllers/servicecenterController.js"
import upload from "../multer/upload.js"
const router =  express.Router()


router.post('/register',upload.single("certificateImg"),registerServiceCenter)

export default router