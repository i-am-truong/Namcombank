/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.auth;

import context.StaffAccountDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import model.auth.Role;
import model.auth.Staff;

/**
 *
 * @author Asus
 */
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String param_user = req.getParameter("username"); // User input
        String param_pass = req.getParameter("password");
        StaffAccountDBContext sdao = new StaffAccountDBContext();
        String pass = sdao.toSHA1(param_pass);
        StaffAccountDBContext db = new StaffAccountDBContext();
        model.auth.Staff account = db.get(param_user, pass); // Lấy tài khoản từ database
        StaffAccountDBContext dbContext = new StaffAccountDBContext();
        // Gọi hàm getRoles và nhận kết quả
        ArrayList<Role> roles = dbContext.getRoles(param_user);
        if (account != null) {
            // Lưu tài khoản vào session
            req.getSession().setAttribute("account", account);
            boolean hasValidRole = false;
            Integer roleId = null;
            Staff staffRole = null;
            for (Role role : roles) {
                if ("Staff".equalsIgnoreCase(role.getName())) {
                    roleId = role.getId();
                    resp.sendRedirect("contractApproval");
                    hasValidRole = true;
                    break;
                } else if (role.getId() == 1) {
                    roleId = role.getId();
                    resp.sendRedirect("managerUser");
                    hasValidRole = true;
                    break;
                } else if (role.getId() == 5) {
                    roleId = role.getId();
                    resp.sendRedirect("managerContracts");
                    hasValidRole = true;
                    break;
                }
            }
            req.getSession().setAttribute("roleId", roleId);
            req.getSession().setAttribute("staffRole", staffRole);
            if (!hasValidRole) {
                resp.sendRedirect("403.html");
            }
        } else {
            req.setAttribute("err", "Invalid username or password!");
            req.getRequestDispatcher("admin.login/login.jsp").forward(req, resp);

        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("admin.login/login.jsp").forward(req, resp);
    }
}
