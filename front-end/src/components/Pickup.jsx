import React from 'react'
import { Button } from 'react-bootstrap';
import Table from 'react-bootstrap/Table';
import { useNavigate } from 'react-router-dom';

function Pickup() {
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

          <button className="menu-item active" onClick={() => navigate("/viewpickup")}>
            <i class=" bi-credit-card"></i>
             Pickup
          </button>

          <button className="menu-item" onClick={() => navigate("/booking")}>
            <i class=" bi-calendar-event"></i>
             Bookings
          </button>

          <button className="menu-item" onClick={() => navigate("/complaint")}>
            <i class=" bi-chat-left-dots"></i>
            Complaints
          </button>

          

        </div>
      </aside>
      <main className='main'>
        <h1><center>Pickup details</center></h1>
         <Table striped>
      <thead>
        <tr>
          <th>No.</th>
          <th>Name</th>
          <th>Contact</th>
          <th>Email</th>
          <th>Vehicle no</th>
          <th></th>
          
        </tr>
      </thead>
      <tbody>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td><Button className='btn-success mx-2'>Accept </Button><Button className='btn-danger'>Reject</Button></td>
        </tr>
        
       
      </tbody>
    </Table>
    </main>
    </div>
  )
}

export default Pickup