import { userReg } from "../controllers/userController"
import express from "express"

const router =  express.Router()


router.post('/register',userReg)

export default router