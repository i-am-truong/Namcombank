<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank - ${viewMode ? 'Asset Details' : 'Add Asset'}</title>

        <!-- Custom styles -->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">

        <style>
            .form-wrapper {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-top: 20px;
            }

            .required-field::after {
                content: " *";
                color: red;
            }

            .btn-action {
                min-width: 120px;
            }

            .error-message {
                color: #e74a3b;
                font-size: 80%;
                margin-top: 0.25rem;
            }

            .view-mode-label {
                font-weight: bold;
                color: #4e73df;
            }

            .view-mode-value {
                padding: 6px 12px;
                background-color: #f8f9fc;
                border-radius: 4px;
                min-height: 38px;
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
                            <h1 class="h3 mb-0 text-gray-800">
                                Add New Asset
                            </h1>
                            <a href="assets-filter" class="btn btn-secondary btn-sm">
                                <i class="fas fa-arrow-left"></i> Back to List
                            </a>
                        </div>

                        <!-- Success message display -->
                        <c:if test="${not empty sessionScope.successMessage}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                ${sessionScope.successMessage}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <c:remove var="successMessage" scope="session" />
                        </c:if>

                        <!-- Error message display -->
                        <c:if test="${not empty sessionScope.errorMessage}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${sessionScope.errorMessage}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <c:remove var="errorMessage" scope="session" />
                        </c:if>

                        <div class="form-wrapper">
                            <c:choose>
                                <c:when test="${viewMode}">
                                    <!-- View mode -->
                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="view-mode-label">Customer</label>
                                                <div class="view-mode-value">${asset.customerName}</div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="view-mode-label">Staff</label>
                                                <div class="view-mode-value">${asset.staffName}</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="view-mode-label">Asset Name</label>
                                                <div class="view-mode-value">${asset.assetName}</div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="view-mode-label">Asset Type</label>
                                                <div class="view-mode-value">${asset.assetTypeDisplay}</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="view-mode-label">Asset Value</label>
                                                <div class="view-mode-value">
                                                    <fmt:formatNumber value="${asset.assetValue}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="view-mode-label">Description</label>
                                                <div class="view-mode-value">${asset.description}</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="view-mode-label">Status</label>
                                                <div class="view-mode-value">
                                                    <c:choose>
                                                        <c:when test="${asset.status eq 'PENDING'}">
                                                            <span class="text-warning"><i class="fas fa-clock"></i> Pending</span>
                                                        </c:when>
                                                        <c:when test="${asset.status eq 'APPROVED'}">
                                                            <span class="text-success"><i class="fas fa-check-circle"></i> Approved</span>
                                                        </c:when>
                                                        <c:when test="${asset.status eq 'REJECTED'}">
                                                            <span class="text-danger"><i class="fas fa-times-circle"></i> Rejected</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${asset.status}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="view-mode-label">Created Date</label>
                                                <div class="view-mode-value">
                                                    <fmt:formatDate value="${asset.createdDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <c:if test="${asset.status ne 'PENDING'}">
                                        <div class="row mb-4">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="view-mode-label">Approved By</label>
                                                    <div class="view-mode-value">${asset.approverName}</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="view-mode-label">Approval Date</label>
                                                    <div class="view-mode-value">
                                                        <fmt:formatDate value="${asset.approvedDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>

                                    <!-- Action buttons -->
                                    <div class="form-group text-center mt-4">
                                        <a href="assets-filter" class="btn btn-primary btn-action">
                                            <i class="fas fa-list"></i> View List
                                        </a>
                                        <a href="assets-add" class="btn btn-success btn-action ml-2">
                                            <i class="fas fa-plus"></i> Add New Asset
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <!-- Add asset mode -->
                                    <form action="assets-add" method="post" id="assetForm">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="customer_id" class="required-field">Customer</label>
                                                    <select class="form-control ${not empty errors.customer_id ? 'is-invalid' : ''}" 
                                                            id="customer_id" name="customer_id">
                                                        <option value="">-- Select Customer --</option>
                                                        <c:forEach items="${customers}" var="customer">
                                                            <option value="${customer.customerId}" 
                                                                    ${customer_id eq customer.customerId ? 'selected' : ''}>
                                                                ${customer.fullname} (ID: ${customer.cid})
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                    <c:if test="${not empty errors.customer_id}">
                                                        <div class="error-message">${errors.customer_id}</div>
                                                    </c:if>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="staff_id_display" class="required-field">Staff</label>
                                                    <input type="text" class="form-control" id="staff_id_display" value="${sessionScope.account.fullname}" readonly>
                                                    <input type="hidden" id="staff_id" name="staff_id" value="${sessionScope.account.id}">

                                                    <c:if test="${not empty errors.staff_id}">
                                                        <div class="error-message">${errors.staff_id}</div>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="asset_name" class="required-field">Asset Name</label>
                                                    <input type="text" class="form-control ${not empty errors.asset_name ? 'is-invalid' : ''}" 
                                                           id="asset_name" name="asset_name" value="${asset_name}">
                                                    <c:if test="${not empty errors.asset_name}">
                                                        <div class="error-message">${errors.asset_name}</div>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="asset_type" class="required-field">Asset Type</label>
                                                    <select class="form-control ${not empty errors.asset_type ? 'is-invalid' : ''}" 
                                                            id="asset_type" name="asset_type">
                                                        <option value="">-- Select Asset Type --</option>
                                                        <option value="REAL_ESTATE" ${asset_type eq 'REAL_ESTATE' ? 'selected' : ''}>Real Estate</option>
                                                        <option value="VEHICLE" ${asset_type eq 'VEHICLE' ? 'selected' : ''}>Vehicle</option>
                                                        <option value="INCOME" ${asset_type eq 'INCOME' ? 'selected' : ''}>Income</option>
                                                        <option value="OTHER" ${asset_type eq 'OTHER' ? 'selected' : ''}>Other</option>
                                                    </select>
                                                    <c:if test="${not empty errors.asset_type}">
                                                        <div class="error-message">${errors.asset_type}</div>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="asset_value" class="required-field">Asset Value (VND)</label>
                                                    <input type="text" class="form-control ${not empty errors.asset_value ? 'is-invalid' : ''}" 
                                                           id="asset_value" name="asset_value" value="${asset_value}"
                                                           placeholder="Please enter a numeric value, maximum 1,000 billion VND">
                                                    <c:if test="${not empty errors.asset_value}">
                                                        <div class="error-message">${errors.asset_value}</div>
                                                    </c:if>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="description">Description</label>
                                                    <textarea class="form-control" id="description" name="description" rows="3">${description}</textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Submit button -->
                                        <div class="form-group text-center mt-4">
                                            <button type="submit" class="btn btn-primary btn-action mr-2">
                                                <i class="fas fa-save"></i> Save Asset
                                            </button>
                                        </div>
                                    </form>
                                </c:otherwise>
                            </c:choose>
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

        <!-- Money validation script -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const assetValueInput = document.getElementById('asset_value');
                
                if (assetValueInput) {
                    // Format the initial value if it exists
                    if (assetValueInput.value) {
                        assetValueInput.value = formatCurrency(assetValueInput.value);
                    }
                    
                    // Add input event listener for real-time formatting
                    assetValueInput.addEventListener('input', function(e) {
                        // Store cursor position
                        const cursorPos = this.selectionStart;
                        const oldLength = this.value.length;
                        
                        // Remove non-numeric characters for processing
                        let value = this.value.replace(/[^\d]/g, '');
                        
                        // Format the value
                        if (value) {
                            this.value = formatCurrency(value);
                        }
                        
                        // Adjust cursor position after formatting
                        const newLength = this.value.length;
                        const cursorAdjustment = newLength - oldLength;
                        this.setSelectionRange(cursorPos + cursorAdjustment, cursorPos + cursorAdjustment);
                    });
                    
                    // Add blur event to ensure proper formatting when leaving the field
                    assetValueInput.addEventListener('blur', function() {
                        if (this.value) {
                            // Remove non-numeric characters and format
                            let value = this.value.replace(/[^\d]/g, '');
                            this.value = formatCurrency(value);
                        }
                    });
                    
                    // Add form submit handler to clean up the value before submission
                    const assetForm = document.getElementById('assetForm');
                    if (assetForm) {
                        assetForm.addEventListener('submit', function(e) {
                            // Remove formatting before submitting
                            if (assetValueInput.value) {
                                assetValueInput.value = assetValueInput.value.replace(/[^\d]/g, '');
                                
                                // Validate maximum value (1,000 billion VND = 1,000,000,000,000)
                                const numValue = Number(assetValueInput.value);
                                if (numValue > 1000000000000) {
                                    e.preventDefault();
                                    alert('Asset value cannot exceed 1,000 billion VND');
                                    assetValueInput.focus();
                                    // Reapply formatting for display
                                    assetValueInput.value = formatCurrency(assetValueInput.value);
                                }
                            }
                        });
                    }
                }
                
                // Function to format currency with commas as thousand separators
                function formatCurrency(value) {
                    return value.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                }
            });
        </script>
    </body>
</html>
