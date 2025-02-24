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
import model.Department;
import model.auth.Staff;
import context.RoleDAO;
import model.auth.Role;

/**
 *
 * @author Asus
 */
public class StaffAddController extends BaseRBACControlller {

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account)
            throws ServletException, IOException {
        // Lấy danh sách phòng ban
        DepartmentDAO dbDept = new DepartmentDAO();
        ArrayList<Department> depts = dbDept.list();
        request.setAttribute("depts", depts);

        // Lấy danh sách nhân viên
        StaffDAO dbEmp = new StaffDAO();
        ArrayList<Staff> staffList = dbEmp.list();
        request.setAttribute("staff", staffList);

        // Lấy danh sách Roles
        RoleDAO roleDAO = new RoleDAO();
        ArrayList<Role> roles = roleDAO.list();
        request.setAttribute("roles", roles);

        // Chuyển hướng đến trang thêm nhân viên
        request.getRequestDispatcher("staff/addStaff.jsp").forward(request, response);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Staff account)
            throws ServletException, IOException {
        try {
            // Lấy danh sách dữ liệu từ form
            String raw_sname = request.getParameter("nameS");
            String raw_dob = request.getParameter("dobS");
            String raw_gender = request.getParameter("genderS");
            String raw_address = request.getParameter("addressS");
            String raw_email = request.getParameter("emailS");
            String raw_phonenumber = request.getParameter("phoneS");
            String raw_cic = request.getParameter("cicS");
            String raw_username = request.getParameter("usernameS");
            String raw_password = request.getParameter("passS");
            String raw_did = request.getParameter("did");
            String[] raw_roleIds = request.getParameterValues("roleId");

            // Kiểm tra dữ liệu bắt buộc
            if (raw_sname == null || raw_sname.trim().isEmpty() || raw_dob == null || raw_dob.isEmpty()
                    || raw_username == null || raw_username.trim().isEmpty() || raw_password == null || raw_password.isEmpty()) {
                request.setAttribute("errorMessage", "Please fill in all required fields!");

                // Load lại danh sách phòng ban và role
                DepartmentDAO dbDept = new DepartmentDAO();
                ArrayList<Department> depts = dbDept.list();
                request.setAttribute("depts", depts);

                RoleDAO dbRole = new RoleDAO();
                ArrayList<Role> roles = dbRole.list();
                request.setAttribute("roles", roles);

                request.getRequestDispatcher("staff/addStaff.jsp").forward(request, response);
                return;
            }

            // Tạo đối tượng Staff
            Staff s = new Staff();
            s.setFullname(raw_sname);
            s.setDob(Date.valueOf(raw_dob));
            s.setGender("1".equals(raw_gender));
            s.setAddress(raw_address);
            s.setEmail(raw_email);
            s.setPhonenumber(raw_phonenumber);
            s.setCitizenId(raw_cic);
            s.setUsername(raw_username);
            s.setPassword(toSHA1(raw_password));
            s.setActive(true);

            // Gán phòng ban
            Department d = new Department();
            d.setId(Integer.parseInt(raw_did));
            s.setDept(d);

            // Gán danh sách Roles
            ArrayList<Role> roles = new ArrayList<>();
            if (raw_roleIds != null) {
                for (String roleId : raw_roleIds) {
                    Role role = new Role();
                    role.setId(Integer.parseInt(roleId));
                    roles.add(role);
                }
            }
            s.setRoles(roles);

            // Thêm nhân viên vào database
            StaffDAO db = new StaffDAO();
            db.insert(s);
            ArrayList<Role> selectedRoles = new ArrayList<>();
            if (raw_roleIds != null) {
                for (String roleId : raw_roleIds) {
                    Role role = new Role();
                    role.setId(Integer.parseInt(roleId));
                    selectedRoles.add(role);
                }
            }
            request.setAttribute("selectedRoles", selectedRoles);

            // Load lại danh sách department và role để hiển thị
            DepartmentDAO dbDept = new DepartmentDAO();
            request.setAttribute("depts", dbDept.list());

            RoleDAO dbRole = new RoleDAO();
            request.setAttribute("roles", dbRole.list());

            request.setAttribute("successMessage", "Staff added successfully!");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error adding staff: " + e.getMessage());
        }
        request.getRequestDispatcher("staff/addStaff.jsp").forward(request, response);
    }

}
