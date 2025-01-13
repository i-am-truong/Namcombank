const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const poolPromise = require('./db');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// API endpoint để lấy dữ liệu
app.get('/api/customers', async (req, res) => {
  try {
    const pool = await poolPromise;
    const result = await pool.request().query('SELECT * FROM Customers'); // Thay "Customers" bằng bảng của bạn
    res.json(result.recordset);
  } catch (err) {
    console.error(err);
    res.status(500).send('Database query error');
  }
});

// Khởi chạy server
const PORT = 5000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
