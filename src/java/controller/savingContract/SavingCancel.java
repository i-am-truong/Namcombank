/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.savingContract;

import context.SavingDao;
import controller.auth.BaseRBACControlller;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.auth.Staff;

/**
 *
 * @author admin
 */
public class SavingCancel extends BaseRBACControlller {

    private SavingDao dao = new SavingDao();

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
            out.println("<title>Servlet SavingCancel</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SavingCancel at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleId") == null || (int) session.getAttribute("roleId") != 1) {
            response.sendRedirect("admin.login");
            return;
        }

        String savings_idStr = request.getParameter("savings_id");
        int savings_id = -1;
        try {
            savings_id = Integer.parseInt(savings_idStr);
        } catch (NumberFormatException e) {
            request.getRequestDispatcher("SavingCancelList").forward(request, response);
            return;
        }

        Staff staff = (Staff) request.getSession().getAttribute("account");
        if (staff == null) {
            response.sendRedirect("admin.login");
            return;
        }
        int staff_id = staff.getId();

        dao.SavingCancel(savings_id, staff_id);

        request.getRequestDispatcher("SavingCancelList").forward(request, response);

    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleId") == null || (int) session.getAttribute("roleId") != 1) {
            response.sendRedirect("admin.login");
            return;
        }

        String savings_idStr = request.getParameter("savings_id");
        int savings_id;
        try {
            savings_id = Integer.parseInt(savings_idStr);
        } catch (NumberFormatException e) {
            request.getRequestDispatcher("SavingCancelList").forward(request, response);
            return;
        }

        Staff staff = (Staff) request.getSession().getAttribute("account");
        if (staff == null) {
            response.sendRedirect("admin.login");
            return;
        }
        int staff_id = staff.getId();

        dao.SavingCancel(savings_id, staff_id);

        request.getRequestDispatcher("SavingCancelList").forward(request, response);
    }

}
