<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<jsp:include page="../common/head.jsp" />
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	
	<main class="main">
		<section class="articleTitle">
			<div class="mx-auto">
				<h4 class="text-center m-0">
					회원가입
				</h4>
			</div>
		</section>
		<section class="article">
			<div class="joinProcess mx-auto text-center border border-muted rounded p-3">
				<ul class="list-inline text-muted m-0 p-0">
					<li class="list-inline-item text-info"><i class="far fa-check-square d-block text-center mb-1"></i><h6 class="d-block mb-0 small">STEP 01<br>약관동의</h6></li>
					<li class="list-inline-item" ><i class="fas fa-chevron-right"></i></li>
					<li class="list-inline-item"><i class="fas fa-edit d-block text-center mb-1"></i><h6 class="d-block mb-0 small">STEP 02<br>정보입력</h6></li>
					<li class="list-inline-item"><i class="fas fa-chevron-right"></i></li> 
					<li class="list-inline-item"><i class="fas fa-user-check d-block text-center mb-1"></i><h6 class="d-block mb-0 small">STEP 03<br>가입완료</h6></li> 
					<li class="list-inline-item"><i class="fas fa-chevron-right"></i></li> 
					<li class="list-inline-item"><i class="fas fa-envelope-open-text"></i><h6 class="d-block mb-0 small">STEP 04<br>메일인증</h6></li> 
				</ul>
			</div>		
			<div class="detailWrap contract mx-auto p-0">
				<div class="mb-4">
					<input type="checkbox" id="agree1" />
					<label class="mb-2" for="agree1"> 공존공원 이용약관 동의<span class="text-danger"> [필수]</span></label>
					<textarea class="form-control form-control-lg d-block p-2" readonly><jsp:include page="termsAndConditions.jsp" /></textarea>
				</div>
			 	<div class="mb-5">
					<input type="checkbox" id="agree2" />
			    	<label class="mb-2" for="agree2"> 개인정보 수집·이용 동의<span class="text-danger"> [필수]</span></label>
					<textarea class="form-control form-control-lg d-block p-2" readonly><jsp:include page="privacyPolicy.jsp" /></textarea>
				</div>
				<div>
					<input type="checkbox" id="agreeAll" />
					<label class="mb-2" for="agreeAll"> 이용약관과 개인정보 수집 및 이용에 모두 동의합니다. </label>
				</div>
				<form method="post"><button class="col btn btn-info mt-2" id="btnNext" disabled>회원가입</button></form>
			</div>		
		</section>
	</main>
	<jsp:include page="../common/footer.jsp" />
</body>
<script>
	$(function() {
		var agree1 = document.querySelector("#agree1");
		var agree2 = document.querySelector("#agree2");
		var agreeAll = document.querySelector("#agreeAll");
		var btnNext = document.querySelector("#btnNext");
		agreeAll.addEventListener("input", checkAll);
		function checkAll() {
			agree1.checked = agreeAll.checked;
			agree2.checked = agreeAll.checked;
		};
		setInterval(function() {
			var agree1stat = $("#agree1").is(":checked");
			var agree2stat = $("#agree2").is(":checked");
			agree1stat && agree2stat ? agreeAll.checked = true : agreeAll.checked = false;
			agree1stat && agree2stat ? btnNext.disabled = false : btnNext.disabled = true;
	    }, 10);
	});
</script>
</html>