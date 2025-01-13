const sql = require('mssql');

// Cấu hình SQL Server
const config = {
  user: 'your_username',
  password: 'your_password',
  server: 'localhost', // hoặc địa chỉ IP server SQL
  database: 'your_database',
  options: {
    encrypt: true, // Nếu sử dụng Azure SQL
    trustServerCertificate: true, // Để tránh lỗi chứng chỉ
  },
};

const poolPromise = new sql.ConnectionPool(config)
  .connect()
  .then((pool) => {
    console.log('Connected to SQL Server');
    return pool;
  })
  .catch((err) => {
    console.error('Database Connection Failed!', err);
  });

module.exports = poolPromise;
