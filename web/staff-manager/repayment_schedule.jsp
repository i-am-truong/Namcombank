<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Repayment Schedules</title>
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

            .badge-pending {
                background-color: var(--warning-color);
                color: #212529;
            }

            .badge-overdue {
                background-color: var(--danger-color);
                color: #fff;
            }

            .badge-due-soon {
                background-color: var(--warning-color);
                color: #212529;
            }

            .no-data {
                text-align: center;
                padding: 50px;
                color: #6c757d;
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
                border-color: var(--primary-dark);
            }

            .status-due-soon {
                color: var(--warning-color);
                font-weight: bold;
            }

            .status-overdue {
                color: var(--danger-color);
                font-weight: bold;
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

            .search-filters {
                background: white;
                padding: 15px;
                border-radius: 8px;
                margin-bottom: 20px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .search-filters h4 {
                color: var(--primary-color);
                margin-bottom: 15px;
            }

            /* Hover effect for table rows */
            .table tbody tr:hover {
                background-color: rgba(30, 126, 52, 0.05);
            }

            .btn-disabled {
                background-color: #6c757d;
                border-color: #6c757d;
                cursor: not-allowed;
                opacity: 0.65;
            }

            .btn-disabled:hover {
                background-color: #6c757d;
                border-color: #6c757d;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <!-- Navigation Bar -->
            <div class="navigation-bar">
                <h3><i class="fas fa-money-bill-wave me-2"></i>Repayment Schedules</h3>
                <div class="nav-buttons">
                    <a href="/Namcombank/Home" class="nav-btn nav-btn-outline">
                        <i class="fas fa-home"></i> Home
                    </a>
                    <a href="${pageContext.request.contextPath}/customer-loan-requests" class="nav-btn nav-btn-outline">
                        <i class="fas fa-file-invoice-dollar"></i> Loan Requests
                    </a>
                    <!-- Thêm nút dẫn đến trang lịch sử thanh toán -->
                    <a href="${pageContext.request.contextPath}/payment-history" class="nav-btn nav-btn-primary">
                        <i class="fas fa-history"></i> Payment History
                    </a>
                </div>
            </div>
            <!-- Payment Message Alert -->
            <c:if test="${not empty paymentMessage}">
                <div class="alert ${paymentMessage.contains('successful') ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                    <i class="${paymentMessage.contains('successful') ? 'fas fa-check-circle' : 'fas fa-exclamation-circle'} me-2"></i>
                    ${paymentMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>



            <div class="row">
                <div class="col-md-12">

                    <!-- Due Soon Payments Table -->
                    <div class="table-wrapper">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-exclamation-circle me-2"></i>Due Soon Payments</h5>
                        </div>
                        <c:choose>
                            <c:when test="${empty schedules}">
                                <div class="no-data">
                                    <i class="fas fa-info-circle fa-3x mb-3" style="color: #1e7e34;"></i>
                                    <h5>No repayment schedules found</h5>
                                    <p>There are no scheduled repayments for this customer.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dueSoonTable">
                                        <thead>
                                            <tr>
                                                <th>Request ID</th>
                                                <th>Status</th>
                                                <th>Due Date</th>
                                                <th class="text-end">Amount Due</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:set var="dueSoonCount" value="0" />
                                            <c:forEach var="schedule" items="${schedules}">
                                                <c:set var="now" value="<%= new java.util.Date()%>" />
                                                <c:set var="dueDate" value="${schedule.dueDate}" />
                                                <c:set var="daysDiff" value="${(dueDate.time - now.time) / (1000 * 60 * 60 * 24)}" />

                                                <c:if test="${daysDiff >= 0 && daysDiff < 7 && schedule.status != 'PAID'}">
                                                    <c:set var="dueSoonCount" value="${dueSoonCount + 1}" />
                                                    <tr>
                                                        <td>${schedule.requestId}</td>
                                                        <td>
                                                            <span class="badge badge-due-soon">Due Soon</span>
                                                        </td>
                                                        <td>
                                                            <fmt:formatDate value="${schedule.dueDate}" pattern="dd-MM-yyyy" />
                                                            <span class="status-due-soon ms-2">
                                                                (${Math.round(daysDiff)} days left)
                                                            </span>
                                                        </td>
                                                        <td class="amount">
                                                            <fmt:formatNumber value="${schedule.amountDue}" type="currency" currencySymbol=""  /> VND
                                                        </td>

                                                        <td>
                                                            <!-- Pay Now button only appears for Due Soon status -->
                                                            <a href="${pageContext.request.contextPath}/repaymentSchedule?scheduleId=${schedule.schedule_id}&action=pay" 
                                                               class="btn btn-sm btn-primary">
                                                                <i class="fas fa-credit-card"></i> Pay Now
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>

                                            <c:if test="${dueSoonCount == 0}">
                                                <tr>
                                                    <td colspan="5" class="text-center">No payments due soon</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Pending Payments Table -->
                    <div class="table-wrapper">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-calendar-alt me-2"></i>Upcoming Payments</h5>
                        </div>
                        <c:choose>
                            <c:when test="${empty schedules}">
                                <div class="no-data">
                                    <i class="fas fa-info-circle fa-3x mb-3" style="color: #1e7e34;"></i>
                                    <h5>No repayment schedules found</h5>
                                    <p>There are no scheduled repayments for this customer.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="pendingPaymentsTable">
                                        <thead>
                                            <tr>
                                                <th>Request ID</th>
                                                <th>Status</th>
                                                <th>Due Date</th>
                                                <th class="text-end">Amount Due</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:set var="pendingCount" value="0" />
                                            <c:forEach var="schedule" items="${schedules}">
                                                <c:set var="now" value="<%= new java.util.Date()%>" />
                                                <c:set var="dueDate" value="${schedule.dueDate}" />
                                                <c:set var="daysDiff" value="${(dueDate.time - now.time) / (1000 * 60 * 60 * 24)}" />

                                                <c:if test="${daysDiff >= 7 && schedule.status != 'PAID'}">
                                                    <c:set var="pendingCount" value="${pendingCount + 1}" />
                                                    <tr>
                                                        <td>${schedule.requestId}</td>
                                                        <td>
                                                            <span class="badge badge-pending">Pending</span>
                                                        </td>
                                                        <td>
                                                            <fmt:formatDate value="${schedule.dueDate}" pattern="dd-MM-yyyy" />
                                                        </td>
                                                        <td class="amount">
                                                            <fmt:formatNumber value="${schedule.amountDue}" type="currency" currencySymbol="" /> VND
                                                        </td>

                                                        <td>
                                                            <!-- For pending payments, show disabled button -->
                                                            <button class="btn btn-sm btn-disabled" disabled>
                                                                <i class="fas fa-clock"></i> Not Yet Available
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>

                                            <c:if test="${pendingCount == 0}">
                                                <tr>
                                                    <td colspan="5" class="text-center">No pending payments</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                </div>
            </div>
        </div>

        <!-- JavaScript for Bootstrap -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Add confirmation dialog for payment
            document.addEventListener('DOMContentLoaded', function () {
                // Existing confirmation code
                const payButtons = document.querySelectorAll('.btn-primary:not(.nav-btn)');
                payButtons.forEach(button => {
                    button.addEventListener('click', function (e) {
                        if (!confirm('Are you sure you want to make this payment?')) {
                            e.preventDefault();
                        }
                    });
                });

                // Auto-hide payment message after 5 seconds
                const alertMessage = document.querySelector('.alert');
                if (alertMessage) {
                    setTimeout(function () {
                        const bsAlert = new bootstrap.Alert(alertMessage);
                        bsAlert.close();
                    }, 5000); // 5000ms = 5 seconds
                }
            });
        </script>

    </body>
</html>
