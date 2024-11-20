<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/notice/resourcewrite.css">
    <title>합격 후기 작성</title>
    <%@ include file="../header.jsp" %>
</head>
<body>

<jsp:include page="../navbar.jsp" />

<div class="main-content">
    <div class="container">
        <header class="header">
            <h1>취업 자료 등록</h1>
            <p>취업 준비에 도움이 되는 유용한 자료를 공유해주세요</p>
        </header>

        <form class="form-card" action="/notice/resource/write" method="post" enctype="multipart/form-data">
            <sec:csrfInput />

            <div class="metadata-section">
                <div class="metadata-grid">
                    <div class="input-group">
                        <label class="input-label">자료 구분</label>
                        <select class="input-field" name="category" required>
                            <option value="">선택해주세요</option>
                            <option value="interview">면접 준비</option>
                            <option value="resume">이력서/자소서</option>
                            <option value="coding">코딩테스트</option>
                            <option value="career">취업 전략</option>
                            <option value="company">기업 분석</option>
                            <option value="other">기타</option>
                        </select>
                    </div>

                    <div class="input-group">
                        <label class="input-label">대상 직무</label>
                        <input type="text" class="input-field" name="targetJob" placeholder="예: 개발자, 디자이너, 마케팅 등" required>
                    </div>
                </div>
            </div>

            <div class="content-section">
                <div class="input-group">
                    <label class="input-label">제목</label>
                    <input type="text" class="input-field" name="title" placeholder="제목을 입력해주세요" required>
                </div>

                <div class="input-group" style="margin-top: 1.5rem;">
                    <label class="input-label">내용</label>
                    <textarea class="content-textarea" name="content" placeholder="내용을 입력해주세요..." required></textarea>
                </div>

                <div class="input-group">
                    <label class="input-label">파일 첨부</label>
                    <input type="file" name="files" multiple class="input-field">
                    <p style="font-size: 0.85rem; color: #6B7280; margin-top: 0.25rem;">
                        * PDF, DOC, DOCX, PPT, PPTX, XLS, XLSX 파일만 업로드 가능 (최대 10MB)
                    </p>
                </div>

                <div class="input-group" style="margin-top: 1.5rem;">
                    <label class="input-label">태그</label>
                    <input type="text" class="input-field" id="tagInput" placeholder="태그를 입력하고 Enter를 눌러주세요">
                    <div class="tag-container" id="tagContainer"></div>
                    <input type="hidden" name="tags" id="tagsInput">
                </div>
            </div>

            <div class="form-buttons">
                <button type="button" class="btn btn-cancel">취소</button>
                <button type="submit" class="btn btn-submit">등록하기</button>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const tagInput = document.getElementById('tagInput');
        const tagContainer = document.getElementById('tagContainer');
        const tagsInput = document.getElementById('tagsInput');
        let tags = [];

        // Tag handling
        tagInput.addEventListener('keydown', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                const tag = this.value.trim();
                if (tag && !tags.includes(tag)) {
                    addTag(tag);
                    this.value = '';
                }
            }
        });

        function addTag(tag) {
            tags.push(tag);
            updateTags();
        }

        function removeTag(tag) {
            tags = tags.filter(t => t !== tag);
            updateTags();
        }

        function updateTags() {
            tagContainer.innerHTML = '';
            tags.forEach(tag => {
                const tagElement = document.createElement('span');
                tagElement.className = 'tag';
                tagElement.innerHTML = `
                        ${tag}
                        <button type="button" onclick="removeTag('${tag}')">&times;</button>
                    `;
                tagContainer.appendChild(tagElement);
            });
            tagsInput.value = JSON.stringify(tags);
        }

        // Make removeTag function globally accessible
        window.removeTag = removeTag;

        // Cancel button handling
        document.querySelector('.btn-cancel').addEventListener('click', function() {
            if (confirm('작성을 취소하시겠습니까? 작성중인 내용은 저장되지 않습니다.')) {
                window.location.href = '/notice/resourceboard';
            }
        });

        // Form submission
        document.querySelector('form').addEventListener('submit', function(e) {
            e.preventDefault();
            // Add your validation logic here
            this.submit();
        });
    });
</script>
</body>
</html>