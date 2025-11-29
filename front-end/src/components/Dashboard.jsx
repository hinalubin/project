import React from "react";
import { useNavigate } from "react-router-dom";
import "./Dashboard.css";


const Dashboard = () => {
  const navigate = useNavigate();

  return (
    <div className="container">

      {/* SIDEBAR */}
      <aside className="sidebar">

        <h2 className="logo">
          <span className="logo-icon">▦</span> Dashboard
        </h2>

        <div className="menu">

          <button className="menu-item active" onClick={() => navigate("/dashboard")}>
             <i className="bi bi-house-door"></i> 
            
             Dashboard
          </button>

          <button className="menu-item" onClick={() => navigate("/servicecenter")}>
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

      {/* MAIN CONTENT */}
      <main className="main">

        {/* TOP CARDS */}
        <div className="cards">
          <div className="card">
            <h3>56</h3>
            <p>Total Mechanics</p>
          </div>

          <div className="card">
            <h3>23</h3>
            <p>Active Service Jobs</p>
          </div>

          <div className="card">
            <h3>18</h3>
            <p>Pending Pickups</p>
          </div>

          <div className="card">
            <h3>12</h3>
            <p>Complaints Raised</p>
          </div>
        </div>

        {/* TABLE + PICKUP */}
        <div className="row">

          {/* BOOKINGS TABLE */}
          <div className="box table-box">
            <h3>Recent Bookings</h3>

            <table>
              <thead>
                <tr>
                  <th>Booking ID</th>
                  <th>Customer</th>
                  <th>Service</th>
                  <th>Date</th>
                </tr>
              </thead>

              <tbody>
                <tr>
                  <td>#1027</td><td>Alex Johnson</td><td>Oil change</td><td>2024-04-18</td>
                </tr>
                <tr>
                  <td>#1026</td><td>Michael Smith</td><td>Tire rotation</td><td>2024-04-17</td>
                </tr>
                <tr>
                  <td>#1024</td><td>Olivia Brown</td><td>Battery</td><td>2024-04-16</td>
                </tr>
                <tr>
                  <td>#1023</td><td>Emma Wilson</td><td>Brake insp.</td><td>2024-04-15</td>
                </tr>
              </tbody>
            </table>
          </div>

          {/* PICKUP TIMELINE */}
          <div className="box pickup-box">
            <h3>Pickup</h3>

            <ul className="pickup-list">
              <li><span>Apr 18</span><div className="dot"></div><span className="count">5</span></li>
              <li><span>Apr 17</span><div className="dot"></div><span className="count">2</span></li>
              <li><span>Apr 16</span><div className="dot"></div><span className="count">4</span></li>
            </ul>
          </div>

        </div>

        {/* COMPLAINTS + MECHANICS */}
        <div className="row">

          {/* COMPLAINTS SECTION */}
          <div className="box complaint-box">
            <h3>Complaints</h3>

            <div className="complaint-grid">
              <div className="c-card"><h4>2</h4><p>OPEN</p></div>
              <div className="c-card"><h4>3</h4><p>IN-PROGRESS</p></div>
              <div className="c-card"><h4>5</h4><p>RESOLVED</p></div>
            </div>
          </div>

          {/* MECHANIC AVAILABILITY CHART */}
          <div className="box chart-box">
            <h3>Mechanic Availability</h3>

            <img
              src="https://i.imgur.com/KLG2G4q.png"
              className="chart-img"
              alt="Mechanic chart"
            />
          </div>

        </div>

      </main>
    </div>
  );
};

export default Dashboard;