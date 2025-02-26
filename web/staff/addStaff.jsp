<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank - Add Staff</title>
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
                        <h1>Add Staff</h1>
                        <form action="addStaff" method="post" class="col-8">
                            <div class="form-group">
                                <label for="name">Name:</label>
                                <input type="text" class="form-control" name="nameS" id="name" value="${param.nameS}">
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone:</label>
                                <input type="text" class="form-control" name="phoneS" id="phone" value="${param.phoneS}">
                            </div>
                            <div class="form-group">
                                <label for="email">Email:</label>
                                <input type="email" class="form-control" name="emailS" id="email" value="${param.emailS}">
                            </div>
                            <div class="form-group">
                                <label for="cic">Citizen ID:</label>
                                <input type="text" class="form-control" name="cicS" id="cic" value="${param.cicS}">
                            </div>
                            <div class="form-group">
                                <label for="address">Address:</label>
                                <input type="text" class="form-control" name="addressS" id="address" value="${param.addressS}">
                            </div>
                            <div class="form-group">
                                <label for="dob">Date of Birth:</label>
                                <input type="date" class="form-control" name="dobS" id="dob" value="${param.dobS}">
                            </div>
                            <div class="form-group">
                                <label>Gender:</label>
                                <input type="radio" name="genderS" value="1" ${param.genderS == '1' ? 'checked' : ''}> Male
                                <input type="radio" name="genderS" value="0" ${param.genderS == '0' ? 'checked' : ''}> Female
                            </div>

                            <div class="form-group">
                                <label>Department:</label>
                                <select class="form-control" name="did">
                                    <c:forEach var="dept" items="${depts}">
                                        <option value="${dept.id}" ${param.did == dept.id ? 'selected' : ''}>${dept.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="role-wrapper">
                                <label class="role-title">Select Roles</label>
                                <div class="role-options">
                                    <c:forEach var="role" items="${roles}">
                                        <label class="role-toggle">
                                            <input type="checkbox" name="roleId" value="${role.id}" 
                                                   <c:if test="${not empty paramValues.roleId}">
                                                       <c:forEach var="selectedRole" items="${paramValues.roleId}">
                                                           <c:if test="${selectedRole == role.id}">checked</c:if>
                                                       </c:forEach>
                                                   </c:if>>
                                            ${role.name}
                                        </label>
                                    </c:forEach>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="username">Username:</label>
                                <input type="text" class="form-control" name="usernameS" id="username" value="${param.usernameS}">
                            </div>

                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger">${errorMessage}</div>
                            </c:if>
                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success">${successMessage}</div>
                            </c:if>
                            <button type="submit" class="btn btn-primary">Add Staff</button>
                            <a href="managerUser" class="btn btn-secondary">Back</a>
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
