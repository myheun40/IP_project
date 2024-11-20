<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>IPro</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/review_board/review_list.css">

</head>

<body>
<jsp:include page="../navbar.jsp"/>
<main class="main-content" style="margin-top: 0;">
    <div class="jumbotron">
        <h1>기업 면접 후기 & 리뷰</h1>
        <p>앞으로 근무할 기업은 어떤 모습일까 궁금하시죠?</p>
        <hr>
        <p>현직 선배님들의 기업 리뷰와 미리 알아보는 면접 후기</p>
    </div>


    <div class="container d-flex flex-column" style="gap:0">
        <!-- Search Section -->
        <section class="search-section mt-4">
            <form action="${pageContext.request.contextPath}/review_board/search" method="get" class="search-form">
                <div class="search-group">
                    <select name="orderBy" class="search-select">
                        <option value="all" ${param.orderBy == 'all' ? 'selected' : ''}>합격 여부</option>
                        <option value="합격" ${param.orderBy == '합격' ? 'selected' : ''}>합격</option>
                        <option value="불합격" ${param.orderBy == '불합격' ? 'selected' : ''}>불합격</option>
                        <option value="결과대기중" ${param.orderBy == '결과대기중' ? 'selected' : ''}>결과대기중</option>
                    </select>
                </div>
                <div class="search-input-group">
                    <input type="text" name="keyword" class="search-input" placeholder="기업명" value="${param.keyword}">
                    <button type="submit" class="btn-primary">검색</button>
                    <button type="button" class="btn-secondary" onclick="location.href='${pageContext.request.contextPath}/review_board'">초기화</button>
                </div>
            </form>
        </section>

        <!--  Reviews Section -->
        <section class="company-reviews-section">
            <div class="review-title d-flex justify-content-between align-items-center">
                <h2 style="text-align:center;">면접 후기</h2>
                <button class="btn-write" onclick="location.href='${pageContext.request.contextPath}/review_board/review_write'">
                    <span class="write-icon">✎</span>리뷰 등록하기
                </button>
            </div>
            <div class="row row-cols-1 g-1">
                <c:forEach var="board" items="${list}" varStatus="i">
                    <a class="nav-link" href="${pageContext.request.contextPath}/review_board/review_view/${board.reviewIdx}">
                        <div class="col">
                            <div class="review-card">
                                <div class="reviewcard-body">

                                    <div class="corpreviewtitle">
                                        <h5 class="reviewcard-title">${board.reviewCompany}</h5>
                                        <p class="reviewcard-text">${board.reviewPosition}</p>
                                        <footer>
                                            <button type="button" class="result-tag">
                                                    <c:set var="resultClass" value="" />
                                                <c:choose>
                                                <c:when test="${board.result == '합격'}">
                                                    <c:set var="resultClass" value="pass" />
                                                </c:when>
                                                <c:when test="${board.result == '불합격'}">
                                                    <c:set var="resultClass" value="fail" />
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="resultClass" value="pending" />
                                                </c:otherwise>
                                                </c:choose>
                                                <button type="button" class="result-tag ${resultClass}">
                                                        ${board.result}
                                                </button>
                                        </footer>
                                    </div>
                                    <div class="content-wrapper">
                                        <div class="corpreviewtext1">
                                            <h5>[${board.period}] ${board.reviewTitle}</h5>
                                        </div>
                                        <div class="corpreviewtext2">
                                            <p><strong>"면접 분위기나 진행방식은 어떠했습니까?"</strong></p>
                                            <p>${board.atmosphere}</p>
                                            <p><strong>"면접에서 좋았던 점이나 아쉬웠던 점은 무엇입니까??"</strong></p>
                                            <p>${board.sorrow}</p>
                                            <p><strong>"면접 합격 팁이나 조언이 있다면?"</strong></p>
                                            <p>${board.advice}</p>
                                        </div>
                                    </div>
                                    <span class="review-count">${board.formattedReviewDate}</span>
                                </div>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </section>

        <br>


    </div>
</main>
<jsp:include page="../footer.jsp"/>
</body>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Get current URL parameters
        const urlParams = new URLSearchParams(window.location.search);
        const itemsPerPage = 5; // Set limit to 5 items per page

        // Handle pagination click events
        function handlePaginationClick(e) {
            e.preventDefault();
            const href = this.getAttribute('onclick')?.match(/href='([^']+)'/)?.[1];
            if (href) {
                // Preserve existing search parameters while updating page
                const currentParams = new URLSearchParams(window.location.search);
                const newParams = new URLSearchParams(href.split('?')[1]);

                // Update page parameter
                currentParams.set('page', newParams.get('page'));

                // Keep existing search parameters
                const orderBy = currentParams.get('orderBy');
                const career = currentParams.get('career');
                const jobType = currentParams.get('jobType');
                const keyword = currentParams.get('keyword');

                // Construct new URL
                let newUrl = `?page=${newParams.get('page')}`;
                if (orderBy) newUrl += `&orderBy=${orderBy}`;
                if (career) newUrl += `&career=${career}`;
                if (jobType) newUrl += `&jobType=${jobType}`;
                if (keyword) newUrl += `&keyword=${keyword}`;

                // Navigate to new URL
                window.location.href = newUrl;

                // Smooth scroll to reviews section
                document.querySelector('.reviews-section').scrollIntoView({
                    behavior: 'smooth'
                });
            }
        }

        // Attach event listeners to pagination buttons
        const pageButtons = document.querySelectorAll('.page-btn');
        pageButtons.forEach(button => {
            button.removeEventListener('click', handlePaginationClick); // Remove any existing listeners
            button.addEventListener('click', handlePaginationClick);
        });

        // Handle search form
        const searchForm = document.querySelector('.search-form');
        if (searchForm) {
            searchForm.addEventListener('submit', (e) => {
                const keyword = searchForm.querySelector('.search-input').value.trim();

                // Add validation if needed
                if (keyword.length < 1 && keyword.length > 0) {
                    e.preventDefault();
                    alert('검색어는 1글자 이상 입력해주세요.');
                }

                // Add page parameter with value 1 when searching
                const pageInput = document.createElement('input');
                pageInput.type = 'hidden';
                pageInput.name = 'page';
                pageInput.value = '1';
                searchForm.appendChild(pageInput);
            });
        }

        // Handle reset button
        const resetButton = document.querySelector('.btn-secondary');
        if (resetButton) {
            resetButton.addEventListener('click', () => {
                const inputs = searchForm.querySelectorAll('input, select');
                inputs.forEach(input => {
                    if (input.type === 'text') {
                        input.value = '';
                    } else if (input.tagName === 'SELECT') {
                        input.selectedIndex = 0;
                    }
                });
                // Reset to page 1
                window.location.href = '?page=1';
            });
        }

        // Handle responsive table
        function handleResponsiveTable() {
            const table = document.querySelector('.reviews-table table');
            if (table) {
                const windowWidth = window.innerWidth;
                if (windowWidth < 768) {
                    const headers = Array.from(table.querySelectorAll('th')).map(th => th.textContent);
                    table.querySelectorAll('tbody tr').forEach(row => {
                        row.querySelectorAll('td').forEach((cell, index) => {
                            cell.setAttribute('data-label', headers[index]);
                        });
                    });
                }
            }
        }

        // Initialize responsive table
        handleResponsiveTable();
        window.addEventListener('resize', handleResponsiveTable);
    });
</script>



</body>

</html>