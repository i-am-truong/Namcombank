/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import model.Customer;
import context.CustomerDAO;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author TQT
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 100 // 100MB
)
public class ImportCustomers extends HttpServlet {

    private final CustomerDAO cdao = new CustomerDAO();

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
        response.setHeader("Content-Disposition", "attachment; filename=customerscan'tadd.xlsx");

        Part filePart = request.getPart("file");
        List<Customer> readCustomers = new ArrayList<>();
        if (filePart != null) {
            String fileName = filePart.getSubmittedFileName();
            File file = new File(getServletContext().getRealPath("/") + fileName);
            filePart.write(file.getAbsolutePath());

            try (FileInputStream fis = new FileInputStream(file); Workbook workbook = new XSSFWorkbook(fis);) {
                Sheet sheet = workbook.getSheetAt(0);
                for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                    Row row = sheet.getRow(i);
                    Customer customer = new Customer();
                    customer.setFullname(row.getCell(1).getStringCellValue());
                    customer.setUsername(row.getCell(2).getStringCellValue());
                    customer.setEmail(row.getCell(3).getStringCellValue());
                    customer.setPhonenumber(row.getCell(4).getStringCellValue());
                    customer.setAddress(row.getCell(5).getStringCellValue());
                    customer.setCid(row.getCell(6).getStringCellValue());
                    readCustomers.add(customer);
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (file.exists()) {
                    file.delete();
                }
            }
        }
        int countAdded = 0;
        int countNotAdded = 0;
        List<Customer> notAdded = new ArrayList<>();
        for (Customer readCustomer : readCustomers) {
            System.out.println("test");
            if (cdao.addImport(readCustomer)) {
                countAdded++;
            } else {
                countNotAdded++;
                notAdded.add(readCustomer);
            }
        }
             HttpSession session = request.getSession();
            session.setAttribute("errorCustomers", notAdded);
        response.sendRedirect("manageCustomerVer2");
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
