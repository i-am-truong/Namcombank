
import context.DBContext;
import context.DepartmentDAO;
import context.RoleDAO;
import context.StaffDAO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.util.ArrayList;
import model.Department;
import model.auth.Role;
import model.auth.Staff;

public class Main extends DBContext {

    public static void main(String[] args) {
        System.out.println("=== Staff Update Test ===\n");

        try {
            // Initialize DAOs
            StaffDAO staffDAO = new StaffDAO();
            DepartmentDAO deptDAO = new DepartmentDAO();
            RoleDAO roleDAO = new RoleDAO();

            // Fetch available departments and roles
            ArrayList<Department> departments = deptDAO.list();
            ArrayList<Role> availableRoles = roleDAO.getAllRoles();

            // Validate prerequisites
            if (departments.isEmpty() || availableRoles.isEmpty()) {
                System.out.println("❌ Error: Required departments or roles not found!");
                return;
            }

            // Create test data
            Staff staffToUpdate = createTestStaff(departments, availableRoles);

            // 1. Get current staff data
            System.out.println("📋 Fetching current staff data...");
            Staff currentStaff = staffDAO.getById(staffToUpdate.getId());
            if (currentStaff == null) {
                System.out.println("❌ Error: Staff not found!");
                return;
            }

            System.out.println("\nCurrent Staff Details:");
            printStaffDetails(currentStaff);

            // 2. Perform update
            System.out.println("\n🔄 Performing update...");
            boolean updateResult = staffDAO.updateStaff(staffToUpdate);

            // 3. Verify results
            if (updateResult) {
                System.out.println("✅ Update successful!");
                verifyUpdate(staffToUpdate, staffDAO);
            } else {
                System.out.println("❌ Update failed!");
            }

        } catch (Exception e) {
            System.out.println("❌ Error during test execution: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static Staff createTestStaff(ArrayList<Department> departments, ArrayList<Role> availableRoles) {
        Staff staff = new Staff();
        staff.setId(1); // Assuming staff with ID 1 exists
        staff.setFullname("John Doe Updated");
        staff.setEmail("john.updated@example.com");
        staff.setDob(new java.sql.Date(System.currentTimeMillis()));
        staff.setGender(true);
        staff.setPhonenumber("0123456789");
        staff.setCitizenId("123456789");
        staff.setAddress("123 Updated Street");

        // Set department (choose a different one if possible)
        Department newDept = departments.get(departments.size() > 1 ? 1 : 0);
        staff.setDept(newDept);

        // Set roles (add multiple if available)
        ArrayList<Role> roles = new ArrayList<>();
        roles.add(availableRoles.get(0));
        if (availableRoles.size() > 1) {
            roles.add(availableRoles.get(1));
        }
        staff.setRoles(roles);

        return staff;
    }

    private static void printStaffDetails(Staff staff) {
        System.out.println("---------------------------");
        System.out.println("Staff ID: " + staff.getId());
        System.out.println("Name: " + staff.getFullname());
        System.out.println("Email: " + staff.getEmail());
        System.out.println("Phone: " + staff.getPhonenumber());
        System.out.println("Department: "
                + (staff.getDept() != null
                ? String.format("%d - %s", staff.getDept().getId(), staff.getDept().getName())
                : "Not assigned"));

        System.out.println("Roles ("
                + (staff.getRoles() != null ? staff.getRoles().size() : 0) + "):");
        if (staff.getRoles() != null) {
            staff.getRoles().forEach(role
                    -> System.out.println("  - " + role.getId() + ": " + role.getName()));
        }
        System.out.println("---------------------------");
    }

    private static void verifyUpdate(Staff expected, StaffDAO staffDAO) {
        System.out.println("\n🔍 Verifying update results...");
        Staff actual = staffDAO.getById(expected.getId());

        if (actual == null) {
            System.out.println("❌ Error: Could not fetch updated staff!");
            return;
        }

        System.out.println("\nUpdated Staff Details:");
        printStaffDetails(actual);

        // Verify all fields
        boolean success = true;
        success &= verifyField("Name", expected.getFullname(), actual.getFullname());
        success &= verifyField("Email", expected.getEmail(), actual.getEmail());
        success &= verifyField("Phone", expected.getPhonenumber(), actual.getPhonenumber());
        success &= verifyField("Address", expected.getAddress(), actual.getAddress());

        // Verify department
        if (expected.getDept() != null && actual.getDept() != null) {
            success &= verifyField("Department ID",
                    String.valueOf(expected.getDept().getId()),
                    String.valueOf(actual.getDept().getId()));
        } else {
            System.out.println("❌ Department verification failed - null value detected");
            success = false;
        }

        // Verify roles
        if (expected.getRoles() != null && actual.getRoles() != null) {
            success &= verifyField("Roles count",
                    String.valueOf(expected.getRoles().size()),
                    String.valueOf(actual.getRoles().size()));
        } else {
            System.out.println("❌ Roles verification failed - null value detected");
            success = false;
        }

        System.out.println("\nOverall Verification: "
                + (success ? "✅ PASSED" : "❌ FAILED"));
    }

    private static boolean verifyField(String fieldName, String expected, String actual) {
        boolean match = expected != null && expected.equals(actual);
        System.out.println(String.format("%s %s: %s",
                match ? "✅" : "❌",
                fieldName,
                match ? "Matched" : String.format("Mismatch (Expected: %s, Actual: %s)",
                                expected, actual)));
        return match;
    }

    @Override
    public void insert(Object model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Object model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Object model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Object get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
