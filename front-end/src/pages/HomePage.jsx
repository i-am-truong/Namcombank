import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import styles from "../styles/Layout";
import { Billing, Business, CardDeal, Clients, CTA, Footer, Navbar, Stats, Testimonials, Hero } from "../components/layout";
import Login from '../pages/LoginPage';
import Register from '../pages/RegisterPage';

export default function HomePage() {
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
        </Routes>
      </div>
    </Router>
  );
}
