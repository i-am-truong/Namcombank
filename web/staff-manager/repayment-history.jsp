<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Payment History</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #1e7e34;
                --primary-light: #28a745;
                --primary-dark: #145523;
                --secondary-color: #f8f9fa;
                --warning-color: #ffc107;
                --danger-color: #dc3545;
                --text-color: #212529;
            }

            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                padding: 20px;
                color: var(--text-color);
            }

            .table-wrapper {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-top: 20px;
            }

            .card-header {
                background-color: var(--primary-color);
                color: white;
                padding: 15px 20px;
                border-radius: 8px 8px 0 0;
            }

            .table {
                margin-bottom: 0;
            }

            .table th {
                background-color: #f8f9fc;
                color: var(--primary-color);
                font-weight: 600;
                border-top: none;
            }

            .amount {
                font-weight: 600;
                text-align: right;
            }

            .badge {
                font-size: 0.85rem;
                padding: 6px 10px;
            }

            .badge-paid {
                background-color: #28a745;
                color: white;
            }

            .no-data {
                text-align: center;
                padding: 50px;
                color: #6c757d;
            }

            .navigation-bar {
                background-color: white;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-bottom: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .navigation-bar h3 {
                margin: 0;
                color: var(--primary-color);
            }

            .nav-buttons {
                display: flex;
                gap: 10px;
            }

            .nav-btn {
                padding: 8px 16px;
                border-radius: 4px;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .nav-btn i {
                margin-right: 8px;
            }

            .nav-btn-outline {
                color: var(--primary-color);
                background-color: transparent;
                border: 1px solid var(--primary-color);
            }

            .nav-btn-outline:hover {
                background-color: var(--primary-color);
                color: white;
            }

            .nav-btn-primary {
                color: white;
                background-color: var(--primary-color);
                border: 1px solid var(--primary-color);
            }

            .nav-btn-primary:hover {
                background-color: var(--primary-dark);
                border-color: var(--primary-dark);
            }

            /* Hover effect for table rows */
            .table tbody tr:hover {
                background-color: rgba(30, 126, 52, 0.05);
            }

            /* Customer info section */
            .customer-info {
                background-color: white;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-bottom: 20px;
            }

            .customer-info h4 {
                color: var(--primary-color);
                margin-bottom: 10px;
            }

            .customer-details {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
            }

            .customer-detail {
                flex: 1;
                min-width: 200px;
            }

            .detail-label {
                font-weight: 600;
                color: #6c757d;
                font-size: 0.9rem;
            }

            .detail-value {
                font-size: 1.1rem;
                margin-top: 5px;
            }

            /* Payment statistics */
            .payment-stats {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                margin-bottom: 20px;
            }

            .stat-card {
                flex: 1;
                min-width: 200px;
                background-color: white;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .stat-label {
                color: #6c757d;
                font-size: 0.9rem;
            }

            .stat-value {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--primary-color);
                margin-top: 5px;
            }

            /* Print button */
            .print-btn {
                margin-left: auto;
                background-color: #6c757d;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .print-btn:hover {
                background-color: #5a6268;
            }

            @media print {
                .navigation-bar, .print-btn {
                    display: none;
                }

                body {
                    padding: 0;
                    background-color: white;
                }

                .table-wrapper, .customer-info, .stat-card {
                    box-shadow: none;
                    margin: 0;
                    padding: 10px 0;
                }

                .card-header {
                    background-color: white !important;
                    color: black !important;
                    padding: 10px 0 !important;
                }

                .table th {
                    background-color: white !important;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <!-- Navigation Bar -->
            <div class="navigation-bar">
                <h3><i class="fas fa-history me-2"></i>Payment History</h3>
                <div class="nav-buttons">
                    <a href="/Namcombank/Home" class="nav-btn nav-btn-outline">
                        <i class="fas fa-home"></i> Home
                    </a>
                    <a href="${pageContext.request.contextPath}/repaymentSchedule" class="nav-btn nav-btn-outline">
                        <i class="fas fa-money-bill-wave"></i> Repayment Schedules
                    </a>
                    <a href="${pageContext.request.contextPath}/customer-loan-requests" class="nav-btn nav-btn-outline">
                        <i class="fas fa-file-invoice-dollar"></i> Loan Requests
                    </a>
                </div>
            </div>
            Customer Information 
            <div class="customer-info">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4><i class="fas fa-user me-2"></i>Customer Information</h4>
                    <button class="print-btn" onclick="window.print()">
                        <i class="fas fa-print"></i> Print History
                    </button>
                </div>
                <div class="customer-details">
                    <div class="customer-detail">
                        <div class="detail-label">Customer ID</div>
                        <div class="detail-value">${customer.customerId}</div>
                    </div>
                    <div class="customer-detail">
                        <div class="detail-label">Name</div>
                        <div class="detail-value">${customer.fullname}</div>
                    </div>
                    <div class="customer-detail">
                        <div class="detail-label">Email</div>
                        <div class="detail-value">${customer.email}</div>
                    </div>
                    <div class="customer-detail">
                        <div class="detail-label">Current Balance</div>
                        <div class="detail-value"><fmt:formatNumber value="${customer.balance}" pattern="#,##0.00"/> VND</div>
                    </div>
                </div>
            </div>

            Payment Statistics 
            <div class="payment-stats">
                <div class="stat-card">
                    <div class="stat-label">Total Payments Made</div>
                    <div class="stat-value">${paymentHistory.size()}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Total Amount Paid</div><!--
                    <c:set var="totalPaid" value="0" />
                    <c:forEach var="payment" items="${paymentHistory}">
                        <c:set var="totalPaid" value="${totalPaid + payment.amountDue}" />
                    </c:forEach>
                    -->                    <div class="stat-value"><fmt:formatNumber value="${totalPaid}" pattern="#,##0.00"/> VND</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Last Payment Date</div>
                    <div class="stat-value">
                        <c:if test="${not empty paymentHistory}">
                            <fmt:formatDate value="${paymentHistory[0].transactionDate}" pattern="dd-MM-yyyy"/>
                        </c:if>
                        <c:if test="${empty paymentHistory}">
                            N/A
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Payment History Table -->
            <div class="table-wrapper">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-receipt me-2"></i>Payment History</h5>
                </div>
                <c:choose>
                    <c:when test="${empty paymentHistory}">
                        <div class="no-data">
                            <i class="fas fa-info-circle fa-3x mb-3" style="color: #1e7e34;"></i>
                            <h5>No payment history found</h5>
                            <p>You have not made any payments yet.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-bordered" id="historyTable">
                                <thead>
                                    <tr>
                                        <th>Payment ID</th>
                                        <th>Request ID</th>
                                        <th>Status</th>
                                        <th>Due Date</th>
                                        <th>Payment Date</th>
                                        <th class="text-end">Amount Paid</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="payment" items="${paymentHistory}">
                                        <tr>
                                            <td>${payment.scheduleId}</td>
                                            <td>${payment.requestId}</td>
                                            <td>
                                                <span class="badge badge-paid">Paid</span>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${payment.dueDate}" pattern="dd-MM-yyyy" />
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${payment.transactionDate}" pattern="dd-MM-yyyy" />
                                            </td>
                                            <td class="amount">
                                                <fmt:formatNumber value="${payment.amountDue}" pattern="#,##0.00" /> VND
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- JavaScript for Bootstrap -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
