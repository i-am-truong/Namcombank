import React from "react";
import { Link, useNavigate } from "react-router-dom";

const CustomerDashboard = () => {
  const navigate = useNavigate();

  const handleLogout = () => {
    // Xử lý đăng xuất (xóa token hoặc thông tin đăng nhập)
    alert("You have been logged out.");
    navigate("/login"); // Chuyển hướng đến trang đăng nhập
  };

  return (
    <div className="min-h-screen bg-gray-100 flex flex-col items-center p-4">
      <div className="bg-white shadow-md rounded-lg w-full max-w-4xl p-6">
        <h2 className="text-2xl font-bold text-gray-700 text-center mb-6">
          Welcome to Customer Dashboard
        </h2>
        <div className="mb-4">
          <p className="text-gray-600 text-center">
            Hello, <span className="font-bold">[Customer Name]</span>!
          </p>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <Link
            to="/account"
            className="bg-indigo-600 text-white text-center py-3 rounded hover:bg-indigo-700"
          >
            Account Information
          </Link>
          <Link
            to="/orders"
            className="bg-indigo-600 text-white text-center py-3 rounded hover:bg-indigo-700"
          >
            View Orders
          </Link>
          <button
            onClick={handleLogout}
            className="bg-red-600 text-white text-center py-3 rounded hover:bg-red-700"
          >
            Logout
          </button>
        </div>
      </div>
    </div>
  );
};

export default CustomerDashboard;
