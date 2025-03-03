package controller.Staff;

import static context.CustomerDAO.toSHA1;
import context.DepartmentDAO;
import context.StaffDAO;
import controller.auth.BaseRBACControlller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.regex.Pattern;
import model.Department;
import model.auth.Staff;
import context.RoleDAO;
import model.auth.Role;

public class StaffAddController extends BaseRBACControlller {

    private static final Pattern CIC_REGEX = Pattern.compile("^[0-9]{12}$");
    private static final Pattern PHONE_REGEX = Pattern.compile("^0[0-9]{9}$");
    private static final Pattern EMAIL_REGEX = Pattern.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$");
    private static final Pattern ADDRESS_REGEX = Pattern.compile("^[\\p{L}0-9\\s,.\\-'/()]{3,}$");
    private static final Pattern USERNAME_REGEX = Pattern.compile("^[A-Za-z0-9_.]+$");
    private static final Pattern FULLNAME_REGEX = Pattern.compile("^\\p{L}+(?:\\s\\p{L}+)+$");

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account)
            throws ServletException, IOException {
        DepartmentDAO dbDept = new DepartmentDAO();
        ArrayList<Department> depts = dbDept.list();
        request.setAttribute("depts", depts);

        StaffDAO dbEmp = new StaffDAO();
        ArrayList<Staff> staffList = dbEmp.list();
        request.setAttribute("staff", staffList);

        RoleDAO roleDAO = new RoleDAO();
        ArrayList<Role> roles = roleDAO.list();
        request.setAttribute("roles", roles);

        request.getRequestDispatcher("staff/addStaff.jsp").forward(request, response);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Staff account)
            throws ServletException, IOException {
        try {
            String raw_sname = request.getParameter("nameS");
            String raw_dob = request.getParameter("dobS");
            String raw_gender = request.getParameter("genderS");
            String raw_address = request.getParameter("addressS");
            String raw_email = request.getParameter("emailS");
            String raw_phonenumber = request.getParameter("phoneS");
            String raw_cic = request.getParameter("cicS");
            String raw_username = request.getParameter("usernameS");
            String raw_did = request.getParameter("did");
            String[] raw_roleIds = request.getParameterValues("roleId");

            String errorMessage = null;
            StaffDAO db = new StaffDAO();


            // Validate input parameters
            if (raw_sname == null || raw_sname.trim().isEmpty() || !FULLNAME_REGEX.matcher(raw_sname).matches()) {
                errorMessage = "Fullname must include at least the first and last names, separated by spaces, and contain only valid characters.";
            } else if (raw_phonenumber == null || !PHONE_REGEX.matcher(raw_phonenumber).matches()) {
                errorMessage = "Invalid phone number.";
            } else if (raw_email == null || !EMAIL_REGEX.matcher(raw_email).matches()) {
                errorMessage = "Invalid email format.";
            } else if (raw_cic == null || !CIC_REGEX.matcher(raw_cic).matches()) {
                errorMessage = "Citizen Identification must be 12 digits.";
            } else if (raw_address == null || raw_address.trim().isEmpty() || !ADDRESS_REGEX.matcher(raw_address).matches()) {
                errorMessage = "Invalid address. Must be at least 3 characters and only contain letters, numbers, and allowed special characters.";
            } else if (raw_dob == null || raw_dob.isEmpty()) {
                errorMessage = "Date of birth cannot be empty.";
            } else if (raw_username == null || raw_username.trim().isEmpty() || !USERNAME_REGEX.matcher(raw_username).matches()) {
                errorMessage = "Invalid username format.";
            } else {
                boolean isCitizenIDExists = db.doesRecordExist("citizen_identification_card", raw_cic);
                boolean isUsernameExists = db.doesRecordExist("username", raw_username);
                boolean isEmailExists = db.doesRecordExist("email", raw_email);
                boolean isPhoneExists = db.doesRecordExist("phonenumber", raw_phonenumber);

                // Check for existing credentials
                if (isPhoneExists) {
                    errorMessage = "Phone number already exists.";
                } else if (isEmailExists) {
                    errorMessage = "Email already exists.";
                } else if (isCitizenIDExists) {
                    errorMessage = "Citizen ID already exists.";
                } else if (isUsernameExists) {
                    errorMessage = "Username already exists.";
                }
            }

            // Load departments and roles to avoid losing data if errors occur
            DepartmentDAO dbDept = new DepartmentDAO();
            ArrayList<Department> depts = dbDept.list();
            request.setAttribute("depts", depts);

            RoleDAO roleDAO = new RoleDAO();
            ArrayList<Role> roles = roleDAO.list();
            request.setAttribute("roles", roles);

            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
                // Keep previously entered information
                request.setAttribute("nameS", raw_sname);
                request.setAttribute("dobS", raw_dob);
                request.setAttribute("genderS", raw_gender);
                request.setAttribute("addressS", raw_address);
                request.setAttribute("emailS", raw_email);
                request.setAttribute("phoneS", raw_phonenumber);
                request.setAttribute("cicS", raw_cic);
                request.setAttribute("usernameS", raw_username);
                request.setAttribute("did", raw_did);
                request.setAttribute("selectedRoles", raw_roleIds);
                request.getRequestDispatcher("staff/addStaff.jsp").forward(request, response);
                return;
            }

            // Generate a random password
            String generatedPassword = db.generateRandomPassword();

            // Create new Staff object
            Staff s = new Staff();
            s.setFullname(raw_sname);
            s.setDob(Date.valueOf(raw_dob));
            s.setGender("1".equals(raw_gender));
            s.setAddress(raw_address);
            s.setEmail(raw_email);
            s.setPhonenumber(raw_phonenumber);
            s.setCitizenId(raw_cic);
            s.setUsername(raw_username);
            s.setPassword(toSHA1(generatedPassword)); // Hash the generated password
            s.setActive(true);

            Department d = new Department();
            d.setId(Integer.parseInt(raw_did));
            s.setDept(d);

            // Assign roles to the staff
            ArrayList<Role> roleList = new ArrayList<>();
            if (raw_roleIds != null) {
                for (String roleId : raw_roleIds) {
                    Role role = new Role();
                    role.setId(Integer.parseInt(roleId));
                    roleList.add(role);
                }
            }
            s.setRoles(roleList);
            // Insert staff into the database
            db.insert(s);
            // Send the generated password via email
            db.sendEmail(raw_email, generatedPassword, raw_username);

            request.setAttribute("successMessage", "Staff added successfully! Password sent via email.");
            // Keep the entered information of the newly added staff
            request.setAttribute("nameS", raw_sname);
            request.setAttribute("dobS", raw_dob);
            request.setAttribute("genderS", raw_gender);
            request.setAttribute("addressS", raw_address);
            request.setAttribute("emailS", raw_email);
            request.setAttribute("phoneS", raw_phonenumber);
            request.setAttribute("cicS", raw_cic);
            request.setAttribute("usernameS", raw_username);
            request.setAttribute("did", raw_did);
            request.setAttribute("selectedRoles", raw_roleIds);

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error adding staff: " + e.getMessage());
        }
        request.getRequestDispatcher("staff/addStaff.jsp").forward(request, response);
    }
}
