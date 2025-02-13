/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Login;

import context.CustomerDAO;
import java.io.IOException;
import java.time.Instant;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import model.Customer;

/**
 *
 * @author lenovo
 */
public class login extends HttpServlet {

    private static final int MAX_ATTEMPTS = 3; // Số lần nhập sai tối đa
    private static final int LOCK_TIME_SECONDS = 60; // Thời gian khóa tài khoản (1 phút)

    // Lưu danh sách tài khoản bị khóa tạm thời (có thể thay thế bằng database)
    private static final Map<String, Instant> lockedAccounts = new HashMap<>();

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
        String param_user = request.getParameter("username");
        String param_pass = request.getParameter("password");
        String remember = request.getParameter("rem");
        CustomerDAO cdao = new CustomerDAO();
        String pass = cdao.toSHA1(param_pass);
        HttpSession session = request.getSession();

        // Kiểm tra nếu tài khoản đang bị khóa
        if (lockedAccounts.containsKey(param_user)) {
            Instant lockTime = lockedAccounts.get(param_user);
            Instant now = Instant.now();
            if (now.isBefore(lockTime.plusSeconds(LOCK_TIME_SECONDS))) {
                request.setAttribute("err", "Your account is locked. Please try again later.");
                request.getRequestDispatcher("login/login.jsp").forward(request, response);
                return;
            } else {
                lockedAccounts.remove(param_user); // Hết thời gian khóa thì mở lại
            }
        }

        Customer customer = cdao.checkUser(param_user, pass);
        if (customer == null) {
            // Tăng số lần nhập sai
            Integer attempts = (Integer) session.getAttribute("loginAttempts");
            attempts = (attempts == null) ? 1 : attempts + 1;
            session.setAttribute("loginAttempts", attempts);

            if (attempts >= MAX_ATTEMPTS) {
                lockedAccounts.put(param_user, Instant.now());
                request.setAttribute("err", "Too many failed attempts. Your account is locked for 1 minute.");
            } else {
                request.setAttribute("err", "Invalid username or password. Attempts left: " + (MAX_ATTEMPTS - attempts));
            }
            request.getRequestDispatcher("login/login.jsp").forward(request, response);
            return;
        }

        // Nếu đăng nhập thành công, reset số lần nhập sai
        session.removeAttribute("loginAttempts");

        if (customer.getActive() == 0) {
            request.setAttribute("err", "Your account has been blocked!");
            request.getRequestDispatcher("login/login.jsp").forward(request, response);
            return;
        }

        double balance = cdao.getBalanceByCId(customer);
        session.setAttribute("balance", balance);
        session.setAttribute("customer", customer);
        session.setAttribute("customer_id", cdao.getCustomerId(param_user, pass));

        Cookie username = new Cookie("username", param_user);
        Cookie password = new Cookie("password", param_pass);
        Cookie remem = new Cookie("rem", remember);
        int cookieAge = (remember != null) ? (24 * 60 * 60 * 7) : 0;
        username.setMaxAge(cookieAge);
        password.setMaxAge(cookieAge);
        remem.setMaxAge(cookieAge);

        response.addCookie(username);
        response.addCookie(password);
        response.addCookie(remem);

        response.sendRedirect("Home");
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
