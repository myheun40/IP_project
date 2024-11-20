<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/member/join.css">
</head>
<body>
<jsp:include page="../navbar.jsp" />
<div class="form-container">
    <form action="${pageContext.request.contextPath}/member/join" method="post" id="joinForm">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <div class="container1">
	        <div class="brand-section">
		        <img src="<c:url value='/resources/static/img/white.PNG'/>" alt="lgLogo" class="lglogo">
		        <h1 class="login-title">AI 면접의 첫 걸음</h1>
	        </div>
            <div class="form-group">
                <label for="id">아이디</label>
            </div>
            <div class="form-group id-group">
                <input type="text" id="id" name="username"
                       value="${param.username}"
                       placeholder="아이디 입력"
                       required
                       oninput="checkIdInput()"
                       pattern="^[a-zA-Z0-9]{4,20}$"
                       title="4~20자의 영문, 숫자만 사용 가능합니다">
                <button type="button" class="id-check-btn" id="check-btn">중복확인</button>
                <span id="id-message" class="message"></span>
            </div>

            <div class="form-group">
                <label for="pw">비밀번호</label>
                <input type="password" id="pw" name="password"
                       placeholder="비밀번호"
                       required
                       pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$"
                       title="8자 이상의 영문, 숫자, 특수문자를 포함해야 합니다">
                <span id="pw-message" class="message"></span>
            </div>

            <div class="form-group">
                <label for="confirm-pw">비밀번호 확인</label>
                <input type="password" id="confirm-pw"
                       placeholder="비밀번호 확인"
                       required>
                <span id="confirm-pw-message" class="message"></span>
            </div>
        </div>

        <div class="container2">
	        <div class="brand-section">
		        <img src="<c:url value='/resources/static/img/white.PNG'/>" alt="lgLogo" class="lglogo">
		        <h1 class="login-title">AI 면접의 첫 걸음</h1>
	        </div>
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name"
                       value="${param.name}"
                       placeholder="이름 입력"
                       required>
            </div>

            <div class="form-group">
                <label for="phone">핸드폰 번호</label>
                <input type="tel" id="phone" name="phone"
                       value="${param.phone}"
                       placeholder="01012341234"
                       required
                       pattern="^01[0-9]{8,9}$"
                       title="올바른 핸드폰 번호를 입력해주세요">
                <span id="phone-message" class="message"></span>
            </div>

            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email"
                       value="${param.email}"
                       placeholder="ID@email.com"
                       required>
                <span id="email-message" class="message"></span>
            </div>
        </div>

        <button type="submit" class="signup-btn" disabled>회원가입</button>
    </form>
</div>

<script>
    // Initial setup
    document.addEventListener('DOMContentLoaded', function() {
        const container1 = document.querySelector('.container1');
        const container2 = document.querySelector('.container2');
        const signupBtn = document.querySelector('.signup-btn');

        // Hide container2 and signup button initially
        container2.style.display = 'none';
        signupBtn.style.display = 'none';

        // Add 'Next' button after container1
        const nextButton = document.createElement('button');
        nextButton.type = 'button';
        nextButton.className = 'next-btn';
        nextButton.textContent = '다음';
        nextButton.disabled = true;

        container1.insertAdjacentElement('afterend', nextButton);

        // Container 1 validation function
        function validateContainer1() {
            const id = document.getElementById('id');
            const pw = document.getElementById('pw');
            const confirmPw = document.getElementById('confirm-pw');

            const idMessage = document.getElementById('id-message');
            const pwMessage = document.getElementById('pw-message');
            const confirmPwMessage = document.getElementById('confirm-pw-message');

            const isIdValid = idMessage.style.color === 'green';
            const isPwValid = pwMessage.style.color === 'green';
            const isConfirmPwValid = confirmPwMessage.style.color === 'green';

            return isIdValid && isPwValid && isConfirmPwValid && isIdChecked;
        }

        // Update next button state
        function updateNextButton() {
            nextButton.disabled = !validateContainer1();
        }

        // Add event listeners to container1 inputs
        document.getElementById('id').addEventListener('input', updateNextButton);
        document.getElementById('pw').addEventListener('input', updateNextButton);
        document.getElementById('confirm-pw').addEventListener('input', updateNextButton);

        // Update next button when ID check is completed
        const originalFetch = window.fetch;
        window.fetch = function() {
            return originalFetch.apply(this, arguments)
                .then(response => {
                    response.clone().json().then(() => {
                        setTimeout(updateNextButton, 100);
                    });
                    return response;
                });
        };

        // Next button click handler
        nextButton.addEventListener('click', function() {
            if (validateContainer1()) {
                // Slide animation
                container1.style.transition = 'transform 0.5s, opacity 0.5s';
                container1.style.transform = 'translateX(-50px)';
                container1.style.opacity = '0';

                setTimeout(function() {
                    container1.style.display = 'none';
                    nextButton.style.display = 'none';

                    container2.style.display = 'block';
                    container2.style.transform = 'translateX(50px)';
                    container2.style.opacity = '0';

                    signupBtn.style.display = 'block';

                    requestAnimationFrame(function() {
                        container2.style.transition = 'transform 0.5s, opacity 0.5s';
                        container2.style.transform = 'translateX(0)';
                        container2.style.opacity = '1';
                    });
                }, 500);
            }
        });

        // Back to container1 when clicking browser's back button
        window.addEventListener('popstate', function() {
            if (container2.style.display === 'block') {
                showContainer1();
            }
        });

        // Add event listeners for container2 validation
        const container2Inputs = container2.querySelectorAll('input');
        container2Inputs.forEach(function(input) {
            input.addEventListener('input', updateSubmitButton);
        });
    });

    // Modify the existing updateSubmitButton function
    function updateSubmitButton() {
        const submitBtn = document.querySelector('.signup-btn');
        const name = document.getElementById('name').value;
        const phone = document.getElementById('phone').value;
        const email = document.getElementById('email').value;

        const phoneRegex = /^01[0-9]{8,9}$/;
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        const isValid =
            name.length > 0 &&
            phoneRegex.test(phone) &&
            emailRegex.test(email);

        submitBtn.disabled = !isValid;
    }

    // Add a function to show container1 (for back button)
    function showContainer1() {
        const container1 = document.querySelector('.container1');
        const container2 = document.querySelector('.container2');
        const nextButton = document.querySelector('.next-btn');
        const signupBtn = document.querySelector('.signup-btn');

        container2.style.display = 'none';
        signupBtn.style.display = 'none';

        container1.style.display = 'block';
        nextButton.style.display = 'block';

        container1.style.transform = 'translateX(0)';
        container1.style.opacity = '1';
    }


    let isIdChecked = false;

    function checkIdInput() {
        const idInput = document.getElementById("id").value;
        const checkBtn = document.getElementById("check-btn");
        const idMessage = document.getElementById("id-message");
        isIdChecked = false;

        if (idInput.length > 0) {
            checkBtn.style.display = "inline-block";
            idMessage.textContent = "중복확인이 필요합니다";
            idMessage.style.color = "red";
        } else {
            checkBtn.style.display = "none";
            idMessage.textContent = "";
        }
        updateSubmitButton();
    }

    // 비밀번호 실시간 검증
    document.getElementById('pw').addEventListener('input', function() {
        const pwMessage = document.getElementById('pw-message');
        const pwRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;

        if(pwRegex.test(this.value)) {
            pwMessage.textContent = "사용 가능한 비밀번호입니다";
            pwMessage.style.color = "green";
        } else {
            pwMessage.textContent = "8자 이상의 영문, 숫자, 특수문자를 포함해야 합니다";
            pwMessage.style.color = "red";
        }
        updateSubmitButton();
    });

    // 비밀번호 확인 실시간 검증
    document.getElementById('confirm-pw').addEventListener('input', function() {
        const confirmPwMessage = document.getElementById('confirm-pw-message');
        const pwValue = document.getElementById('pw').value;

        if(this.value === pwValue) {
            confirmPwMessage.textContent = "비밀번호가 일치합니다";
            confirmPwMessage.style.color = "green";
        } else {
            confirmPwMessage.textContent = "비밀번호가 일치하지 않습니다";
            confirmPwMessage.style.color = "red";
        }
        updateSubmitButton();
    });

    // 전화번호 실시간 검증
    document.getElementById('phone').addEventListener('input', function() {
        const phoneMessage = document.getElementById('phone-message');
        const phoneRegex = /^01[0-9]{8,9}$/;

        if(phoneRegex.test(this.value)) {
            phoneMessage.textContent = "올바른 전화번호 형식입니다";
            phoneMessage.style.color = "green";
        } else {
            phoneMessage.textContent = "올바른 전화번호 형식이 아닙니다";
            phoneMessage.style.color = "red";
        }
        updateSubmitButton();
    });

    // 이메일 실시간 검증
    document.getElementById('email').addEventListener('input', function() {
        const emailMessage = document.getElementById('email-message');
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if(emailRegex.test(this.value)) {
            emailMessage.textContent = "올바른 이메일 형식입니다";
            emailMessage.style.color = "green";
        } else {
            emailMessage.textContent = "올바른 이메일 형식이 아닙니다";
            emailMessage.style.color = "red";
        }
        updateSubmitButton();
    });

    // 중복확인 버튼 클릭 이벤트
    document.getElementById('check-btn').addEventListener("click", function() {
        const username = document.getElementById("id").value;
        const idMessage = document.getElementById("id-message");

        if(username.length < 4) {
            idMessage.textContent = "아이디는 4자 이상이어야 합니다";
            idMessage.style.color = "red";
            return;
        }

        fetch(`${pageContext.request.contextPath}/member/checkId?username=` + username)
            .then(response => response.json())
            .then(data => {
                if(data.available) {
                    idMessage.textContent = "사용 가능한 아이디입니다";
                    idMessage.style.color = "green";
                    isIdChecked = true;
                } else {
                    idMessage.textContent = "이미 사용중인 아이디입니다";
                    idMessage.style.color = "red";
                    isIdChecked = false;
                }
                updateSubmitButton();
            })
            .catch(error => {
                console.error('Error:', error);
                idMessage.textContent = "중복 확인 중 오류가 발생했습니다";
                idMessage.style.color = "red";
            });
    });

    // 회원가입 버튼 활성화 조건 확인
    function updateSubmitButton() {
        const submitBtn = document.querySelector(".signup-btn");
        const id = document.getElementById('id').value;
        const pw = document.getElementById('pw').value;
        const confirmPw = document.getElementById('confirm-pw').value;
        const name = document.getElementById('name').value;
        const phone = document.getElementById('phone').value;
        const email = document.getElementById('email').value;

        const pwRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
        const phoneRegex = /^01[0-9]{8,9}$/;
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        const isValid = isIdChecked &&
            pwRegex.test(pw) &&
            pw === confirmPw &&
            name.length > 0 &&
            phoneRegex.test(phone) &&
            emailRegex.test(email);

        submitBtn.disabled = !isValid;
    }

    // 폼 제출 전 최종 확인
    document.getElementById('joinForm').addEventListener('submit', function(e) {
        const idMessage = document.getElementById("id-message");

        if(!isIdChecked) {
            e.preventDefault();
            idMessage.textContent = "아이디 중복확인이 필요합니다";
            idMessage.style.color = "red";
            return;
        }

        const password = document.getElementById('pw').value;
        const confirmPassword = document.getElementById('confirm-pw').value;

        if(password !== confirmPassword) {
            e.preventDefault();
            alert("비밀번호가 일치하지 않습니다.");
            return;
        }
    });

    // 페이지 로드 시 초기 버튼 상태 설정
    window.addEventListener('load', updateSubmitButton);
</script>

</body>
</html>