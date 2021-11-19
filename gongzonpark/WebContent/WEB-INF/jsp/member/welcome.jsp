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
					<li class="list-inline-item"><i class="fas fa-edit d-block text-center mb-1"></i><h6 class="d-block mb-0 small">STEP 02<br>정보입력</h6></li>
					<li class="list-inline-item"><i class="fas fa-chevron-right"></i></li> 
					<li class="list-inline-item text-info"><i class="fas fa-user-check d-block text-center mb-1"></i><h6 class="d-block mb-0 small">STEP 03<br>가입완료</h6></li> 
					<li class="list-inline-item"><i class="fas fa-chevron-right"></i></li> 
					<li class="list-inline-item"><i class="fas fa-envelope-open-text"></i><h6 class="d-block mb-0 small">STEP 04<br>메일인증</h6></li> 
				</ul>
			</div>	
			<div class="detailWrap mx-auto p-0 text-center">
				<h4 class="m-2">공존공원 회원으로</h4><h4 class="mb-3">가입해 주셔서 감사합니다.</h4>		
				<p class="mb-4">
					가입시 입력하신 메일주소로<br>
					이메일 인증을 위한 메일이 발송 되었습니다.<br>
					메일로 보내드린 링크주소로 이동하여 인증을 완료해 주세요.
				</p>
				<div class="bg-light border border-muted rounded p-3 text-left text-muted small">
					<ul class="pl-4 mb-0">
						<li>회원 가입 인증 메일이 수신 되지 않은 경우 스팸메일함을 확인해 주세요.</li>
						<li>회원가입이 완료되어 로그인이 가능하나 원할한 공존공원 사이트를 이용(게시글과 댓글 작성)하기 위해서는 이메일 인증이 필요합니다.</li>
						<li>메일 주소 변경이 필요한 경우 로그인 후 [마이페이지 > 회원정보] 메뉴에서 이메일을 변경하실 수 있습니다.</li>
						<li>회원 가입 인증 메일이 수신 되지 않은 경우 [마이페이지 > 회원정보] 메뉴에서 [인증메일 재발송]으로 다시 받으실 수 있습니다.</li>
					</ul>
				</div>
				<div class="mt-5">
					<button onclick="location.href='index.html'" class="twoButton btn btn-info">메인화면</button>
					<button onclick="location.href='login?url='" class="twoButton btn btn-info">로그인</button>	
				</div>
			</div>
			
		</section>
	</main>	
	<jsp:include page="../common/footer.jsp" />			
</body>
</html>