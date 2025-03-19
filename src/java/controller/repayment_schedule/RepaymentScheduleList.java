package controller.repayment_schedule;

import context.CustomerDAO;
import context.RepaymentScheduleDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;
import model.Customer;
import model.RepaymentSchedule;

public class RepaymentScheduleList extends HttpServlet {

    // Initialize DAOs
    private RepaymentScheduleDAO repaymentScheduleDAO = new RepaymentScheduleDAO();
    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get session
        HttpSession session = request.getSession(false);

        // Check session and customer
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get customer from session
        Customer customer = (Customer) session.getAttribute("customer");
        int customerId = customer.getCustomerId();

        // Add customer ID to request for display in JSP
        request.setAttribute("customerId", customerId);

        // Check if payment is being made
        String scheduleIdParam = request.getParameter("scheduleId");
        String action = request.getParameter("action");

        // Handle payment if scheduleId and action are provided
        if (scheduleIdParam != null && action != null && action.equals("pay")) {
            try {
                int scheduleId = Integer.parseInt(scheduleIdParam);
                String paymentResult = processPayment(scheduleId, customer);

                // Update customer in session with new balance only if payment was successful
                if (paymentResult.contains("successful")) {
                    customer = customerDAO.getCustomerById(customerId);
                    session.setAttribute("customer", customer);
                }

                // Set payment result message for display
                request.setAttribute("paymentMessage", paymentResult);

            } catch (NumberFormatException e) {
                request.setAttribute("paymentMessage", "Invalid schedule ID format.");
                System.out.println("Error parsing schedule ID: " + e.getMessage());
            } catch (Exception e) {
                request.setAttribute("paymentMessage", "Error processing payment: " + e.getMessage());
                System.out.println("Error in payment processing: " + e.getMessage());
                e.printStackTrace();
            }
        }

        // Get repayment schedules list
        List<RepaymentSchedule> schedules = repaymentScheduleDAO.getRepaymentSchedulesByCustomerId(customerId);

        // Debug information
        // Process schedules to determine due soon status in the controller
        if (schedules != null && !schedules.isEmpty()) {
            Date currentDate = new Date(System.currentTimeMillis());

            for (RepaymentSchedule schedule : schedules) {
                // Calculate days difference for each schedule
                long daysDiff = (schedule.getDueDate().getTime() - currentDate.getTime()) / (1000 * 60 * 60 * 24);
                schedule.setDaysDifference(daysDiff); // Add this field to RepaymentSchedule class

                // Set payment availability
                if (daysDiff >= 0 && daysDiff < 7 && !"PAID".equals(schedule.getStatus())) {
                    schedule.setPaymentAvailable(true); // Add this field to RepaymentSchedule class
                } else {
                    schedule.setPaymentAvailable(false);
                }
            }
        }

        request.setAttribute("schedules", schedules);

        // Forward to JSP
        request.getRequestDispatcher("/staff-manager/repayment_schedule.jsp").forward(request, response);
    }

    private String processPayment(int scheduleId, Customer customer) throws Exception {
        // Get the repayment schedule
        RepaymentSchedule schedule = repaymentScheduleDAO.getScheduleById(scheduleId);

        if (schedule == null) {
            throw new Exception("Repayment schedule not found.");
        }

        // Check if payment is already made
        if ("PAID".equals(schedule.getStatus())) {
            return "This payment has already been processed.";
        }

        // Check if payment is due soon (within 7 days)
        Date currentDate = new Date(System.currentTimeMillis());
        long daysDiff = (schedule.getDueDate().getTime() - currentDate.getTime()) / (1000 * 60 * 60 * 24);

        if (daysDiff >= 7) {
            return "This payment is not yet due for payment. Payments can only be made within 7 days of the due date.";
        }

        // Get payment amount
        BigDecimal amountDue = schedule.getAmountDue();

        // Check if customer has sufficient balance
        BigDecimal customerBalance = customer.getBalance();

        if (customerBalance.compareTo(amountDue) < 0) {
            return "Insufficient balance. Your current balance is $" + customerBalance
                    + " but the payment requires $" + amountDue + ".";
        }

        // Process the payment using DAO method
        boolean paymentProcessed = repaymentScheduleDAO.processPaymentTransaction(
                scheduleId,
                customer.getCustomerId(),
                amountDue
        );

        if (!paymentProcessed) {
            throw new Exception("Failed to process payment. Please try again later.");
        }

        // Get updated balance after successful payment
        Customer updatedCustomer = customerDAO.getCustomerById(customer.getCustomerId());
        BigDecimal newBalance = updatedCustomer.getBalance();

        return "Payment of $" + amountDue + " was successful. Your new balance is $" + newBalance + ".";
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
