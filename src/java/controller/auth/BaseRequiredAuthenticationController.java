/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.auth.Staff;

/**
 *
 * @author Asus
 */
public abstract class BaseRequiredAuthenticationController extends HttpServlet {

    private boolean isAuthenticated(HttpServletRequest req) {
        Staff staff = (Staff) req.getSession().getAttribute("account");
        return (staff != null);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (isAuthenticated(req)) {
            Staff staff = (Staff) req.getSession().getAttribute("account");
            doPost(req, resp, staff);
        } else {
            resp.getWriter().println("access denied!");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (isAuthenticated(req)) {
            Staff user = (Staff) req.getSession().getAttribute("account");
            doGet(req, resp, user);
        } else {
            resp.getWriter().println("access denied!");
        }
    }

    protected abstract void doGet(HttpServletRequest req, HttpServletResponse resp, Staff account) throws ServletException, IOException;

    protected abstract void doPost(HttpServletRequest req, HttpServletResponse resp, Staff account) throws ServletException, IOException;
}
