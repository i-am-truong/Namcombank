<%-- 
    Document   : viewLoanRequest
    Created on : Mar 9, 2025, 11:28:14 PM
    Author     : lenovo
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank - Loan Request Customer</title>

        <!-- Custom styles -->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">

        <style>
            .table-wrapper {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-top: 20px;
            }

            .search-filters {
                background: #f8f9fc;
                padding: 15px;
                border-radius: 8px;
                margin-bottom: 20px;
            }

            .search-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 10px;
                margin-bottom: 15px;
            }

            .action-btn {
                padding: 4px 8px;
                margin: 0 2px;
                border-radius: 4px;
            }

            .search-buttons {
                display: flex;
                justify-content: space-between;
                margin-top: 15px;
            }

            .status-pending {
                color: #f6c23e;
                font-weight: bold;
            }

            .status-approved {
                color: #1cc88a;
                font-weight: bold;
            }

            .status-rejected {
                color: #e74a3b;
                font-weight: bold;
            }

            .clickable-row {
                cursor: pointer;
            }

            .clickable-row:hover {
                background-color: #f8f9fc;
            }

            @media (max-width: 768px) {
                .search-buttons {
                    flex-direction: column;
                    gap: 10px;
                }

                .search-buttons button {
                    width: 100%;
                }
            }
        </style>
    </head>

    <body id="page-top">
        <div id="wrapper">
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <div class="container-fluid">
                        <div class="table-wrapper">
                            <div class="text-right mb-3">
                                <a href="Home" class="btn btn-info">
                                    <i class="fas fa-home"></i> Home
                                </a>
                                <a href="loanpackage-customer/loan_packages.jsp" class="btn btn-success">
                                    <i class="fas fa-plus"></i> View available loan packages
                                </a>
                            </div>

                            <c:if test="${not empty creditCardMessage}">
                                <div style="padding: 10px; background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; margin-bottom: 15px;">
                                    ${creditCardMessage}
                                </div>
                            </c:if>


                            <!-- Debug information -->
                            <c:if test="${not empty loanRequests}">
                                <div class="alert alert-info">
                                    Number of loan requests found: ${loanRequests.size()}
                                </div>
                            </c:if>
                        </div>
                        </form>

                        <!-- Status Summary Cards -->
                        <div class="row mb-4">
                            <div class="col-xl-3 col-md-6 mb-4">
                                <div class="card border-left-primary shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                    Total Loan Requests</div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${totalRequests}</div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-3 col-md-6 mb-4">
                                <div class="card border-left-warning shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                    Pending</div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${pendingRequests}</div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-clock fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-3 col-md-6 mb-4">
                                <div class="card border-left-success shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                    Approved</div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${approvedRequests}</div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-check-circle fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-3 col-md-6 mb-4">
                                <div class="card border-left-danger shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">
                                                    Rejected</div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${rejectedRequests}</div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-times-circle fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- LoanRequests Table -->
                        <div class="table-responsive">
                            <table class="table table-bordered" id="loanRequestTable">
                                <thead>
                                    <tr>
                                        <th>Request ID</th>
                                        <th>Customer</th>
                                        <th>Loan Package</th>
                                        <th>Amount</th>
                                        <th>Request Date</th>
                                        <th>Status</th>
                                        <th>Collateral</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty loanRequests && loanRequests.size() > 0}">
                                            <c:forEach items="${loanRequests}" var="request">
                                                <tr class="clickable-row" onclick="window.location.href = 'customer-loan-request-detail?id=${request.requestId}'">
                                                    <td>${request.requestId}</td>
                                                    <td>${request.customer.fullname}</td>
                                                    <td>${request.loanPackage.packageName}</td>
                                                    <td><fmt:formatNumber value="${request.amount}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND</td>
                                                    <td><fmt:formatDate value="${request.requestDate}" pattern="dd/MM/yyyy"/></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${request.status eq 'Pending'}">
                                                                <span class="status-pending"><i class="fas fa-clock"></i> Pending</span>
                                                            </c:when>
                                                            <c:when test="${request.status eq 'Approved'}">
                                                                <span class="status-approved"><i class="fas fa-check-circle"></i> Approved</span>
                                                            </c:when>
                                                            <c:when test="${request.status eq 'Rejected'}">
                                                                <span class="status-rejected"><i class="fas fa-times-circle"></i> Rejected</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${request.status}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty request.asset}">
                                                                <i class="fas fa-check-circle text-success"></i> ${request.asset.assetName}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="fas fa-times-circle text-danger"></i> None
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>

                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${request.status eq 'Pending'}">
                                                                <a href="delete-loan-request?id=${request.requestId}" class="btn btn-danger btn-sm"
                                                                   onclick="return confirm('Are you sure you want to delete this loan request?');">
                                                                    <i class="fas fa-trash-alt"></i> Delete
                                                                </a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">N/A</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>


                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="9" class="text-center">No loan requests found</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                                <c:if test="${not empty requestScope.errorMessage}">
                                    <div class="alert alert-danger mt-3">${requestScope.errorMessage}</div>
                                </c:if>
                                <c:if test="${not empty requestScope.successMessage}">
                                    <div class="alert alert-success mt-3">${requestScope.successMessage}</div>
                                </c:if>

                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="adminassets/js/sb-admin-2.min.js"></script>
    <script>
        // Clear filters functionality
        document.getElementById('clearFiltersBtn').addEventListener('click', function () {
            // Reset all form fields
            document.getElementById('customerName').value = '';
            document.getElementById('packageName').value = '';
            document.getElementById('status').value = '';
            document.getElementById('minAmount').value = '';
            document.getElementById('maxAmount').value = '';
            document.getElementById('hasAsset').value = '';
            document.getElementById('requestDateFrom').value = '';
            document.getElementById('requestDateTo').value = '';
            document.getElementById('approvedBy').value = '';
            document.getElementById('approvedDate').value = '';
            document.getElementById('approvalDateFrom').value = '';
            document.getElementById('approvalDateTo').value = '';

            // Redirect to customer-loan-requests without search parameters
            window.location.href = 'customer-loan-requests';
        });
    </script>
</body>
</html>
