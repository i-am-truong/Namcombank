import React from 'react';
import { Link } from 'react-router-dom'; // Sử dụng Link từ react-router-dom
import { useState } from 'react';
import ReactRecaptcha from 'react-recaptcha';


// dùng Hooks
const Login = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [captcha, setCaptcha] = useState('');
  const [rememberMe, setRememberMe] = useState(false);
  const [errorMessage, setErrorMessage] = useState('');

  const handleSubmit = (event) => {
    event.preventDefault();
    // xử lý đăng nhập
    console.log(username, password, captcha, rememberMe);
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;

    if (!emailRegex.test(username)) {
      setErrorMessage('Invalid email format');
    } else if (!passwordRegex.test(password)) {
      setErrorMessage('Password must be at least 8 characters long and contain at least one letter and one number');
    } else if (captcha != '123456') {
      setErrorMessage('Captcha không chính xác');
    } else {
      // Xu ly dang nhap
      alert("Login successful!");
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100">
      <div className="bg-white p-8 rounded shadow-md w-full max-w-md">
        <h2 className="text-2xl font-bold mb-6 text-center">Login</h2>
        <form onSubmit={handleSubmit}>
          <div className="mb-4">
            <label htmlFor="username" className="block text-sm font-medium text-gray-700">Email</label>
            <input
              type="text"
              id="username"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              className="mt-1 block w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
              placeholder="Enter an email"
            />
          </div>
          <div className="mb-4">
            <label htmlFor="password" className="block text-sm font-medium text-gray-700">Password</label>
            <input
              type="password"
              id="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="mt-1 block w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
              placeholder="Enter a password"
            />
          </div>
          <div className="mb-4">
            <label htmlFor="captcha" className="block text-sm font-medium text-gray-700">Captcha</label>
            <input
              type="text"
              id="captcha"
              value={captcha}
              onChange={(e) => setCaptcha(e.target.value)}
              className="mt-1 block w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
              placeholder="Enter the captcha"
            />
            <img src="captcha.jpg" alt="Captcha" />
          </div>
          <div className="flex items-center justify-between mb-4">
            <label className="flex items-center">
              <input
                type="checkbox"
                id="rememberMe"
                checked={rememberMe}
                onChange={(e) => setRememberMe(e.target.checked)}
                className="form-checkbox h-4 w-4 text-indigo-600"
              />
              <span className="ml-2 text-sm text-gray-700">Remember me</span>
            </label>
            <a href="#" className="text-sm text-indigo-600 hover:underline">Forgot password?</a>
          </div>
          <button
            type="submit"
            className="w-full bg-indigo-600 text-white py-2 px-4 rounded hover:bg-indigo-700"
          >
            Login
          </button>
          {errorMessage && (
            <p className="mt-4 text-center text-sm text-red-600">{errorMessage}</p>
          )}
        </form>
        <p className="mt-4 text-center text-sm text-gray-600">
          Don't have an account?{' '}
          <Link to="/register" className="text-indigo-600 hover:underline">
            Register
          </Link>
        </p>
      </div>
    </div>
  );
};

export default Login;