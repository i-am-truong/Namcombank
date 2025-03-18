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
import java.util.List;
import model.SavingPackage_id;
import model.SavingRequest_id;
import model.auth.Staff;

/**
 *
 * @author admin
 */
public class savingMoney extends BaseRBACControlller {

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
            out.println("<title>Servlet savingMoney</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet savingMoney at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleId") == null || (int) session.getAttribute("roleId") != 1) {
            response.sendRedirect("admin.login");
            return;
        }

        String saving_request_idStr = request.getParameter("saving_request_id");
        int saving_request_id = Integer.parseInt(saving_request_idStr);
        String money_approval_status = request.getParameter("money_approval_status");

        String saving_approval_date = getCurrentDate();
        Staff staff = (Staff) request.getSession().getAttribute("account");
        int staff_id = staff.getId();
        boolean isUpdated = dao.acceptMoney(money_approval_status, saving_approval_date, saving_request_id, staff_id);

        if (isUpdated) {
            int saving_package_id = dao.selectSaving_package_id(saving_request_id);
            int customer_id = dao.selectCustomer_id(saving_request_id);
            String customer_name = dao.selectCustomer_fullname(customer_id);
            double amount = dao.selectAmount(saving_request_id);
            double interest_rate = dao.selectRate(saving_package_id);
            int term_months = dao.selectTerm(saving_package_id);
            String opened_date = dao.select_openDate(saving_request_id);
            LocalDate openedLocalDate = LocalDate.parse(opened_date, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            LocalDate moneyGetLocalDate = openedLocalDate.plusMonths(term_months);
            String money_get_date = moneyGetLocalDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            int saving_package_withdrawable = dao.selectSaving_package_withdrawable(saving_package_id);
            dao.AddSavingFinal(customer_id, amount, interest_rate, term_months, opened_date, saving_request_id, staff_id, money_get_date, customer_name, saving_package_withdrawable);
        }
        List<SavingRequest_id> list = dao.getAllSavingRequestMoneyPending();
        request.setAttribute("list", list);
        request.getRequestDispatcher("SavingContract/SavingMoney.jsp").forward(request, response);

    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleId") == null || (int) session.getAttribute("roleId") != 1) {
            response.sendRedirect("admin.login");
            return;
        }
        SavingDao dao = new SavingDao();
        List<SavingRequest_id> list = dao.getAllSavingRequestMoneyPending();

        request.setAttribute("list", list);
        request.getRequestDispatcher("SavingContract/SavingMoney.jsp").forward(request, response);

    }

    private String getCurrentDate() {
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return currentDate.format(formatter);
    }
}
