/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import context.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import model.Customer;


/**
 *
 * @author TQT
 */
public class ExportCustomers extends HttpServlet {

    private static CustomerDAO cdao = new CustomerDAO();
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
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=Customers.xlsx");
        String type = request.getParameter("type");
        HttpSession session = request.getSession();
        try (Workbook workbook = new XSSFWorkbook(); OutputStream out = response.getOutputStream();) {

            Sheet sheet = workbook.createSheet("Components");
            Row header = sheet.createRow(0);
            String[] columns = {"ID", "Fullname", "Username", "Active", "Email", "DOB", "Gender", "Phonenumber", "Balance", "CID", "Address"};
            for (int i = 0; i < columns.length; i++) {
                header.createCell(i).setCellValue(columns[i]);
            }
            int rowNum = 1;
            List<Customer> customers = new ArrayList<>();
            if ("error".equalsIgnoreCase(type)) {
                customers = (List<Customer>) session.getAttribute("errorCustomers");
                if (customers == null || customers.isEmpty()) {
                    customers = cdao.getAllCustomers();
                }
                session.removeAttribute("errorComponents");
            } else {
                customers = cdao.getAllCustomers();
            }

            for (Customer customer : customers) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(customer.getCustomerId());
                row.createCell(1).setCellValue(customer.getFullname());
                row.createCell(2).setCellValue(customer.getUsername());
                row.createCell(3).setCellValue(customer.getActive() == 0 ? "Closed" : "Opening");
                row.createCell(4).setCellValue(customer.getEmail());
                row.createCell(5).setCellValue(customer.getDob().toString());
                row.createCell(6).setCellValue(customer.getGender() == 0 ? "Female" : "Male");
                row.createCell(7).setCellValue(customer.getPhonenumber());
                row.createCell(8).setCellValue(customer.getBalance());
                row.createCell(9).setCellValue(customer.getCid());
                row.createCell(10).setCellValue(customer.getAddress());
            }

            workbook.write(out);
        } catch (Exception e) {
            e.printStackTrace();
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
        processRequest(request, response);
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
