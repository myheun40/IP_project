<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>check</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/aiboard/ai_makequestion.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>

<jsp:include page="../navbar.jsp"/>
<div class="jumbotron">
    <h1 class="display-4">AI 면접 준비</h1>
    <p class="lead">나에게 맞는 면접 질문부터 실전 연습까지</p>
    <hr>
    <p class="lead">나의 자기소개서를 기반으로 지원 기업 맞춤 면접 준비를 도와줘요</p>
</div>
<div class="content">
    <h4 class="h-title">3. 질문 및 답변 확인하기</h4>
    <h5>질문 답변 확인 > 저장</h5>

    <hr style="width:100%;">

    <!-- 질문 및 답변 테이블 -->
    <div class="container d-flex flex-column align-items-center mb-5">
        <div class="table-container">
            <table class="text-center" style="width:1000px">
                <colgroup>
                    <col style="width: 10%;">
                    <col style="width: 10%;">
                    <col style="width: 80%;">
                </colgroup>
                <thead>
                <tr>
                    <th colspan="3">면접 질문 및 답변</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td rowspan="3"><strong>기업/직무</strong></td>
                    <td><span class="tag" style="background-color: <c:out value="${not empty questions[0].IPRO_ANSWER ? '#28a745' : '#494949'}"/>;">
                        <c:choose>
                        <c:when test="${not empty questions[0].IPRO_ANSWER}">
                            답변완료
                        </c:when>
                        <c:otherwise>
                            미답변
                        </c:otherwise>
                    </c:choose></span></td>
                    <td>
                        <button class="accordion">${questions[0].IPRO_QUESTION}</button>
                        <div class="panel">
                            <p>${questions[0].IPRO_ANSWER}</p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><span class="tag" style="background-color: <c:out value="${not empty questions[1].IPRO_ANSWER ? '#28a745' : '#494949'}"/>;">
                                           <c:choose>
                                               <c:when test="${not empty questions[1].IPRO_ANSWER}">
                                                   답변완료
                                               </c:when>
                                               <c:otherwise>
                                                   미답변
                                               </c:otherwise>
                                           </c:choose>
                    </span></td>
                    <td>
                        <button class="accordion">${questions[1].IPRO_QUESTION}</button>
                        <div class="panel">
                            <p>${questions[1].IPRO_ANSWER}</p>
                        </div>
                    </td>
                </tr>
                <tr style="border-bottom:1px solid #edebeb">
                    <td><span class="tag"  style="background-color: <c:out value="${not empty questions[2].IPRO_ANSWER ? '#28a745' : '#494949'}"/>;">
                                           <c:choose>
                                               <c:when test="${not empty questions[2].IPRO_ANSWER}">
                                                   답변완료
                                               </c:when>
                                               <c:otherwise>
                                                   미답변
                                               </c:otherwise>
                                           </c:choose>
                    </span></td>
                    <td>
                        <button class="accordion">${questions[2].IPRO_QUESTION}</button>
                        <div class="panel">
                            <p>${questions[2].IPRO.ANSWER}</p>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td rowspan="3"><strong>자기소개서</strong></td>
                    <td><span class="tag"  style="background-color: <c:out value="${not empty questions[3].IPRO_ANSWER ? '#28a745' : '#494949'}"/>;">
                                           <c:choose>
                                               <c:when test="${not empty questions[3].IPRO_ANSWER}">
                                                   답변완료
                                               </c:when>
                                               <c:otherwise>
                                                   미답변
                                               </c:otherwise>
                                           </c:choose>
                    </span></td>
                    <td>
                        <button class="accordion">${questions[3].IPRO_QUESTION}</button>
                        <div class="panel">
                            <p>${questions[3].IPRO.ANSWER}</p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><span class="tag"  style="background-color: <c:out value="${not empty questions[4].IPRO_ANSWER ? '#28a745' : '#494949'}"/>;">
                          <c:choose>
                              <c:when test="${not empty questions[4].IPRO_ANSWER}">
                                  답변완료
                              </c:when>
                              <c:otherwise>
                                  미답변
                              </c:otherwise>
                          </c:choose>
                    </span></td>
                    <td>
                        <button class="accordion">${questions[4].IPRO_QUESTION}</button>
                        <div class="panel">
                            <p>${questions[4].IPRO.ANSWER}</p>

                        </div>
                    </td>
                </tr>
                <tr>
                    <td><span class="tag" style="background-color: <c:out value="${not empty questions[5].IPRO_ANSWER ? '#28a745' : '#494949'}"/>;">
                          <c:choose>
                              <c:when test="${not empty questions[5].IPRO_ANSWER}">
                                  답변완료
                              </c:when>
                              <c:otherwise>
                                  미답변
                              </c:otherwise>
                          </c:choose>
                    </span></td>
                    <td>
                        <button class="accordion">${questions[5].IPRO_QUESTION}</button>
                        <div class="panel">
                            <p>${questions[5].IPRO.ANSWER}</p>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>

        </div>
        <div>
            <button onclick="location.href='<%= request.getContextPath() %>/aiboard/ai_board'" type="button" class="btn btn-secondary">
                처음으로 돌아가기
            </button>
            <button onclick="location.href='<%= request.getContextPath() %>/aiboard/ai_preparation?selfIdx=${param.selfIdx}'"
                    type="submit" id="next"
                    class="btn btn-primary">
                영상면접 보러가기
            </button>

        </div>

    </div>

</div>
<jsp:include page="../footer.jsp"/>



<script>
    const questions = [
        <c:forEach var="question" items="${questions}" varStatus="status">
        {
            "idx": "${question['IPRO_IDX']}",
            "question": "${question['IPRO_QUESTION']}",
            "type": "${question['IPRO_TYPE']}",
            "answer": "${question['IPRO_ANSWER']}"
        }
        <c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    // 아코디언 버튼을 선택하여 답변 여부에 따라 활성화/비활성화 설정
    const acc = document.getElementsByClassName("accordion");

    for (let i = 0; i < acc.length; i++) {
        const answerStatus = questions[i].answer;

        // 답변 여부에 따라 아코디언 기능 활성화 여부 설정
        if (!answerStatus) {
            // 미답변 상태: 아코디언 비활성화 및 색상 설정
            acc[i].disabled = true;
        } else {
            // 답변 완료 상태: 아코디언 활성화 및 색상 설정
            acc[i].addEventListener("click", function () {
                this.classList.toggle("active");
                const panel = this.nextElementSibling;
                if (panel.style.maxHeight) {
                    panel.style.maxHeight = null;  // 축소
                } else {
                    panel.style.maxHeight = panel.scrollHeight + "px";  // 확장
                }
            });
        }
    }
</script>
</script>


</body>
</html>
