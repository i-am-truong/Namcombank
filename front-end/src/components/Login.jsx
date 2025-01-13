import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import ReCAPTCHA from 'react-google-recaptcha';
import { GoogleLogin, GoogleOAuthProvider } from '@react-oauth/google';
import { useNavigate } from 'react-router-dom';


const Login = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [captcha, setCaptcha] = useState('');
  const [rememberMe, setRememberMe] = useState(false);
  const [errorMessage, setErrorMessage] = useState('');

  const navigate = useNavigate(); // Declare useNavigate at the top level

  const handleCaptchaChange = (value) => {
    setCaptcha(value); // Save the CAPTCHA token
    console.log('CAPTCHA value:', value); // Use this token for server-side validation
  };

  const handleSubmit = (event) => {
    const navigate = useNavigate();
    event.preventDefault();
    
    console.log(username, password, captcha, rememberMe);

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;

    if (!emailRegex.test(username)) {
      setErrorMessage('Invalid email format');
    } else if (!passwordRegex.test(password)) {
      setErrorMessage('Password must be at least 8 characters long and contain at least one letter and one number');
    } else if (!captcha) {
      setErrorMessage('Please complete the CAPTCHA');
    } else {
      // Handle login
      // alert('Login successful!');
      // setErrorMessage('');
      navigate('/customer-dashboard');
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100">
      <div className="bg-white p-8 rounded shadow-md w-full max-w-md">
        <h2 className="text-2xl font-bold mb-6 text-center">Login</h2>
        <form onSubmit={handleSubmit}>
          <div className="mb-4">
            <label htmlFor="username" className="block text-sm font-medium text-gray-700">
              Email
            </label>
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
            <label htmlFor="password" className="block text-sm font-medium text-gray-700">
              Password
            </label>
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
            <ReCAPTCHA
              sitekey="6Lf4AbYqAAAAAKxRMN3tzYf8XMcT4LCZmI0BuWJw" // Replace with your actual site key
              onChange={handleCaptchaChange}
            />
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
              <span className="ml-2 text-sm text-black-700">Remember me</span>
            </label>
            <a href="/forgot-password" className="text-sm text-green-800 hover:underline">
              Forgot password?
            </a>
          </div>
          <button
            type="submit"
            className="w-full bg-green-800 text-white py-2 px-4 rounded hover:bg-green-700"
          >
            Login
          </button>
          {errorMessage && (
            <p className="mt-4 text-center text-sm text-red-600">{errorMessage}</p>
          )}
        </form>
        <p className="mt-4 text-center text-sm text-black-600">
          Don't have an account?{' '}
          <Link to="/register" className="text-green-800 hover:underline">
            Register
          </Link>
        </p>
        <GoogleOAuthProvider clientId="147676468818-86oa6l06us45c8as6272v1mbc6egenf5.apps.googleusercontent.com"> {/* Add your Google Client ID */}
          <div className="mt-4">
            <GoogleLogin
              onSuccess={(credentialResponse) => {
                console.log(credentialResponse);
                // alert('Google Login successful!');
                navigate("/customer-dashboard");
              }}
              onError={() => {
                console.log('Login Failed');
                alert('Google Login failed!');
              }}
            />
          </div>
        </GoogleOAuthProvider>
      </div>
    </div>
  );
};

export default Login;
