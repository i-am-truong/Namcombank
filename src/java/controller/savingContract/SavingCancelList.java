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
import java.util.ArrayList;
import java.util.List;
import model.Saving;
import model.auth.Staff;

/**
 *
 * @author admin
 */
public class SavingCancelList extends BaseRBACControlller {

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
        int savings_id;
        if (savings_idStr != null && !savings_idStr.trim().isEmpty()) {
            try {
                savings_id = Integer.parseInt(savings_idStr);
                Staff staff = (Staff) session.getAttribute("account");
                if (staff != null) {
//                    int staff_id = staff.getId();
//                    dao.SavingCancel(savings_id,staff_id, 1);
                }
            } catch (NumberFormatException e) {

            }
        }

        String saving_withdrawableStr = request.getParameter("saving_withdrawable");
        int saving_withdrawable;
        saving_withdrawable = Integer.parseInt(saving_withdrawableStr);

        List<Saving> list = new ArrayList<>();

        int index = 1;
        try {
            index = Integer.parseInt(request.getParameter("index"));
        } catch (NumberFormatException e) {
            index = 1; // Mặc định trang đầu
        }

        String nameInput = request.getParameter("customer_name");
        String name = null;
        if (!checkInput(nameInput)) {
            request.setAttribute("Vui lòng không nhập kí tự đặc biệt", "error");
            list = dao.pagingSaving(index);
            request.setAttribute("listPaging", list);
            request.getRequestDispatcher("SavingContract/SavingCancelList.jsp").forward(request, response);
            return;
        } else if (nameInput != null) {
            name = formatName(nameInput);
        } else if (nameInput == null) {
            name = null;
        }

        int count = 0;
        if (name != null && saving_withdrawable == 1) {
            count = dao.getTotalSavingName1(name);
            list = dao.pagingSavingByName1(index, name);

        }
        if (name != null && saving_withdrawable == 0) {
            count = dao.getTotalSavingName0(name);
            list = dao.pagingSavingByName0(index, name);

        }
        if (name != null && saving_withdrawable == 5) {
            count = dao.getTotalSavingName(name);
            list = dao.pagingSavingByName(index, name);

        }
        if (name == null && saving_withdrawable == 1) {
            count = dao.getTotalSaving1();
            list = dao.pagingSaving1(index);
        }
        if (name == null && saving_withdrawable == 0) {
            count = dao.getTotalSaving0();
            list = dao.pagingSaving0(index);
        }
        if (name == null && saving_withdrawable == 5) {
            count = dao.getTotalSaving();
            list = dao.pagingSaving(index);
        }

        int endPage = (count % 8 == 0) ? count / 8 : (count / 8) + 1;
        request.setAttribute("endPage", endPage);
        request.setAttribute("name_selected", name);
        request.setAttribute("saving_withdrawable_selected", saving_withdrawable);
        request.setAttribute("listPaging", list);
        request.setAttribute("currentPage", index);
        request.getRequestDispatcher("SavingContract/SavingCancelList.jsp").forward(request, response);
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleId") == null || (int) session.getAttribute("roleId") != 1) {
            response.sendRedirect("admin.login");
            return;
        }

        List<Saving> list = new ArrayList<>();

        String indexStr = request.getParameter("index");

        int index = 1;
        if (indexStr != null && !indexStr.isEmpty()) {
            index = Integer.parseInt(indexStr);
        }
        String name = request.getParameter("customer_name");

        if (name != null && !name.isEmpty()) {
            name = request.getParameter("customer_name");
        } else {
            name = null;
        }
        int count;
        if (name != null) {
            count = dao.getTotalSavingName(name);
            list = dao.pagingSavingByName(index, name);
        } else {
            count = dao.getTotalSaving();
            list = dao.pagingSaving(index);
        }

        int endPage = (count % 8 == 0) ? count / 8 : (count / 8) + 1;
        request.setAttribute("endPage", endPage);
        request.setAttribute("name_selected", name);
        request.setAttribute("listPaging", list);
        request.setAttribute("currentPage", index);
        request.getRequestDispatcher("SavingContract/SavingCancelList.jsp").forward(request, response);
    }

    public boolean checkInput(String input) {
        return input.matches("^[\\p{L}\\s.,!?]*$");
    }

    private String formatInput(String input) {

        if (input == null || input.isEmpty()) {
            return null;
        }
        return Character.toUpperCase(input.charAt(0)) + input.substring(1);
    }

    private String formatName(String name) {
        if (name == null || name.isEmpty()) {
            return null;
        }
        return name.trim().replaceAll("\\s+", " ");
    }

}
