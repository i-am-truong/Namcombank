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

/**
 *
 * @author Asus
 */
public class StaffAddController extends BaseRBACControlller {

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account)
            throws ServletException, IOException {
        // Lấy danh sách phòng ban để hiển thị trong form
        DepartmentDAO dbDept = new DepartmentDAO();
        ArrayList<Department> depts = dbDept.list();
        request.setAttribute("depts", depts);

        // Lấy danh sách nhân viên (nếu cần hiển thị trong trang)
        StaffDAO dbEmp = new StaffDAO();
        ArrayList<Staff> staffList = dbEmp.list();
        request.setAttribute("staff", staffList);

        // Chuyển hướng đến trang thêm nhân viên
        request.getRequestDispatcher("staff/addStaff.jsp").forward(request, response);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Staff account)
            throws ServletException, IOException {
        // Lấy dữ liệu từ form gửi lên
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

        if (raw_dob == null || raw_dob.isEmpty()) {
            request.setAttribute("errorMessage", "Date of Birth is required!");
            request.getRequestDispatcher("staff/addStaff.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng Staff mới và gán dữ liệu
        Staff s = new Staff();
        s.setFullname(raw_sname);
        s.setDob(Date.valueOf(raw_dob));  // Chuyển đổi String thành Date
        s.setGender(raw_gender.equals("1")); // 1 = Nam, 0 = Nữ
        s.setAddress(raw_address);
        s.setEmail(raw_email);
        s.setPhonenumber(raw_phonenumber);
        s.setCitizenId(raw_cic);
        s.setUsername(raw_username);
        s.setPassword(toSHA1(raw_password)); // Hash mật khẩu

        // Parse department ID
        Department d = new Department();
        d.setId(Integer.parseInt(raw_did));
        s.setDept(d);

        // Lưu dữ liệu
        StaffDAO db = new StaffDAO();
        db.insert(s);

        // Phản hồi tới người dùng
        request.setAttribute("successMessage", "Staff added successfully!");
        request.getRequestDispatcher("staff/addStaff.jsp").forward(request, response);
    }
}
