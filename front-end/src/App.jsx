import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import styles from "./style";
import { Billing, Business, CardDeal, Clients, CTA, Footer, Navbar, Stats, Testimonials, Hero } from "./components";
import Login from './components/Login';
import Register from './components/Register';
import { GoogleOAuthProvider } from '@react-oauth/google';
import CustomerDashboard from './components/CustomerDashboard';
import ForgotPassword from './components/ForgotPassword';

export default function App() {
  
  return (
    <Router>
      <div className="w-full overflow-hidden">
        <div className={`${styles.paddingX} ${styles.flexCenter}`}>
          <div className={`${styles.boxWidth}`}>
            <Navbar />
          </div>
        </div>

        <Routes>
          {/* Trang chính */}
          <Route
            path="/"
            element={
              <div>
                <div className={`${styles.flexStart}`}>
                  <div className={`${styles.boxWidth}`}>
                    <Hero />
                  </div>
                </div>

                <div className={`${styles.paddingX} ${styles.flexCenter}`}>
                  <div className={`${styles.boxWidth}`}>
                    <Stats />
                    <Business />
                    <Billing />
                    <CardDeal />
                    <Testimonials />
                    <CTA />
                    <Footer />
                  </div>
                </div>
              </div>
            }
          />

          {/* Trang Login */}
          <Route path="/login" element={<Login />} />

          {/* Trang Register */}
          <Route path="/register" element={<Register />} />

          {/* Trang Forgot Password */}
          <Route path="/forgot-password" element={<ForgotPassword />} />

          {/* Trang Customer Dashboard */}
          <Route path="/customer-dashboard" element={<CustomerDashboard />} />
        </Routes>
      </div>
    </Router>
  );
}
