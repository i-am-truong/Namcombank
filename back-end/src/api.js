import axios from 'axios';

const API_BASE_URL = 'http://localhost:5000/api';

export const fetchCustomers = async () => {
  try {
    const response = await axios.get(`${API_BASE_URL}/customers`);
    return response.data;
  } catch (err) {
    console.error('Error fetching customers:', err);
    return [];
  }
};
