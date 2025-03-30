<%--
    Document   : sidebar_admin
    Created on : Jun 17, 2024, 4:31:07 PM
    Author     : lenvo
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <link rel="stylesheet" href="assets/css/fontawesome.all.min.css">
</head>

<ul class="navbar-nav bg-gradient-success sidebar sidebar-dark accordion" id="accordionSidebar">
    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="javascript:void(0)">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-university"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Banking Services System
        </div>
    </a>

    <!-- Divider -->
    <!--<hr class="sidebar-divider my-0">-->

    <!-- Nav Item - Dashboard -->
<!--    <li class="nav-item">
        <a class="nav-link" href="Dashboard">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Dashboard</span></a>
    </li>-->

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">Interface</div>

    <li class="nav-item active">
        <a class="nav-link" href="staffProfile">
            <i class="fas fa-fw fa-user-circle"></i>
            <span>Profile</span></a>
    </li>

    <li class="nav-item active">
        <a class="nav-link" href="loanpackage/listloanpackage">
            <i class="fas fa-fw fa-money-bill-wave"></i>
            <span>Loan Packages Table</span></a>
    </li>


    <li class="nav-item active">
        <a class="nav-link" href="chat/chat_staff.jsp">
            <i class="fas fa-fw fa-comments"></i>
            <span>Chat with Customer</span>
        </a>
    </li>

    <li class="nav-item">
        <a class="nav-link" href="#" data-toggle="collapse" data-target="#staffMenu" aria-expanded="false">
            <i class="fas fa-fw fa-users-cog"></i>
            <span>Staff Manager</span>
        </a>
        <div id="staffMenu" class="collapse">
            <a class="nav-link sub-menu" href="staffFilter">
                <i class="fas fa-fw fa-filter"></i> Filter Staff
            </a>
            <a class="nav-link sub-menu" href="addStaff">
                <i class="fas fa-fw fa-user-plus"></i> Add Staff
            </a>
        </div>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="#" data-toggle="collapse" data-target="#assetMenu" aria-expanded="false">
            <i class="fas fa-fw fa-chart-line"></i>
            <span>Asset Manager</span>
        </a>
        <div id="assetMenu" class="collapse">
            <a class="nav-link sub-menu" href="assets-filter">
                <i class="fas fa-fw fa-search-dollar"></i> Filter Asset
            </a>
            <a class="nav-link sub-menu" href="assets-add">
                <i class="fas fa-fw fa-plus-circle"></i> Add Asset
            </a>
        </div>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="loan-requests-auth">
            <i class="fas fa-fw fa-file-contract"></i>
            <span>Loan Require Filter</span>
        </a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="transaction-filter">
            <i class="fas fa-fw fa-exchange-alt"></i>
            <span>Transaction Filter</span>
        </a>
    </li>

<!--    <li class="nav-item active">
        <a class="nav-link" href="viewCustomerFeedback">
            <i class="fas fa-fw fa-comment-dots"></i>
            <span>View Customer Feedback</span></a>
    </li>-->

    <li class="nav-item active">
        <a class="nav-link" href="newsListStaff">
            <i class="fas fa-fw fa-newspaper"></i>
            <span>News Manager</span></a>
    </li>

    <li class="nav-item active">
        <a class="nav-link" href="manageCustomerVer2">
            <i class="fas fa-fw fa-user-friends"></i>
            <span>Manage Customer</span></a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

</ul>
<!-- jQuery and Bootstrap  -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
