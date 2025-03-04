package controller.Staff;

import context.DepartmentDAO;
import context.RoleDAO;
import context.StaffDAO;
import jakarta.servlet.ServletException;
import java.util.*;
import java.sql.*;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Department;
import model.auth.Role;
import model.auth.Staff;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;

public class staffProfile extends HttpServlet {
   
    private static final Logger logger = Logger.getLogger(staffProfile.class.getName());

    // Regex patterns for validation
    private static final Pattern CIC_REGEX = Pattern.compile("^[0-9]{12}$");
    private static final Pattern PHONE_REGEX = Pattern.compile("^0[0-9]{9,10}$");
    private static final Pattern EMAIL_REGEX = Pattern.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$");
    private static final Pattern ADDRESS_REGEX = Pattern.compile("^[\\p{L}0-9\\s,.\\-'/()]{3,}$");
    private static final Pattern FULLNAME_REGEX = Pattern.compile("^\\p{L}+(?:\\s\\p{L}+)+$");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        Staff account = (Staff) session.getAttribute("account");

        if (account == null) {
            response.sendRedirect("admin.login");
            return;
    } 

        System.out.println("Session ID: " + session.getId());
        System.out.println("Staff in session: " + account);

        // Lấy danh sách phòng ban
        DepartmentDAO dbDept = new DepartmentDAO();
        ArrayList<Department> depts = dbDept.list();
        request.setAttribute("depts", depts);

        // Lấy danh sách roles
        RoleDAO roleDAO = new RoleDAO();
        ArrayList<Role> roles = roleDAO.getAllRoles();
        request.setAttribute("allRoles", roles);

        // Gửi dữ liệu nhân viên đến JSP
        request.setAttribute("staff", account);
        request.getRequestDispatcher("staff/profileStaff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            // Retrieve parameters
            String raw_id = request.getParameter("id");
            String raw_sname = request.getParameter("nameS");
            String raw_dob = request.getParameter("dobS");
            String raw_gender = request.getParameter("genderS");
            String raw_address = request.getParameter("addressS");
            String raw_email = request.getParameter("emailS");
            String raw_phonenumber = request.getParameter("phoneS");
            String raw_cic = request.getParameter("cicS");
            String raw_did = request.getParameter("did");
            String[] raw_roleIds = request.getParameterValues("roleIds");

            // Validate input data
            String errorMessage = null;
            StaffDAO db = new StaffDAO();

            if (raw_id == null || raw_id.trim().isEmpty()) {
                errorMessage = "Staff ID is missing.";
            } else if (raw_sname == null || raw_sname.trim().isEmpty() || !FULLNAME_REGEX.matcher(raw_sname).matches()) {
                errorMessage = "Fullname must include at least the first and last names, separated by spaces, and contain only valid characters.";
            } else if (raw_dob == null || raw_dob.isEmpty()) {
                errorMessage = "Date of birth cannot be empty.";
            } else if (raw_phonenumber == null || !PHONE_REGEX.matcher(raw_phonenumber).matches()) {
                errorMessage = "Invalid phone number.";
            } else if (raw_email == null || !EMAIL_REGEX.matcher(raw_email).matches()) {
                errorMessage = "Invalid email format.";
            } else if (raw_cic == null || !CIC_REGEX.matcher(raw_cic).matches()) {
                errorMessage = "Citizen Identification must be 12 digits.";
            } else if (raw_address == null || raw_address.trim().isEmpty() || !ADDRESS_REGEX.matcher(raw_address).matches()) {
                errorMessage = "Invalid address. Must be at least 3 characters and only contain letters, numbers, and allowed special characters.";
            } else {
                int staffId = Integer.parseInt(raw_id);
                boolean isEmailExists = db.isValueExistExcept("email", raw_email, staffId);
                boolean isPhoneExists = db.isValueExistExcept("phonenumber", raw_phonenumber, staffId);
                boolean isCitizenIDExists = db.isValueExistExcept("citizen_identification_card", raw_cic, staffId);

                if (isPhoneExists) {
                    errorMessage = "Phone number already exists.";
                } else if (isEmailExists) {
                    errorMessage = "Email already exists.";
                } else if (isCitizenIDExists) {
                    errorMessage = "Citizen ID already exists.";
    }
            }

            // Load departments and roles for potential redisplay
            DepartmentDAO dbDept = new DepartmentDAO();
            ArrayList<Department> depts = dbDept.list();
            request.setAttribute("depts", depts);

            RoleDAO roleDAO = new RoleDAO();
            ArrayList<Role> allRoles = roleDAO.getAllRoles();
            request.setAttribute("allRoles", allRoles);

            int id = Integer.parseInt(raw_id);
            StaffDAO sdao = new StaffDAO();

            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);

                // Create a staff object with entered values to preserve form data
                Staff staff = new Staff();
                staff.setId(id);
                staff.setFullname(raw_sname);
                staff.setPhonenumber(raw_phonenumber);
                if (raw_dob != null && !raw_dob.isEmpty()) {
                    try {
                        staff.setDob(Date.valueOf(raw_dob));
                    } catch (IllegalArgumentException e) {
                        // Invalid date format, don't set
}
                }
                staff.setGender("1".equals(raw_gender));
                staff.setAddress(raw_address);
                staff.setEmail(raw_email);        
                staff.setCitizenId(raw_cic);
                        
                // Set department
                Department dept = new Department();
                if (raw_did != null && !raw_did.isEmpty()) {
                    dept.setId(Integer.parseInt(raw_did));
                }
                staff.setDept(dept);

                // Set roles
                ArrayList<Role> roles = new ArrayList<>();
                if (raw_roleIds != null) {
                    for (String roleId : raw_roleIds) {
                        Role role = new Role();
                        role.setId(Integer.parseInt(roleId));
                        roles.add(role);
                    }
                }
                staff.setRoles(roles);
                request.setAttribute("staff", staff);
                request.getRequestDispatcher("staff/profileStaff.jsp").forward(request, response);
                return;
            }

            // Create updated Staff object
            Staff staff = new Staff();
            staff.setId(id);
            staff.setFullname(raw_sname);
            staff.setPhonenumber(raw_phonenumber);
            staff.setDob(Date.valueOf(raw_dob));
            staff.setGender("1".equals(raw_gender));
            staff.setAddress(raw_address);
            staff.setEmail(raw_email);    
            staff.setCitizenId(raw_cic);

            // Set department
            Department dept = new Department();
            dept.setId(Integer.parseInt(raw_did));
            staff.setDept(dept);

            // Set roles
            ArrayList<Role> roles = new ArrayList<>();
            if (raw_roleIds != null) {
                for (String roleId : raw_roleIds) {
                    Role role = new Role();
                    role.setId(Integer.parseInt(roleId));
                    roles.add(role);
                }
            }
            staff.setRoles(roles);

            // Update staff information
            boolean isUpdated = sdao.updateStaff(staff);

            if (isUpdated) {
                // Refresh staff data after update
                staff = sdao.getById(id);
                request.setAttribute("staff", staff);
                request.setAttribute("successMessage", "Staff updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update staff.");
                request.setAttribute("staff", staff);
            }

            request.getRequestDispatcher("staff/profileStaff.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            logger.log(Level.SEVERE, "Invalid number format in request parameters", e);
            request.setAttribute("errorMessage", "Invalid input format. Please check your data.");
            request.getRequestDispatcher("staff/profileStaff.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            logger.log(Level.SEVERE, "Invalid date format or other input error", e);
            request.setAttribute("errorMessage", "Invalid date format or input error.");
            request.getRequestDispatcher("staff/profileStaff.jsp").forward(request, response);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Unexpected error in doAuthorizedPost", e);
            request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("staff/profileStaff.jsp").forward(request, response);
        }
    }
}
