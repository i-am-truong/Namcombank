<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Namcombank || Edit Staff Info</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center text-success">Edit Staff Info</h2>
            <a href="staffFilter" class="btn btn-primary mb-3">Back to Staff List</a>

            <form id="updateStaff" action="updateStaff" method="POST">

                <input type="hidden" name="id" value="${staff.id}">

                <div class="form-group">
                    <label for="nameS">Full Name</label>
                    <input type="text" class="form-control" id="nameS" name="nameS"
                           value="${staff.fullname}" required pattern="[A-Za-z\s]{3,}" title="Full Name must be at least 3 characters and only contain letters.">
                </div>

                <div class="form-group">
                    <label for="phoneS">Phone Number</label>
                    <input type="tel" class="form-control" id="phoneS" name="phoneS"
                           value="${staff.phonenumber}" required pattern="^0[0-9]{9}$" title="Phone number must start with 0 and have exactly 10 digits.">
                </div>

                <div class="form-group">
                    <label for="emailS">Email</label>
                    <input type="email" class="form-control" id="emailS" name="emailS"
                           value="${staff.email}" required pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" title="Enter a valid email.">
                </div>

                <div class="form-group">
                    <label for="cicS">Citizen Identification</label>
                    <input type="text" class="form-control" id="cicS" name="cicS"
                           value="${staff.citizenId}" required pattern="^[0-9]{9,12}$" title="CIC must be 9 or 12 digits.">
                </div>

                <div class="form-group">
                    <label for="addressS">Address</label>
                    <input type="text" class="form-control" id="addressS" name="addressS"
                           value="${staff.address}" required pattern=".{5,}" title="Address must be at least 5 characters long.">
                </div>

                <div class="form-group">
                    <label for="dobS">Date of Birth</label>
                    <input type="date" class="form-control" id="dobS" name="dobS" value="${staff.dob}" required>
                </div>

                <div class="form-group">
                    <label for="genderS">Gender</label>
                    <select class="form-control" id="genderS" name="genderS" required>
                        <option value="true" ${staff.gender ? 'selected' : ''}>Male</option>
                        <option value="false" ${!staff.gender ? 'selected' : ''}>Female</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="did">Department</label>
                    <select class="form-control" id="did" name="did" required>
                        <c:forEach var="dept" items="${depts}">
                            <option value="${dept.id}" ${staff.dept.id == dept.id ? 'selected' : ''}>${dept.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <!-- Thêm phần chọn roles -->
                <div class="form-group">
                    <label>Roles:</label>
                    <c:forEach var="role" items="${allRoles}">
                        <div class="form-check">
                            <input type="checkbox" 
                                   name="roleIds" 
                                   value="${role.id}" 
                                   class="form-check-input"
                                   <c:forEach var="staffRole" items="${staff.roles}">
                                       <c:if test="${role.id eq staffRole.id}">checked</c:if>
                                   </c:forEach>
                                   />
                            <label class="form-check-label">${role.name}</label>
                        </div>
                    </c:forEach>
                </div>

                <div class="col-12">
                    <div class="d-grid">
                        <button type="submit" class="btn btn-success btn-lg">Update Staff</button>
                    </div>
                </div>
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success">${successMessage}</div>
                </c:if>

            </form>

            <script>
                document.querySelector("form").addEventListener("submit", function (event) {
                    let dob = document.getElementById("dobS").value;
                    let dobDate = new Date(dob);
                    let today = new Date();
                    today.setHours(0, 0, 0, 0);

                    if (dobDate >= today) {
                        alert("Date of birth cannot be today or in the future.");
                        event.preventDefault();
                    }
                });
            </script>


            <script>
                document.getElementById('updateStaff').addEventListener('submit', function (event) {
                    var phoneRegex = /^0\d{9}$/;
                    var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                    var cicRegex = /^[0-9]{9,12}$/;

                    var phone = document.getElementById('phoneS').value.trim();
                    var email = document.getElementById('emailS').value.trim();
                    var cic = document.getElementById('cicS').value.trim();
                    var dob = document.getElementById('dobS').value.trim();
                    var department = document.getElementById('did').value;

                    var errors = [];

                    if (!phoneRegex.test(phone)) {
                        errors.push('Phone number must start with 09 or 03 and have 10 digits.');
                    }
                    if (!emailRegex.test(email)) {
                        errors.push('Invalid email format.');
                    }
                    if (!cicRegex.test(cic)) {
                        errors.push('Citizen ID must be 9 or 12 digits.');
                    }

                    var today = new Date();
                    var dobDate = new Date(dob);
                    if (dobDate >= today) {
                        errors.push('Date of birth must be in the past.');
                    }
                    if (!department) {
                        errors.push('Please select a department.');
                    }

                    if (errors.length > 0) {
                        event.preventDefault();
                        alert(errors.join('\n'));
                    }
                });



            </script>
    </body>
</html>
