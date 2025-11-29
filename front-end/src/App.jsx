import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'
import Login from './components/Login'
import Servicecenter from './components/Servicecenter'
import Mechanic from './components/Mechanic'
import Pickup from './components/Pickup'
import { Route, Routes } from 'react-router-dom'
import Booking from './Booking'
import Complaint from './Complaint'
import Dashboard from './components/Dashboard'
import 'bootstrap-icons/font/bootstrap-icons.css';



function App() {
  // const [count, setCount] = useState(0)

  return (
    <>
      {/* <div>
        <a href="https://vite.dev" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Vite  project</h1>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          count is {count}
        </button>
        <p>
          Edit <code>src/App.jsx</code> and save to test HMR
        </p>
      </div>
      <p className="read-the-docs">
        Click on the Vite and React logos to learn more
      </p> */}
      {/* <Login/> */}
      {/* <Servicecenter/> */}
      {/* <Mechanic/> */}
      {/* <Pickup/> */}
      <Routes>
        <Route path='/' element={<Login/>}/>
        <Route path='/servicecenter' element={<Servicecenter/>}/>
        <Route path='/viewmechanic' element={<Mechanic/>}/>
        <Route path='/viewpickup' element={<Pickup/>}/>
        <Route path='/booking' element={<Booking/>}/>
        <Route path='/complaint' element={<Complaint/>}/>
        <Route path='/dashboard' element={<Dashboard/>}/>



      
      </Routes>
    </>
    
  )
}

export default App
