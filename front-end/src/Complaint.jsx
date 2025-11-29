import React from 'react'
import Table from 'react-bootstrap/Table';
import { useNavigate } from 'react-router-dom';

function Complaint() {
  const navigate = useNavigate();
  return (
    <div className='container'>
      <aside className="sidebar">

        <h2 className="logo">
          <span className="logo-icon">▦</span> Dashboard
        </h2>

        <div className="menu">

          <button className="menu-item " onClick={() => navigate("/dashboard")}>
             <i className="bi bi-house-door"></i> 
            
             Dashboard
          </button>

          <button className="menu-item" onClick={() => navigate("/servicecenter")}>
            <i className="bi-building"></i> 

            Service Centre
          </button>

          <button className="menu-item " onClick={() => navigate("/viewmechanic")}>
            <i class="bi bi-person-fill"></i>
             Mechanics
          </button>

          <button className="menu-item " onClick={() => navigate("/viewpickup")}>
            <i class=" bi-credit-card"></i>
             Pickup
          </button>

          <button className="menu-item " onClick={() => navigate("/booking")}>
            <i class=" bi-calendar-event"></i>
             Bookings
          </button>

          <button className="menu-item active" onClick={() => navigate("/complaint")}>
            <i class=" bi-chat-left-dots"></i>
            Complaints
          </button>

          
        </div>
      </aside>
      <main className='main'>
        <h1><center>Complaint Details</center></h1>
        <Table striped>
      <thead>
        <tr>
          <th>id</th>
          <th>Name</th>
          <th>Service center</th>
          <th>Complaint</th>
          
          
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>fyg</td>
          <td>hj</td>
          <td>hyugu</td>
          <td>gh</td>
          
        </tr>
        <tr>
          <td>jh</td>
          <td>kj</td>
          <td>jh</td>
          <td>o</td>
         
        </tr>
       
      </tbody>
    </Table>
    </main>
    </div>
  )
}

export default Complaint