package controller.Staff;

import context.DepartmentDAO;
import context.RoleDAO;
import context.StaffDAO;
import controller.auth.BaseRBACControlller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import model.Department;
import model.auth.Role;
import model.auth.Staff;

public class StaffFilterController extends BaseRBACControlller {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response, Staff account)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Retrieve parameters from the request
        String raw_sid = request.getParameter("staffid");
        String raw_did = request.getParameter("did");
        String raw_sname = request.getParameter("fullname");
        String raw_gender = request.getParameter("gender");
        String raw_address = request.getParameter("address");
        String raw_email = request.getParameter("email");
        String raw_phonenumber = request.getParameter("phonenumber");
        String raw_cic = request.getParameter("citizen_identification_card");
        String raw_dob = request.getParameter("dob");
        String raw_rid = request.getParameter("roleid");

        // Process parameters with proper null/empty checks
//        Integer sid = (raw_sid != null && !raw_sid.isBlank()) ? Integer.parseInt(raw_sid) : null;
        Integer did = (raw_did != null && !raw_did.equals("-1")) ? Integer.parseInt(raw_did) : null;
        Integer rid = (raw_rid != null && !raw_rid.equals("-1")) ? Integer.parseInt(raw_rid) : null;

        String sname = raw_sname;

        // Handle gender with more robust approach
        Boolean gender = (raw_gender != null && !raw_gender.equals("-1")) ? Boolean.parseBoolean(raw_gender) : null;

        String dob = raw_dob;
        String address = raw_address;
        String email = raw_email;
        String phonenumber = raw_phonenumber;
        String cic = raw_cic;

        // Retrieve staff list based on search criteria
        StaffDAO dbStaff = new StaffDAO();
        ArrayList<Staff> staffs = dbStaff.search( sname, gender, dob, address, did, phonenumber, email, cic, rid);

        // Retrieve departments and roles for dropdowns
        DepartmentDAO dbDept = new DepartmentDAO();
        ArrayList<Department> depts = dbDept.list();

        RoleDAO dbRole = new RoleDAO();
        ArrayList<Role> roles = dbRole.list();

        // Set attributes for JSP
        request.setAttribute("staff", staffs);
        request.setAttribute("depts", depts);
        request.setAttribute("roles", roles);

        // Set search parameters as attributes for form persistence
        request.setAttribute("staffid", raw_sid);
        request.setAttribute("did", raw_did);
        request.setAttribute("fullname", raw_sname);
        request.setAttribute("gender", raw_gender);
        request.setAttribute("address", raw_address);
        request.setAttribute("email", raw_email);
        request.setAttribute("phonenumber", raw_phonenumber);
        request.setAttribute("citizen_identification_card", raw_cic);
        request.setAttribute("dob", raw_dob);
        request.setAttribute("roleid", raw_rid);

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
