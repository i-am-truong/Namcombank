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
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Banking Services System
        </div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item">
        <a class="nav-link" href="Dashboard">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Dashboard</span></a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">Interface</div>

    <li class="nav-item active">
        <a class="nav-link" href="userProfile">
            <i class="fas fa-fw fa-table"></i>
            <span>Profile</span></a>
    </li>
    <!--    <li class="nav-item active">
            <a class="nav-link" href="userProfile">
                <i class="fas fa-fw fa-table"></i>
                <span>Profile</span></a>
        </li>-->

    <!-- Nav Item - Tables -->
    <li class="nav-item active">
        <a class="nav-link" href="loanpackage/listloanpackage">
            <i class="fas fa-fw fa-table"></i>
            <span>Loan Packages Table</span></a>
    </li>

    <li class="nav-item active">
        <a class="nav-link" href="managerUser">
            <i class="fas fa-fw fa-table"></i>
            <span>Manager Customer</span></a>
    </li>


    <!-- feedback cua admin -->

    <li class="nav-item active">
        <a class="nav-link" href="viewCustomerFeedback">
            <i class="fas fa-fw fa-table"></i>
            <span>View Customer Feedback</span></a>
    </li>



    <li class="nav-item active">
        <a class="nav-link" href="listCate">
            <i class="fas fa-fw fa-table"></i>
            <span>Category Table</span></a>
    </li>



    <li class="nav-item active">
        <a class="nav-link" href="newsListStaff">
            <i class="fas fa-fw fa-table"></i>
            <span>News Manager</span></a>
    </li>

    <li class="nav-item active">
        <a class="nav-link" href="addNews">
            <i class="fas fa-fw fa-table"></i>
            <span> News Manager</span></a>
    </li>



    <!--    <li class="nav-item active">
            <a class="nav-link" href="listCate">
                <i class="fas fa-fw fa-table"></i>
                <span>Category Table</span></a>
        </li>
    
    
    
    -->    <li class="nav-item active">
        <a class="nav-link" href="newsList">
            <i class="fas fa-fw fa-table"></i>
            <span> News</span></a>
    </li>


    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>
</ul>
<script>
    document.getElementById('sidebarToggle').addEventListener('click', function () {
        document.getElementById('accordionSidebar').classList.toggle('toggled');
    });
</script>