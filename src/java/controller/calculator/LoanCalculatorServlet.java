/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.calculator;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import model.LoanPayment;

/**
 *
 * @author lenovo
 */
@WebServlet(name = "LoanCalculatorServlet", urlPatterns = {"/loan-calculator"})
public class LoanCalculatorServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Nhận dữ liệu từ form JSP
            double loanAmount = Double.parseDouble(request.getParameter("amount"));
            double annualInterestRate = Double.parseDouble(request.getParameter("interest"));
            int months = Integer.parseInt(request.getParameter("months"));

            // Chuyển đổi lãi suất thành số thập phân theo tháng
            double monthlyInterestRate = (annualInterestRate / 100) / 12;

            // Tính toán theo phương thức dư nợ giảm dần
            double totalInterest = 0;
            double remainingLoan = loanAmount;
            double monthlyPrincipal = loanAmount / months;
            StringBuilder schedule = new StringBuilder();

            DecimalFormat df = new DecimalFormat("#,### VND");

            // Tạo lịch trả nợ
            for (int i = 1; i <= months; i++) {
                double monthlyInterest = remainingLoan * monthlyInterestRate;
                double monthlyPayment = monthlyPrincipal + monthlyInterest;
                totalInterest += monthlyInterest;
                remainingLoan -= monthlyPrincipal;

                schedule.append("<tr>")
                        .append("<td>").append(i).append("</td>")
                        .append("<td>").append(df.format(monthlyPrincipal)).append("</td>")
                        .append("<td>").append(df.format(monthlyInterest)).append("</td>")
                        .append("<td>").append(df.format(monthlyPayment)).append("</td>")
                        .append("<td>").append(df.format(remainingLoan)).append("</td>")
                        .append("</tr>");
            }

            // Gửi dữ liệu sang JSP
            request.setAttribute("totalPrincipal", df.format(loanAmount));
            request.setAttribute("totalInterest", df.format(totalInterest));
            request.setAttribute("totalPayment", df.format(loanAmount + totalInterest));
            request.setAttribute("schedule", schedule.toString());

            RequestDispatcher dispatcher = request.getRequestDispatcher("loanrequest/loan_interest_calculator.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            response.getWriter().println("Lỗi xử lý: " + e.getMessage());
        }
    }
}
