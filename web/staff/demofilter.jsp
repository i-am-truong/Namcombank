<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank</title>

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

            .table-controls {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .entries-selector {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .search-box {
                width: 300px;
            }

            .pagination {
                margin-top: 20px;
                justify-content: flex-end;
            }

            .action-btn {
                padding: 4px 8px;
                margin: 0 2px;
                border-radius: 4px;
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
                            <div class="table-controls">
                                <div class="entries-selector">
                                    <span>Show</span>
                                    <select id="entriesPerPage" class="form-select">
                                        <option value="5">5</option>
                                        <option value="10" selected>10</option>
                                        <option value="25">25</option>
                                        <option value="50">50</option>
                                    </select>
                                    <span>entries</span>
                                </div>

                                <div class="search-box">
                                    <input type="text" 
                                           id="searchInput" 
                                           class="form-control" 
                                           placeholder="Search...">
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-bordered" id="staffTable">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Gender</th>
                                            <th>Date of Birth</th>
                                            <th>Phone</th>
                                            <th>CID</th>
                                            <th>Email</th>
                                            <th>Address</th>
                                            <th>Department</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${requestScope.staff}" var="s">
                                            <tr>
                                                <td>${s.fullname}</td>
                                                <td>${s.gender ? "Male" : "Female"}</td>
                                                <td>${s.dob}</td>
                                                <td>${s.phonenumber}</td>
                                                <td>${s.citizenId}</td>
                                                <td>${s.email}</td>
                                                <td>${s.address}</td>
                                                <td>${s.dept.name}</td>
                                                <td>
                                                    <a href="updateStaff?id=${s.id}" 
                                                       class="btn btn-primary btn-sm action-btn">Edit</a>
                                                    <button onclick="checkDeleteCustomer('${s.id}')" 
                                                            class="btn btn-danger btn-sm action-btn">Delete</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <nav aria-label="Table navigation">
                                <ul class="pagination" id="pagination"></ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Pagination and Search Logic
            let currentPage = 1;
            let rowsPerPage = 10;
            let tableRows = [];

            function initializeTable() {
                tableRows = Array.from(document.querySelectorAll('#staffTable tbody tr'));
                displayTableData();
                setupEventListeners();
            }

            function displayTableData() {
                const searchTerm = document.getElementById('searchInput').value.toLowerCase();
                const filteredRows = tableRows.filter(row => {
                    const text = row.textContent.toLowerCase();
                    return text.includes(searchTerm);
                });

                const startIndex = (currentPage - 1) * rowsPerPage;
                const endIndex = startIndex + rowsPerPage;

                tableRows.forEach(row => row.style.display = 'none');
                filteredRows.slice(startIndex, endIndex).forEach(row => row.style.display = '');

                updatePagination(filteredRows.length);
            }

            function updatePagination(totalRows) {
                const totalPages = Math.ceil(totalRows / rowsPerPage);
                const pagination = document.getElementById('pagination');
                let paginationHTML = '';

                // Previous button
                paginationHTML += '<li class="page-item ' + (currentPage === 1 ? 'disabled' : '') + '">' +
                        '<a class="page-link" href="javascript:void(0)" onclick="changePage(' + (currentPage - 1) + ')">' +
                        'Previous</a></li>';

                // Page numbers
                for (let i = 1; i <= totalPages; i++) {
                    paginationHTML += '<li class="page-item ' + (currentPage === i ? 'active' : '') + '">' +
                            '<a class="page-link" href="javascript:void(0)" onclick="changePage(' + i + ')">' +
                            i + '</a></li>';
                }

                // Next button
                paginationHTML += '<li class="page-item ' + (currentPage === totalPages ? 'disabled' : '') + '">' +
                        '<a class="page-link" href="javascript:void(0)" onclick="changePage(' + (currentPage + 1) + ')">' +
                        'Next</a></li>';

                pagination.innerHTML = paginationHTML;
            }


            function setupEventListeners() {
                document.getElementById('searchInput').addEventListener('input', () => {
                    currentPage = 1;
                    displayTableData();
                });

                document.getElementById('entriesPerPage').addEventListener('change', (e) => {
                    rowsPerPage = parseInt(e.target.value);
                    currentPage = 1;
                    displayTableData();
                });
            }

            function changePage(page) {
                if (page < 1 || page > Math.ceil(tableRows.length / rowsPerPage))
                    return;
                currentPage = page;
                displayTableData();
            }

            function checkDeleteCustomer(sid) {
                if (confirm('Are you sure you want to delete this staff member?')) {
                    window.location = 'staffDelete?id=' + sid;
                }
            }

            // Initialize on page load
            document.addEventListener('DOMContentLoaded', initializeTable);
        </script>
    </body>
</html>