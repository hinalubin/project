import { getUserHome, userReg } from "../controllers/userController.js"
import express from "express"

const router =  express.Router()


router.post('/register',userReg)
router.get('/home/:loginId',getUserHome)
export default router