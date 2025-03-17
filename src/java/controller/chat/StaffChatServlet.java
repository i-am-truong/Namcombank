/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.chat;

import context.MessageDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Message;

/**
 *
 * @author lenovo
 */
@WebServlet(name = "StaffChatServlet", urlPatterns = {"/StaffChatServlet"})
public class StaffChatServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer staffId = (Integer) session.getAttribute("staff_id");

        // Debug xem staffId có null không
        System.out.println("Staff ID từ session: " + staffId);

        if (staffId == null) {
            response.sendRedirect("admin.login/login.jsp");
            return;
        }

        String customerIdParam = request.getParameter("customer_id");
        if (customerIdParam == null || customerIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu customer_id");
            return;
        }

        int customerId;
        try {
            customerId = Integer.parseInt(customerIdParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "customer_id không hợp lệ");
            return;
        }

        MessageDAO messageDAO = new MessageDAO();
        List<Message> messages = messageDAO.getMessagesBetween(customerId, staffId);

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            for (Message msg : messages) {
                out.println("<div class=\"message "
                        + (msg.getSenderType().equals("customer") ? "customer" : "staff")
                        + "\">" + msg.getContent() + "</div>");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer staffId = (Integer) session.getAttribute("staffId");

        if (staffId == null) {
            response.sendRedirect("admin.login/login.jsp"); // Chuyển hướng về trang login nếu chưa đăng nhập
            return;
        }

        String content = request.getParameter("content");
        String customerIdParam = request.getParameter("customer_id");

        if (content == null || content.trim().isEmpty() || customerIdParam == null || customerIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Nội dung tin nhắn hoặc customer_id không hợp lệ");
            return;
        }

        int customerId;
        try {
            customerId = Integer.parseInt(customerIdParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "customer_id không hợp lệ");
            return;
        }

        // Tạo tin nhắn mới
        MessageDAO messageDAO = new MessageDAO();
        Message newMessage = new Message();
        newMessage.setSenderId(staffId);
        newMessage.setReceiverId(customerId);
        newMessage.setSenderType("staff");
        newMessage.setContent(content);

        // Lưu tin nhắn vào database
        messageDAO.insertMessage(newMessage);

        // Chuyển hướng trở lại trang chat của nhân viên
        response.sendRedirect("chat/chat_staff.jsp?customer_id=" + customerId);
    }
}
