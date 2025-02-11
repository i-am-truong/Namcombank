package controller.Staff;

import static context.CustomerDAO.toSHA1;
import context.DepartmentDAO;
import context.StaffDAO;
import controller.auth.BaseRBACControlller;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import model.Department;
import model.auth.Staff;
import java.util.logging.Level;
import java.util.logging.Logger;
//@WebServlet(name = "StaffUpdateController", urlPatterns = {"/updateStaff"})
public class StaffUpdateController extends BaseRBACControlller {

    private static final Logger logger = Logger.getLogger(StaffUpdateController.class.getName());

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account)
            throws ServletException, IOException {
        try {
            String staffID = request.getParameter("id");
            if (staffID == null || staffID.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/updateStaff");

                return;
            }

            StaffDAO sdao = new StaffDAO();
            Staff staff = sdao.getById(Integer.parseInt(staffID));

            if (staff == null) {
                response.sendRedirect(request.getContextPath() + "/updateStaff");

                return;
            }
            DepartmentDAO dbDept = new DepartmentDAO();
            ArrayList<Department> depts = dbDept.list();
            request.setAttribute("depts", depts);
            
            request.setAttribute("staff", staff);
            request.getRequestDispatcher("staff/updateStaff.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/updateStaff");

            return;
        }
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Staff account)
            throws ServletException, IOException {
        try {
            // Retrieve and validate parameters
            int id = Integer.parseInt(request.getParameter("id"));
            String fullname = request.getParameter("nameS");
            Date dob = Date.valueOf(request.getParameter("dobS"));
            String raw_gender = request.getParameter("genderS");
            String address = request.getParameter("addressS");
            String email = request.getParameter("emailS");
            String phonenumber = request.getParameter("phoneS");
            String cic = request.getParameter("cicS");
            int did = Integer.parseInt(request.getParameter("did"));

            // Create updated Staff object
            Staff staff = new Staff();
            staff.setId(id);
            staff.setFullname(fullname);
            staff.setDob(dob);
            staff.setGender(Boolean.parseBoolean(raw_gender));
            staff.setAddress(address);
            staff.setEmail(email);
            staff.setPhonenumber(phonenumber);
            staff.setCitizenId(cic);

            // Set department
            Department dept = new Department();
            dept.setId(did);
            staff.setDept(dept);

            // Update staff information
            StaffDAO sdao = new StaffDAO();
            boolean isUpdated = sdao.updateStaff(staff);

            if (isUpdated) {
                request.setAttribute("successMessage", "Staff updated successfully!");
                response.sendRedirect("staffFilter");
            } else {
                request.setAttribute("errorMessage", "Failed to update staff.");
                request.getRequestDispatcher("staff/updateStaff.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            logger.log(Level.SEVERE, "Invalid number format in request parameters", e);
            request.setAttribute("errorMessage", "Invalid input format. Please check your data.");
            request.getRequestDispatcher("staff/updateStaff.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            logger.log(Level.SEVERE, "Invalid date format or other input error", e);
            request.setAttribute("errorMessage", "Invalid date format or input error.");
            request.getRequestDispatcher("staff/updateStaff.jsp").forward(request, response);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Unexpected error in doAuthorizedPost", e);
            request.setAttribute("errorMessage", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("staff/updateStaff.jsp").forward(request, response);
        }
    }
}
