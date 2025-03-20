<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank - Loan Request Details</title>

        <!-- Custom styles -->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">

        <style>
            .detail-card {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-top: 20px;
            }
            .status-badge {
                padding: 5px 10px;
                border-radius: 5px;
                font-weight: bold;
                display: inline-block;
                margin-bottom: 10px;
            }
            .badge-pending {
                background-color: #f6c23e;
                color: #fff;
            }
            .badge-approved {
                background-color: #1cc88a;
                color: #fff;
            }
            .badge-rejected {
                background-color: #e74a3b;
                color: #fff;
            }
            .detail-section {
                margin-bottom: 30px;
            }
            .detail-section h5 {
                border-bottom: 1px solid #e3e6f0;
                padding-bottom: 10px;
                margin-bottom: 15px;
            }
            .detail-row {
                display: flex;
                margin-bottom: 10px;
            }
            .detail-label {
                font-weight: bold;
                width: 150px;
                color: #4e73df;
            }
            .detail-value {
                flex: 1;
            }
            .approval-section {
                background-color: #f8f9fc;
                padding: 20px;
                border-radius: 8px;
                margin-top: 20px;
            }
            .approval-col {
                padding: 15px;
                border-radius: 5px;
            }
            .approval-col-approve {
                background-color: rgba(28, 200, 138, 0.1);
                border-left: 4px solid #1cc88a;
            }
            .approval-col-reject {
                background-color: rgba(231, 74, 59, 0.1);
                border-left: 4px solid #e74a3b;
            }
            .rejected-reason, .approval-note {
                padding: 10px;
                border-radius: 5px;
                margin-top: 10px;
            }
            .rejected-reason {
                background-color: #feecec;
                border-left: 4px solid #e74a3b;
            }
            .approval-note {
                background-color: #eafbf3;
                border-left: 4px solid #1cc88a;
            }
            .btn-delete {
                background-color: #dc3545;
                color: white;
            }
            .delete-section {
                margin-top: 20px;
                padding-top: 20px;
                border-top: 1px dashed #ccc;
            }
            .col-title {
                font-weight: bold;
                font-size: 16px;
                margin-bottom: 15px;
                display: flex;
                align-items: center;
            }
            .col-title i {
                margin-right: 8px;
            }
            .btn-block {
                display: block;
                width: 100%;
            }
            .asset-item {
                background: #f8f9fc;
                border-radius: 8px;
                padding: 12px;
                margin-bottom: 10px;
                transition: transform 0.2s;
            }
            .asset-item:hover {
                transform: translateY(-3px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }
            .repayment-schedule {
                margin-top: 30px;
            }
            .repayment-schedule table {
                width: 100%;
                border-collapse: collapse;
            }
            .repayment-schedule th, .repayment-schedule td {
                padding: 10px;
                border: 1px solid #e3e6f0;
            }
            .repayment-schedule th {
                background-color: #f8f9fc;
                font-weight: bold;
            }
            .payment-pending {
                color: #f6c23e;
                font-weight: bold;
            }
            .payment-paid {
                color: #1cc88a;
                font-weight: bold;
            }
            .payment-overdue {
                color: #e74a3b;
                font-weight: bold;
            }
            .warning-box {
                background-color: #fff3cd;
                border-left: 4px solid #f6c23e;
                padding: 10px;
                border-radius: 5px;
                margin-top: 10px;
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
                        <div class="d-sm-flex align-items-center justify-content-between mb-4">
                            <h1 class="h3 mb-0 text-gray-800">Loan Request Details</h1>
                            <a href="${pageContext.request.contextPath}/loan-requests-auth" class="btn btn-secondary btn-sm">
                                <i class="fas fa-arrow-left"></i> Back to List
                            </a>
                        </div>

                        <c:if test="${not empty sessionScope.successMessage}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                ${sessionScope.successMessage}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <c:remove var="successMessage" scope="session" />
                        </c:if>

                        <c:if test="${not empty sessionScope.errorMessage}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${sessionScope.errorMessage}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <c:remove var="errorMessage" scope="session" />
                        </c:if>

                        <div class="detail-card">
                            <div class="text-center mb-4">
                                <h4>Loan Request #${loanRequest.requestId}</h4>
                                <c:choose>
                                    <c:when test="${loanRequest.status eq 'Pending'}">
                                        <span class="status-badge badge-pending"><i class="fas fa-clock"></i> Pending</span>
                                    </c:when>
                                    <c:when test="${loanRequest.status eq 'Approved'}">
                                        <span class="status-badge badge-approved"><i class="fas fa-check-circle"></i> Approved</span>
                                    </c:when>
                                    <c:when test="${loanRequest.status eq 'Rejected'}">
                                        <span class="status-badge badge-rejected"><i class="fas fa-times-circle"></i> Rejected</span>
                                    </c:when>
                                </c:choose>
                            </div>

                            <div class="row">
                                <!-- Left Column -->
                                <div class="col-md-6">
                                    <div class="detail-section">
                                        <h5><i class="fas fa-file-invoice-dollar"></i> Loan Request Information</h5>
                                        <div class="detail-row">
                                            <div class="detail-label">Loan Amount:</div>
                                            <div class="detail-value">
                                                <span class="h5 text-primary">
                                                    <fmt:formatNumber value="${loanRequest.amount}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND
                                                </span>
                                            </div>
                                        </div>
                                        <div class="detail-row">
                                            <div class="detail-label">Request Date:</div>
                                            <div class="detail-value">
                                                <fmt:formatDate value="${loanRequest.requestDate}" pattern="dd/MM/yyyy"/>
                                            </div>
                                        </div>

                                        <div class="detail-row">
                                            <div class="detail-label">Status:</div>
                                            <div class="detail-value">
                                                <c:choose>
                                                    <c:when test="${loanRequest.status eq 'Pending'}">
                                                        <span class="text-warning font-weight-bold">
                                                            <i class="fas fa-clock"></i> Pending
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${loanRequest.status eq 'Approved'}">
                                                        <span class="text-success font-weight-bold">
                                                            <i class="fas fa-check-circle"></i> Approved
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${loanRequest.status eq 'Rejected'}">
                                                        <span class="text-danger font-weight-bold">
                                                            <i class="fas fa-times-circle"></i> Rejected
                                                        </span>
                                                    </c:when>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="detail-section">
                                        <h5><i class="fas fa-money-bill-wave"></i> Loan Package Information</h5>
                                        <div class="detail-row">
                                            <div class="detail-label">Package Name:</div>
                                            <div class="detail-value">
                                                <span class="font-weight-bold">${loanRequest.loanPackage.packageName}</span>
                                            </div>
                                        </div>
                                        <div class="detail-row">
                                            <div class="detail-label">Interest Rate:</div>
                                            <div class="detail-value">
                                                ${loanRequest.loanPackage.interestRate}% / year
                                            </div>
                                        </div>
                                        <c:if test="${not empty loanRequest.loanPackage.loanTerm}">
                                            <div class="detail-row">
                                                <div class="detail-label">Term:</div>
                                                <div class="detail-value">
                                                    ${loanRequest.loanPackage.loanTerm} months
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty loanRequest.loanPackage.description}">
                                            <div class="detail-row">
                                                <div class="detail-label">Description:</div>
                                                <div class="detail-value">${loanRequest.loanPackage.description}</div>
                                            </div>
                                        </c:if>
                                    </div>

                                    <div class="detail-section">
                                        <h5><i class="fas fa-user"></i> Customer Information</h5>
                                        <div class="detail-row">
                                            <div class="detail-label">Full Name:</div>
                                            <div class="detail-value">
                                                <span class="font-weight-bold">${loanRequest.customer.fullname}</span>
                                            </div>
                                        </div>
                                        <c:if test="${not empty loanRequest.customer.cid}">
                                            <div class="detail-row">
                                                <div class="detail-label">ID Card:</div>
                                                <div class="detail-value">${loanRequest.customer.cid}</div>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty loanRequest.customer.phonenumber}">
                                            <div class="detail-row">
                                                <div class="detail-label">Phone:</div>
                                                <div class="detail-value">${loanRequest.customer.phonenumber}</div>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty loanRequest.customer.email}">
                                            <div class="detail-row">
                                                <div class="detail-label">Email:</div>
                                                <div class="detail-value">${loanRequest.customer.email}</div>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty loanRequest.customer.address}">
                                            <div class="detail-row">
                                                <div class="detail-label">Address:</div>
                                                <div class="detail-value">${loanRequest.customer.address}</div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                                <!-- Right Column -->
                                <div class="col-md-6">
                                    <div class="detail-section">
                                        <h5><i class="fas fa-landmark"></i> Collateral for This Loan</h5>
                                        <c:choose>
                                            <c:when test="${not empty loanRequest.asset}">
                                                <div class="detail-row">
                                                    <div class="detail-label">Asset Name:</div>
                                                    <div class="detail-value">
                                                        <span class="font-weight-bold">${loanRequest.asset.assetName}</span>
                                                    </div>
                                                </div>
                                                <div class="detail-row">
                                                    <div class="detail-label">Asset Type:</div>
                                                    <div class="detail-value">${loanRequest.asset.assetType}</div>
                                                </div>
                                                <div class="detail-row">
                                                    <div class="detail-label">Value:</div>
                                                    <div class="detail-value">
                                                        <fmt:formatNumber value="${loanRequest.asset.assetValue}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND
                                                    </div>
                                                </div>

                                                <c:if test="${not empty loanRequest.asset.description}">
                                                    <div class="detail-row">
                                                        <div class="detail-label">Description:</div>
                                                        <div class="detail-value">${loanRequest.asset.description}</div>
                                                    </div>
                                                </c:if>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="alert alert-warning">
                                                    <i class="fas fa-exclamation-triangle"></i> This loan request has no collateral.
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="detail-section">
                                        <h5><i class="fas fa-user-check"></i> Approval Information</h5>
                                        <c:choose>
                                            <c:when test="${loanRequest.status eq 'Pending'}">
                                                <div class="pending-message">
                                                    <i class="fas fa-info-circle"></i> This loan request is pending approval
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="detail-row">
                                                    <div class="detail-label">
                                                        <c:choose>
                                                            <c:when test="${loanRequest.status eq 'Approved'}">Approved By:</c:when>
                                                            <c:when test="${loanRequest.status eq 'Rejected'}">Rejected By:</c:when>
                                                            <c:otherwise>Processed By:</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="detail-value">
                                                        <c:choose>
                                                            <c:when test="${not empty loanRequest.approvedBy}">
                                                                ${loanRequest.approvedBy}
                                                            </c:when>
                                                            <c:otherwise>
                                                                N/A
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>

                                                <div class="detail-row">
                                                    <div class="detail-label">
                                                        <c:choose>
                                                            <c:when test="${loanRequest.status eq 'Approved'}">Approval Date:</c:when>
                                                            <c:when test="${loanRequest.status eq 'Rejected'}">Rejection Date:</c:when>
                                                            <c:otherwise>Process Date:</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="detail-value">
                                                        <c:choose>
                                                            <c:when test="${not empty loanRequest.approvalDate}">
                                                                <fmt:formatDate value="${loanRequest.approvalDate}" pattern="dd/MM/yyyy "/>
                                                            </c:when>
                                                            <c:otherwise>N/A</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>

                                                <c:if test="${loanRequest.status eq 'Approved' && not empty loanRequest.notes}">
                                                    <div class="detail-row">
                                                        <div class="detail-label">Notes:</div>
                                                        <div class="detail-value">
                                                            <div class="approval-note">
                                                                <i class="fas fa-comment-dots mr-2"></i> ${loanRequest.notes}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>

                                                <c:if test="${loanRequest.status eq 'Rejected' && not empty loanRequest.notes}">
                                                    <div class="detail-row">
                                                        <div class="detail-label">Rejection Reason:</div>
                                                        <div class="detail-value">
                                                            <div class="rejected-reason">
                                                                <i class="fas fa-exclamation-circle mr-2"></i> ${loanRequest.notes}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="detail-section">
                                        <h5><i class="fas fa-list"></i> Customer's Other Assets</h5>
                                        <c:choose>
                                            <c:when test="${not empty customerAssets && customerAssets.size() > 0}">
                                                <div class="row">
                                                    <c:forEach items="${customerAssets}" var="asset">
                                                        <div class="col-md-12 mb-3">
                                                            <div class="asset-item">
                                                                <h6 class="font-weight-bold">${asset.assetName}</h6>
                                                                <div class="row">
                                                                    <div class="col-md-6">
                                                                        <small class="text-muted">Type: ${asset.assetType}</small>
                                                                    </div>
                                                                    <div class="col-md-6 text-right">
                                                                        <small class="text-primary font-weight-bold">
                                                                            <fmt:formatNumber value="${asset.assetValue}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND
                                                                        </small>
                                                                    </div>
                                                                </div>
                                                                <c:if test="${not empty asset.description}">
                                                                    <div class="mt-2">
                                                                        <small>${asset.description}</small>
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="alert alert-info">
                                                    <i class="fas fa-info-circle"></i> Customer has no other assets.
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <!-- Repayment Schedule Section - Only shown for approved loans -->
                            <c:if test="${loanRequest.status eq 'Approved' && not empty repaymentSchedule}">
                                <div class="repayment-schedule">
                                    <h5 class="mb-3"><i class="fas fa-calendar-alt"></i> Repayment Schedule</h5>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Due Date</th>
                                                    <th>Amount</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${repaymentSchedule}" var="payment" varStatus="status">
                                                    <tr>
                                                        <td>${status.index + 1}</td>
                                                        <td><fmt:formatDate value="${payment.dueDate}" pattern="dd/MM/yyyy"/></td>
                                                        <td><fmt:formatNumber value="${payment.amountDue}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${payment.status eq 'PAID'}">
                                                                    <span class="payment-paid"><i class="fas fa-check-circle"></i> Paid</span>
                                                                </c:when>
                                                                <c:when test="${payment.status eq 'OVERDUE'}">
                                                                    <span class="payment-overdue"><i class="fas fa-exclamation-circle"></i> Overdue</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="payment-pending"><i class="fas fa-clock"></i> Pending</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                            <tfoot>
                                                <tr class="bg-light">
                                                    <td colspan="2" class="text-right font-weight-bold">Total:</td>
                                                    <td class="font-weight-bold">
                                                        <fmt:formatNumber value="${totalRepaymentAmount}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND
                                                    </td>
                                                    <td></td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Approval section - only shown if status is pending and user has permission -->
                            <c:if test="${loanRequest.status eq 'Pending' && canApprove}">
                                <div class="approval-section mt-4" id="approval-section">
                                    <h5 class="mb-4"><i class="fas fa-check-double"></i> Approval Decision</h5>

                                    <div class="row">
                                        <!-- Left column - Approve -->
                                        <div class="col-md-6">
                                            <div class="approval-col approval-col-approve p-3">
                                                <div class="col-title">
                                                    <i class="fas fa-check-circle text-success"></i> Approve Loan Request
                                                </div>
                                                <!-- Separate approval form -->
                                                <form action="${pageContext.request.contextPath}/loan-request-detail" method="post" class="mb-2">
                                                    <input type="hidden" name="requestId" value="${loanRequest.requestId}"/>
                                                    <input type="hidden" name="action" value="approve"/>
                                                    <div class="form-group">
                                                        <label for="approveNotes">Notes (optional):</label>
                                                        <textarea id="approveNotes" name="notes" class="form-control" rows="3" placeholder="Enter approval notes (if needed)"></textarea>
                                                    </div>
                                                    <button type="submit" class="btn btn-success btn-block">
                                                        <i class="fas fa-check"></i> Approve Loan Request
                                                    </button>
                                                </form>
                                            </div>
                                        </div>

                                        <!-- Right column - Reject -->
                                        <div class="col-md-6">
                                            <div class="approval-col approval-col-reject p-3">
                                                <div class="col-title">
                                                    <i class="fas fa-times-circle text-danger"></i> Reject Loan Request
                                                </div>
                                                <!-- Separate rejection form -->
                                                <form action="${pageContext.request.contextPath}/loan-request-detail" method="post" class="mb-2">
                                                    <input type="hidden" name="requestId" value="${loanRequest.requestId}"/>
                                                    <input type="hidden" name="action" value="reject"/>
                                                    <div class="form-group">
                                                        <label for="rejectReason"><span class="text-danger">*</span> Rejection Reason:</label>
                                                        <textarea id="rejectReason" name="notes" class="form-control" rows="3" placeholder="Enter rejection reason (required)" required></textarea>
                                                        <small class="form-text text-muted">Rejection reason is required.</small>
                                                    </div>
                                                    <button type="submit" class="btn btn-danger btn-block">
                                                        <i class="fas fa-times"></i> Reject Loan Request
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Delete section - only shown if user has permission -->
                            <c:if test="${canDelete}">
                                <div class="delete-section mt-4">
                                    <h5 class="mb-3"><i class="fas fa-trash-alt text-danger"></i> Delete Loan Request</h5>
                                    <div class="alert alert-warning">
                                        <i class="fas fa-exclamation-triangle"></i> Warning: This action cannot be undone. Deleting a loan request will permanently remove it from the system.
                                    </div>
                                    <form action="${pageContext.request.contextPath}/loan-request-detail" method="post" id="deleteForm">
                                        <input type="hidden" name="requestId" value="${loanRequest.requestId}"/>
                                        <input type="hidden" name="action" value="delete"/>
                                        <button type="submit" class="btn btn-danger">
                                            <i class="fas fa-trash-alt"></i> Delete Loan Request
                                        </button>
                                    </form>
                                </div>
                            </c:if>
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
    </body>
</html>
