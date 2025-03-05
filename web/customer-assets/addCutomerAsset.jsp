<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank - ${viewMode ? 'Chi Tiết' : 'Thêm'} Tài Sản</title>

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
                                ${viewMode ? 'Chi Tiết' : 'Thêm'} Tài Sản
                            </h1>
                            <a href="assets-filter" class="btn btn-secondary btn-sm">
                                <i class="fas fa-arrow-left"></i> Quay lại danh sách
                            </a>
                        </div>

                        <!-- Hiển thị thông báo thành công nếu có -->
                        <c:if test="${not empty sessionScope.successMessage}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                ${sessionScope.successMessage}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <c:remove var="successMessage" scope="session" />
                        </c:if>

                        <!-- Hiển thị thông báo lỗi nếu có -->
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
                                    <!-- Chế độ xem chi tiết -->
                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="view-mode-label">Khách Hàng</label>
                                                <div class="view-mode-value">${asset.customerName}</div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="view-mode-label">Nhân Viên</label>
                                                <div class="view-mode-value">${asset.staffName}</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="view-mode-label">Tên Tài Sản</label>
                                                <div class="view-mode-value">${asset.assetName}</div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="view-mode-label">Loại Tài Sản</label>
                                                <div class="view-mode-value">${asset.assetTypeDisplay}</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="view-mode-label">Giá Trị Tài Sản</label>
                                                <div class="view-mode-value">
                                                    <fmt:formatNumber value="${asset.assetValue}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="view-mode-label">Mô Tả</label>
                                                <div class="view-mode-value">${asset.description}</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="view-mode-label">Trạng Thái</label>
                                                <div class="view-mode-value">
                                                    <c:choose>
                                                        <c:when test="${asset.status eq 'PENDING'}">
                                                            <span class="text-warning"><i class="fas fa-clock"></i> Chờ duyệt</span>
                                                        </c:when>
                                                        <c:when test="${asset.status eq 'APPROVED'}">
                                                            <span class="text-success"><i class="fas fa-check-circle"></i> Đã duyệt</span>
                                                        </c:when>
                                                        <c:when test="${asset.status eq 'REJECTED'}">
                                                            <span class="text-danger"><i class="fas fa-times-circle"></i> Từ chối</span>
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
                                                <label class="view-mode-label">Ngày Tạo</label>
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
                                                    <label class="view-mode-label">Người Duyệt</label>
                                                    <div class="view-mode-value">${asset.approverName}</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="view-mode-label">Ngày Duyệt</label>
                                                    <div class="view-mode-value">
                                                        <fmt:formatDate value="${asset.approvedDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>

                                    <!-- Nút thao tác -->
                                    <div class="form-group text-center mt-4">
                                        <a href="assets-filter" class="btn btn-primary btn-action">
                                            <i class="fas fa-list"></i> Xem Danh Sách
                                        </a>
                                        <a href="assets-add" class="btn btn-success btn-action ml-2">
                                            <i class="fas fa-plus"></i> Thêm Tài Sản Mới
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <!-- Chế độ thêm tài sản -->
                                    <form action="assets-add" method="post" id="assetForm">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="customer_id" class="required-field">Khách Hàng</label>
                                                    <select class="form-control ${not empty errors.customer_id ? 'is-invalid' : ''}" 
                                                            id="customer_id" name="customer_id">
                                                        <option value="">-- Chọn Khách Hàng --</option>
                                                        <c:forEach items="${customers}" var="customer">
                                                            <option value="${customer.customerId}" 
                                                                    ${customer_id eq customer.customerId ? 'selected' : ''}>
                                                                ${customer.fullname} (CMND/CCCD: ${customer.cid})
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
                                                    <label for="staff_id_display" class="required-field">Nhân Viên</label>
                                                    <input type="text" class="form-control" id="staff_id_display" value="${sessionScope.account.fullname}" readonly>
                                                    <input type="hidden" id="staff_id" name="staff_id" value="${sessionScope.account.id}">

                                                    <c:if test="${not empty errors.staff_id}">
                                                        <div class="error-message">${errors.staff_id}</div>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Debug staff info -->
                                        <div style="display: none;">
                                            <p>Session attributes:</p>
                                            <c:forEach items="${sessionScope}" var="attr">
                                                <p>${attr.key}: ${attr.value}</p>
                                            </c:forEach>
                                        </div>


                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="asset_name" class="required-field">Tên Tài Sản</label>
                                                    <input type="text" class="form-control ${not empty errors.asset_name ? 'is-invalid' : ''}" 
                                                           id="asset_name" name="asset_name" value="${asset_name}">
                                                    <c:if test="${not empty errors.asset_name}">
                                                        <div class="error-message">${errors.asset_name}</div>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="asset_type" class="required-field">Loại Tài Sản</label>
                                                    <select class="form-control ${not empty errors.asset_type ? 'is-invalid' : ''}" 
                                                            id="asset_type" name="asset_type">
                                                        <option value="">-- Chọn Loại Tài Sản --</option>
                                                        <option value="REAL_ESTATE" ${asset_type eq 'REAL_ESTATE' ? 'selected' : ''}>Bất động sản</option>
                                                        <option value="VEHICLE" ${asset_type eq 'VEHICLE' ? 'selected' : ''}>Phương tiện</option>
                                                        <option value="INCOME" ${asset_type eq 'INCOME' ? 'selected' : ''}>Thu nhập</option>
                                                        <option value="OTHER" ${asset_type eq 'OTHER' ? 'selected' : ''}>Khác</option>
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
                                                    <label for="asset_value" class="required-field">Giá Trị Tài Sản (VND)</label>
                                                    <input type="text" class="form-control ${not empty errors.asset_value ? 'is-invalid' : ''}" 
                                                           id="asset_value" name="asset_value" value="${asset_value}"
                                                           placeholder="Nhập giá trị, ví dụ: 1,000,000">
                                                    <small class="form-text text-muted">Vui lòng nhập giá trị số, không bao gồm đơn vị tiền tệ</small>
                                                    <c:if test="${not empty errors.asset_value}">
                                                        <div class="error-message">${errors.asset_value}</div>
                                                    </c:if>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="description">Mô Tả</label>
                                                    <textarea class="form-control" id="description" name="description" rows="3">${description}</textarea>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Nút submit -->
                                        <div class="form-group text-center mt-4">
                                            <button type="submit" class="btn btn-primary btn-action mr-2">
                                                <i class="fas fa-save"></i> Lưu Tài Sản
                                            </button>
                                            <a href="assets" class="btn btn-secondary btn-action">
                                                <i class="fas fa-times"></i> Hủy
                                            </a>
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

        <c:if test="${not viewMode}">

            <script>
                // Định dạng số tiền khi nhập
                document.getElementById('asset_value').addEventListener('input', function (e) {
                    // Lưu vị trí con trỏ
                    var cursorPos = this.selectionStart;
                    var oldLength = this.value.length;
                    // Loại bỏ tất cả ký tự không phải số
                    var value = this.value.replace(/[^\d]/g, '');
                    // Nếu không có gì, không làm gì cả
                    if (!value) {
                        this.value = '';
                        return;
                    }

                    // Định dạng số với dấu phẩy ngăn cách hàng nghìn mà không sử dụng parseInt
                    var formattedValue = '';
                    for (var i = 0; i < value.length; i++) {
                        if (i > 0 && (value.length - i) % 3 === 0) {
                            formattedValue += ',';
                        }
                        formattedValue += value.charAt(i);
                    }

                    // Cập nhật giá trị
                    this.value = formattedValue;
                    // Điều chỉnh vị trí con trỏ sau khi định dạng
                    var newLength = this.value.length;
                    var newCursorPos = cursorPos + (newLength - oldLength);
                    if (newCursorPos < 0)
                        newCursorPos = 0;
                    if (newCursorPos > newLength)
                        newCursorPos = newLength;
                    this.setSelectionRange(newCursorPos, newCursorPos);
                });

                // Kiểm tra form trước khi submit
                document.getElementById('assetForm').addEventListener('submit', function (e) {
                    var assetValue = document.getElementById('asset_value').value;
                    // Kiểm tra nếu giá trị tài sản trống
                    if (!assetValue || assetValue.trim() === '') {
                        e.preventDefault();
                        alert('Vui lòng nhập giá trị tài sản');
                        document.getElementById('asset_value').focus();
                        return false;
                    }

                    // Form hợp lệ, tiếp tục submit
                    return true;
                });
            </script>
        </c:if>
    </body>
</html>
