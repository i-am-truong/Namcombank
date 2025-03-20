package controller.Staff;

import context.DepartmentDAO;
import context.RoleDAO;
import context.StaffDAO;
import controller.auth.BaseRBACControlller;
import jakarta.servlet.ServletException;
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

public class staffProfile extends BaseRBACControlller {

    private static final Logger logger = Logger.getLogger(staffProfile.class.getName());

    private static final Pattern CIC_REGEX = Pattern.compile("^[0-9]{12}$"); // Chỉ chấp nhận 12 chữ số cho số căn cước công dân.
    private static final Pattern PHONE_REGEX = Pattern.compile("^0[0-9]{9,10}$"); // Bắt đầu bằng số 0, tiếp theo là 9 hoặc 10 chữ số 
    private static final Pattern EMAIL_REGEX = Pattern.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"); // Định dạng email hợp lệ, ví dụ xxx@yyy.zzz
    private static final Pattern ADDRESS_REGEX = Pattern.compile("^[\\p{L}0-9\\s,.\\-'/()]{3,}$"); // Chấp nhận ký tự chữ, số, dấu câu, khoảng trắng
    private static final Pattern FULLNAME_REGEX = Pattern.compile("^\\p{L}+(?:\\s\\p{L}+)+$"); // Chỉ chấp nhận chữ cái và khoảng trắng giữa các từ

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
        if (!CIC_REGEX.matcher(cic).matches()) {
            return "CIC must be exactly 12 digits.";
        }

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

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        try {
            int staffId = account.getId();

            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneS");
            String email = request.getParameter("emailS");
            String address = request.getParameter("addressS");
            String cic = request.getParameter("cicS");
            String dob = request.getParameter("dobS");
            String gender = request.getParameter("genderS");

            String errorMessage = validateInput(fullName, phoneNumber, email, address, cic, dob);
            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
                doAuthorizedGet(request, response, account);
                return;
            }

            StaffDAO staffDAO = new StaffDAO();
            Staff updatedStaff = staffDAO.getById(staffId);

            if (updatedStaff == null) {
                request.setAttribute("errorMessage", "Không tìm thấy thông tin nhân viên.");
                doAuthorizedGet(request, response, account);
                return;
            }

            updatedStaff.setFullname(fullName);
            updatedStaff.setPhonenumber(phoneNumber);
            updatedStaff.setEmail(email);
            updatedStaff.setAddress(address);
            updatedStaff.setCitizenId(cic);
            updatedStaff.setDob(Date.valueOf(dob));
            updatedStaff.setGender("1".equals(gender));

            boolean isUpdated = staffDAO.updateStaff(updatedStaff);
            if (isUpdated) {
                request.getSession().setAttribute("staff", updatedStaff);
                request.setAttribute("successMessage", "Update profile successfully!");
                logger.info("Employee ID Profile " + staffId + " has been updated successfully.");
            } else {
                request.setAttribute("errorMessage", "Unable to update information. Please try again later.");
            }

            doAuthorizedGet(request, response, account);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error while updating employee profile", e);
            request.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            doAuthorizedGet(request, response, account);
        }
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        try {
            // Lấy thông tin nhân viên từ session
            int staffId = account.getId();

            // Lấy thông tin chi tiết của nhân viên từ DB
            StaffDAO dao = new StaffDAO();
            Staff staffData = dao.getById(staffId);

            if (staffData != null) {
                // Log thông tin nhân viên để debug
                logger.info("Retrieved staff data: ID=" + staffData.getId()
                        + ", Name=" + staffData.getFullname()
                        + ", Phone=" + (staffData.getPhonenumber() != null ? staffData.getPhonenumber() : "N/A")
                        + ", Email=" + (staffData.getEmail() != null ? staffData.getEmail() : "N/A"));

                // Kiểm tra và log thông tin phòng ban
                if (staffData.getDept() != null) {
                    logger.info("Staff department: ID=" + staffData.getDept().getId()
                            + ", Name=" + staffData.getDept().getName());
                } else {
                    logger.warning("No department found for staff ID: " + staffId);
                    // Không cần khởi tạo Department vì JSP đã có kiểm tra null
                }

                // Kiểm tra và log thông tin vai trò
                if (staffData.getRoles() != null && !staffData.getRoles().isEmpty()) {
                    logger.info("Staff has " + staffData.getRoles().size() + " roles");
                } else {
                    logger.warning("No roles found for staff ID: " + staffId);
                    // Khởi tạo danh sách vai trò trống nếu null
                    staffData.setRoles(new ArrayList<>());
                }

                // Cập nhật cả request và session
                request.setAttribute("staff", staffData);
                request.getSession().setAttribute("staff", staffData);

                // Lấy danh sách phòng ban và vai trò
                DepartmentDAO dbDept = new DepartmentDAO();
                RoleDAO roleDAO = new RoleDAO();

                request.setAttribute("depts", dbDept.list());
                request.setAttribute("allRoles", roleDAO.getAllRoles());

                logger.info("Loading profile page for staff ID: " + staffId);
                request.getRequestDispatcher("/staff/profileStaff.jsp").forward(request, response);
            } else {
                logger.warning("Could not retrieve staff data for ID: " + staffId);
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error loading staff profile: " + e.getMessage(), e);
            response.sendRedirect("error.jsp");
        }
    }

}
