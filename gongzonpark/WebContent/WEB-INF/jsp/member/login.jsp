<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
					로그인
				</h4>
			</div>
		</section>
		<section class="article">
			<div class="detailWrap mx-auto p-0">
				<form method="post" class="form-group m-0">
					<fieldset>
						<input type="hidden" name="url" value="${param.url}" />
						<label for="loginId"><span class="text-danger">* </span>아이디</label>
						<input type="text" name="id" id="loginId" class="form-control mb-4" title="아이디를 입력하세요." required />
						<label for="loginPwd"><span class="text-danger">* </span>비밀번호</label>
						<input type="password" name="pwd" id="loginPwd" class="form-control mb-4" title="비밀번호를 입력하세요." required />
						<div class="msg text-center text-danger small" id="loginFailMsg"></div>
						<label class="my-4"><input type="checkbox" name="savedId" id="savedId"/> 아이디 저장</label>
						<button class="col btn btn-info" id="btnLogin">로그인</button>
					</fieldset>
				</form>
			</div>
		</section>
	</main>	
	<jsp:include page="../common/footer.jsp" />
</body>
<script>
	$(function() {
		if($.cookie("savedId")) {
			$("#loginId").val($.cookie("savedId"));
			$("#savedId").prop("checked", true);
		}
		if("${param.msg}" == 'fail') {
			$("#loginFailMsg").text("아이디 또는 비밀번호 입력이 올바르지 않습니다.");
		}
	});
</script>
</html>