/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.loanpackage;

import context.LoanPackageDAO;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import model.LoanPackage;

/**
 *
 * @author lenovo
 */
public class CreateLoanPackageController extends HttpServlet {

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
            out.println("<title>Servlet CreateLoanPackageController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateLoanPackageController at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        try {
            String staffId = request.getParameter("staffId");
            String packageName = request.getParameter("packageName");
            String loanType = request.getParameter("loanType");
            String description = request.getParameter("description");
            String interestRateStr = request.getParameter("interestRate");
            String maxAmountStr = request.getParameter("maxAmount");
            String minAmountStr = request.getParameter("minAmount");
            String loanTermStr = request.getParameter("loanTerm");

            // Kiểm tra và parse an toàn
            double interestRate = (interestRateStr != null && !interestRateStr.isEmpty()) ? Double.parseDouble(interestRateStr) : 0;
            double maxAmount = (maxAmountStr != null && !maxAmountStr.isEmpty()) ? Double.parseDouble(maxAmountStr) : 0;
            double minAmount = (minAmountStr != null && !minAmountStr.isEmpty()) ? Double.parseDouble(minAmountStr) : 0;
            int loanTerm = (loanTermStr != null && !loanTermStr.isEmpty()) ? Integer.parseInt(loanTermStr) : 12; // Mặc định 12 tháng

            // Kiểm tra staffId có hợp lệ không
            int staffIdInt = (staffId != null && !staffId.isEmpty()) ? Integer.parseInt(staffId) : 1;

            Date createdDate = new Date();

            LoanPackage loanPackage = new LoanPackage(
                    0, staffIdInt, packageName, loanType, description,
                    interestRate, maxAmount, minAmount, loanTerm, new java.sql.Date(createdDate.getTime()));

            LoanPackageDAO dao = new LoanPackageDAO();
            dao.insertLoanPackage(loanPackage);

            response.sendRedirect("loanpackage-list.jsp");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input! Please enter valid numbers.");
            request.getRequestDispatcher("loanpackage-create.jsp").forward(request, response);
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
