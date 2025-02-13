/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.User;

import context.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import model.Customer;

/**
 *
 * @author lenovo
 */
public class userProfile extends HttpServlet {

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
            return; // Ensure the method returns to avoid further execution
        } else {

            String errorPhoneNumber = "Please enter the first letter is 09 or 03!";

            // lấy dữ liệu từ form
            String fullName = formatName(request.getParameter("fullName"));
            String phoneNumber = request.getParameter("phoneNumber");
            if (!formatPhoneNumber(phoneNumber)) {
                request.setAttribute("errorPhoneNumber", errorPhoneNumber);
                request.getRequestDispatcher("user/profileUser.jsp").forward(request, response);
                return;
            }
            String email = request.getParameter("email");

            String address = request.getParameter("address");
            String gender = request.getParameter("gender");
            String dob = request.getParameter("dateOfBirth");

            CustomerDAO cdao = new CustomerDAO();
            // update ttin khách hàng
            customer.setFullname(fullName);
            customer.setPhonenumber(phoneNumber);
            customer.setAddress(address);
            customer.setEmail(email);
            customer.setDob(Date.valueOf(dob));
            if (gender.equals("male")) {
                customer.setGender(1);
            } else {
                customer.setGender(0);
            }
            cdao.updateProfile(customer);

            request.getRequestDispatcher("user/profileUser.jsp").forward(request, response);
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

    private String formatName(String name) {
        name = name.trim().replaceAll("\\s+", " ");// thay nhieu khoang trang bang 1
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
        return phone != null && phone.startsWith("09") || phone.startsWith("03");
    }

}
