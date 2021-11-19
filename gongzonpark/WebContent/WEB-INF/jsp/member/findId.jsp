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
					<li class="list-inline-item m-0 p-0"><a href="findid" class="twoLink border border-muted rounded m-0 bg-light text-decoration-none text-info">아이디 찾기</a></li>
					<li class="list-inline-item m-0 p-0"><a href="findpwd" class="twoLink border border-muted rounded m-0 bg-light text-decoration-none text-secondary">비밀번호 찾기</a></li>
				</ul>
			</div>	
			<div class="detailWrap mx-auto">
				<form method="post" class="mx-auto mb-5 p-0 form-group m-0">
					<label for="searchIdByName"><span class="text-danger">* </span>이름을 입력하세요.</label>
					<input type="text" name="name" id="searchIdByName" class="col form-control mb-4" required />
					<label for="searchIdByEmail"><span class="text-danger">* </span>이메일을 입력하세요.</label>
					<input type="email" name="email" id="searchIdByEmail" class="col form-control mb-5" required />
					<button class="col btn btn-info d-inline mb-5">아이디 찾기</button>
				</form>
			</div>
		</section>
	</main>
	
	<jsp:include page="../common/footer.jsp" />	
</body>
</html>