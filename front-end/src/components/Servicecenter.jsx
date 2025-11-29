import React from 'react'
import { Button } from 'react-bootstrap';
import Table from 'react-bootstrap/Table';
import { useNavigate } from 'react-router-dom';

function Servicecenter() {
    const navigate = useNavigate();

  return (
    <div className='container'>
      {/* SIDEBAR */}
      <aside className="sidebar">

        <h2 className="logo">
          <span className="logo-icon">▦</span> Dashboard
        </h2>

        <div className="menu">

          <button className="menu-item " onClick={() => navigate("/dashboard")}>
             <i className="bi bi-house-door"></i> 
            
             Dashboard
          </button>

          <button className="menu-item active" onClick={() => navigate("/servicecenter")}>
            <i className="bi-building"></i> 

            Service Centre
          </button>

          <button className="menu-item" onClick={() => navigate("/viewmechanic")}>
            <i class="bi bi-person-fill"></i>
             Mechanics
          </button>

          <button className="menu-item" onClick={() => navigate("/viewpickup")}>
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
            <main className="main">

        <h1 class="text-center my-4">Service Center Details</h1>

<div class="card shadow-lg p-3 rounded-4">
  <div class="table-responsive">
    <table class="table table-striped align-middle">
      <thead class="table-dark">
        <tr>
          <th>No.</th>
          <th>Name</th>
          <th>Contact</th>
          <th>Email</th>
          <th>Location</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>fyg</td>
          <td>hj</td>
          <td>hyugu</td>
          <td>gh</td>
          <td>kjh</td>
          <td>
            <button class="btn btn-success btn-sm rounded-pill px-3 mx-1">Accept</button>
            <button class="btn btn-danger btn-sm rounded-pill px-3">Reject</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</div>

    </main>
    </div>
  )
}

export default Servicecenter