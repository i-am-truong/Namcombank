/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale.Category;

import context.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;

/**
 *
 * @author TQT
 */
public class editCustomer extends HttpServlet {

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
            out.println("<title>Servlet editCustomer</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet editCustomer at " + request.getContextPath() + "</h1>");
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
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        CustomerDAO cdao = new CustomerDAO();
        Customer customer = cdao.getCustomerById(customerId);
        request.setAttribute("customer", customer);
        // try {
        //     int productId = Integer.parseInt(request.getParameter("productId"));
        //     String name = request.getParameter("name");
        //     int quantity = Integer.parseInt(request.getParameter("quantity"));
        //     double price = Double.parseDouble(request.getParameter("price"));
        //     String describe = request.getParameter("describe");
        //     String img = request.getParameter("img");
        //     Date releaseDate = Date.valueOf(request.getParameter("releaseDate"));
        //     int categoryId = Integer.parseInt(request.getParameter("category"));
        //     int brandId = Integer.parseInt(request.getParameter("brand"));
        //     int genderId = Integer.parseInt(request.getParameter("gender"));

        //     String[] sizeIds = request.getParameterValues("size");
        //     List<Size> sizes = new ArrayList<>();
        //     if (sizeIds != null) {
        //         for (String sizeId : sizeIds) {
        //             Size size = productDAO.getSizeById(Integer.parseInt(sizeId));
        //             sizes.add(size);
        //         }
        //     }
        //     Category category = productDAO.getCategoryById(categoryId);
        //     Brand brand = productDAO.getBrandById(brandId);
        //     Gender gender = productDAO.getGenderById(genderId);
        //     Product product = new Product(productId, name, quantity, price, describe, img, releaseDate, category, brand, gender, sizes);
        //     productDAO.updateProduct(product);
        //     response.sendRedirect("listproduct");
        // } catch (Exception e) {
        //     throw new ServletException("Error updating product", e);
        // }
        request.getRequestDispatcher("customer/editCustomer.jsp").forward(request, response);

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
        //    lấy dữ liệu từ form đăng ký
        // String fullname = request.getParameter("fullnameC");
        // String phonenumber = request.getParameter("phonenumberC");
        // String email = request.getParameter("emailC");
        // String address = request.getParameter("addressC");
        // String dob = request.getParameter("dobC");
        // String gender = request.getParameter("genderC");
        // String username = request.getParameter("usernameC");
        // String password = request.getParameter("passwordC");
        // String confirmPassword = request.getParameter("confirmPasswordC");
        // if (!password.equals(confirmPassword)) {
        //     request.setAttribute("suc", "Passwords do not match!");
        //     request.getRequestDispatcher("login/register.jsp").forward(request, response);
        //     return;
        // }
        // String cic = request.getParameter("cicC");
        // CustomerDAO cd = new CustomerDAO();
        // // check xem username or email or phonenumber đã tồn tại hay chưa
        // if (cd.checkUsername(username, email, phonenumber)) {
        //     password = cd.toSHA1(password);
        //     cd.registerAcc(fullname, username, password, email, dob, Integer.parseInt(gender), phonenumber, cic, address);
        //     request.setAttribute("suc", "Create account successfully!");
        //     request.getRequestDispatcher("login/register.jsp").forward(request, response);
        // } else {
        //     request.setAttribute("error", "Username or email or phonenumber already exist!");
        //     request.getRequestDispatcher("login/register.jsp").forward(request, response);
        // }
//        request.getRequestDispatcher("customer/editCustomer.jsp").forward(request, response);
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
