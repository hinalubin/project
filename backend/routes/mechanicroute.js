import express from "express"
import {  registerMechanic} from "../controllers/mechanicController.js"
import upload from "../multer/upload.js"

const router =  express.Router()


router.post('/register',upload.single("img"),registerMechanic)

export default router