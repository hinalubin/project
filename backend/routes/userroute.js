import { userReg } from "../controllers/userController.js"
import express from "express"

const router =  express.Router()


router.post('/register',userReg)

export default router