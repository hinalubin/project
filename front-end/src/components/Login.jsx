import React from 'react'
import './Login.css'
import { Link } from 'react-router-dom'
function Login() {
  return (
    <div className='loginpage'>
        <form className='formpage'>
    <h1 className='title'>LOGIN</h1>
<input className ='input'type='text' placeholder='Username'/><br></br>
<input className ='input input1'type='password' placeholder='Password'/><br></br>
<button className='loginbtn'>SIGN IN</button>

 {/* <Button variant="outline-primary">Primary</Button> */}
</form>
    </div >
    
  )
}

export default Login