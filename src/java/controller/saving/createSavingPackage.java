/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.saving;

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
import model.auth.Staff;

/**
 *
 * @author admin
 */
public class createSavingPackage extends BaseRBACControlller {

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
            out.println("<title>Servlet createSavingPackage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet createSavingPackage at " + request.getContextPath() + "</h1>");
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

        //private int staff_id;private String saving_package_created_at;private String saving_package_updated_at;
//         private String saving_package_name;
//                        private String saving_package_description;
//                        private double saving_package_interest_rate;
//                        private int saving_package_term_months;
//                        private Double saving_package_min_deposit;
//                        private Double saving_package_max_deposit;
//                        private String saving_package_status;
        try {
            // Lấy tham số từ request
            String saving_package_name = request.getParameter("saving_package_name");
            String saving_package_description = request.getParameter("saving_package_description");
            String interestRateStr = request.getParameter("saving_package_interest_rate");
            String termMonthsStr = request.getParameter("saving_package_term_months");
            String minDepositStr = request.getParameter("saving_package_min_deposit");
            String maxDepositStr = request.getParameter("saving_package_max_deposit");
            String saving_package_status = request.getParameter("saving_package_status");
            String saving_package_approval_status = request.getParameter("saving_package_approval_status");
            String withdrawableStr = request.getParameter("saving_package_withdrawable");
            String saving_package_under_haftStr = request.getParameter("saving_package_under_haft");
            String saving_package_over_haftStr = request.getParameter("saving_package_over_haft");
            // Chuyển đổi kiểu dữ liệu với xử lý lỗi
            double saving_package_interest_rate;
            int saving_package_term_months;
            double saving_package_min_deposit;
            double saving_package_max_deposit;
            int saving_package_withdrawable;
            double saving_package_under_haft;
            double saving_package_over_haft;

            saving_package_interest_rate = Double.parseDouble(interestRateStr);
            saving_package_term_months = Integer.parseInt(termMonthsStr);
            saving_package_min_deposit = Double.parseDouble(minDepositStr);
            saving_package_max_deposit = Double.parseDouble(maxDepositStr);
            saving_package_withdrawable = Integer.parseInt(withdrawableStr);
            saving_package_under_haft = Double.parseDouble(saving_package_under_haftStr);
            saving_package_over_haft = Double.parseDouble(saving_package_over_haftStr);

            Staff staff = (Staff) request.getSession().getAttribute("account");
            if (staff == null) {
                response.sendRedirect("admin.login");
                return;
            }
            int staff_id = staff.getId();

            String saving_package_created_at = getCurrentDate();
            String saving_package_updated_at = getCurrentDate();

            // Insert vào database
            SavingDao dao = new SavingDao();
            dao.insertSavingPackage(staff_id, saving_package_name, saving_package_description,
                    saving_package_created_at, saving_package_updated_at, saving_package_interest_rate,
                    saving_package_term_months, saving_package_min_deposit, saving_package_max_deposit,
                    saving_package_status, saving_package_withdrawable, saving_package_approval_status, saving_package_under_haft,
                    saving_package_over_haft);

            // Chuyển hướng sau khi thêm thành công
            response.sendRedirect("managerSaving");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại.");
            request.getRequestDispatcher("Saving/listSavingPackages.jsp").forward(request, response);

        }
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleId") == null || (int) session.getAttribute("roleId") != 1) {
            response.sendRedirect("admin.login");
            return;
        }
        request.getRequestDispatcher("SavingPackage/createSavingPackage.jsp").forward(request, response);
    }

    private String getCurrentDate() {
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return currentDate.format(formatter);
    }
}
