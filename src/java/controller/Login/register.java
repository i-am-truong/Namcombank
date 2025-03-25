/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Login;

import context.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

/**
 *
 * @author lenovo
 */
public class register extends HttpServlet {

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
            out.println("<title>Servlet register</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet register at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("login/register.jsp").forward(request, response);
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
        // Lấy dữ liệu từ form đăng ký
        String fullname = request.getParameter("fullnameC");
        String phonenumber = request.getParameter("phonenumberC");
        String email = request.getParameter("emailC");
        String address = request.getParameter("addressC");
        String dob = request.getParameter("dobC"); // Format: yyyy-MM-dd
        String gender = request.getParameter("genderC");
        String username = request.getParameter("usernameC");
        String password = request.getParameter("passwordC");
        String confirmPassword = request.getParameter("confirmPasswordC");
        String cic = request.getParameter("cicC");

        // Kiểm tra mật khẩu trùng khớp
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("login/register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra tuổi có >= 18 không
        try {
            // Định dạng đúng với đầu vào từ người dùng (dd/MM/yyyy)
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            LocalDate birthDate = LocalDate.parse(dob, formatter); // Chuyển String thành LocalDate

            LocalDate today = LocalDate.now();
            Period age = Period.between(birthDate, today);

            if (age.getYears() < 18) {
                request.setAttribute("error", "You must be at least 18 years old to register!");
                request.getRequestDispatcher("login/register.jsp").forward(request, response);
                return;
            }

            // Nếu cần lưu vào database, chuyển sang yyyy-MM-dd
            String formattedDate = birthDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            // Lưu formattedDate vào database (ví dụ)
            // userDAO.saveUser(birthDate);
        } catch (DateTimeParseException e) {
            request.setAttribute("error", "Invalid date format! Please enter a valid date (dd/MM/yyyy).");
            request.getRequestDispatcher("login/register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra username/email/phone đã tồn tại chưa
        CustomerDAO cd = new CustomerDAO();
        if (cd.checkUsername(username, email, phonenumber)) {
            password = cd.toSHA1(password);
            cd.registerAcc(fullname, username, password, email, dob, Integer.parseInt(gender), phonenumber, cic, address);
            request.setAttribute("suc", "Create account successfully!");
            request.getRequestDispatcher("login/register.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Username or email or phonenumber already exists!");
            request.getRequestDispatcher("login/register.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
