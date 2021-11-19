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
					<li class="list-inline-item"><i class="far fa-check-square d-block text-center mb-1"></i><h6 class="d-block mb-0 small">STEP 01<br>약관동의</h6></li>
					<li class="list-inline-item" ><i class="fas fa-chevron-right"></i></li>
					<li class="list-inline-item text-info"><i class="fas fa-edit d-block text-center mb-1"></i><h6 class="d-block mb-0 small">STEP 02<br>정보입력</h6></li>
					<li class="list-inline-item"><i class="fas fa-chevron-right"></i></li> 
					<li class="list-inline-item"><i class="fas fa-user-check d-block text-center mb-1"></i><h6 class="d-block mb-0 small">STEP 03<br>가입완료</h6></li> 
					<li class="list-inline-item"><i class="fas fa-chevron-right"></i></li> 
					<li class="list-inline-item"><i class="fas fa-envelope-open-text"></i><h6 class="d-block mb-0 small">STEP 04<br>메일인증</h6></li> 
				</ul>
			</div>	
			<div class="detailWrap mx-auto p-0">
				<form method="post" class="form-group m-0">
					<fieldset>
						<label for="joinId"><span class="text-danger">* </span>아이디</label>
						<i class="far fa-question-circle text-muted small" title="5~15자의 영문 소문자와 숫자만 사용 할 수 있습니다. 아이디는 회원가입 후 수정이 불가능합니다."></i>
						&nbsp;<span class="msg text-danger small" id="joinIdMsg"></span>
						<input type="text" name="id" id="joinId" class="form-control mb-3" title="아이디를 입력하세요." required />
						
						<label for="joinPwd"><span class="text-danger">* </span>비밀번호</label>
						<i class="far fa-question-circle text-muted small" title="8~16자의 영문과 숫자만 사용 할 수 있습니다. 비밀번호는 회원가입 후 수정이 가능합니다."></i>
						&nbsp;<span class="msg text-danger small" id="joinPwdMsg"></span>
						<input type="password" name="pwd" id="joinPwd" class="form-control mb-3" title="비밀번호를 입력하세요." required />
						
						<label for="joinPwdCk"><span class="text-danger">* </span>비밀번호 재확인</label>&nbsp;<span class="msg text-danger small" id="joinPwdCkMsg"></span>
						<input type="password" name="pwdCk" id="joinPwdCk" class="form-control mb-3" title="비밀번호를 한 번 더 입력하세요." required />
						
						<label for="joinEmail"><span class="text-danger">* </span>이메일</label>
						<i class="far fa-question-circle text-muted small" title="입력하신 주소로 인증을 위한 메일이 발송 됩니다. 수신 가능한 메일주소를 입력해 주세요. 이메일은 회원가입 후 수정이 가능합니다."></i>
						&nbsp;<span class="msg text-danger small" id="joinEmailMsg"></span>
						<input type="email" name="email" id="joinEmail" class="form-control mb-3" title="이메일을 입력하세요." required />
		
						<label for="joinName"><span class="text-danger">* </span>이름</label>
						<i class="far fa-question-circle text-muted small" title="2~20자의 한글과 영문를 사용 할 수 있습니다. 이름은 회원가입 후 수정이 불가능합니다."></i>
						&nbsp;<span class="msg text-danger small" id="joinNameMsg"></span>
						<input type="text" name="name" id="joinName" class="form-control mb-3" required />
						
						<label for="joinNickname"><span class="text-danger">* </span>별명</label>
						<i class="far fa-question-circle text-muted small" title="2~10자의 한글, 영문, 숫자를 사용 할 수 있습니다. 별명은 회원가입 후 수정이 가능합니다."></i>
						&nbsp;<span class="msg text-danger small" id="joinNicknameMsg"></span>
						<input type="text" name="nickname" id="joinNickname" class="form-control mb-5" required />
						<button class="col btn btn-info" id="btnJoin" onclick="join()" disabled>회원가입</button>
					</fieldset>
				</form>
			</div>
			<div class="modal" id="LoadingLayerModal">
				<div class="modal-dialog text-center">
					<div class="spinner-border text-info mx-auto" id="LoadingLayer"></div>
					<p class="text-light mt-2">요청 중입니다. 잠시만 기다려 주세요.</p>
				</div>
			</div>
		</section>
	</main>
	
	<jsp:include page="../common/footer.jsp" />
</body>
<script>
	var cp = '${pageContext.request.contextPath}';
	$(function() {
		var joinId = document.querySelector("#joinId");
		var joinPwd = document.querySelector("#joinPwd");
		var joinPwdCk = document.querySelector("#joinPwdCk");
		var joinEmail = document.querySelector("#joinEmail");
		var joinName = document.querySelector("#joinName");
		var joinNickname = document.querySelector("#joinNickname");
		
		var btnJoin = document.querySelector("#btnJoin");
			
		var joinIdChek = false;
		var joinPwdCheck = false;
		var joinPwdCkCheck = false;
		var joinEmailCheck = false;
		var joinNameCheck = false;
		var joinNicknameCheck = false;
	    
		inIt();
		function inIt() {
			joinId.addEventListener("input", idValid);
			joinPwd.addEventListener("input", pwdValid);
			joinPwdCk.addEventListener("input", pwdCkValid);
			joinEmail.addEventListener("input", emailValid);
			joinName.addEventListener("input", nameValid);
			joinNickname.addEventListener("input", nicknameValid);
			setInterval(function() {
		    	joinIdChek && joinPwdCheck && joinPwdCkCheck && joinEmailCheck && joinNameCheck && joinNicknameCheck ? btnJoin.disabled = false : btnJoin.disabled = true;
		    }, 10);
		};
		
		// 아이디 유효성 검사
		function idValid() {
			var id = $("#joinId").val();
			if(id) {
				$.ajax(cp+"/idValid?id="+id, {
					success: function(data1) {
						if(data1 == 0) {
							$("#joinIdMsg").text("");
							joinIdChek = true;
						}
						else if(data1 == 1) {
							$("#joinIdMsg").text("이미 사용 중이거나 탈퇴한 아이디입니다.");
							joinIdChek = false;
						}
						else if(data1 == 2) {
							$("#joinIdMsg").text("첫 글자는 영문 소문자만 사용 가능합니다.");
							joinIdChek = false;
						}
						else if(data1 == 3) {
							$("#joinIdMsg").text("5~15자 이내로 사용 가능합니다.");
							joinIdChek = false;
						}
						else if(data1 == 4) {
							$("#joinIdMsg").text("영문 소문자, 숫자만 사용 가능합니다.");
							joinIdChek = false;
						}
					}
				})
			}
		}
		// 비밀번호 유효성 검사
		function pwdValid() {
			var pwd = $("#joinPwd").val();
			if(pwd) {
				$.ajax(cp+"/pwdValid?pwd="+pwd, {
					success: function(data2) {
						if(data2 == 0){
							$("#joinPwdMsg").text("");
							joinPwdCheck = true;
						}
						else if(data2 == 1) {
							$("#joinPwdMsg").text("첫 글자는 영문만 사용 가능합니다.");
							joinPwdCheck = false;
						}
						else if(data2 == 2) {
							$("#joinPwdMsg").text("8~16자 이내로 사용 가능합니다.");
							joinPwdCheck = false;
						}
						else if(data2 == 3) {
							$("#joinPwdMsg").text("영문, 숫자만 사용 가능합니다.");
							joinPwdCheck = false;
						}
					}
				})
			}
		}
		// 비밀번호 재확인 유효성 검사
		function pwdCkValid() {
			var pwd = $("#joinPwd").val();
			var pwdCk = $("#joinPwdCk").val();
			if(pwd && pwdCk && pwd == pwdCk) {
				$("#joinPwdCkMsg").text("");
				joinPwdCkCheck = true;
			}
			else{
				$("#joinPwdCkMsg").text("비밀번호가 일치하지 않습니다.");
				joinPwdCkCheck = false;
			}
		}		
		// 이메일 유효성 검사
		function emailValid() {
			var email = $("#joinEmail").val();
			if(email) {
				$.ajax(cp+"/emailValid?email="+email, {
					success: function(data4) {
						if(data4 == 0) {
							$("#joinEmailMsg").text("");
							joinEmailCheck = true;
						}
						else if(data4 == 1) {
							$("#joinEmailMsg").text("이미 사용 중인 이메일입니다.");
							joinEmailCheck = false;
						}
					}
				})
			}
		}		
		// 이름 유효성 검사
		function nameValid() {
			var name = $("#joinName").val();
			if(name) {
				$.ajax(cp+"/nameValid?name="+name, {
					success: function(data5) {
						if(data5 == 0) {
							$("#joinNameMsg").text("");
							joinNameCheck = true;
						}
						else if(data5 == 1) {
							$("#joinNameMsg").text("2~20자 이내로 사용 가능합니다.");
							joinNameCheck = false;
						}
						else if(data5 == 2) {
							$("#joinNameMsg").text("한글과 영문만 사용 가능합니다.");
							joinNameCheck = false;
						}
					}
				})
			}
		}	
		// 별명 유효성 검사
		function nicknameValid() {
			var nickname = $("#joinNickname").val();
			if(nickname) {
				$.ajax(cp+"/nicknameValid?nickname="+nickname, {
					success: function(data6) {
						if(data6 == 0) {
							$("#joinNicknameMsg").text("");
							joinNicknameCheck = true;
						}
						else if(data6 == 1) {
							$("#joinNicknameMsg").text("이미 사용 중인 별명입니다.");
							joinNicknameCheck = false;
						}
						else if(data6 == 2) {
							$("#joinNicknameMsg").text("2~10자 이내로 사용 가능합니다.");
							joinNicknameCheck = false;
						}
						else if(data6 == 3) {
							$("#joinNicknameMsg").text("한글, 영문, 숫자만 사용 가능합니다.");
							joinNicknameCheck = false;
						}
					}
				})
			}
		}		
	});
	function join() {
		$("#LoadingLayerModal").modal({keyboard: false, backdrop: 'static'});
	}
</script>
</html>