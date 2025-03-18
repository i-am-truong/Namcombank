/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.savingContract;

import context.SavingDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Saving;
import model.SavingRequest;

/**
 *
 * @author admin
 */
public class SavingCustomerActive extends HttpServlet {

    private final SavingDao dao = new SavingDao();

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
            out.println("<title>Servlet SavingCustomerActive</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SavingCustomerActive at " + request.getContextPath() + "</h1>");
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
        }
        Integer customer_id = Integer.parseInt(session.getAttribute("customer_id").toString());
        List<Saving> list = dao.getAllSavingWithdrawable(customer_id);
        List<Saving> listP = dao.getAllSavingNoWithdrawable(customer_id);
        request.setAttribute("listP", listP);
        request.setAttribute("list", list);

        request.getRequestDispatcher("Saving/SavingCustomerActive.jsp").forward(request, response);
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
        }
        String savings_idStr = request.getParameter("savings_id");
//        String saving_withdrawableStr = request.getParameter("saving_withdrawable");
//        int saving_withdrawable = Integer.parseInt(saving_withdrawableStr);
        int savings_id = Integer.parseInt(savings_idStr);
//        Integer customer_id = Integer.parseInt(session.getAttribute("customer_id").toString());
//        if (saving_withdrawable == 1) {
//            List<Saving> list = dao.getSaving(savings_id);
//            request.setAttribute("list", list);
//            request.getRequestDispatcher("SavingContract/Saving_Customer_Detail.jsp").forward(request, response);
//            return;
//        }
//
//        if (saving_withdrawable == 0) {
            List<Saving> list = dao.getSaving(savings_id);
            request.setAttribute("list", list);
            request.getRequestDispatcher("SavingContract/Saving_Customer_Detail.jsp").forward(request, response);
//            return;
//        }

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
