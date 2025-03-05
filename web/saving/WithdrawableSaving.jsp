<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<a href="Home">HOME</a>

<h2>Gói Tiết Kiệm Không Linh Hoạt</h2>
<table border="1">
    <tr>
        <th>Tên Gói</th>
        <th>Lãi Suất</th>
        <th>Kỳ Hạn (tháng)</th>
        <th>Trạng Thái</th>
    </tr>
    <c:forEach var="saving" items="${withdrawableList}">
        <tr>
            <td>${saving.saving_package_name}</td>
            <td>${saving.saving_package_interest_rate}%</td>
            <td>${saving.saving_package_term_months}</td>
            <td>${saving.saving_package_status}</td>
        </tr>
    </c:forEach>
    <!--<th>lãi suất được cập nhật lúc:$/{saving.saving_package_updated_at}</th>-->
</table>

<h2>Tính lãi suất</h2>
<h2>Nhập Số Tiền Gửi</h2>
<form action="" method="get">
    <label for="amount">Số tiền gửi:</label>
    <input type="number" id="amount" name="amount" required min="1">
    <button type="submit">Tính</button>
</form>

<c:if test="${not empty param.amount}">
    <h2>Kết Quả Tính Toán</h2>
    <table border="1">
        <tr>
            <th>Tên Gói</th>
            <th>Kỳ Hạn (tháng)</th>
            <th>Số Tiền Gửi</th>
            <th>Lãi Suất</th>
            <th>Tiền Lãi</th>
            <th>Tổng Nhận</th>
        </tr>
        <c:forEach var="saving" items="${withdrawableList}">
            <c:set var="deposit" value="${param.amount}" />
            <c:set var="interestRate" value="${saving.saving_package_interest_rate / 100}" />
            <c:set var="months" value="${saving.saving_package_term_months}" />
            <c:set var="n" value="12" />
            <c:set var="t" value="${months / 12}" />
            <c:set var="compoundFactor" value="${1 + (interestRate / n)}" />
            <c:set var="interest" value="${deposit * (Math.pow(compoundFactor, n * t) - 1)}" />
            <c:set var="totalAmount" value="${deposit + interest}" />

            <tr>
                <td>${saving.saving_package_name}</td>
                <td>${saving.saving_package_term_months}</td>
                <td><fmt:formatNumber value="${deposit}" type="currency" currencySymbol="VND"/></td>
                <td>${saving.saving_package_interest_rate}%</td>
                <td><fmt:formatNumber value="${interest}" type="currency" currencySymbol="VND"/></td>
                <td><fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="VND"/></td>
            </tr>
        </c:forEach>

    </table>
</c:if>

