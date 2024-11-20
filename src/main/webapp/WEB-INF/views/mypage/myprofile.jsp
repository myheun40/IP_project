<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="../header.jsp" %>
	<title>My Page</title>
	<link rel="stylesheet" href="<c:url value='/resources/static/mypage/myprofile.css'/>">
</head>
<body>
<jsp:include page="../navbar.jsp"/>

<div class="mypsidebar-container">

	<div class="main-content container-fluid">
		<div class="row g-0">
			<div class="col-2">
				<jsp:include page="mypagebar.jsp"/>
			</div>
			<div class="col-10">
				<div class="profile-header mb-4">
					<h2 class="page-header mb-4">
						프로필 정보
					</h2>
				</div>
				<div class="profile-container p-4">
					<!-- Profile Photo Section -->
					<div class="row mb-5">
						<div class="col-md-3">
							<div class="profile-photo-section text-center">
								<div class="position-relative d-inline-block">
									<img src="/resources/static/img/logo.svg" alt="프로필 사진" class="rounded-circle mb-2"
									     width="150" height="150">
								<button class="btn btn-sm btn-outline-primary position-absolute bottom-0 end-0" id="idprofile">
									변경
								</button>
								</div>
								<p class="text-muted mt-2">프로필 사진</p>
							</div>
						</div>
						<div class="col-md-3">
							<div class="member-id-section mb-3">
								<label for="memberId" class="form-label fw-bold">회원 ID</label>
								<input type="text" class="form-control" id="memberId" placeholder="회원 ID" readonly>
							</div>
						</div>
					</div>

					<!-- Education Section -->
					<div class="mb-4">
						<h4 class="mb-3">학력</h4>
						<div id="educationContainer">
							<div class="education-entry mb-3" id="education-0">
								<div class="row g-3">
									<div class="col-md-3">
										<label class="form-label">학교명</label>
										<input type="text" class="form-control" placeholder="학교명을 입력하세요">
									</div>
									<div class="col-md-3">
										<label class="form-label">전공</label>
										<input type="text" class="form-control" placeholder="전공을 입력하세요">
									</div>
									<div class="col-md-3">
										<label class="form-label">졸업상태</label>
										<select class="form-select">
											<option value="">선택하세요</option>
											<option value="graduated">졸업</option>
											<option value="attending">재학중</option>
											<option value="leave">휴학</option>
											<option value="dropout">중퇴</option>
										</select>
									</div>
									<div class="col-md-3 d-flex align-items-end">
										<button type="button" class="btn btn-outline-danger"
										        onclick="removeSection('education-0')">
											삭제
										</button>
									</div>
								</div>
							</div>
						</div>
						<button type="button" class="btn btn-outline-primary btn-sm" id="addEducation">+ 학력
							추가
						</button>
					</div>

					<!-- Career Section -->
					<div class="mb-4">
						<h4 class="mb-3">경력</h4>
						<div id="careerContainer">
							<div class="career-entry mb-3" id="career-0">
								<div class="row g-3">
									<div class="col-md-3">
										<label class="form-label">회사명</label>
										<input type="text" class="form-control" placeholder="회사명을 입력하세요">
									</div>
									<div class="col-md-3">
										<label class="form-label">직무</label>
										<input type="text" class="form-control" placeholder="직무를 입력하세요">
									</div>
									<div class="col-md-3">
										<label class="form-label">근무기간</label>
										<div class="input-group">
											<input type="number" class="form-control" placeholder="년">
											<input type="number" class="form-control" placeholder="개월">
										</div>
									</div>
									<div class="col-md-3 d-flex align-items-end">
										<button type="button" class="btn btn-outline-danger"
										        onclick="removeSection('career-0')">
											삭제
										</button>
									</div>
								</div>
							</div>
						</div>
						<button type="button" class="btn btn-outline-primary btn-sm" id="addCareer">+ 경력
							추가
						</button>
					</div>
					<!-- Technical Stack Section -->

					<div class="mb-4">
						<h4 class="mb-3">기술(스택)</h4>
						<div class="tech-stack-container">
							<!-- Selected Technologies Display -->
							<div class="selected-techs-container mb-3 p-3 border rounded">
								<div id="selectedTechStack" class="d-flex flex-wrap gap-2">
									<!-- Selected tech tags will appear here -->
								</div>
							</div>

							<!-- Technology Selection Buttons -->
							<div class="tech-categories mb-3">
								<!-- Frontend -->
								<div class="tech-category mb-3">
									<h6 class="mb-2">Frontend</h6>
									<div class="d-flex flex-wrap gap-2">
										<button type="button" class="btn btn-outline-secondary tech-btn" data-tech="HTML">HTML</button>

										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="CSS">CSS
										</button>
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="JavaScript">JavaScript
										</button>
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="React">React
										</button>
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="Vue.js">Vue.js
										</button>
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="Angular">Angular
										</button>
									</div>
								</div>

								<!-- Backend -->
								<div class="tech-category mb-3">
									<h6 class="mb-2">Backend</h6>
									<div class="d-flex flex-wrap gap-2">
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="Python">Python
										</button>
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="Java">Java
										</button>
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="Node.js">Node.js
										</button>
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="Spring">Spring
										</button>
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="Django">Django
										</button>
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="PHP">PHP
										</button>
									</div>
								</div>

								<!-- Database -->
								<div class="tech-category mb-3">
									<h6 class="mb-2">Database</h6>
									<div class="d-flex flex-wrap gap-2">
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="MySQL">MySQL
										</button>
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="PostgreSQL">PostgreSQL
										</button>
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="MongoDB">MongoDB
										</button>
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="Oracle">Oracle
										</button>
									</div>
								</div>

								<!-- DevOps -->
								<div class="tech-category mb-3">
									<h6 class="mb-2">DevOps</h6>
									<div class="d-flex flex-wrap gap-2">
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="Docker">Docker
										</button>
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="Kubernetes">Kubernetes
										</button>
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="AWS">AWS
										</button>
										<button type="button" class="btn btn-outline-secondary tech-btn"
										        data-tech="Git">Git
										</button>
									</div>
								</div>
								<div class="tech-category mb-3">
									<div class="d-flex align-items-center mb-2">
										<h6 class="mb-0 me-2">직접 입력</h6>
										<button type="button" class="btn btn-sm btn-outline-primary"
										        id="addCustomTechBtn">+
										</button>
									</div>
									<div id="customTechInput" class="custom-tech-input" style="display: none;">
										<div class="input-group mb-2" style="max-width: 300px;">
											<input type="text" class="form-control" id="newTechInput"
											       placeholder="기술 스택 입력">
											<button class="btn btn-primary" type="button" id="submitCustomTech">추가
											</button>
											<button class="btn btn-outline-secondary" type="button"
											        id="cancelCustomTech">취소
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- Preferred Location Section -->
					<div class="mb-4">
						<h4 class="mb-3">희망 취업지역</h4>
						<div class="row g-3">
							<div class="col-md-3">
								<select id="regionSelect" class="form-select">
									<option value="">시/도 선택</option>
									<option value="서울특별시">서울특별시</option>
									<option value="인천광역시">인천광역시</option>
									<option value="광주광역시">광주광역시</option>
									<option value="부산광역시">부산광역시</option>
									<option value="울산광역시">울산광역시</option>
									<option value="대전광역시">대전광역시</option>
									<option value="대구광역시">대구광역시</option>
									<option value="경기도">경기도</option>
									<option value="강원도">강원도</option>
									<option value="경상남도">경상남도</option>
									<option value="경상북도">경상북도</option>
									<option value="충청남도">충청남도</option>
									<option value="충청북도">충청북도</option>
									<option value="전라남도">전라남도</option>
									<option value="전라북도">전라북도</option>
									<option value="제주특별자치도">제주특별자치도</option>
									<option value="세종특별자치시">세종특별자치시</option>
								</select>
							</div>
							<div class="col-md-3">
								<select id="districtSelect" class="form-select">
									<option value="">구/군 선택</option>
									<!-- 시/도 선택 시 여기에 구/군이 동적으로 추가됩니다 -->
								</select>
							</div>
						</div>
					</div>

					<!-- Desired Salary Section -->
					<div class="mb-2">
						<h4 class="mb-3">희망 연봉</h4>
						<div class="row g-3">
							<div class="col-md-6">
								<div class="input-group">
									<input type="number" class="form-control" placeholder="희망 연봉을 입력하세요">
									<span class="input-group-text">만원</span>
								</div>
							</div>
						</div>
					</div>

					<!-- Employment Type Section -->
					<div class="mb-4">
						<h4 class="mb-3">희망 취업 유형</h4>
						<div class="row g-3">
							<div class="col-12">
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="fulltime">
									<label class="form-check-label" for="fulltime">정규직</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="contract">
									<label class="form-check-label" for="contract">계약직</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="intern">
									<label class="form-check-label" for="intern">인턴</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="freelance">
									<label class="form-check-label" for="freelance">프리랜서</label>
								</div>
							</div>
						</div>
					</div>

					<!-- Submit Buttons -->
					<div class="d-flex gap-2 justify-content-end">
						<button type="button" class="btn btn-secondary" id="editBtn">수정</button>
						<button type="button" class="btn btn-secondary" id="cancelBtn">취소</button>
						<button type="button" class="btn btn-primary" id="saveBtn">저장하기</button>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Initialize elements
        const selectedTechStack = document.getElementById('selectedTechStack');
        const techButtons = document.querySelectorAll('.tech-btn');
        const techCategories = document.querySelector('.tech-categories');
        const addCustomTechBtn = document.getElementById('addCustomTechBtn');
        const customTechInput = document.getElementById('customTechInput');
        const newTechInput = document.getElementById('newTechInput');
        const submitCustomTech = document.getElementById('submitCustomTech');
        const cancelCustomTech = document.getElementById('cancelCustomTech');
        const editBtn = document.getElementById('editBtn');
        const cancelBtn = document.getElementById('cancelBtn');
        const saveBtn = document.getElementById('saveBtn');

        let selectedTechs = new Set();
        let educationCounter = 0;
        let careerCounter = 0;

        // Initially hide cancel and save buttons
        if (cancelBtn) cancelBtn.style.display = 'none';
        if (saveBtn) saveBtn.style.display = 'none';

        // Education section
        document.getElementById('addEducation')?.addEventListener('click', function () {
            educationCounter++;
            const newEducation =
                '<div class="education-entry mb-3" id="education-' + educationCounter + '">' +
                '<div class="row g-3">' +
                '<div class="col-md-3">' +
                '<label class="form-label">학교명</label>' +
                '<input type="text" class="form-control" placeholder="학교명을 입력하세요">' +
                '</div>' +
                '<div class="col-md-3">' +
                '<label class="form-label">전공</label>' +
                '<input type="text" class="form-control" placeholder="전공을 입력하세요">' +
                '</div>' +
                '<div class="col-md-3">' +
                '<label class="form-label">졸업상태</label>' +
                '<select class="form-select">' +
                '<option value="">선택하세요</option>' +
                '<option value="graduated">졸업</option>' +
                '<option value="attending">재학중</option>' +
                '<option value="leave">휴학</option>' +
                '<option value="dropout">중퇴</option>' +
                '</select>' +
                '</div>' +
                '<div class="col-md-3 d-flex align-items-end">' +
                '<button type="button" class="btn btn-outline-danger" onclick="removeSection(\'education-' + educationCounter + '\')">' +
                '삭제' +
                '</button>' +
                '</div>' +
                '</div>' +
                '</div>';
            const educationContainer = document.getElementById('educationContainer');
            educationContainer.insertAdjacentHTML('beforeend', newEducation);
        });

        // Career section
        document.getElementById('addCareer')?.addEventListener('click', function () {
            careerCounter++;
            const newCareer =
                '<div class="career-entry mb-3" id="career-' + careerCounter + '">' +
                '<div class="row g-3">' +
                '<div class="col-md-3">' +
                '<label class="form-label">회사명</label>' +
                '<input type="text" class="form-control" placeholder="회사명을 입력하세요">' +
                '</div>' +
                '<div class="col-md-3">' +
                '<label class="form-label">직무</label>' +
                '<input type="text" class="form-control" placeholder="직무를 입력하세요">' +
                '</div>' +
                '<div class="col-md-3">' +
                '<label class="form-label">근무기간</label>' +
                '<div class="input-group">' +
                '<input type="number" class="form-control" placeholder="년">' +
                '<input type="number" class="form-control" placeholder="개월">' +
                '</div>' +
                '</div>' +
                '<div class="col-md-3 d-flex align-items-end">' +
                '<button type="button" class="btn btn-outline-danger" onclick="removeSection(\'career-' + careerCounter + '\')">' +
                '삭제' +
                '</button>' +
                '</div>' +
                '</div>' +
                '</div>';
            const careerContainer = document.getElementById('careerContainer');
            careerContainer.insertAdjacentHTML('beforeend', newCareer);
        });

        // Tech stack functions
        function addTechStack(tech) {
            if (selectedTechs.has(tech)) return;

            const tag = document.createElement('div');
            tag.className = 'tech-tag';
            tag.innerHTML =
                '<span class="tech-name">' +
                tech +
                '</span>' +
                '<button type="button" class="delete-tech" aria-label="Remove ' + tech + '">×</button>';

            tag.querySelector('.delete-tech').addEventListener('click', () => {
                selectedTechs.delete(tech);
                tag.remove();
                updateButtonStates();
            });

            selectedTechStack.appendChild(tag);
            selectedTechs.add(tech);
            updateButtonStates();
        }

        function updateButtonStates() {
            techButtons.forEach(button => {
                const tech = button.dataset.tech;
                if (selectedTechs.has(tech)) {
                    button.disabled = true;
                    button.classList.add('selected');
                } else {
                    button.disabled = false;
                    button.classList.remove('selected');
                }
            });
        }

        // Tech button click handlers
        techButtons.forEach(button => {
            button.addEventListener('click', function () {
                const tech = this.getAttribute('data-tech');
                if (!selectedTechs.has(tech)) {
                    addTechStack(tech);
                }
            });
        });
        techCategories.style.display = 'none';
        techButtons.forEach(button => {
            button.style.display = 'none';
        });
        // Custom tech input handlers
        if (addCustomTechBtn) {
            addCustomTechBtn.addEventListener('click', function () {
                customTechInput.style.display = 'block';
                newTechInput.focus();
                addCustomTechBtn.style.display = 'none';
            });
        }

        function addCustomTechnology() {
            const techName = newTechInput.value.trim();
            if (techName && !selectedTechs.has(techName)) {
                addTechStack(techName);
                hideCustomTechInput();
            }
        }

        function hideCustomTechInput() {
            if (customTechInput) customTechInput.style.display = 'none';
            if (addCustomTechBtn) addCustomTechBtn.style.display = 'inline-block';
            if (newTechInput) newTechInput.value = '';
        }

        if (submitCustomTech) {
            submitCustomTech.addEventListener('click', addCustomTechnology);
        }

        if (cancelCustomTech) {
            cancelCustomTech.addEventListener('click', hideCustomTechInput);
        }

        if (newTechInput) {
            newTechInput.addEventListener('keypress', function (e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    addCustomTechnology();
                }
            });
        }

        // Form state management
        function setFieldsReadOnly(readonly) {
            // Handle input fields and selects
            document.querySelectorAll('input, select, textarea').forEach(element => {
                element.readOnly = readonly;
                if (element.tagName.toLowerCase() === 'select') {
                    element.disabled = readonly;
                }
            });

            // Handle checkbox inputs separately
            document.querySelectorAll('input[type="checkbox"]').forEach(checkbox => {
                checkbox.disabled = readonly;
            });

            // Handle tech categories visibility
            if (readonly) {
                techCategories.classList.remove('show');
            } else {
                techCategories.classList.add('show');
            }

            // Handle buttons visibility
            document.querySelectorAll('.btn-outline-primary, .btn-outline-danger').forEach(btn => {
                btn.style.display = readonly ? 'none' : 'inline-block';
            });

            // Tech buttons and delete buttons
            techButtons.forEach(button => {
                button.disabled = readonly;
            });

            document.querySelectorAll('.delete-tech').forEach(button => {
                button.style.display = readonly ? 'none' : 'inline-block';
            });

            // Custom tech input
            if (readonly) {
                if (addCustomTechBtn) addCustomTechBtn.style.display = 'none';
                if (customTechInput) customTechInput.style.display = 'none';
            } else {
                if (addCustomTechBtn) addCustomTechBtn.style.display = 'inline-block';
            }
        }

        // Initialize form in readonly state
        setFieldsReadOnly(true);

        // Edit button handler
        editBtn?.addEventListener('click', function () {
            if (cancelBtn) cancelBtn.style.display = 'block';
            if (saveBtn) saveBtn.style.display = 'block';
            if (editBtn) editBtn.style.display = 'none';

            // Show tech buttons and categories when editing
            techCategories.style.display = 'block';
            techButtons.forEach(button => {
                button.style.display = 'inline-block';
            });

            setFieldsReadOnly(false);
        });

        // Cancel button handler
        cancelBtn?.addEventListener('click', function () {
            if (cancelBtn) cancelBtn.style.display = 'none';
            if (saveBtn) saveBtn.style.display = 'none';
            if (editBtn) editBtn.style.display = 'block';

            // Hide tech buttons and categories when canceling
            techCategories.style.display = 'none';
            techButtons.forEach(button => {
                button.style.display = 'none';
            });

            setFieldsReadOnly(true);
        });
        // Save button handler
        saveBtn?.addEventListener('click', function () {
            if (cancelBtn) cancelBtn.style.display = 'none';
            if (saveBtn) saveBtn.style.display = 'none';
            if (editBtn) editBtn.style.display = 'block';

            // Hide tech buttons and categories when saving
            techCategories.style.display = 'none';
            techButtons.forEach(button => {
                button.style.display = 'none';
            });
            setFieldsReadOnly(true);
            alert('저장되었습니다!');
        });
    });
    const regions = {
        "서울특별시": [
            "강남구", "강동구", "강북구", "강서구", "관악구",
            "광진구", "구로구", "금천구", "노원구", "도봉구",
            "동대문구", "동작구", "마포구", "서대문구", "서초구",
            "성동구", "성북구", "송파구", "양천구", "영등포구",
            "용산구", "은평구", "종로구", "중구", "중랑구"
        ],
        "인천광역시": [
            "강화군", "계양구", "남동구", "동구", "미추홀구",
            "부평구", "서구", "연수구", "중구"
        ],
        "광주광역시": [
            "광산구", "남구", "동구", "북구", "서구"
        ],
        "부산광역시": [
            "강서구", "금정구", "남구", "동구", "동래구",
            "부산진구", "북구", "사상구", "사하구", "서구",
            "수영구", "연제구", "영도구", "중구", "해운대구"
        ],
        "울산광역시": [
            "남구", "동구", "북구", "중구", "울주군"
        ],
        "대전광역시": [
            "대덕구", "동구", "중구", "유성구", "서구"
        ],
        "대구광역시": [
            "남구", "달서구", "달성군", "동구", "북구",
            "서구", "수성구", "중구"
        ],
        "경기도": [
            "고양시 덕양구", "고양시 일산동구", "고양시 일산서구",
            "과천시", "광명시", "광주시", "구리시", "군포시",
            "김포시", "남양주시", "동두천시", "부천시", "성남시 수정구",
            "성남시 중원구", "성남시 분당구", "수원시 장안구", "수원시 권선구",
            "수원시 팔달구", "수원시 영통구", "시흥시", "안산시 단원구",
            "안산시 상록구", "안성시", "안양시 동안구", "안양시 만안구",
            "양주시", "양평군", "여주시", "연천군", "오산시", "용인시 기흥구",
            "용인시 수지구", "용인시 처인구", "의왕시", "의정부시", "이천시",
            "파주시", "평택시", "포천시", "하남시", "화성시"
        ],
        "강원도": [
            "강릉시", "동해시", "태백시", "속초시", "삼척시",
            "홍천군", "횡성군", "영월군", "평창군", "정선군",
            "철원군", "화천군", "양구군", "인제군", "고성군",
            "양양군"
        ],
        "경상남도": [
            "거제시", "양산시", "진주시", "창원시 마산합포구",
            "창원시 마산회원구", "창원시 성산구", "창원시 의창구",
            "창원시 진해구", "통영시", "사천시", "김해시", "밀양시",
            "함안군", "거창군", "합천군", "창녕군", "남해군",
            "하동군", "산청군", "의령군", "함양군"
        ],
        "경상북도": [
            "경주시", "포항시 남구", "포항시 북구", "안동시",
            "김천시", "구미시", "영주시", "영천시", "상주시",
            "문경시", "경산시", "군위군", "의성군", "청도군",
            "청송군", "영덕군", "영양군", "예천군", "봉화군",
            "울진군", "울릉군"
        ],
        "충청남도": [
            "천안시 동남구", "천안시 서북구", "공주시", "보령시",
            "아산시", "서산시", "논산시", "계룡시", "당진시",
            "금산군", "부여군", "서천군", "청양군", "홍성군",
            "예산군", "태안군"
        ],
        "충청북도": [
            "청주시 상당구", "청주시 서원구", "청주시 흥덕구",
            "충주시", "제천시", "보은군", "옥천군", "영동군",
            "증평군", "진천군", "괴산군", "음성군", "단양군"
        ],
        "전라남도": [
            "목포시", "여수시", "순천시", "나주시", "광양시",
            "담양군", "곡성군", "구례군", "고흥군", "보성군",
            "화순군", "장흥군", "강진군", "해남군", "영암군",
            "무안군", "함평군", "영광군", "장성군", "완도군",
            "진도군", "신안군"
        ],
        "전라북도": [
            "전주시 완산구", "전주시 덕진구", "군산시", "익산시",
            "정읍시", "남원시", "김제시", "완주군", "진안군",
            "무주군", "장수군", "임실군", "순창군", "고창군",
            "부안군"
        ],
        "제주특별자치도": [
            "제주시", "서귀포시", "남제주군", "북제주군"
        ],
        "세종특별자치시": [
            "세종특별자치시"
        ]
    };

    // 시/도 선택 시 구/군 선택 박스 업데이트 함수
    document.getElementById('regionSelect').addEventListener('change', function() {
        const selectedRegion = this.value;
        const districtSelect = document.getElementById('districtSelect');

        // 구/군 선택 박스 초기화
        districtSelect.innerHTML = '<option value="">구/군 선택</option>';

        if(selectedRegion && regions[selectedRegion]) {
            regions[selectedRegion].forEach(function(district) {
                const option = document.createElement('option');
                option.value = district;
                option.textContent = district;
                districtSelect.appendChild(option);
            });
        }
    });
    // Global function for removing sections
    function removeSection(id) {
        const section = document.getElementById(id);
        if (section) {
            section.remove();
        }
    }
</script>

</body>
</html>
