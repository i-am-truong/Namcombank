<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank - Quản Lý Tài Sản</title>

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
            <%@include file="../homepage/sidebar_admin.jsp" %>
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <%@include file="../homepage/header_admin.jsp" %>
                    <div class="container-fluid">
                        <div class="table-wrapper">
                            <!-- Thêm thông tin debug -->
                            <c:if test="${not empty assets}">
                                <div class="alert alert-info">
                                    Số tài sản tìm thấy: ${assets.size()}
                                </div>
                            </c:if>

                            <!-- Search Filters Form - Sửa method thành GET và action thành assets -->
                            <form action="${pageContext.request.contextPath}/assets-filter" method="GET" id="searchForm">
                                <div class="search-filters">
                                    <h4 class="mb-3">Tìm kiếm tài sản</h4>

                                    <div class="search-grid">
                                        <div class="form-group">
                                            <label for="assetName">Tên tài sản</label>
                                            <input type="text" id="assetName" name="assetName" class="form-control" 
                                                   value="${param.assetName}" placeholder="Tên tài sản">
                                        </div>

                                        <div class="form-group">
                                            <label for="assetType">Loại tài sản</label>
                                            <select id="assetType" name="assetType" class="form-control">
                                                <option value="" ${param.assetType == null || param.assetType == '' ? 'selected' : ''}>Tất cả</option>
                                                <option value="REAL_ESTATE" ${param.assetType == 'REAL_ESTATE' ? 'selected' : ''}>Bất động sản</option>
                                                <option value="VEHICLE" ${param.assetType == 'VEHICLE' ? 'selected' : ''}>Phương tiện</option>
                                                <option value="INCOME" ${param.assetType == 'INCOME' ? 'selected' : ''}>Thu nhập</option>
                                                <option value="OTHER" ${param.assetType == 'OTHER' ? 'selected' : ''}>Khác</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="customerName">Tên khách hàng</label>
                                            <input type="text" id="customerName" name="customerName" class="form-control" 
                                                   value="${param.customerName}" placeholder="Tên khách hàng">
                                        </div>

                                        <div class="form-group">
                                            <label for="minValue">Giá trị tối thiểu</label>
                                            <input type="number" id="minValue" name="minValue" class="form-control" 
                                                   value="${param.minValue}" placeholder="Giá trị tối thiểu">
                                        </div>

                                        <div class="form-group">
                                            <label for="maxValue">Giá trị tối đa</label>
                                            <input type="number" id="maxValue" name="maxValue" class="form-control" 
                                                   value="${param.maxValue}" placeholder="Giá trị tối đa">
                                        </div>

                                        <div class="form-group">
                                            <label for="status">Trạng thái</label>
                                            <select id="status" name="status" class="form-control">
                                                <option value="" ${param.status == null || param.status == '' ? 'selected' : ''}>Tất cả</option>
                                                <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>Chờ duyệt</option>
                                                <option value="APPROVED" ${param.status == 'APPROVED' ? 'selected' : ''}>Đã duyệt</option>
                                                <option value="REJECTED" ${param.status == 'REJECTED' ? 'selected' : ''}>Từ chối</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="createdDateFrom">Ngày tạo từ</label>
                                            <input type="date" id="createdDateFrom" name="createdDateFrom" class="form-control" 
                                                   value="${param.createdDateFrom}">
                                        </div>

                                        <div class="form-group">
                                            <label for="createdDateTo">Ngày tạo đến</label>
                                            <input type="date" id="createdDateTo" name="createdDateTo" class="form-control" 
                                                   value="${param.createdDateTo}">
                                        </div>

                                        <div class="form-group">
                                            <label for="approvedBy">Người duyệt</label>
                                            <input type="text" id="approvedBy" name="approvedBy" class="form-control" 
                                                   value="${param.approvedBy}" placeholder="Tên/ID người duyệt">
                                        </div>

                                        <div class="form-group">
                                            <label for="approvedDateFrom">Ngày duyệt từ</label>
                                            <input type="date" id="approvedDateFrom" name="approvedDateFrom" class="form-control" 
                                                   value="${param.approvedDateFrom}">
                                        </div>

                                        <div class="form-group">
                                            <label for="approvedDateTo">Ngày duyệt đến</label>
                                            <input type="date" id="approvedDateTo" name="approvedDateTo" class="form-control" 
                                                   value="${param.approvedDateTo}">
                                        </div>
                                    </div>

                                    <div class="search-buttons">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-search"></i> Tìm kiếm
                                        </button>
                                        <button type="button" id="clearFiltersBtn" class="btn btn-secondary">
                                            <i class="fas fa-undo"></i> Xóa bộ lọc
                                        </button>
                                    </div>
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
                                                        Tổng tài sản</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">${totalAssets}</div>
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
                                                        Chờ duyệt</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">${pendingAssets}</div>
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
                                                        Đã duyệt</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">${approvedAssets}</div>
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
                                                        Từ chối</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">${rejectedAssets}</div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-times-circle fa-2x text-gray-300"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Assets Table -->
                            <div class="table-responsive">
                                <table class="table table-bordered" id="assetTable">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên tài sản</th>
                                            <th>Loại</th>
                                            <th>Khách hàng</th>
                                            <th>Giá trị</th>
                                            <th>Người tạo</th>
                                            <th>Ngày tạo</th>
                                            <th>Trạng thái</th>
                                            <th>Người duyệt</th>
                                            <th>Ngày duyệt</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty assets && assets.size() > 0}">
                                                <c:forEach items="${assets}" var="asset">
                                                    <tr class="clickable-row" onclick="window.location.href = 'asset-detail?id=${asset.assetId}'">
                                                        <td>${asset.assetId}</td>
                                                        <td>${asset.assetName}</td>
                                                        <td>${asset.assetTypeDisplay}</td>
                                                        <td>${asset.customerName}</td>
                                                        <td><fmt:formatNumber value="${asset.assetValue}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND</td>
                                                        <td>${asset.staffName}</td>
                                                        <td><fmt:formatDate value="${asset.createdDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${asset.status eq 'PENDING'}">
                                                                    <span class="status-pending"><i class="fas fa-clock"></i> Chờ duyệt</span>
                                                                </c:when>
                                                                <c:when test="${asset.status eq 'APPROVED'}">
                                                                    <span class="status-approved"><i class="fas fa-check-circle"></i> Đã duyệt</span>
                                                                </c:when>
                                                                <c:when test="${asset.status eq 'REJECTED'}">
                                                                    <span class="status-rejected"><i class="fas fa-times-circle"></i> Từ chối</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${asset.status}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${asset.approverName}</td>
                                                        <td><fmt:formatDate value="${asset.approvedDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="10" class="text-center">Không tìm thấy tài sản nào</td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Pagination - Cập nhật để duy trì tham số tìm kiếm -->
                            <c:if test="${not empty assets && assets.size() > 0 && totalPages > 1}">
                                <div class="d-flex justify-content-center mt-4">
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination">
                                            <c:if test="${currentPage > 1}">
                                                <li class="page-item">
                                                    <a class="page-link" href="assets?page=${currentPage - 1}
                                                       <c:if test="${not empty param.assetName}">&assetName=${param.assetName}</c:if>
                                                       <c:if test="${not empty param.assetType}">&assetType=${param.assetType}</c:if>
                                                       <c:if test="${not empty param.customerName}">&customerName=${param.customerName}</c:if>
                                                       <c:if test="${not empty param.minValue}">&minValue=${param.minValue}</c:if>
                                                       <c:if test="${not empty param.maxValue}">&maxValue=${param.maxValue}</c:if>
                                                       <c:if test="${not empty param.status}">&status=${param.status}</c:if>
                                                       <c:if test="${not empty param.createdDateFrom}">&createdDateFrom=${param.createdDateFrom}</c:if>
                                                       <c:if test="${not empty param.createdDateTo}">&createdDateTo=${param.createdDateTo}</c:if>
                                                           " aria-label="Previous">
                                                           <span aria-hidden="true">&laquo;</span>
                                                       </a>
                                                    </li>
                                            </c:if>

                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                    <a class="page-link" href="assets?page=${i}
                                                       <c:if test="${not empty param.assetName}">&assetName=${param.assetName}</c:if>
                                                       <c:if test="${not empty param.assetType}">&assetType=${param.assetType}</c:if>
                                                       <c:if test="${not empty param.customerName}">&customerName=${param.customerName}</c:if>
                                                       <c:if test="${not empty param.minValue}">&minValue=${param.minValue}</c:if>
                                                       <c:if test="${not empty param.maxValue}">&maxValue=${param.maxValue}</c:if>
                                                       <c:if test="${not empty param.status}">&status=${param.status}</c:if>
                                                       <c:if test="${not empty param.createdDateFrom}">&createdDateFrom=${param.createdDateFrom}</c:if>
                                                       <c:if test="${not empty param.createdDateTo}">&createdDateTo=${param.createdDateTo}</c:if>
                                                       ">${i}</a>
                                                </li>
                                            </c:forEach>

                                            <c:if test="${currentPage < totalPages}">
                                                <li class="page-item">
                                                    <a class="page-link" href="assets?page=${currentPage + 1}
                                                       <c:if test="${not empty param.assetName}">&assetName=${param.assetName}</c:if>
                                                       <c:if test="${not empty param.assetType}">&assetType=${param.assetType}</c:if>
                                                       <c:if test="${not empty param.customerName}">&customerName=${param.customerName}</c:if>
                                                       <c:if test="${not empty param.minValue}">&minValue=${param.minValue}</c:if>
                                                       <c:if test="${not empty param.maxValue}">&maxValue=${param.maxValue}</c:if>
                                                       <c:if test="${not empty param.status}">&status=${param.status}</c:if>
                                                       <c:if test="${not empty param.createdDateFrom}">&createdDateFrom=${param.createdDateFrom}</c:if>
                                                       <c:if test="${not empty param.createdDateTo}">&createdDateTo=${param.createdDateTo}</c:if>
                                                           " aria-label="Next">
                                                           <span aria-hidden="true">&raquo;</span>
                                                       </a>
                                                    </li>
                                            </c:if>
                                        </ul>
                                    </nav>
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
                                                        // Clear filters functionality
                                                        document.getElementById('clearFiltersBtn').addEventListener('click', function () {
                                                            // Reset all form fields
                                                            document.getElementById('assetName').value = '';
                                                            document.getElementById('assetType').value = '';
                                                            document.getElementById('customerName').value = '';
                                                            document.getElementById('minValue').value = '';
                                                            document.getElementById('maxValue').value = '';
                                                            document.getElementById('status').value = '';
                                                            document.getElementById('createdDateFrom').value = '';
                                                            document.getElementById('createdDateTo').value = '';

                                                            // Chuyển hướng đến trang assets mà không có tham số tìm kiếm
                                                            window.location.href = 'assets-filter';
                                                        });
        </script>
    </body>
</html>
