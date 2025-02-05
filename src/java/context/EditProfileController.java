/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import com.google.gson.Gson;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;
import model.Customer;
/**
 *
 * @author duong
 */
public class EditProfileController extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra người dùng đã được xác thực
        HttpSession session = request.getSession();
        CustomerDAO currentUser = (CustomerDAO) session.getAttribute("customers");
        String currentUsername = currentUser != null ? currentUser.getUserName() : null;
        String currentEmail = currentUser != null ? currentUser.getEmail() : null;

        if (currentUsername == null || currentEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy lại giới tính và ngày sinh mới từ form
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("dob");

        // Chuyển đổi dobStr thành đối tượng Date nếu không null và không rỗng
        Date dob = null;
        if (dobStr != null && !dobStr.isEmpty()) {
            try {
                dob = Date.valueOf(dobStr);
                if (dob.after(new java.util.Date())) {
                    sendErrorMessage(response, "Bạn chưa được sinh ra");
                    return;
                }
            } catch (IllegalArgumentException e) {
                sendErrorMessage(response, "Lỗi format ngày");
                return;
            }
        }

        if (!isValidGender(gender)) {
            // Đặt thông báo lỗi và chuyển hướng trở lại trang hồ sơ

            request.setAttribute("errorMessage", "Please đừng F12");
            request.getRequestDispatcher("view/user/dashboardUser.jsp").forward(request, response);
            return; 
        }

        // Cập nhật cơ sở dữ liệu với giới tính mới and/or ngày sinh
        CustomerDAO userDAO = new CustomerDAO();
        boolean isUpdated = userDAO.updateUserProfile(currentUsername, gender, dob);
        if (isUpdated) {
            // Cập nhật phiên với thông tin người dùng mới
            Customer updatedCustomer = CustomerDAO.getCustomerByEmail(currentEmail);
            session.setAttribute("users", updatedCustomer);
            
            // Send success
            Map<String, String> responseData = new HashMap<>();
            responseData.put("errorMessage", "Cập nhật thông tin thành công");
            sendResponse(response, responseData);
            session.setAttribute("gender", gender);
            session.setAttribute("dob", dob);
        } else {
            // Update failed
            sendErrorMessage(response, "Cập nhật thông tin thất bại");
        }
    }

    private void sendErrorMessage(HttpServletResponse response, String errorMessage) throws IOException {
        Map<String, String> responseData = new HashMap<>();
        responseData.put("errorMessage", errorMessage);
        sendResponse(response, responseData);
    }

    private void sendResponse(HttpServletResponse response, Map<String, String> responseData) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(responseData));
    }

    private boolean isValidGender(String gender) {
        return "Nam".equals(gender) || "Nữ".equals(gender) || "Không nói".equals(gender);
    }
}
