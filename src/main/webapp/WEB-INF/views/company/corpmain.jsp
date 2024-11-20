<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>

<title>기업 분석 메인</title>
<link rel="stylesheet" href="<c:url value='/resources/static/company/corpmain.css'/>">

<jsp:include page="../navbar.jsp"/>

<div class="jumbotron">
    <h1 class="display-4">기업 분석</h1>
    <p class="lead">AI가 분석해주는 SWOT · 최신 동향</p>
    <hr class="my-4">
    <div class="input-group mb-0 w-50 mx-auto">
        <input type="text" class="form-control" placeholder="기업명을 입력하세요" aria-label="Search" name="corp"
               id="corpInput" required
               value="${param.corp}"/>
        <button class="btn btn-toolbar btn-dark" id="searchButton" type="button" onclick="searchCompany()">Search</button>
    </div>
</div>

<div class="main-content pt-0">

    <div class="content mt-5">

        <div class="row row-cols-1 row-cols-md-5 g-4">
            <c:forEach var="vo" items="${list}" varStatus="i">
                <a href="<c:url value='${pageContext.request.contextPath}/company/corp?companyIdx=${vo.companyIdx}&corp=${vo.companyName}'/>"
                   class="text-decoration-none">
                    <div class="col">
                        <div class="card h-100">
                            <img src="<c:url value='/resources/static/img/${vo.img}'/>" class="card-img-top">
                            <div class="card-body">
                                <h5 class="card-title">${vo.companyName}</h5>
                                <p class="card-text1">${vo.companyType}</p>
                                <p class="card-text2">${vo.companyIndustry}</p>
                            </div>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
        <hr>
    </div>
</div>

<script type="text/javascript">
    function searchCompany() {
        // 검색어 가져오기
        const corpName = document.getElementById("corpInput").value;

        // 검색어가 비어 있는지 확인
        if (corpName.trim() === "") {
            alert("기업명을 입력해 주세요.");
            return;
        }

        // corp.jsp 페이지로 이동, 검색어를 파라미터로 전달
        window.location.href = `<c:url value='${pageContext.request.contextPath}/company/search'/>?companyName=` + encodeURIComponent(corpName);
    }
</script>

<%@ include file="../footer.jsp" %>
