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
            .search-filters {
                background: #fff;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-bottom: 20px;
            }

            .filters-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
            }

            .entries-selector {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .search-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 10px;
            }

            @media (max-width: 768px) {
                .filters-row {
                    flex-direction: column;
                    gap: 10px;
                }

                .entries-selector {
                    width: 100%;
                }

                #clearFilters {
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
                            <!-- Search Filters Section -->
                            <div class="search-filters">
                                <div class="filters-row">
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
                                    <button id="clearFilters" class="btn btn-secondary">Clear Filters</button>
                                </div>

                                <div class="search-grid">
                                    <input type="text" id="searchName" class="form-control" placeholder="Search Name">
                                    <select id="searchGender" class="form-control">
                                        <option value="">All Gender</option>
                                        <option value="male">Male</option>
                                        <option value="female">Female</option>
                                    </select>
                                    <input type="text" id="searchPhone" class="form-control" placeholder="Search Phone">
                                    <input type="text" id="searchCID" class="form-control" placeholder="Search CID">
                                    <input type="text" id="searchEmail" class="form-control" placeholder="Search Email">
                                    <input type="text" id="searchAddress" class="form-control" placeholder="Search Address">
                                    <select id="searchDepartment" class="form-control">
                                        <option value="">All Departments</option>
                                        <option value="IT">IT</option>
                                        <option value="Human Resources">Human Resources</option>
                                        <option value="Finance">Finance</option>
                                        <option value="Sales">Sales</option>
                                        <option value="Customer Support">Customer Support</option>
                                    </select>
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
            // Constants
            const DEBOUNCE_DELAY = 300;

            // Utility function for debouncing
            function debounce(func, delay) {
                let timeoutId;
                return function (...args) {
                    clearTimeout(timeoutId);
                    timeoutId = setTimeout(() => func.apply(this, args), delay);
                };
            }

            // Main search and pagination logic
            let currentPage = 1;
            let rowsPerPage = 10;
            let tableRows = [];

            function initializeTable() {
                tableRows = Array.from(document.querySelectorAll('#staffTable tbody tr'));
                setupEventListeners();
                displayTableData();
            }

            function setupEventListeners() {
                // Setup entries per page
                document.getElementById('entriesPerPage').addEventListener('change', (e) => {
                    rowsPerPage = parseInt(e.target.value);
                    currentPage = 1;
                    displayTableData();
                });

                // Setup search fields with validation
                const searchFields = {
                    name: 'searchName',
                    gender: 'searchGender',
                    phone: 'searchPhone',
                    cid: 'searchCID',
                    email: 'searchEmail',
                    address: 'searchAddress',
                    department: 'searchDepartment'
                };

                // Add event listeners for each search field
                Object.entries(searchFields).forEach(([field, id]) => {
                    const element = document.getElementById(id);
                    if (element) {
                        // Special validation for phone and CID
                        if (field === 'phone' || field === 'cid') {
                            element.addEventListener('input', (e) => {
                                e.target.value = e.target.value.replace(/[^0-9]/g, '');
                            });
                        }

                        // Email validation
                        if (field === 'email') {
                            element.addEventListener('input', (e) => {
                                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                                if (e.target.value && !emailRegex.test(e.target.value)) {
                                    element.classList.add('is-invalid');
                                } else {
                                    element.classList.remove('is-invalid');
                                }
                            });
                        }

                        // Add debounced search handler
                        element.addEventListener('input', debounce(() => {
                            currentPage = 1;
                            displayTableData();
                        }, DEBOUNCE_DELAY));
                }
                });

                // Setup clear filters
                document.getElementById('clearFilters').addEventListener('click', clearFilters);
            }

            function displayTableData() {
                const filteredRows = filterRows();
                const startIndex = (currentPage - 1) * rowsPerPage;
                const endIndex = startIndex + rowsPerPage;

                // Hide all rows first
                tableRows.forEach(row => row.style.display = 'none');

                // Show filtered rows for current page
                filteredRows.slice(startIndex, endIndex).forEach(row => {
                    row.style.display = '';
                });

                updatePagination(filteredRows.length);
            }

            function filterRows() {
                return tableRows.filter(row => {
                    const name = row.cells[0].textContent.toLowerCase();
                    const gender = row.cells[1].textContent.toLowerCase();
                    const phone = row.cells[3].textContent;
                    const cid = row.cells[4].textContent;
                    const email = row.cells[5].textContent.toLowerCase();
                    const address = row.cells[6].textContent.toLowerCase();
                    const department = row.cells[7].textContent.toLowerCase();

                    // Get search values
                    const nameSearch = document.getElementById('searchName').value.toLowerCase();
                    const genderSearch = document.getElementById('searchGender').value.toLowerCase();
                    const phoneSearch = document.getElementById('searchPhone').value;
                    const cidSearch = document.getElementById('searchCID').value;
                    const emailSearch = document.getElementById('searchEmail').value.toLowerCase();
                    const addressSearch = document.getElementById('searchAddress').value.toLowerCase();
                    const departmentSearch = document.getElementById('searchDepartment').value.toLowerCase();

                    // Check all conditions
                    return (!nameSearch || name.includes(nameSearch)) &&
                            (!genderSearch || gender === genderSearch) &&
                            (!phoneSearch || phone.includes(phoneSearch)) &&
                            (!cidSearch || cid.includes(cidSearch)) &&
                            (!emailSearch || email.includes(emailSearch)) &&
                            (!addressSearch || address.includes(addressSearch)) &&
                            (!departmentSearch || department.includes(departmentSearch));
                });
            }

            function clearFilters() {
                // Clear all search inputs
                const searchInputs = document.querySelectorAll('.search-grid input, .search-grid select');
                searchInputs.forEach(input => {
                    input.value = '';
                    input.classList.remove('is-invalid');
                });

                currentPage = 1;
                displayTableData();
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

            function changePage(page) {
                if (page < 1)
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