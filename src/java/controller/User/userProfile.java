/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.User;

import context.CustomerDAO;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.PrintWriter;
import java.sql.Date;
import model.Customer;

/**
 *
 * @author lenovo
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)

public class userProfile extends HttpServlet {

    private static final String UPLOAD_DIR = "web/assets/img/profile/";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet userProfile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet userProfile at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null) {
            response.sendRedirect("login");
            return; // Ensure the method returns to avoid further execution
        } else {
            request.getRequestDispatcher("user/profileUser.jsp").forward(request, response);
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            response.sendRedirect("login");
            return;
        }

        String errorPhoneNumber = "Please enter the first letter is 09 or 03!";
        String errorName = "Please enter only letters!";

        // Lấy thông tin từ form
        String fullNameStr = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dateOfBirth");

        // Kiểm tra hợp lệ tên
        if (!checkName(fullNameStr)) {
            request.setAttribute("errorName", "Invalid name!");
            request.getRequestDispatcher("user/profileUser.jsp").forward(request, response);
            return;
        }

        // Định dạng lại tên hợp lệ
        String fullName = formatName(fullNameStr);

        // Kiểm tra số điện thoại hợp lệ
        if (!formatPhoneNumber(phoneNumber)) {
            request.setAttribute("errorPhoneNumber", errorPhoneNumber);
            request.getRequestDispatcher("user/profileUser.jsp").forward(request, response);
            return;
        }

        // Kiểm tra số điện thoại đã tồn tại chưa
        CustomerDAO cdao = new CustomerDAO();
        if (cdao.isPhoneNumberExist(phoneNumber, customer.getCustomerId())) {
            request.setAttribute("existPhoneNumber", "This phone number is already in use!");
            request.getRequestDispatcher("user/profileUser.jsp").forward(request, response);
            return;
        }

        // Xử lý file upload avatar
        Part filePart = request.getPart("avatar");
        String avatarFileName = customer.getAvatar(); // Giữ nguyên nếu không có ảnh mới

        if (filePart != null && filePart.getSize() > 0) {
            // Lấy đường dẫn thư mục lưu ảnh
            String uploadPath = getServletContext().getRealPath("/") + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // Tạo thư mục nếu chưa có
            }

            // Lấy tên file gốc
            avatarFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String avatarPath = uploadPath + File.separator + avatarFileName;

            // Lưu file ảnh vào thư mục
            filePart.write(avatarPath);

            // Cập nhật avatar với đường dẫn hợp lệ
            customer.setAvatar(UPLOAD_DIR + avatarFileName);
        }

        // Cập nhật thông tin khách hàng
        customer.setFullname(fullName);
        customer.setPhonenumber(phoneNumber);
        customer.setAddress(address);
        customer.setEmail(email);

        try {
            customer.setDob(Date.valueOf(dob));
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorDob", "Invalid date format!");
            request.getRequestDispatcher("user/profileUser.jsp").forward(request, response);
            return;
        }

        customer.setGender(gender.equals("male") ? 1 : 0);

        // Cập nhật vào database
        cdao.updateProfile(customer);

        // Cập nhật lại session
        session.setAttribute("customer", customer);

        // Chuyển hướng về trang profile
        request.getRequestDispatcher("user/profileUser.jsp").forward(request, response);
    }

    private String formatName(String name) {
        name = name.trim().replaceAll("\\s+", " ");
        String[] words = name.split(" ");
        StringBuilder formattedName = new StringBuilder();
        for (String word : words) {
            formattedName.append(Character.toUpperCase(word.charAt(0)))
                    .append(word.substring(1).toLowerCase())
                    .append(" ");
        }
        return formattedName.toString().trim();
    }

    private boolean formatPhoneNumber(String phone) {
        return phone != null && (phone.startsWith("09") || phone.startsWith("03"));
    }

    private boolean checkName(String name) {
        return name != null && name.matches("^[\\p{L}\\s]+$");
    }
}
