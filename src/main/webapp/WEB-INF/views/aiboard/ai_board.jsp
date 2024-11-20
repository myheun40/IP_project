<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>
<html>
<head>
    <title>IPro-AIInterview</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/aiboard/ai_board.css">
</head>
<body>
<jsp:include page="../navbar.jsp"/>

<!-- 배너 -->
<div class="jumbotron">
    <h1>AI 면접 준비</h1>
    <p class="lead">나에게 맞는 면접 질문 준비부터 실전 면접 연습까지!</p>
    <hr>
    <p class="lead">AI가 면접 질문 추출 및 답변을 도와주고 가상 면접 기회를 제공해요</p>
</div>

<!-- 메인 콘텐츠 -->
<div class="content d-flex flex-column align-items-center">

    <!-- 섹션 -->
    <section class="process" style="width:100%">
        <h4 class="h-title">면접 안내 및 시작하기</h4>
        <hr>
        <!-- 안내 섹션 -->
        <div class="guide-text d-flex flex-column align-items-center" style="text-align: center;">
            <div class="progress-container mb-4">
                <div class="progress-stage green-border">Stage 1<br><span>자기소개서 입력</span></div>
                <div class="progress-stage green-border">Stage 2<br><span>질문 답변 및 피드백</span></div>
                <div class="progress-stage green-border">Stage 3<br><span>답변 확인 및 저장</span></div>
                <div class="progress-stage blue-border">Stage 4<br><span>영상 면접 응시</span></div>
                <div class="progress-stage blue-border">Stage 5<br><span>면접 내역 확인</span></div>
            </div>
            <p><span style="font-weight: bold;">맞춤 질문·답변 생성 (Stage 1~3):</span> 자기소개서를 입력하면 AI를 활용하여 맞춤형 질문과 답변을 준비할 수
                있습니다.</p>
            <p><span style="font-weight: bold;">가상 영상 면접 (Stage 4~5):</span> 가상 영상 면접을 통해 면접 경험을 쌓고, 면접 내역을 확인할 수 있습니다.
            </p>

        </div>
        <div class="container mb-5">
            <form action="${pageContext.request.contextPath}/aiboard/ai_custominfo" method="get" class="card-form">
                <button type="submit" id="box1" class="card">
                    <div class="card-body">
                        <h4 class="box-title">맞춤 질문·답변<br>생성하기</h4>
                        <!-- 동그라미 화살표 버튼 추가 -->
                        <div class="circle-arrow">
                            <i class="arrow-icon">&#10132;</i> <!-- 화살표 아이콘 -->
                        </div>
                    </div>
                </button>
            </form>

            <form action="${pageContext.request.contextPath}/aiboard/ai_preparation" method="get" class="card-form">
                <button type="submit" id="box2" class="card">
                    <div class="card-body">
                        <h4 class="box-title">가상 영상 면접<br> 보러가기</h4>
                        <!-- 동그라미 화살표 버튼 추가 -->
                        <div class="circle-arrow">
                            <i class="arrow-icon">&#10132;</i> <!-- 화살표 아이콘 -->
                        </div>
                    </div>
                </button>
            </form>
        </div>


    </section>


</div>


<jsp:include page="../footer.jsp"/>
</body>
</html>
