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
					아이디/비밀번호 찾기
				</h4>
			</div>
		</section>
		<section class="article">
			<div class="findIdPwd mx-auto text-center p-3">
				<ul class="list-inline text-muted m-0 p-0">
					<li class="list-inline-item m-0 p-0"><a href="findid" class="twoLink border border-muted rounded m-0 bg-light text-decoration-none text-secondary">아이디 찾기</a></li>
					<li class="list-inline-item m-0 p-0"><a href="findpwd" class="twoLink border border-muted rounded m-0 bg-light text-decoration-none text-info">비밀번호 찾기</a></li>
				</ul>
			</div>
			<div class="detailWrap mx-auto">
				<form method="post" class="col mx-auto my-1 p-0 form-group m-0">
					<label for="searchPwdById"><span class="text-danger">* </span>아이디를 입력하세요.</label>
					<input type="text" name="id" id="searchPwdById" class="col form-control mb-4" required />
					<label for="searchPwdByEmail"><span class="text-danger">* </span>이메일을 입력하세요.</label>
					<input type="email" name="email" id="searchPwdByEmail" class="col form-control mb-5" required />
					<button class="col btn btn-info d-inline mb-5" id="btnFindPwd" onclick="findPwd()">비밀번호 찾기</button>
					<div class="modal" id="LoadingLayerModal">
						<div class="modal-dialog text-center">
							<div class="spinner-border text-info mx-auto" id="LoadingLayer"></div>
							<p class="text-light mt-2">요청 중입니다. 잠시만 기다려 주세요.</p>
						</div>
					</div>
				</form>
			</div>
		</section>
	</main>
	<jsp:include page="../common/footer.jsp" />	
</body>
<script>
	function findPwd() {
		$("#LoadingLayerModal").modal({keyboard: false, backdrop: 'static'});
	}
</script>
</html>