<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank - Transaction Management</title>

        <!-- Custom styles -->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">

        <style>
            /* Override sidebar styles to match loan-requests-auth */
            .sidebar {
                background-color: #1cc88a !important;
                background-image: linear-gradient(180deg, #1cc88a 10%, #13855c 100%) !important;
            }
            
            /* Remove any additional brightness effects */
            .sidebar .nav-item .nav-link {
                color: rgba(255, 255, 255, 0.8) !important;
            }
            
            .sidebar .nav-item .nav-link:active,
            .sidebar .nav-item .nav-link:focus,
            .sidebar .nav-item .nav-link:hover {
                color: rgba(255, 255, 255, 1) !important;
            }
            
            .sidebar .sidebar-brand {
                color: #fff !important;
            }
            
            .sidebar-dark .nav-item .nav-link:active i, 
            .sidebar-dark .nav-item .nav-link:focus i, 
            .sidebar-dark .nav-item .nav-link:hover i {
                color: #fff !important;
            }
            
            .sidebar-dark .nav-item.active .nav-link {
                color: #fff !important;
            }
            
            .sidebar-dark .nav-item.active .nav-link i {
                color: #fff !important;
            }
            
            .sidebar-dark .sidebar-heading {
                color: rgba(255, 255, 255, 0.4) !important;
            }
            
            /* Existing styles */
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

            .clickable-row {
                cursor: pointer;
            }

            .clickable-row:hover {
                background-color: #f8f9fc;
            }

            .sortable {
                cursor: pointer;
            }

            .sortable:hover {
                background-color: #f0f0f0;
            }

            .sort-icon {
                margin-left: 5px;
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
            <%@include file="../homepage/sidebar_admin.jsp" %>
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <%@include file="../homepage/header_admin.jsp" %>
                    <div class="container-fluid">
                        <div class="table-wrapper">
                            <!-- Debug information -->
                            <c:if test="${not empty transactions}">
                                <div class="alert alert-info">
                                    Number of transactions found: ${transactions.size()}
                                </div>
                            </c:if>

                            <c:if test="${not empty sessionScope.successMessage}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    ${sessionScope.successMessage}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <c:remove var="successMessage" scope="session" />
                            </c:if>

                            <!-- Search Filters Form -->
                            <form action="${pageContext.request.contextPath}/transaction-filter" method="POST" id="searchForm">
                                <input type="hidden" name="action" value="search">
                                <input type="hidden" id="sortBy" name="sortBy" value="${sortBy}">
                                <input type="hidden" id="sortOrder" name="sortOrder" value="${sortOrder}">

                                <div class="search-filters">
                                    <h4 class="mb-3">Search Transactions</h4>

                                    <div class="search-grid">
                                        <div class="form-group">
                                            <label for="customerName">Customer Name</label>
                                            <input type="text" id="customerName" name="customerName" class="form-control" 
                                                   value="${customerName}" placeholder="Customer name">
                                        </div>

                                        <div class="form-group">
                                            <label for="type">Transaction Type</label>
                                            <select id="type" name="type" class="form-control">
                                                <option value="" ${type == null || type == '' ? 'selected' : ''}>All</option>
                                                <option value="Disbursement" ${type == 'Disbursement' ? 'selected' : ''}>Disbursement</option>
                                                <option value="Repayment" ${type == 'Repayment' ? 'selected' : ''}>Repayment</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="minAmount">Amount From</label>
                                            <input type="number" id="minAmount" name="minAmount" class="form-control" 
                                                   value="${minAmount}" placeholder="Minimum amount">
                                        </div>

                                        <div class="form-group">
                                            <label for="maxAmount">Amount To</label>
                                            <input type="number" id="maxAmount" name="maxAmount" class="form-control" 
                                                   value="${maxAmount}" placeholder="Maximum amount">
                                        </div>

                                        <div class="form-group">
                                            <label for="startDate">Date From</label>
                                            <input type="date" id="startDate" name="startDate" class="form-control" 
                                                   value="${startDate}">
                                        </div>

                                        <div class="form-group">
                                            <label for="endDate">Date To</label>
                                            <input type="date" id="endDate" name="endDate" class="form-control" 
                                                   value="${endDate}">
                                        </div>
                                    </div>

                                    <div class="search-buttons">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-search"></i> Search
                                        </button>
                                        <button type="button" id="clearFiltersBtn" class="btn btn-secondary">
                                            <i class="fas fa-undo"></i> Clear Filters
                                        </button>
                                    </div>
                                </div>
                            </form>

                            <!-- Status Summary Cards -->


                            <!-- Transactions Table -->
                            <div class="table-responsive">
                                <table class="table table-bordered" id="transactionTable">
                                    <thead>
                                        <tr>
                                            <th class="sortable" data-sort="transactionId">
                                                Transaction ID
                                                <c:if test="${sortBy == 'transactionId'}">
                                                    <i class="fas fa-sort-${sortOrder == 'asc' ? 'up' : 'down'} sort-icon"></i>
                                                </c:if>
                                            </th>
                                            <th>Customer</th>
                                            <th>Schedule ID</th>
                                            <th>Due Date</th>
                                            <th class="sortable" data-sort="amount">
                                                Amount
                                                <c:if test="${sortBy == 'amount'}">
                                                    <i class="fas fa-sort-${sortOrder == 'asc' ? 'up' : 'down'} sort-icon"></i>
                                                </c:if>
                                            </th>
                                            <th class="sortable" data-sort="transactionDate">
                                                Transaction Date
                                                <c:if test="${sortBy == 'transactionDate'}">
                                                    <i class="fas fa-sort-${sortOrder == 'asc' ? 'up' : 'down'} sort-icon"></i>
                                                </c:if>
                                            </th>
                                            <th>Type</th>
                                            <th>Staff</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty transactions && transactions.size() > 0}">
                                                <c:forEach items="${transactions}" var="transaction">
                                                    <tr>
                                                        <td>${transaction.transactionId}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty transaction.customer}">
                                                                    ${transaction.customer.fullname}
                                                                    <br>
                                                                    <small class="text-muted">ID: ${transaction.customerId}</small>
                                                                    <br>
                                                                    <small class="text-muted">CID: ${transaction.customer.cid}</small>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">N/A</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${transaction.scheduleId != null ? transaction.scheduleId : 'N/A'}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty transaction.repaymentSchedule && not empty transaction.repaymentSchedule.dueDate}">
                                                                    <fmt:formatDate value="${transaction.repaymentSchedule.dueDate}" pattern="dd/MM/yyyy"/>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">N/A</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td><fmt:formatNumber value="${transaction.amount}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND</td>
                                                        <td><fmt:formatDate value="${transaction.transactionDate}" pattern="dd/MM/yyyy"/></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${transaction.type eq 'Disbursement'}">
                                                                    <span class="badge badge-primary">${transaction.type}</span>
                                                                </c:when>
                                                                <c:when test="${transaction.type eq 'Repayment'}">
                                                                    <span class="badge badge-success">${transaction.type}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge badge-secondary">${transaction.type}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty transaction.staff}">
                                                                    ${transaction.staff.fullname}
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
                                                    <td colspan="8" class="text-center">No transactions found</td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
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
                // Create a form to submit a clear action
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/transaction-filter';

                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'clear';
                form.appendChild(actionInput);

                document.body.appendChild(form);
                form.submit();
            });

            // Setup sorting
            document.querySelectorAll('.sortable').forEach(function (th) {
                th.addEventListener('click', function () {
                    var sortBy = this.getAttribute('data-sort');
                    var currentSortBy = '${sortBy}';
                    var currentSortOrder = '${sortOrder}';

                    var newSortOrder = 'asc';
                    if (sortBy === currentSortBy && currentSortOrder === 'asc') {
                        newSortOrder = 'desc';
                    }

                    // Create a form to submit sort parameters
                    var form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '${pageContext.request.contextPath}/transaction-filter';

                    var actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'sort';
                    form.appendChild(actionInput);

                    var sortByInput = document.createElement('input');
                    sortByInput.type = 'hidden';
                    sortByInput.name = 'sortBy';
                    sortByInput.value = sortBy;
                    form.appendChild(sortByInput);

                    var sortOrderInput = document.createElement('input');
                    sortOrderInput.type = 'hidden';
                    sortOrderInput.name = 'sortOrder';
                    sortOrderInput.value = newSortOrder;
                    form.appendChild(sortOrderInput);

                    document.body.appendChild(form);
                    form.submit();
                });
            });
        </script>
    </body>
</html>
