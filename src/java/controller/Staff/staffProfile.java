package controller.Staff;

import context.DepartmentDAO;
import context.RoleDAO;
import context.StaffDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Department;
import model.auth.Role;
import model.auth.Staff;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;

public class staffProfile extends HttpServlet {

    private static final Logger logger = Logger.getLogger(staffProfile.class.getName());

    private static final Pattern CIC_REGEX = Pattern.compile("^[0-9]{12}$");
    private static final Pattern PHONE_REGEX = Pattern.compile("^0[0-9]{9,10}$");
    private static final Pattern EMAIL_REGEX = Pattern.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$");
    private static final Pattern ADDRESS_REGEX = Pattern.compile("^[\\p{L}0-9\\s,.\\-'/()]{3,}$");
    private static final Pattern FULLNAME_REGEX = Pattern.compile("^\\p{L}+(?:\\s\\p{L}+)+$");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("account");

        if (staff == null) {
            logger.warning("No staff found in session. Redirecting to login.");
            response.sendRedirect("admin.login");
            return;
        }

        try {
            // Get fresh staff data from database
            StaffDAO dao = new StaffDAO();
            Staff freshStaffData = dao.getById(staff.getId());

            if (freshStaffData != null) {
                // Update session with fresh data
                session.setAttribute("account", freshStaffData);

                // Get departments and roles
                DepartmentDAO dbDept = new DepartmentDAO();
                RoleDAO roleDAO = new RoleDAO();

                request.setAttribute("depts", dbDept.list());
                request.setAttribute("allRoles", roleDAO.getAllRoles());
                request.setAttribute("staff", freshStaffData);

                logger.info("Loading profile page for staff ID: " + freshStaffData.getId());
                request.getRequestDispatcher("/staff/profileStaff.jsp").forward(request, response);
            } else {
                logger.warning("Could not retrieve staff data for ID: " + staff.getId());
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error loading staff profile", e);
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get current staff from session
            HttpSession session = request.getSession();
            Staff currentStaff = (Staff) session.getAttribute("account");

            if (currentStaff == null) {
                response.sendRedirect("admin.login");
                return;
            }

            // Get form parameters
            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneS");
            String email = request.getParameter("emailS");
            String address = request.getParameter("addressS");
            String cic = request.getParameter("cicS");
            String dob = request.getParameter("dobS");
            String gender = request.getParameter("genderS");
            String departmentId = request.getParameter("did");
            String[] roleIds = request.getParameterValues("roleIds");

            // Validate input
            String errorMessage = validateInput(fullName, phoneNumber, email, address, cic, dob);
            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
                doGet(request, response);
                return;
            }

            // Update staff object
            Staff updatedStaff = new Staff();
            updatedStaff.setId(currentStaff.getId());
            updatedStaff.setFullname(fullName);
            updatedStaff.setPhonenumber(phoneNumber);
            updatedStaff.setEmail(email);
            updatedStaff.setAddress(address);
            updatedStaff.setCitizenId(cic);
            updatedStaff.setDob(Date.valueOf(dob));
            updatedStaff.setGender("1".equals(gender));

            // Set department
            Department dept = new Department();
            dept.setId(Integer.parseInt(departmentId));
            updatedStaff.setDept(dept);

            // Set roles
            ArrayList<Role> roles = new ArrayList<>();
            if (roleIds != null) {
                for (String roleId : roleIds) {
                    Role role = new Role();
                    role.setId(Integer.parseInt(roleId));
                    roles.add(role);
                }
            }
            updatedStaff.setRoles(roles);

            // Update in database
            StaffDAO staffDAO = new StaffDAO();
            boolean isUpdated = staffDAO.updateStaff(updatedStaff);

            if (isUpdated) {
                // Refresh session data
                Staff refreshedStaff = staffDAO.getById(currentStaff.getId());
                session.setAttribute("account", refreshedStaff);
                session.setAttribute("address", refreshedStaff.getAddress());
                request.setAttribute("successMessage", "Profile updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile.");
            }

            // Reload the page with updated data
            doGet(request, response);

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error updating staff profile", e);
            request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
            doGet(request, response);
        }
    }

    private String validateInput(String fullName, String phoneNumber, String email, String address, String cic, String dob) {
        if (!FULLNAME_REGEX.matcher(fullName).matches()) {
            return "Invalid full name format";
        }
        if (!PHONE_REGEX.matcher(phoneNumber).matches()) {
            return "Invalid phone number format";
        }
        if (!EMAIL_REGEX.matcher(email).matches()) {
            return "Invalid email format";
        }
        if (!ADDRESS_REGEX.matcher(address).matches()) {
            return "Invalid address format";
        }
        if (!CIC_REGEX.matcher(cic).matches()) { // 🆕 Kiểm tra CIC hợp lệ
        return "CIC must be exactly 12 digits.";
    }

        // Kiểm tra ngày sinh phải từ 18 tuổi trở lên
        try {
            LocalDate birthDate = LocalDate.parse(dob);
            if (Period.between(birthDate, LocalDate.now()).getYears() < 18) {
                return "Staff must be at least 18 years old";
            }
        } catch (Exception e) {
            return "Invalid date of birth format";
        }

        return null;
    }

}