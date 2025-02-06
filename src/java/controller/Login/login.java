/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Login;

import context.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;

/**
 *
 * @author lenovo
 */
public class login extends HttpServlet {

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
            out.println("<title>Servlet login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet login at " + request.getContextPath() + "</h1>");
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
        // lấy danh sách cookie từ trình duyệt
        Cookie arr[] = request.getCookies();
        // ktra nếu có username, password thì lưu vào request
        if (arr != null) {
            for (Cookie o : arr) {
                if (o.getName().equals("username")) {
                    request.setAttribute("username", o.getValue());
                }
                if (o.getName().equals("password")) {
                    request.setAttribute("password", o.getValue());
                }
            }
            request.getRequestDispatcher("login/login.jsp").forward(request, response);
        } else {
            response.sendRedirect("Home");
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
        String param_user = request.getParameter("username");//lấy username và password từ form
        String param_pass = request.getParameter("password");
        String remember = request.getParameter("rem");       // ktra checkbox remember me
        CustomerDAO cdao = new CustomerDAO();
        String pass = cdao.toSHA1(param_pass); // mã hóa mk bằng SHA-1
        HttpSession session = request.getSession();
        Customer customer = cdao.checkUser(param_user, pass); // check ttin người dùng
        if (customer == null) {
            request.setAttribute("err", "Invalid username or password!");
            request.getRequestDispatcher("login/login.jsp").forward(request, response);
            return;
        } else if (customer.getActive() == 0) {
            request.setAttribute("err", "Your account has been blocked!");
            request.getRequestDispatcher("login/login.jsp").forward(request, response);
            return;
        } else {
            double balance = cdao.getBalanceByCId(customer);
            session.setAttribute("balance", balance);
            session.setAttribute("customer", customer);
            session.setAttribute("customer_id", cdao.getCustomerId(param_user, pass));

            Cookie username = new Cookie("username", param_user);
            Cookie password = new Cookie("password", param_pass);
            Cookie remem = new Cookie("rem", remember);
            int cookieAge = (remember != null) ? (24 * 60 * 60 * 60) : 0;
            username.setMaxAge(cookieAge);
            password.setMaxAge(cookieAge);
            remem.setMaxAge(cookieAge);

            response.addCookie(username);
            response.addCookie(password);
            response.addCookie(remem);

            response.sendRedirect("Home");
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
