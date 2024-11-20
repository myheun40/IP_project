<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/notice/acceptanceboard.css">
    <title>합격 후기 작성</title>
    <%@ include file="../header.jsp" %>
</head>
<body>
<jsp:include page="../navbar.jsp" />
<div class="main-content">

<div class="forum-container">
    <div class="forum-header">
        <h1 class="forum-title">취업 자료 게시판</h1>
        <a href="/notice/resourcewrite" class="write-btn">글쓰기</a>
    </div>

    <div class="filter-section">
        <div class="filter-group">
            <label>시기:</label>
            <select class="filter-select">
                <option value="">전체</option>
                <option value="2024-1">2024년 상반기</option>
                <option value="2024-2">2024년 하반기</option>
                <option value="2023-1">2023년 상반기</option>
                <option value="2023-2">2023년 하반기</option>
            </select>
        </div>
        <div class="filter-group">
            <label>직무:</label>
            <select class="filter-select">
                <option value="">전체</option>
                <option value="developer">개발자</option>
                <option value="designer">디자이너</option>
                <option value="marketing">마케팅</option>
            </select>
        </div>
        <div class="filter-group">
            <label>경력:</label>
            <select class="filter-select">
                <option value="">전체</option>
                <option value="신입">신입</option>
                <option value="경력">경력</option>
                <option value="인턴">인턴</option>
            </select>
        </div>
    </div>

    <div class="search-section">
        <input type="text" class="search-input" placeholder="검색어를 입력하세요">
        <button class="search-btn">검색</button>
    </div>

    <table class="board-table">
        <thead>
        <tr>
            <th style="width: 7%">번호</th>
            <th style="width: 53%">제목</th>
            <th style="width: 15%">작성자</th>
            <th style="width: 15%">작성일</th>
            <th style="width: 10%">조회</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${posts}" var="post" varStatus="status">
            <tr>
                <td>${post.id}</td>
                <td class="title-cell">
                    <span class="company-badge">${post.company}</span>
                    <a href="/acceptance/view/${post.id}">${post.title}</a>
                    <c:if test="${post.commentCount > 0}">
                        <span class="meta-info">[${post.commentCount}]</span>
                    </c:if>
                </td>
                <td>${post.author}</td>
                <td>
                    <fmt:formatDate value="${post.createdAt}" pattern="yyyy.MM.dd"/>
                </td>
                <td>${post.viewCount}</td>
            </tr>
        </c:forEach>
        <c:if test="${empty posts}">
            <tr>
                <td colspan="5" class="no-results">
                    작성된 게시글이 없습니다.
                </td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div class="pagination">
        <a href="#" class="page-link">«</a>
        <a href="#" class="page-link active">1</a>
        <a href="#" class="page-link">2</a>
        <a href="#" class="page-link">3</a>
        <a href="#" class="page-link">4</a>
        <a href="#" class="page-link">5</a>
        <a href="#" class="page-link">»</a>
    </div>
</div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Handle filters
        const filters = document.querySelectorAll('.filter-select');
        filters.forEach(filter => {
            filter.addEventListener('change', function() {
                // Add your filter logic here
                console.log('Filter changed:', this.value);
            });
        });

        // Handle search
        const searchBtn = document.querySelector('.search-btn');
        const searchInput = document.querySelector('.search-input');

        searchBtn.addEventListener('click', function() {
            const searchTerm = searchInput.value.trim();
            if (searchTerm) {
                // Add your search logic here
                console.log('Searching for:', searchTerm);
            }
        });
    });
</script>
</body>
</html>