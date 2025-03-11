<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank - Asset Details</title>

        <!-- Custom styles -->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">

        <style>
            /* Keep your existing styles */
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
        </style>
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
                            <h1 class="h3 mb-0 text-gray-800">Asset Details</h1>
                            <a href="assets-filter" class="btn btn-secondary btn-sm">
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
                                <h4>${asset.assetName}</h4>
                                <c:choose>
                                    <c:when test="${asset.status eq 'PENDING'}">
                                        <span class="status-badge badge-pending"><i class="fas fa-clock"></i> Pending</span>
                                    </c:when>
                                    <c:when test="${asset.status eq 'APPROVED'}">
                                        <span class="status-badge badge-approved"><i class="fas fa-check-circle"></i> Approved</span>
                                    </c:when>
                                    <c:when test="${asset.status eq 'REJECTED'}">
                                        <span class="status-badge badge-rejected"><i class="fas fa-times-circle"></i> Rejected</span>
                                    </c:when>
                                </c:choose>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="detail-section">
                                        <h5><i class="fas fa-info-circle"></i> Basic Information</h5>
                                        <div class="detail-row">
                                            <div class="detail-label">Asset Type:</div>
                                            <div class="detail-value">${asset.assetTypeDisplay}</div>
                                        </div>
                                        <div class="detail-row">
                                            <div class="detail-label">Value:</div>
                                            <div class="detail-value"><fmt:formatNumber value="${asset.assetValue}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND</div>
                                        </div>
                                        <div class="detail-row">
                                            <div class="detail-label">Description:</div>
                                            <div class="detail-value">${asset.description}</div>
                                        </div>
                                    </div>

                                    <div class="detail-section">
                                        <h5><i class="fas fa-user"></i> Customer Information</h5>
                                        <div class="detail-row">
                                            <div class="detail-label">Customer ID:</div>
                                            <div class="detail-value">${asset.customerId}</div>
                                        </div>
                                        <div class="detail-row">
                                            <div class="detail-label">Customer Name:</div>
                                            <div class="detail-value">${asset.customerName}</div>
                                        </div>
                                        <div class="detail-row">
                                            <div class="detail-label">ID Card:</div>
                                            <div class="detail-value">${customer.cid}</div>
                                        </div>
                                        <div class="detail-row">
                                            <div class="detail-label">Phone Number:</div>
                                            <div class="detail-value">${customer.phonenumber}</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="detail-section">
                                        <h5><i class="fas fa-clipboard-list"></i> Registration Information</h5>
                                        <div class="detail-row">
                                            <div class="detail-label">Created By:</div>
                                            <div class="detail-value">${asset.staffName}</div>
                                        </div>
                                        <div class="detail-row">
                                            <div class="detail-label">Creation Date:</div>
                                            <div class="detail-value"><fmt:formatDate value="${asset.createdDate}" pattern="MM/dd/yyyy HH:mm"/></div>
                                        </div>
                                    </div>

                                    <div class="detail-section">
                                        <h5><i class="fas fa-user-check"></i> Approval Information</h5>
                                        <c:choose>
                                            <c:when test="${asset.status eq 'PENDING'}">
                                                <div class="pending-message">
                                                    <i class="fas fa-info-circle"></i> This asset is pending approval
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="detail-row">
                                                    <div class="detail-label">Approved By:</div>
                                                    <div class="detail-value">${not empty asset.approverName ? asset.approverName : 'N/A'}</div>
                                                </div>
                                                <div class="detail-row">
                                                    <div class="detail-label">Approval Date:</div>
                                                    <div class="detail-value">
                                                        <c:choose>
                                                            <c:when test="${not empty asset.approvedDate}">
                                                                <fmt:formatDate value="${asset.approvedDate}" pattern="MM/dd/yyyy HH:mm"/>
                                                            </c:when>
                                                            <c:otherwise>N/A</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>

                                                <c:if test="${asset.status eq 'APPROVED' && not empty asset.notes}">
                                                    <div class="detail-row">
                                                        <div class="detail-label">Notes:</div>
                                                        <div class="detail-value">
                                                            <div class="approval-note">
                                                                <i class="fas fa-comment-dots mr-2"></i> ${asset.notes}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>

                                                <c:if test="${asset.status eq 'REJECTED' && not empty asset.notes}">
                                                    <div class="detail-row">
                                                        <div class="detail-label">Rejection Reason:</div>
                                                        <div class="detail-value">
                                                            <div class="rejection-reason">
                                                                <i class="fas fa-exclamation-circle mr-2"></i> ${asset.notes}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    
                                    <!-- Delete Asset Button -->
                                    <c:if test="${canApprove}">
                                        <div class="detail-section">
                                            <h5><i class="fas fa-trash-alt"></i> Asset Management</h5>
                                            <form action="asset-detail" method="POST" id="deleteAssetForm">
                                                <input type="hidden" name="asset_id" value="${asset.assetId}"/>
                                                <input type="hidden" name="action" value="delete"/>
                                                <button type="button" class="btn btn-danger btn-block" onclick="confirmDelete()">
                                                    <i class="fas fa-trash-alt"></i> Delete Asset
                                                </button>
                                            </form>
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                            <!-- Display approval/rejection form only if user has permission and asset is pending -->
                            <c:if test="${canApprove && asset.status eq 'PENDING'}">
                                <div class="approval-section mt-4" id="approval-section">
                                    <h5 class="mb-4"><i class="fas fa-check-double"></i> Approval Decision</h5>

                                    <form action="asset-detail" method="POST" id="assetActionForm" class="mb-2">
                                        <input type="hidden" name="asset_id" value="${asset.assetId}"/>
                                        <input type="hidden" name="action" id="actionType" value=""/>

                                        <div class="row">
                                            <!-- Left column - Approve -->
                                            <div class="col-md-6">
                                                <div class="approval-col approval-col-approve p-3">
                                                    <div class="col-title">
                                                        <i class="fas fa-check-circle text-success"></i> Approve Asset
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="note">Notes (optional):</label>
                                                        <textarea id="note" name="note" class="form-control" rows="3" placeholder="Enter approval notes (if needed)"></textarea>
                                                    </div>
                                                    <button type="button" class="btn btn-success btn-block" onclick="submitAction('approve')">
                                                        <i class="fas fa-check"></i> Approve Asset
                                                    </button>
                                                </div>
                                            </div>

                                            <!-- Right column - Reject -->
                                            <div class="col-md-6">
                                                <div class="approval-col approval-col-reject p-3">
                                                    <div class="col-title">
                                                        <i class="fas fa-times-circle text-danger"></i> Reject Asset
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="reason"><span class="text-danger">*</span> Rejection Reason:</label>
                                                        <textarea id="reason" name="reason" class="form-control" rows="3" placeholder="Enter rejection reason (required)"></textarea>
                                                        <small class="form-text text-muted">Rejection reason is required.</small>
                                                    </div>
                                                    <button type="button" class="btn btn-danger btn-block" onclick="submitReject()">
                                                        <i class="fas fa-times"></i> Reject Asset
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
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

        <script>
            function submitAction(action) {
                const form = document.getElementById('assetActionForm');
                const actionInput = document.getElementById('actionType');

                actionInput.value = action;

                if (action === 'approve') {
                    // Confirm approval
                    if (!confirm('Are you sure you want to approve this asset?')) {
                        return;
                    }
                }

                form.submit();
            }

            function submitReject() {
                const form = document.getElementById('assetActionForm');
                const actionInput = document.getElementById('actionType');
                const reasonInput = document.getElementById('reason');

                // Set action
                actionInput.value = 'reject';

                // Check rejection reason
                if (!reasonInput.value.trim()) {
                    alert('Please enter a rejection reason.');
                    reasonInput.focus();
                    return;
                }

                // Confirm rejection
                if (!confirm('Are you sure you want to reject this asset?')) {
                    return;
                }

                form.submit();
            }
            
            function confirmDelete() {
                if (confirm('Are you sure you want to delete this asset? This action cannot be undone.')) {
                    document.getElementById('deleteAssetForm').submit();
                }
            }

            // Auto-scroll to approval section if hash in URL
            $(document).ready(function () {
                if (window.location.hash === '#approval-section') {
                    $('html, body').animate({
                        scrollTop: $('#approval-section').offset().top - 100
                    }, 1000);
                }
            });
        </script>
    </body>
</html>
