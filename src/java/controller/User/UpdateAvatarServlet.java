/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.User;

import context.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import model.Customer;

/**
 *
 * @author lenovo
 */
@WebServlet(name = "UpdateAvatarServlet", urlPatterns = {"/updateAvatar"})

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class UpdateAvatarServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("avatar");
        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("errorMessage", "Vui lòng chọn ảnh!");
            request.getRequestDispatcher("user/profileUser.jsp").forward(request, response);
            return;
        }

        // Kiểm tra định dạng file
        String fileType = filePart.getContentType();
        if (!fileType.startsWith("image/")) {
            request.setAttribute("errorMessage", "Chỉ được phép tải lên hình ảnh!");
            request.getRequestDispatcher("user/profileUser.jsp").forward(request, response);
            return;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "avatars";

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // Tạo thư mục nếu chưa tồn tại
        }

        // Lưu file
        filePart.write(uploadPath + File.separator + fileName);

        // Cập nhật session
        request.getSession().setAttribute("customerAvatar", "uploads/avatars/" + fileName);

        response.sendRedirect("user/profileUser.jsp");
    }
}
