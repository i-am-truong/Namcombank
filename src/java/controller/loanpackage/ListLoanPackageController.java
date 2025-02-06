/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.loanpackage;

import context.LoanPackageDAO;
import controller.auth.BaseRBACControlller;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.LoanPackage;
import model.auth.Staff;

/**
 *
 * @author lenovo
 */
public class ListLoanPackageController extends BaseRBACControlller {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListLoanPackageController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListLoanPackageController at " + request.getContextPath () + "</h1>");
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
        processRequest(request, response);
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
                // Fetch the list of loan packages from the DAO
        LoanPackageDAO loanPackageDAO = new LoanPackageDAO();
        List<LoanPackage> loanPackages = loanPackageDAO.getAllLoanPackages();

        // Attach the list to the request object
        request.setAttribute("loanPackages", loanPackages);

        // Forward the request to the JSP page
        request.getRequestDispatcher("loanpackage-list.jsp").forward(request, response);
    }

}
