<%-- 
    Document   : wishlist
    Created on : Jan 26, 2025, 9:02:32 PM
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Wishlist</title>

    <!-- Include CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }

        .wishlist-container {
            max-width: 900px;
            margin: 50px auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .wishlist-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .wishlist-header h1 {
            font-size: 1.8rem;
        }

        .wishlist-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid #dee2e6;
        }

        .wishlist-item:last-child {
            border-bottom: none;
        }

        .wishlist-item img {
            width: 80px;
            height: 80px;
            border-radius: 10px;
            object-fit: cover;
        }

        .wishlist-item .item-details {
            flex-grow: 1;
            margin-left: 20px;
        }

        .wishlist-item .item-details h5 {
            margin: 0;
            font-size: 1.2rem;
        }

        .wishlist-item .item-details p {
            margin: 5px 0 0;
            color: #6c757d;
        }

        .wishlist-item .item-actions button {
            margin-left: 10px;
        }
    </style>
</head>

<body>
    <div class="wishlist-container">
        <div class="wishlist-header">
            <h1>My Wishlist</h1>
            <button class="btn btn-primary">
                <i class="bi bi-plus-circle"></i> Add New Item
            </button>
        </div>

        <div class="wishlist-item">
            <img src="https://via.placeholder.com/80" alt="Item Image">
            <div class="item-details">
                <h5>Loan Package A</h5>
                <p>Interest rate: 6% | Tenure: 12 months</p>
            </div>
            <div class="item-actions">
                <button class="btn btn-success">
                    <i class="bi bi-check-circle"></i> Apply Now
                </button>
                <button class="btn btn-danger">
                    <i class="bi bi-trash"></i> Remove
                </button>
            </div>
        </div>

        <div class="wishlist-item">
            <img src="https://via.placeholder.com/80" alt="Item Image">
            <div class="item-details">
                <h5>Savings Plan B</h5>
                <p>Interest rate: 4% | Lock-in: 24 months</p>
            </div>
            <div class="item-actions">
                <button class="btn btn-success">
                    <i class="bi bi-check-circle"></i> Apply Now
                </button>
                <button class="btn btn-danger">
                    <i class="bi bi-trash"></i> Remove
                </button>
            </div>
        </div>

        <div class="wishlist-item">
            <img src="https://via.placeholder.com/80" alt="Item Image">
            <div class="item-details">
                <h5>Fixed Deposit C</h5>
                <p>Interest rate: 7% | Tenure: 36 months</p>
            </div>
            <div class="item-actions">
                <button class="btn btn-success">
                    <i class="bi bi-check-circle"></i> Apply Now
                </button>
                <button class="btn btn-danger">
                    <i class="bi bi-trash"></i> Remove
                </button>
            </div>
        </div>
    </div>

    <!-- Include JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>

