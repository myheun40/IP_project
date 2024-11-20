<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <link rel="stylesheet" href="<c:url value='/resources/static/notice/noticeboard.css'/>">
    <title>Title</title>
    <%@ include file="../header.jsp" %>
</head>
<body>
<jsp:include page="../navbar.jsp"/>
<!-- Main Content -->
<div class="main-content">
    <div class="jumbotron">
        <h1>면접의 고수</h1>
        <hr>
        <p>합격자들의 자소서와 취업 관련 최신 정보들까지</p>
        <p>보증된 합격자들의 합격 노하우!</p>
    </div>
    <main class="content-wrapper">
        <div class="board-container">
            <div class="board-grid">
                <!-- User Posts Section -->
                <div class="board-card">
                    <div class="board-header">
                        <h2><a href="/notice/acceptanceboard" style="text-decoration: none; color: inherit;">합격자 자소서</a>
                        </h2>
                        <button class="btn-write" onclick="location.href='acceptancewrite'">
                            <i class="fas fa-pen"></i> 글쓰기
                        </button>
                    </div>
                    <div class="board-content">
                        <table class="board-table">
                            <thead>
                            <tr>
                                <th style="width: 60%">제목</th>
                                <th style="width: 20%">작성자</th>
                                <th style="width: 20%">작성일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr class="post-item">
                                <td class="post-title">네이버 합격 자소서 공유합니다</td>
                                <td>김**</td>
                                <td>2024.10.25</td>
                            </tr>
                            <tr class="post-item">
                                <td class="post-title">카카오 최종 합격 후기</td>
                                <td>*하*</td>
                                <td>2024.10.24</td>
                            </tr>
                            <tr class="post-item">
                                <td class="post-title">중근당 합격 자소서입니다</td>
                                <td>**은</td>
                                <td>2024.10.23</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Admin Notice Section -->
                <div class="board-card">
                    <div class="board-header">
                        <h2><span class="category-label">취업 관련 유용한 자료</span></h2>
                        <button class="btn-write" onclick="location.href='resourcewrite'">
                            <i class="fas fa-thumbtack"></i> 공지작성
                        </button>
                    </div>
                    <div class="board-content">
                        <table class="board-table">
                            <thead>
                            <tr>
                                <th style="width: 15%">구분</th>
                                <th style="width: 45%">제목</th>
                                <th style="width: 20%">작성자</th>
                                <th style="width: 20%">작성일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr class="post-item">
                                <td class="post-category">공지</td>
                                <td class="post-title">10월 채용 공고 모음</td>
                                <td>관리자</td>
                                <td>2024.10.25</td>
                            </tr>
                            <tr class="post-item">
                                <td class="post-category">취업</td>
                                <td class="post-title">2024 하반기 공채 일정</td>
                                <td>관리자</td>
                                <td>2024.10.24</td>
                            </tr>
                            <tr class="post-item">
                                <td class="post-category">면접</td>
                                <td class="post-title">IT 기업 면접 준비하기</td>
                                <td>관리자</td>
                                <td>2024.10.23</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
<script>
    // Add smooth hover effects and interactions
    document.addEventListener('DOMContentLoaded', function () {
        // Add hover effect to table rows
        const postItems = document.querySelectorAll('.post-item');
        postItems.forEach(item => {
            item.addEventListener('mouseenter', function () {
                this.style.transition = 'background-color 0.2s ease';
            });
        });

        // Add click event to post titles
        const postTitles = document.querySelectorAll('.post-title');
        postTitles.forEach(title => {
            title.addEventListener('click', function (e) {
                // Add ripple effect on click
                const ripple = document.createElement('div');
                ripple.classList.add('ripple');
                this.appendChild(ripple);

                // Get position of click relative to element
                const rect = this.getBoundingClientRect();
                const x = e.clientX - rect.left;
                const y = e.clientY - rect.top;

                ripple.style.left = x + 'px';
                ripple.style.top = y + 'px';

                // Remove ripple after animation
                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
        });

        // Add smooth scroll behavior to buttons
        const buttons = document.querySelectorAll('button');
        buttons.forEach(button => {
            button.addEventListener('click', function () {
                this.style.transform = 'scale(0.98)';
                setTimeout(() => {
                    this.style.transform = 'scale(1)';
                }, 100);
            });
        });

        // Add intersection observer for fade-in animation
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('fade-in');
                    observer.unobserve(entry.target);
                }
            });
        }, {
            threshold: 0.1
        });

        // Observe board cards
        document.querySelectorAll('.board-card').forEach(card => {
            observer.observe(card);
        });

        // Add dynamic badge colors based on content
        const badges = document.querySelectorAll('.badge');
        badges.forEach(badge => {
            const text = badge.textContent.toLowerCase();
            if (text.includes('공지')) {
                badge.style.backgroundColor = '#4F46E5';
            } else if (text.includes('취업')) {
                badge.style.backgroundColor = '#75c9e9';
            } else if (text.includes('면접')) {
                badge.style.backgroundColor = '#d6d6d6';
            }
        });
    });

    // Add responsive table handling
    function handleResponsiveTables() {
        const tables = document.querySelectorAll('.board-table');
        const isMobile = window.innerWidth <= 768;

        tables.forEach(table => {
            const authorCells = table.querySelectorAll('td:nth-child(3), th:nth-child(3)');
            authorCells.forEach(cell => {
                cell.style.display = isMobile ? 'none' : 'table-cell';
            });
        });
    }

    window.addEventListener('resize', handleResponsiveTables);
    handleResponsiveTables();
</script>
</body>
</html>
