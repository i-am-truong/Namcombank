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
        HttpSession session = request.getSession();
        Part filePart = request.getPart("file");
        List<Customer> readCustomers = new ArrayList<>();

        if (filePart != null) {
            String fileName = filePart.getSubmittedFileName();
            if (!fileName.endsWith(".xlsx")) {
                session.setAttribute("alertImportFail", "Please upload an Excel file (.xlsx)");
                response.sendRedirect("manageCustomerVer2");
                return;
            }

            File file = new File(getServletContext().getRealPath("/") + fileName);
            filePart.write(file.getAbsolutePath());

            try (FileInputStream fis = new FileInputStream(file);
                 Workbook workbook = new XSSFWorkbook(fis)) {
                Sheet sheet = workbook.getSheetAt(0);

                // Skip header row
                for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                    Row row = sheet.getRow(i);
                    if (row == null) continue;

                    try {
                        Customer customer = new Customer();
                        customer.setFullname(row.getCell(0) != null ? row.getCell(0).getStringCellValue().trim() : "");
                        customer.setEmail(row.getCell(1) != null ? row.getCell(1).getStringCellValue().trim() : "");
                        customer.setGender(row.getCell(2) != null ? (int)row.getCell(2).getNumericCellValue() : 1);
                        customer.setPhonenumber(row.getCell(3) != null ? row.getCell(3).getStringCellValue().trim() : "");
                        customer.setCid(row.getCell(4) != null ? row.getCell(4).getStringCellValue().trim() : "");
                        customer.setAddress(row.getCell(5) != null ? row.getCell(5).getStringCellValue().trim() : "");


                        if (!customer.getFullname().isEmpty() && !customer.getEmail().isEmpty()
                            && !customer.getPhonenumber().isEmpty() && !customer.getAddress().isEmpty()
                            && cdao.checkCustomer(customer.getCid(), customer.getPhonenumber(), customer.getEmail())) {
                            readCustomers.add(customer);
                        }

                    } catch (Exception e) {
                        System.out.println("Error reading row " + i + ": " + e.getMessage());
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("alertImportFail", "Error reading Excel file: " + e.getMessage());
                response.sendRedirect("manageCustomerVer2");
                return;
            } finally {
                if (file.exists()) {
                    file.delete();
                }
            }
        }

        if (readCustomers.isEmpty()) {
            session.setAttribute("alertImportFail", "No valid data found in the Excel file or all records are duplicates");
            session.removeAttribute("alertImportSuccess"); // Thêm dòng này
            session.removeAttribute("errorCustomers"); // Thêm dòng này
            response.sendRedirect("manageCustomerVer2");
            return;
        }

        int countAdded = 0;
        List<Customer> notAdded = new ArrayList<>();

        for (Customer readCustomer : readCustomers) {
            if (cdao.addImport(readCustomer)) {
                countAdded++;
            } else {
                notAdded.add(readCustomer);
            }
        }

        if (countAdded > 0) {
            session.setAttribute("alertImportSuccess", countAdded + " customers imported successfully");
            session.setAttribute("errorCustomers", new ArrayList<>());
            session.removeAttribute("alertImportFail"); // Thêm dòng này
        }
        if (!notAdded.isEmpty()) {
            session.setAttribute("errorCustomers", notAdded);
            session.setAttribute("alertImportFail", notAdded.size() +
                " customers could not be imported due to duplicate information (phone, email, or CID)");
            session.removeAttribute("alertImportSuccess"); // Thêm dòng này
        }

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
