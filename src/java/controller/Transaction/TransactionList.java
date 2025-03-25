package controller.Transaction;

import context.TransactionDAO;
import controller.auth.BaseRBACControlller;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.Normalizer;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.regex.Pattern;
import model.Transaction;
import model.auth.Staff;

@WebServlet(name = "TransactionController", urlPatterns = {"/transaction-filter"})
public class TransactionList extends BaseRBACControlller {
    private TransactionDAO transactionDAO;
    
    @Override
    public void init() {
        transactionDAO = new TransactionDAO();
    }
    

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        // Handle the request directly without redirection to preserve POST parameters
        searchTransactions(request, response);
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        searchTransactions(request, response);
    }
       private void searchTransactions(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get or create the session
        HttpSession session = request.getSession();
        
        // Check if this is a fresh search (POST) or using stored parameters (GET)
        String action = request.getParameter("action");
        
        // Parse search parameters
        String customerName = null;
        String type = null;
        Date startDate = null;
        Date endDate = null;
        BigDecimal minAmount = null;
        BigDecimal maxAmount = null;
        String sortBy = null;
        String sortOrder = null;
        
        // Process based on action
        if ("search".equals(action)) {
            // Get parameters from request
            customerName = request.getParameter("customerName");
            type = request.getParameter("type");
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            
            try {
                String startDateParam = request.getParameter("startDate");
                if (startDateParam != null && !startDateParam.isEmpty()) {
                    startDate = dateFormat.parse(startDateParam);
                    session.setAttribute("startDateStr", startDateParam);
                } else {
                    session.removeAttribute("startDateStr");
                }
                
                String endDateParam = request.getParameter("endDate");
                if (endDateParam != null && !endDateParam.isEmpty()) {
                    endDate = dateFormat.parse(endDateParam);
                    session.setAttribute("endDateStr", endDateParam);
                } else {
                    session.removeAttribute("endDateStr");
                }
            } catch (ParseException e) {
            }
            
            try {
                String minAmountParam = request.getParameter("minAmount");
                if (minAmountParam != null && !minAmountParam.isEmpty()) {
                    minAmount = new BigDecimal(minAmountParam);
                }
                
                String maxAmountParam = request.getParameter("maxAmount");
                if (maxAmountParam != null && !maxAmountParam.isEmpty()) {
                    maxAmount = new BigDecimal(maxAmountParam);
                }
            } catch (NumberFormatException e) {
                // Invalid number format, leave as null
            }
            
            sortBy = request.getParameter("sortBy");
            sortOrder = request.getParameter("sortOrder");
            
            // Store in session for future use
            session.setAttribute("customerName", customerName);
            session.setAttribute("type", type);
            session.setAttribute("startDate", startDate);
            session.setAttribute("endDate", endDate);
            session.setAttribute("minAmount", minAmount);
            session.setAttribute("maxAmount", maxAmount);
            session.setAttribute("sortBy", sortBy);
            session.setAttribute("sortOrder", sortOrder);
        } else if ("clear".equals(action)) {
            session.removeAttribute("customerName");
            session.removeAttribute("type");
            session.removeAttribute("startDate");
            session.removeAttribute("endDate");
            session.removeAttribute("startDateStr");
            session.removeAttribute("endDateStr");
            session.removeAttribute("minAmount");
            session.removeAttribute("maxAmount");
            session.removeAttribute("sortBy");
            session.removeAttribute("sortOrder");
        } else if ("sort".equals(action)) {
            sortBy = request.getParameter("sortBy");
            sortOrder = request.getParameter("sortOrder");
            session.setAttribute("sortBy", sortBy);
            session.setAttribute("sortOrder", sortOrder);
            customerName = (String) session.getAttribute("customerName");
            type = (String) session.getAttribute("type");
            startDate = (Date) session.getAttribute("startDate");
            endDate = (Date) session.getAttribute("endDate");
            minAmount = (BigDecimal) session.getAttribute("minAmount");
            maxAmount = (BigDecimal) session.getAttribute("maxAmount");
        } else {
            customerName = (String) session.getAttribute("customerName");
            type = (String) session.getAttribute("type");
            startDate = (Date) session.getAttribute("startDate");
            endDate = (Date) session.getAttribute("endDate");
            minAmount = (BigDecimal) session.getAttribute("minAmount");
            maxAmount = (BigDecimal) session.getAttribute("maxAmount");
            sortBy = (String) session.getAttribute("sortBy");
            sortOrder = (String) session.getAttribute("sortOrder");
        }
        
        // Get all transactions first
        ArrayList<Transaction> transactions = transactionDAO.list();
        
        // Apply filters if any parameters are set
        boolean filtersApplied = false;
        
        // Filter by customer name if provided
        if (customerName != null && !customerName.isEmpty()) {
            filtersApplied = true;
            String normalizedSearchName = normalizeVietnameseText(customerName);
            ArrayList<Transaction> filteredTransactions = new ArrayList<>();
            
            for (Transaction transaction : transactions) {
                if (transaction.getCustomer() != null && 
                    transaction.getCustomer().getFullname() != null) {
                    
                    String normalizedCustomerName = normalizeVietnameseText(transaction.getCustomer().getFullname());
                    
                    if (normalizedCustomerName.contains(normalizedSearchName)) {
                        filteredTransactions.add(transaction);
                    }
                }
            }
            transactions = filteredTransactions;
        }
        
        // Filter by type if provided
        if (type != null && !type.isEmpty() && !type.equals("All")) {
            filtersApplied = true;
            ArrayList<Transaction> filteredTransactions = new ArrayList<>();
            for (Transaction transaction : transactions) {
                if (transaction.getType() != null && 
                    transaction.getType().equalsIgnoreCase(type)) {
                    filteredTransactions.add(transaction);
                }
            }
            transactions = filteredTransactions;
        }
        
        // Filter by date range if provided
        if (startDate != null || endDate != null) {
            filtersApplied = true;
            ArrayList<Transaction> filteredTransactions = new ArrayList<>();
            for (Transaction transaction : transactions) {
                Date transDate = transaction.getTransactionDate();
                if (transDate != null) {
                    boolean include = true;
                    
                    if (startDate != null && transDate.before(startDate)) {
                        include = false;
                    }
                    
                    if (endDate != null) {
                        // Add one day to endDate to make it inclusive
                        Calendar cal = Calendar.getInstance();
                        cal.setTime(endDate);
                        cal.add(Calendar.DATE, 1);
                        Date inclusiveEndDate = cal.getTime();
                        
                        if (transDate.after(inclusiveEndDate)) {
                            include = false;
                        }
                    }
                    
                    if (include) {
                        filteredTransactions.add(transaction);
                    }
                }
            }
            transactions = filteredTransactions;
        }
        
        // Filter by amount range if provided
        if (minAmount != null || maxAmount != null) {
            filtersApplied = true;
            ArrayList<Transaction> filteredTransactions = new ArrayList<>();
            for (Transaction transaction : transactions) {
                BigDecimal amount = transaction.getAmount();
                if (amount != null) {
                    boolean include = true;
                    
                    if (minAmount != null && amount.compareTo(minAmount) < 0) {
                        include = false;
                    }
                    
                    if (maxAmount != null && amount.compareTo(maxAmount) > 0) {
                        include = false;
                    }
                    
                    if (include) {
                        filteredTransactions.add(transaction);
                    }
                }
            }
            transactions = filteredTransactions;
        }
        
        // Sort the transactions if requested
        if (sortBy != null && !sortBy.isEmpty()) {
            if (sortOrder == null || !sortOrder.equalsIgnoreCase("desc")) {
                sortOrder = "asc"; // Default to ascending if not specified
            }
            
            final boolean isDescending = sortOrder.equalsIgnoreCase("desc");
            
            switch (sortBy) {
                case "transactionId":
                    Collections.sort(transactions, new Comparator<Transaction>() {
                        @Override
                        public int compare(Transaction t1, Transaction t2) {
                            int result = Integer.compare(t1.getTransactionId(), t2.getTransactionId());
                            return isDescending ? -result : result;
                        }
                    });
                    break;
                    
                case "amount":
                    Collections.sort(transactions, new Comparator<Transaction>() {
                        @Override
                        public int compare(Transaction t1, Transaction t2) {
                            BigDecimal a1 = t1.getAmount() != null ? t1.getAmount() : BigDecimal.ZERO;
                            BigDecimal a2 = t2.getAmount() != null ? t2.getAmount() : BigDecimal.ZERO;
                            int result = a1.compareTo(a2);
                            return isDescending ? -result : result;
                        }
                    });
                    break;
                    
                case "transactionDate":
                    Collections.sort(transactions, new Comparator<Transaction>() {
                        @Override
                        public int compare(Transaction t1, Transaction t2) {
                            Date d1 = t1.getTransactionDate() != null ? t1.getTransactionDate() : new Date(0);
                            Date d2 = t2.getTransactionDate() != null ? t2.getTransactionDate() : new Date(0);
                            int result = d1.compareTo(d2);
                            return isDescending ? -result : result;
                        }
                    });
                    break;
            }
        }
        
        // Set attributes for rendering
        request.setAttribute("transactions", transactions);
        request.setAttribute("customerName", customerName);
        request.setAttribute("type", type);
        request.setAttribute("startDate", session.getAttribute("startDateStr"));
        request.setAttribute("endDate", session.getAttribute("endDateStr"));
        request.setAttribute("minAmount", minAmount);
        request.setAttribute("maxAmount", maxAmount);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("filtersApplied", filtersApplied);
        

        
        // Forward to the JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("transaction/transaction-filter.jsp");
        dispatcher.forward(request, response);
    } 

       
    private String normalizeVietnameseText(String text) {
    if (text == null) {
        return "";
    }
    String temp = Normalizer.normalize(text, Normalizer.Form.NFD);
    Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
    return pattern.matcher(temp).replaceAll("").toLowerCase();
    }

}


