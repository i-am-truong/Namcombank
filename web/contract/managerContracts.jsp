<%-- 
    Document   : managerContracts
    Created on : Feb 9, 2025, 2:11:54 PM
    Author     : lenovo
--%>

<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="context.ContractDAO" %>
<%@ page import="model.Contract" %>

<%
    ContractDAO contractDAO = new ContractDAO();
    String search = request.getParameter("search");
    String sort = request.getParameter("sort");
    String status = request.getParameter("status");

    // Mặc định danh sách hợp đồng nếu không có bộ lọc
    List<Contract> contracts = contractDAO.list();

    // Lọc theo trạng thái nếu có chọn
    if (status != null && !status.equals("all")) {
        contracts = contractDAO.getContractsByStatus(status);
    }

    // Sắp xếp theo amount
    if (sort != null && sort.equals("desc")) {
        contracts.sort((c1, c2) -> Double.compare(c2.getAmount(), c1.getAmount()));
    } else {
        contracts.sort((c1, c2) -> Double.compare(c1.getAmount(), c2.getAmount()));
    }

    // Tìm kiếm theo tên khách hàng
    if (search != null && !search.trim().isEmpty()) {
        contracts.removeIf(c -> !c.getCustomerName().toLowerCase().contains(search.toLowerCase()));
    }
%>

<html>
    <head>
        <meta charset="utf-8">
        <title>Manage Contracts</title>
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    </head>
    <body id="page-top">

        <div id="wrapper">
            <%@include file="../homepage/sidebar_admin.jsp" %>

            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <%@include file="../homepage/header_admin.jsp" %>

                    <div class="container-fluid">
                        <h1 class="h3 mb-2 text-gray-800">Contracts List</h1>

                        <form id="filterForm" name="filterForm" action="contractApproval" method="GET">
                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <input type="text" name="search" class="form-control" placeholder="Search by customer name"
                                           value="<%= (search != null) ? search : "" %>">
                                </div>
                                <div class="col-md-3">
                                    <select name="sort" class="form-control" onchange="document.getElementById('filterForm').submit();">
                                        <option value="asc" <%= "asc".equals(sort) ? "selected" : "" %>>Amount: Low to High</option>
                                        <option value="desc" <%= "desc".equals(sort) ? "selected" : "" %>>Amount: High to Low</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <select name="status" class="form-control" onchange="document.getElementById('filterForm').submit();">
                                        <option value="all" <%= (status == null || status.equals("all")) ? "selected" : "" %>>All</option>
                                        <option value="pending" <%= "pending".equals(status) ? "selected" : "" %>>Pending</option>
                                        <option value="approved" <%= "approved".equals(status) ? "selected" : "" %>>Approved</option>
                                        <option value="rejected" <%= "rejected".equals(status) ? "selected" : "" %>>Rejected</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <button type="submit" class="btn btn-primary">Filter</button>
                                </div>
                            </div>
                        </form>

                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Customer Name</th>
                                    <th>Loan</th>
                                    <th>Loan Package</th>
                                    <th>Amount</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (contracts.isEmpty()) { %>
                                <tr>
                                    <td colspan="6" class="text-center">No contracts found.</td>
                                </tr>
                                <% } else {
                        for (Contract contract : contracts) { %>
                                <tr>
                                    <td><%= contract.getId() %></td>
                                    <td><%= contract.getCustomerName() %></td>
                                    <td><%= contract.getLoanName() %></td>
                                    <td><%= contract.getPackageName() %></td>
                                    <td>$<%= String.format("%.2f", contract.getAmount()) %></td>
                                    <td><%= contract.getStatus() %></td>
                                    <td>
                                        <form action="contractApproval" method="post" style="display:inline-block;">
                                            <input type="hidden" name="contractId" value="<%= contract.getId() %>">
                                            <button type="submit" name="action" value="approve" class="btn btn-success">Approve</button>
                                            <button type="submit" name="action" value="reject" class="btn btn-danger">Reject</button>
                                        </form>
                                        <a href="ContractDetailsController?id=<%= contract.getId() %>" class="btn btn-info">View</a>
                                    </td>
                                </tr>
                                <% } } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="adminassets/js/sb-admin-2.min.js"></script>
    </body>
</html>
