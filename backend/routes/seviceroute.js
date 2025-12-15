import express from "express"
import {  getServiceCenterHome, registerServiceCenter } from "../controllers/servicecenterController.js"
import upload from "../multer/upload.js"
const router =  express.Router()


router.post('/register',upload.single("certificateImg"),registerServiceCenter)
router.get('/home/:loginId',getServiceCenterHome)

export default router