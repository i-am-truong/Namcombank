<%@ page import="java.util.List, model.CreditCard" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="context.CreditCardDAO" %>
<%@ page import="model.Customer" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    Customer customer = (Customer) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("login");
        return;
    }

    CreditCardDAO cardDAO = new CreditCardDAO();
    List<CreditCard> creditCards = cardDAO.getCreditCardsByCustomerId(customer.getCustomerId());
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Credit Cards</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body class="bg-gray-100 min-h-screen flex items-center justify-center">
        <div class="w-full max-w-4xl bg-white shadow-md rounded-lg p-6">
            <a href="Home" class="inline-block bg-gray-500 text-white px-4 py-2 rounded-md shadow-md hover:bg-green-600 transition duration-300">
                🏠 Home
            </a>
            <h2 class="text-2xl font-bold text-gray-800 mb-4">My Credit Cards</h2>

            <% if (creditCards.isEmpty()) { %>
            <p class="text-gray-600">You don't have any credit cards.</p>
            <% } else { %>
            <table class="min-w-full border border-gray-200 shadow-md rounded-lg">
                <thead class="bg-green-500 text-white">
                    <tr>
                        <th class="py-2 px-4 text-left">Card Number</th>
                        <th class="py-2 px-4 text-left">CVV</th>
                        <th class="py-2 px-4 text-left">Credit Limit</th>
                        <th class="py-2 px-4 text-left">Available Balance</th>
                        <th class="py-2 px-4 text-left">Expiry Date</th>
                        <th class="py-2 px-4 text-left">Status</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <% for (CreditCard card : creditCards) { %>
                    <tr class="hover:bg-gray-100">
                        <td class="py-2 px-4"><%= card.getCardNumber() %></td>
                        <td class="py-2 px-4"><%= card.getCvv() %></td>
                        <td class="py-2 px-4">
                            <fmt:formatNumber value="<%= card.getCreditLimit() %>" type="number" groupingUsed="true" /> VND
                        </td>
                        <td class="py-2 px-4">
                            <fmt:formatNumber value="<%= card.getAvailableBalance() %>" type="number" groupingUsed="true" /> VND
                        </td>
                        <td class="py-2 px-4">
                            <fmt:formatDate value="<%= card.getExpiryDate() %>" pattern="dd/MM/yyyy" />
                        </td>
                        <td class="py-2 px-4">
                            <% if (card.getStatus().equalsIgnoreCase("Active")) { %>
                            <span class="text-green-600 font-semibold">Active</span>
                            <% } else { %>
                            <span class="text-red-600 font-semibold">Blocked</span>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } %>
        </div>
    </body>
</html>
