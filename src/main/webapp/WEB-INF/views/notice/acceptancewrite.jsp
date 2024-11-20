<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/notice/acceptancewrite.css">
    <title>합격 후기 작성</title>
    <%@ include file="../header.jsp" %>
</head>
<body>
<jsp:include page="../navbar.jsp" />
<!-- Main Content -->
<div class="main-content">
    <div class="container">
        <header class="header">
            <h1>합격 후기 작성</h1>
            <p>여러분의 소중한 합격 경험을 공유해주세요</p>
        </header>

        <form class="form-card" action="/acceptance/write" method="post" id="acceptanceForm">
            <sec:csrfInput />

            <div class="metadata-section">
                <div class="metadata-grid">
                    <div class="input-group">
                        <label class="input-label">시기</label>
                        <select class="input-field" name="period" required>
                            <option value="">선택해주세요</option>
                            <option value="2024-1">2024년 상반기</option>
                            <option value="2024-2">2024년 하반기</option>
                            <option value="2023-1">2023년 상반기</option>
                            <option value="2023-2">2023년 하반기</option>
                        </select>
                    </div>

                    <div class="input-group">
                        <label class="input-label">직무</label>
                        <input type="text" class="input-field" name="position" placeholder="직무명을 입력하세요" required>
                    </div>

                    <div class="input-group">
                        <label class="input-label">회사명</label>
                        <input type="text" class="input-field" name="company" placeholder="회사명을 입력하세요" required>
                    </div>

                    <div class="input-group">
                        <label class="input-label">경력구분</label>
                        <select class="input-field" name="careerLevel" required>
                            <option value="">선택해주세요</option>
                            <option value="신입">신입</option>
                            <option value="경력">경력</option>
                            <option value="인턴">인턴</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="title-section">
                <div class="input-group">
                    <label class="input-label">제목</label>
                    <input type="text" class="input-field" name="title" placeholder="게시글 제목을 입력해주세요" required>
                </div>
            </div>

            <div class="content-section">
                <div class="format-toggle">
                    <label class="input-label">작성 형식:</label>
                    <button type="button" class="toggle-btn active" data-format="free">자유 양식</button>
                    <button type="button" class="toggle-btn" data-format="qa">질문-답변</button>
                </div>

                <input type="hidden" name="formatType" id="formatType" value="free">

                <div id="free-format">
                    <div class="content-group">
                        <label class="content-label">합격 과정</label>
                        <textarea class="content-textarea" name="process" placeholder="전체적인 합격 과정을 설명해주세요 (서류 전형부터 최종 합격까지)..." required></textarea>
                    </div>

                    <div class="content-group">
                        <label class="content-label">합격 스펙</label>
                        <textarea class="content-textarea" name="spec" placeholder="합격에 도움이 된 스펙을 공유해주세요 (학력, 자격증, 경력 등)..." required></textarea>
                    </div>

                    <div class="content-group">
                        <label class="content-label">합격 꿀팁</label>
                        <textarea class="content-textarea" name="tip" placeholder="다른 지원자들에게 도움이 될 만한 팁을 공유해주세요..." required></textarea>
                    </div>
                </div>

                <div id="qa-format" style="display: none;">
                    <div id="questions-container">
                        <div class="question-section">
                            <label class="content-label">질문 1</label>
                            <input type="text" class="input-field" name="questions[0].question" placeholder="질문을 입력하세요">
                            <textarea class="content-textarea" name="questions[0].answer" placeholder="답변을 입력하세요..."></textarea>
                        </div>
                    </div>
                    <button type="button" class="add-question-btn">
                        질문 추가하기
                    </button>
                </div>

                <div class="form-buttons">
                    <button type="button" class="btn btn-cancel">취소</button>
                    <button type="submit" class="btn btn-submit">작성완료</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('acceptanceForm');
        const toggleBtns = document.querySelectorAll('.toggle-btn');
        const freeFormat = document.getElementById('free-format');
        const qaFormat = document.getElementById('qa-format');
        const addQuestionBtn = document.querySelector('.add-question-btn');
        const formatTypeInput = document.getElementById('formatType');
        let questionCounter = 1;

        // Format toggle
        toggleBtns.forEach(btn => {
            btn.addEventListener('click', function() {
                toggleBtns.forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                const format = this.dataset.format;
                formatTypeInput.value = format;

                if (format === 'free') {
                    freeFormat.style.display = 'block';
                    qaFormat.style.display = 'none';
                    // Enable required validation for free format
                    document.querySelectorAll('#free-format textarea').forEach(textarea => {
                        textarea.required = true;
                    });
                    // Disable required validation for Q&A format
                    document.querySelectorAll('#qa-format input, #qa-format textarea').forEach(element => {
                        element.required = false;
                    });
                } else {
                    freeFormat.style.display = 'none';
                    qaFormat.style.display = 'block';
                    // Enable required validation for Q&A format
                    document.querySelectorAll('#qa-format input, #qa-format textarea').forEach(element => {
                        element.required = true;
                    });
                    // Disable required validation for free format
                    document.querySelectorAll('#free-format textarea').forEach(textarea => {
                        textarea.required = false;
                    });
                }
            });
        });

        // Add question
        addQuestionBtn.addEventListener('click', function() {
            const newQuestion = document.createElement('div');
            newQuestion.className = 'question-section';
            newQuestion.innerHTML = `
                    <label class="content-label">질문 ${questionCounter + 1}</label>
                    <input type="text" class="input-field" name="questions[${questionCounter}].question" placeholder="질문을 입력하세요" required>
                    <textarea class="content-textarea" name="questions[${questionCounter}].answer" placeholder="답변을 입력하세요..." required></textarea>
                `;
            document.getElementById('questions-container').appendChild(newQuestion);
            questionCounter++;
        });

        // Cancel button
        document.querySelector('.btn-cancel').addEventListener('click', function() {
            if (confirm('작성을 취소하시겠습니까? 작성중인 내용은 저장되지 않습니다.')) {
                window.location.href = '/notice/noticeboard';  // Redirect to list page
            }
        });

        // Form submission
        form.addEventListener('submit', function(e) {
            e.preventDefault();

            // Validate based on current format
            const currentFormat = formatTypeInput.value;
            let isValid = true;

            if (currentFormat === 'free') {
                // Validate free format fields
                const requiredFields = form.querySelectorAll('#free-format textarea[required]');
                requiredFields.forEach(field => {
                    if (!field.value.trim()) {
                        isValid = false;
                        field.classList.add('error');
                    }
                });
            } else {
                // Validate Q&A format fields
                const questions = form.querySelectorAll('#qa-format input[required]');
                const answers = form.querySelectorAll('#qa-format textarea[required]');
                [...questions, ...answers].forEach(field => {
                    if (!field.value.trim()) {
                        isValid = false;
                        field.classList.add('error');
                    }
                });
            }

            if (!isValid) {
                alert('모든 필수 항목을 입력해주세요.');
                return;
            }

            // If validation passes, submit the form
            this.submit();
        });
    });
</script>
</body>
</html>