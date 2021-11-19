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
					마이페이지
				</h4>
			</div>
		</section>
		<section class="article">
			<div class="detailWrap mx-auto p-0">
				<div class="text-center mb-4">개인정보 보호를 위해 <span class="text-info">비밀번호</span>를 다시 한번 확인합니다.</div>
				<form method="post" class="form-group m-0">
					<fieldset>
						<label><span class="text-danger">* </span>아이디</label>
						<input type="text" name="id" class="form-control mb-4 bg-light" placeholder="${member.id}" readonly />
						<label for="memberCheckPwd"><span class="text-danger">* </span>비밀번호</label>
						&nbsp;<span class="msg text-danger small" id="checkFailMsg"></span>
						<input type="password" name="pwd" id="checkMemberPwd" class="form-control" required />
						<button class="col btn btn-info mt-5" id="btnCheckPwd">확인</button>
					</fieldset>
				</form>
			</div>
		</section>
	</main>
	<jsp:include page="../common/footer.jsp" />	
</body>
<script>
	var memberPwd = "${member.pwd}";
	$("#checkMemberPwd").focus();
	$(function() {
		$("#btnCheckPwd").on("click", function(e) {
			e.preventDefault();
			var checkMemberPwd = $("#checkMemberPwd").val();
			var result = memberPwd === checkMemberPwd ? true : false;
			if(result) {
				$("#checkFailMsg").text("");
				$("#btnCheckPwd").unbind(e);
			    $("#btnCheckPwd").click();
			}
			else {
				if(checkMemberPwd) {
					$("#checkFailMsg").text("비밀번호가 일치하지 않습니다. 정확히 입력해 주세요.")
				}
				else {
					$("#checkFailMsg").text("비밀번호를 입력하세요.")
					$("#checkMemberPwd").focus();
				}
			}
		});
	});
</script>
</html>