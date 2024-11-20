<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<title>면접 후기</title>
	<%@ include file="../header.jsp" %>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
	<link rel="stylesheet" href="<c:url value='/resources/static/review_board/review_view.css'/>">
</head>
<body>
<jsp:include page="../navbar.jsp" />

<div class="main-content">
	<div class="nav-actions">
		<a href="javascript:history.back()" class="back-button">
			<i class="fas fa-arrow-left"></i>
			뒤로가기
		</a>
		<div class="action-buttons">
			<c:if test="${reviewDto.member.username eq pageContext.request.userPrincipal.name}">
				<button onclick="location.href='/review_board/edit/${reviewDto.reviewIdx}'" class="action-button edit-button">
					<i class="fas fa-edit"></i>
					수정하기
				</button>
				<button onclick="showDeleteConfirm()" class="action-button delete-button">
					<i class="fas fa-trash"></i>
					삭제하기
				</button>
			</c:if>
		</div>
	</div>

	<div class="interview-card">
		<div class="interview-header">
			<div class="metadata-tags">
                <span class="tag">
                    <i class="far fa-calendar"></i>
                    ${reviewDto.period}
                </span>
				<span class="tag">
                    <i class="fas fa-laptop-code"></i>
                    ${reviewDto.reviewPosition}
                </span>
				<c:set var="resultClass" value="" />
				<c:choose>
					<c:when test="${reviewDto.result == '합격'}">
						<c:set var="resultClass" value="pass" />
					</c:when>
					<c:when test="${reviewDto.result == '불합격'}">
						<c:set var="resultClass" value="fail" />
					</c:when>
					<c:otherwise>
						<c:set var="resultClass" value="pending" />
					</c:otherwise>
				</c:choose>
				<button type="button" class="result-tag ${resultClass}">
					${reviewDto.result}
				</button>
			</div>
			<h1 class="interview-title">${reviewDto.reviewTitle}</h1>
			<div class="interview-meta">
				<span class="author">${reviewDto.member.username}</span>
				<span class="date">${reviewDto.formattedReviewDate}</span>
				<span class="views">조회수: ${reviewDto.count}</span>
			</div>
		</div>

		<div class="format-toggle">
			<button type="button" class="toggle-btn active" data-format="free">자유 양식</button>
			<button type="button" class="toggle-btn" data-format="qa">질문-답변</button>
		</div>

		<!-- 자유 양식 섹션 -->
		<div id="free-format" class="question-container active">
			<div class="question-container">
				<div class="question-block">
					<div class="question">
						<span class="question-number">1</span>
						면접 분위기나 진행방식은 어떠했습니까?
					</div>
					<div class="answer">
						${reviewDto.atmosphere}
					</div>
				</div>

				<div class="question-block">
					<div class="question">
						<span class="question-number">2</span>
						면접에서 좋았던 점이나 아쉬웠던 점은 무엇입니까?
					</div>
					<div class="answer">
						${reviewDto.sorrow}
					</div>
				</div>

				<div class="question-block">
					<div class="question">
						<span class="question-number">3</span>
						면접 합격 팁이나 조언이 있다면?
					</div>
					<div class="answer">
						${reviewDto.advice}
					</div>
				</div>
			</div>
		</div>

		<!-- 질문-답변 섹션 -->
		<div id="qa-format" class="question-container">
			<c:forEach var="intro" items="${reviewWrites}">
				<div class="question-block">
					<div class="question">
						<span class="question-number">1</span>
							${intro.introQuestion}
					</div>
					<div class="answer">
							${intro.introAnswer}
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="modal">
	<div class="modal-content">
		<div class="modal-header">
			<h3 class="modal-title">게시글 삭제</h3>
		</div>
		<div class="modal-body">
			정말로 이 게시글을 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.
		</div>
		<div class="modal-actions">
			<button onclick="hideDeleteConfirm()" class="modal-button modal-cancel">취소</button>
			<button onclick = "location.href='${pageContext.request.contextPath}/review_board/remove/${reviewDTO.revie}" class="modal-button modal-confirm">삭제</button>
		</div>
	</div>
</div>

<script>
	document.addEventListener('DOMContentLoaded', function() {
		const toggleBtns = document.querySelectorAll('.toggle-btn');
		const freeFormat = document.getElementById('free-format');
		const qaFormat = document.getElementById('qa-format');

		toggleBtns.forEach(btn => {
			btn.addEventListener('click', function() {
				// 모든 버튼의 활성화 클래스 제거
				toggleBtns.forEach(b => b.classList.remove('active'));
				// 현재 클릭된 버튼 활성화
				this.classList.add('active');

				const format = this.dataset.format;
				if (format === 'free') {
					freeFormat.classList.add('active');
					qaFormat.classList.remove('active');
				} else {
					freeFormat.classList.remove('active');
					qaFormat.classList.add('active');
				}
			});
		});
	});

	function showDeleteConfirm() {
		document.getElementById('deleteModal').style.display = 'flex';
	}

	function hideDeleteConfirm() {
		document.getElementById('deleteModal').style.display = 'none';
	}

</script>
</body>
</html>