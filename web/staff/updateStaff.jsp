<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank - Update Staff</title>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <style>
            .form-group {
                display: flex;
                align-items: center;
                gap: 15px;
            }
            label {
                width: 150px;
            }
            .role-options {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
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
                        <h1>Update Staff</h1>
                        <form action="updateStaff" method="post" class="col-8">
                            <input type="hidden" name="id" value="${staff.id}">

                            <div class="form-group">
                                <label for="name">Name:</label>
                                <input type="text" class="form-control" name="nameS" id="name" 
                                       value="${fn:escapeXml(staff.fullname)}" required>
                            </div>

                            <div class="form-group">
                                <label for="phone">Phone:</label>
                                <input type="text" class="form-control" name="phoneS" id="phone" 
                                       value="${fn:escapeXml(staff.phonenumber)}" 
                                       required pattern="^0[0-9]{9,10}$">
                            </div>

                            <div class="form-group">
                                <label for="email">Email:</label>
                                <input type="email" class="form-control" name="emailS" id="email" 
                                       value="${fn:escapeXml(staff.email)}" 
                                       required pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$">
                            </div>

                            <div class="form-group">
                                <label for="cic">Citizen ID:</label>
                                <input type="text" class="form-control" name="cicS" id="cic" 
                                       value="${fn:escapeXml(staff.citizenId)}" 
                                       required pattern="^[0-9]{12}$">
                            </div>

                            <div class="form-group">
                                <label for="address">Address:</label>
                                <input type="text" class="form-control" name="addressS" id="address" 
                                       value="${fn:escapeXml(staff.address)}" 
                                       required pattern="^[A-Za-z0-9\\s,.'-]{3,}$">
                            </div>

                            <div class="form-group">
                                <label for="dob">Date of Birth:</label>
                                <input type="date" class="form-control" name="dobS" id="dob" 
                                       value="${fn:escapeXml(staff.dob)}" required>
                            </div>

                            <div class="form-group">
                                <label>Gender:</label>
                                <input type="radio" name="genderS" value="1" ${staff.gender ? 'checked' : ''}> Male
                                <input type="radio" name="genderS" value="0" ${!staff.gender ? 'checked' : ''}> Female
                            </div>

                            <div class="form-group">
                                <label>Department:</label>
                                <select class="form-control" name="did">
                                    <c:forEach var="dept" items="${depts}">
                                        <option value="${dept.id}" ${staff.dept.id == dept.id ? 'selected' : ''}>${dept.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="role-wrapper">
                                <label class="role-title">Select Roles</label>
                                <div class="role-options">
                                    <c:forEach var="role" items="${allRoles}">
                                        <label class="role-toggle">
                                            <input type="checkbox" name="roleIds" value="${role.id}" 
                                                   <c:forEach var="staffRole" items="${staff.roles}">
                                                       <c:if test="${role.id eq staffRole.id}">checked</c:if>
                                                   </c:forEach>>
                                            ${role.name}
                                        </label>
                                    </c:forEach>
                                </div>
                            </div>

                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger">${errorMessage}</div>
                            </c:if>
                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success">${successMessage}</div>
                            </c:if>

                            <button type="submit" class="btn btn-primary">Update Staff</button>
                            <a href="staffFilter" class="btn btn-secondary">Back</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
        <script src="adminassets/js/sb-admin-2.min.js"></script>
    </body>
</html>
