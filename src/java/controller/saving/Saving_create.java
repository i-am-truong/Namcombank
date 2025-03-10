/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.saving;

import context.SavingDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.Customer;
import model.SavingPackage_id;

/**
 *
 * @author admin
 */
public class Saving_create extends HttpServlet {

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
            out.println("<title>Servlet Saving_create</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Saving_create at " + request.getContextPath() + "</h1>");
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
        if (session.getAttribute("customer") == null) {
            response.sendRedirect("login");
            return;
        } else {

            Integer customer_id = Integer.parseInt(session.getAttribute("customer_id").toString());
            request.setAttribute("customer_is", customer_id);
            SavingDao dao = new SavingDao();

            String saving_package_withdrawableStr = request.getParameter("saving_package_withdrawable");
            if (saving_package_withdrawableStr == null || saving_package_withdrawableStr.isEmpty()) {
                request.getRequestDispatcher("saving/Saving_create.jsp").forward(request, response);
            }
            int saving_package_withdrawable = Integer.parseInt(saving_package_withdrawableStr);

            List<SavingPackage_id> list = dao.get_saving_package_withdrawable(saving_package_withdrawable);

            String currentDate = getCurrentDate();
            request.setAttribute("currentDate", currentDate);

            request.setAttribute("list", list);
            request.getRequestDispatcher("saving/Saving_create_type.jsp").forward(request, response);
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
        if (session.getAttribute("customer") == null) {
            response.sendRedirect("login");
            return;
        } else {

            Integer saving_package_id = Integer.parseInt(request.getParameter("saving_package_id"));
            double money = Double.parseDouble(request.getParameter("money"));
            String created_at = request.getParameter("created_at");
            SavingDao dao = new SavingDao();

            double rate = dao.selectRate(saving_package_id) / 100.0; // Chuyển lãi suất từ số bình thường sang phần trăm
            int term = dao.selectTerm(saving_package_id); // Lấy số tháng kỳ hạn của gói tiết kiệm
            String name = dao.selectName(saving_package_id);
            int saving_package_term_months = dao.selectSaving_package_term_months(saving_package_id);

            double amount = 0; // Giá trị mặc định
            if (saving_package_term_months > 0) {
                amount = money + money * rate * term / 12;
            }

            Integer customer_id = (Integer) session.getAttribute("customer_id");

            dao.insertSavingRequest(customer_id, saving_package_id, money, created_at, amount, name);

            request.setAttribute("message", "Yêu cầu của bạn đã được gửi. Vui lòng chờ xác nhận từ ngân hàng.");

            request.getRequestDispatcher("saving/Saving_create_type.jsp").forward(request, response);
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

    private String getCurrentDate() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        return formatter.format(new Date());
    }

}
