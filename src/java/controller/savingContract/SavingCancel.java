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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import model.Saving;
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

        String savings_idStr = request.getParameter("savings_id_cancel");
        int savings_id = -1;

        try {
            savings_id = Integer.parseInt(savings_idStr);
        } catch (NumberFormatException e) {
            request.getRequestDispatcher("SavingContract/SavingCancelList.jsp").forward(request, response);
            return;
        }

        int customer_id = dao.selectCustomer_id_by_savings_id(savings_id);

        int saving_request_id = dao.selectSavingRequest_Id_(savings_id);
        int saving_package_id = dao.selectSaving_package_id_by_SavingRequest(saving_request_id);
        int term_months = dao.selectSaving_term(savings_id);
        String opened_date = dao.selectSavingOpendate(savings_id);
        double money = dao.selectMoney(saving_request_id);

        double money_getted;

        double rate1 = dao.selectSavingPackageOver_haft(saving_package_id);
        double rate2 = dao.selectSavingPackageUnder_haft(saving_package_id);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate openedDateLocal = LocalDate.parse(opened_date, formatter);

        LocalDate todayLocalDate = LocalDate.now();
        long monthsElapsed = ChronoUnit.MONTHS.between(todayLocalDate, openedDateLocal);

        money_getted = money;
        double take = (monthsElapsed / (double) term_months);
        if (take > 0.5) {
            money_getted = money + money * rate1 / 100 * monthsElapsed / 24;
        } else {
            money_getted = money + money * rate2 / 100 * monthsElapsed / 24;
        }

        Staff staff = (Staff) request.getSession().getAttribute("account");
        if (staff == null) {
            response.sendRedirect("admin.login");
            return;
        }
        int staff_id = staff.getId();

        boolean i = dao.SavingCancel(savings_id, staff_id, money_getted);
        String payment_method = dao.selectPayment_method(savings_id);
        if (i) {
            if (payment_method.equals("TRANSFER")) {
                dao.balanceUp(money_getted, customer_id);
            }
        }

        int index = 1;
        List<Saving> list = new ArrayList<>();
        list = dao.pagingSaving(index);
        request.setAttribute("listPaging", list);
        request.getRequestDispatcher("SavingContract/SavingCancelList.jsp").forward(request, response);

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

    }

}
