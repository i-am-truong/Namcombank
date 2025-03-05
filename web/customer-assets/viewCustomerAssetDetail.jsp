<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank - Chi Tiết Tài Sản</title>

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
                            <h1 class="h3 mb-0 text-gray-800">Chi Tiết Tài Sản</h1>
                            <a href="assets-filter" class="btn btn-secondary btn-sm">
                                <i class="fas fa-arrow-left"></i> Quay lại danh sách
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
                                        <span class="status-badge badge-pending"><i class="fas fa-clock"></i> Chờ duyệt</span>
                                    </c:when>
                                    <c:when test="${asset.status eq 'APPROVED'}">
                                        <span class="status-badge badge-approved"><i class="fas fa-check-circle"></i> Đã duyệt</span>
                                    </c:when>
                                    <c:when test="${asset.status eq 'REJECTED'}">
                                        <span class="status-badge badge-rejected"><i class="fas fa-times-circle"></i> Từ chối</span>
                                    </c:when>
                                </c:choose>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="detail-section">
                                        <h5><i class="fas fa-info-circle"></i> Thông Tin Cơ Bản</h5>
                                        <div class="detail-row">
                                            <div class="detail-label">ID Tài Sản:</div>
                                            <div class="detail-value">${asset.assetId}</div>
                                        </div>
                                        <div class="detail-row">
                                            <div class="detail-label">Loại Tài Sản:</div>
                                            <div class="detail-value">${asset.assetTypeDisplay}</div>
                                        </div>
                                        <div class="detail-row">
                                            <div class="detail-label">Giá Trị:</div>
                                            <div class="detail-value"><fmt:formatNumber value="${asset.assetValue}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND</div>
                                        </div>
                                        <div class="detail-row">
                                            <div class="detail-label">Mô Tả:</div>
                                            <div class="detail-value">${asset.description}</div>
                                        </div>
                                    </div>

                                    <div class="detail-section">
                                        <h5><i class="fas fa-user"></i> Thông Tin Khách Hàng</h5>
                                        <div class="detail-row">
                                            <div class="detail-label">ID Khách Hàng:</div>
                                            <div class="detail-value">${asset.customerId}</div>
                                        </div>
                                        <div class="detail-row">
                                            <div class="detail-label">Tên Khách Hàng:</div>
                                            <div class="detail-value">${asset.customerName}</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="detail-section">
                                        <h5><i class="fas fa-clipboard-list"></i> Thông Tin Đăng Ký</h5>
                                        <div class="detail-row">
                                            <div class="detail-label">Người Tạo:</div>
                                            <div class="detail-value">${asset.staffName}</div>
                                        </div>
                                        <div class="detail-row">
                                            <div class="detail-label">Ngày Tạo:</div>
                                            <div class="detail-value"><fmt:formatDate value="${asset.createdDate}" pattern="dd/MM/yyyy HH:mm"/></div>
                                        </div>
                                    </div>

                                    <div class="detail-section">
                                        <h5><i class="fas fa-user-check"></i> Thông Tin Duyệt</h5>
                                        <c:choose>
                                            <c:when test="${asset.status eq 'PENDING'}">
                                                <div class="pending-message">
                                                    <i class="fas fa-info-circle"></i> Tài sản này đang chờ duyệt
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="detail-row">
                                                    <div class="detail-label">Người Duyệt:</div>
                                                    <div class="detail-value">${not empty asset.approverName ? asset.approverName : 'N/A'}</div>
                                                </div>
                                                <div class="detail-row">
                                                    <div class="detail-label">Ngày Duyệt:</div>
                                                    <div class="detail-value">
                                                        <c:choose>
                                                            <c:when test="${not empty asset.approvedDate}">
                                                                <fmt:formatDate value="${asset.approvedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                            </c:when>
                                                            <c:otherwise>N/A</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>

                                                <c:if test="${asset.status eq 'APPROVED' && not empty asset.notes}">
                                                    <div class="detail-row">
                                                        <div class="detail-label">Ghi Chú:</div>
                                                        <div class="detail-value">
                                                            <div class="approval-note">
                                                                <i class="fas fa-comment-dots mr-2"></i> ${asset.notes}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>

                                                <c:if test="${asset.status eq 'REJECTED' && not empty asset.notes}">
                                                    <div class="detail-row">
                                                        <div class="detail-label">Lý Do Từ Chối:</div>
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
                                </div>
                            </div>
                            <!-- Hiển thị form duyệt/từ chối chỉ khi người dùng có quyền và tài sản đang ở trạng thái chờ duyệt -->
                            <c:if test="${canApprove && asset.status eq 'PENDING'}">
                                <div class="approval-section mt-4">
                                    <h5><i class="fas fa-check-double"></i> Quyết Định Duyệt</h5>
                                    <form action="asset-detail" method="POST" id="assetActionForm" class="mb-2">
                                        <input type="hidden" name="asset_id" value="${asset.assetId}"/>
                                        <input type="hidden" name="action" id="actionType" value=""/>

                                        <div class="form-group">
                                            <label for="note">Ghi Chú (tùy chọn):</label>
                                            <textarea id="note" name="note" class="form-control" rows="3"></textarea>
                                        </div>

                                        <div class="form-group" id="reasonGroup" style="display: none;">
                                            <label for="reason"><span class="text-danger">*</span> Lý Do Từ Chối:</label>
                                            <textarea id="reason" name="reason" class="form-control" rows="3"></textarea>
                                            <small class="form-text text-muted">Lý do từ chối là bắt buộc.</small>
                                        </div>

                                        <div class="d-flex mt-3">
                                            <button type="button" class="btn btn-success mr-2" onclick="submitAction('approve')">
                                                <i class="fas fa-check"></i> Duyệt
                                            </button>
                                            <button type="button" class="btn btn-danger" onclick="showReasonField()">
                                                <i class="fas fa-times"></i> Từ Chối
                                            </button>
                                        </div>
                                    </form>
                                </div>

                                <script>
                                    function showReasonField() {
                                        document.getElementById('reasonGroup').style.display = 'block';
                                        document.getElementById('reason').focus();

                                        // Thay đổi nút từ chối
                                        const rejectBtn = document.querySelector('.btn-danger');
                                        rejectBtn.innerHTML = '<i class="fas fa-times"></i> Xác nhận từ chối';
                                        rejectBtn.onclick = function () {
                                            submitAction('reject');
                                        };
                                    }

                                    function submitAction(action) {
                                        const form = document.getElementById('assetActionForm');
                                        const actionInput = document.getElementById('actionType');
                                        const reasonInput = document.getElementById('reason');

                                        actionInput.value = action;

                                        if (action === 'reject') {
                                            // Kiểm tra lý do từ chối
                                            if (!reasonInput.value.trim()) {
                                                alert('Vui lòng nhập lý do từ chối.');
                                                reasonInput.focus();
                                                return;
                                            }

                                            // Xác nhận từ chối
                                            if (!confirm('Bạn có chắc chắn muốn từ chối tài sản này?')) {
                                                return;
                                            }
                                        } else {
                                            // Xác nhận duyệt
                                            if (!confirm('Bạn có chắc chắn muốn duyệt tài sản này?')) {
                                                return;
                                            }
                                        }

                                        form.submit();
                                    }
                                </script>
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
