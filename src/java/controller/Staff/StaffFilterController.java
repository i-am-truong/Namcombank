/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.Staff;

import context.DepartmentDAO;
import context.StaffDAO;
import controller.auth.BaseRBACControlller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import model.Department;
import model.auth.Staff;

/**
 *
 * @author Asus
 */
public class StaffFilterController extends BaseRBACControlller {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response, Staff account)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Lấy các tham số từ request
        String raw_sid = request.getParameter("staffid");
        String raw_did = request.getParameter("did");
        String raw_sname = request.getParameter("fullname");
        String raw_gender = request.getParameter("gender");
        String raw_address = request.getParameter("address");
        String raw_email = request.getParameter("email");
        String raw_phonenumber = request.getParameter("phonenumber");
        String raw_cic = request.getParameter("citizen_identification_card");
        String raw_dob = request.getParameter("dob");

        // Xử lý dữ liệu từ request, bao gồm việc chuyển đổi các giá trị null, blank
        Integer sid = (raw_sid != null) && (!raw_sid.isBlank())
                ? Integer.parseInt(raw_sid) : null;

        String sname = raw_sname;

        Boolean gender = (raw_gender != null) && (!raw_gender.equals("-1"))
                ? Boolean.getBoolean(raw_gender) : null;

        String dob = raw_dob;

        String address = raw_address;
        String email = raw_email;

        String phonenumber = raw_phonenumber;

        String cic = raw_cic;

        Integer did = (raw_did != null) && (!raw_did.equals("-1"))
                ? Integer.parseInt(raw_did) : null;

        StaffDAO dbStaff = new StaffDAO();
        ArrayList<Staff> staffs = dbStaff.search(sid, sname, gender, dob, address, did, phonenumber, email, cic);

        DepartmentDAO dbDept = new DepartmentDAO();
        ArrayList<Department> depts = dbDept.list();

        request.setAttribute("depts", depts);
        request.setAttribute("staff", staffs);

        request.getRequestDispatcher("staff/demofilter.jsp").forward(request, response);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        processRequest(request, response, account);
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        processRequest(request, response, account);
    }

}
