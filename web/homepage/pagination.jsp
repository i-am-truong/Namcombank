<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- Pagination -->
<div class="text-center">
    <form id="paginationForm" class="text-center" action="${pageContext.request.contextPath}${pagination.urlPattern}" method="get">
        <div class="btn-group me-2" role="group" style="margin-top:1rem" aria-label="First group">
            <!-- Form for pagination -->
            <input type="hidden" name="page" id="pageInput" value="${pagination.currentPage}">
            <input type="hidden" name="page-size" value="${pagination.pageSize}">

            <!-- Include only necessary search fields -->
            <c:if test="${fn:length(pagination.searchFields) > 0}">
                <c:forEach var="i" begin="0" end="${fn:length(pagination.searchFields) - 1}">
                    <c:if test="${pagination.searchFields[i] != 'sort' && pagination.searchFields[i] != 'order'}">
                        <input type="hidden" name="${pagination.searchFields[i]}" value="${pagination.searchValues[i]}">
                    </c:if>
                </c:forEach>
            </c:if>

            <c:if test="${fn:length(pagination.rangeFields) > 0}">
                <c:forEach var="i" begin="0" end="${fn:length(pagination.rangeFields) - 1}">
                    <input type="hidden" name="${pagination.rangeFields[i]}" value="${pagination.rangeValues[i]}">
                </c:forEach>
            </c:if>

            <!-- Navigation buttons - Adding disabled attribute to prevent clicks -->
            <button type="button" class="btn btn-success ${pagination.currentPage <= 1 ? 'disabled' : ''} btn-pagination"
                    onclick="navigatePage(1)" ${pagination.currentPage <= 1 ? 'disabled' : ''}>&lt;&lt;</button>
            <button type="button" class="btn btn-success ${pagination.currentPage <= 1 ? 'disabled' : ''} btn-pagination"
                    onclick="navigatePage(${pagination.currentPage - 1})" ${pagination.currentPage <= 1 ? 'disabled' : ''}>&lt;</button>

            <!-- Page numbers -->
            <c:set var="startPage" value="${pagination.currentPage - (pagination.totalPagesToShow / 2) + 1}" />
            <c:set var="endPage" value="${startPage + pagination.totalPagesToShow - 1}" />

            <c:if test="${startPage < 1}">
                <c:set var="startPage" value="1" />
                <c:set var="endPage" value="${pagination.totalPagesToShow > pagination.totalPages ? pagination.totalPages : pagination.totalPagesToShow}" />
            </c:if>
            <c:if test="${endPage > pagination.totalPages}">
                <c:set var="endPage" value="${pagination.totalPages}" />
                <c:set var="startPage" value="${endPage - pagination.totalPagesToShow + 1 > 0 ? endPage - pagination.totalPagesToShow + 1 : 1}" />
            </c:if>

            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <button type="button" class="btn btn-success ${i == pagination.currentPage ? 'active' : ''} btn-pagination"
                        onclick="navigatePage(${i})">${i}</button>
            </c:forEach>

            <!-- Navigation buttons - Adding disabled attribute to prevent clicks -->
            <button type="button" class="btn btn-success ${pagination.currentPage >= pagination.totalPages ? 'disabled' : ''} btn-pagination"
                    onclick="navigatePage(${pagination.currentPage + 1})" ${pagination.currentPage >= pagination.totalPages ? 'disabled' : ''}>&gt;</button>
            <button type="button" class="btn btn-success ${pagination.currentPage >= pagination.totalPages ? 'disabled' : ''} btn-pagination"
                    onclick="navigatePage(${pagination.totalPages})" ${pagination.currentPage >= pagination.totalPages ? 'disabled' : ''}>&gt;&gt;</button>
        </div>
    </form>

    <!-- Page number input -->
    <div class="text-center" style="margin-top: 1rem;">
        <form class="row align-items-center justify-content-center" action="${pageContext.request.contextPath}${pagination.urlPattern}" method="get">
            <input type="number" style="width:4.5rem; padding:.3rem .5rem" class="form-control mb-2 me-sm-2"
                   id="inlineFormInputName2" name="page" min="1" max="${pagination.totalPages}" placeholder="Page">
            <input type="hidden" name="page-size" value="${pagination.pageSize}">

            <!-- Include only necessary search fields -->
            <c:if test="${fn:length(pagination.searchFields) > 0}">
                <c:forEach var="i" begin="0" end="${fn:length(pagination.searchFields) - 1}">
                    <c:if test="${pagination.searchFields[i] != 'sort' && pagination.searchFields[i] != 'order'}">
                        <input type="hidden" name="${pagination.searchFields[i]}" value="${pagination.searchValues[i]}">
                    </c:if>
                </c:forEach>
            </c:if>

            <button type="submit" style="width:3rem" class="btn btn-success mb-2">Go</button>
        </form>
    </div>
</div>

<!-- Script for pagination -->
<script>
    function navigatePage(page) {
        // Check if the button is disabled (has the disabled attribute or disabled class)
        const clickedButton = event.currentTarget;
        if (clickedButton.hasAttribute('disabled') || clickedButton.classList.contains('disabled')) {
            // If disabled, prevent navigation
            event.preventDefault();
            event.stopPropagation();
            return false;
        }

        // If it's a valid page, set the page input value and submit the form
        if (page >= 1 && page <= ${pagination.totalPages}) {
            document.getElementById('pageInput').value = page;
            document.getElementById('paginationForm').submit();
        }
    }

    // Backward compatibility with the old setPage function
    function setPage(page) {
        navigatePage(page);
    }

    // Add event listener to ensure disabled buttons don't do anything when clicked
    document.addEventListener('DOMContentLoaded', function() {
        const disabledButtons = document.querySelectorAll('.btn-pagination.disabled, .btn-pagination[disabled]');
        disabledButtons.forEach(button => {
            button.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                return false;
            });
        });
    });
</script>
