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
		<section id="portfolio" class="portfolio">
			<div class="container">
				<div class="section-title" data-aos="fade-in" data-aos-delay="100">
					<h2>회원탈퇴</h2>
					<div class="col-7 mx-auto my-5 p-0 text-center">
						<p class="text-left m-0 p-0">
							<i class="far fa-check-circle text-info"></i>&nbsp;탈퇴가 완료되면 사용하셨던 아이디 <span class="text-info">${member.id}</span>는 재사용 및 복구가 불가능합니다.<br><br>
							<i class="far fa-check-circle text-info"></i>&nbsp;탈퇴와 동시에 고객님의 개인정보(이름, 이메일, 닉네임, 프로필사진)는 삭제됩니다.<br><br>
							<i class="far fa-check-circle text-info"></i>&nbsp;탈퇴 후에도 게시판형 서비스에 등록한 게시물과 댓글은 그대로 남아 있습니다.<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;삭제를 원하는 게시글이 있다면 반드시 탈퇴 전 삭제하시기 바랍니다.<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="text-muted">탈퇴 후에는 회원정보가 삭제되어 본인 여부를 확인할 수 있는 방법이 없어,<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;게시글을 임의로 수정 또는 삭제를 해드릴 수 없습니다.</span>
						</p>
						<div>
							<input type="checkbox" id="agreeLeave" />
							<label class="my-5 text-info" for="agreeLeave" > 위 안내 사항을 모두 확인하였으며, 이에 동의합니다.</label>
						</div>
						<div>
							<button class="col-5 btn btn-secondary" title="공존공원의 회원이 되어주셔서 감사했습니다. 안녕히 가세요." id="btnLeave" disabled>회원탈퇴</button>
						</div>	
					</div>	
				</div>
			</div>
		</section>
		<div class="modal" id="LoadingLayerModal">
			<div class="modal-dialog text-center">
				<div class="spinner-border text-info mx-auto" id="LoadingLayer"></div>
				<p class="text-light mt-2">요청 중입니다. 잠시만 기다려 주세요.</p><br>
			</div>
		</div>
	</main>
	<jsp:include page="../common/footer.jsp" />	
</body>
<script>
	var cp = '${pageContext.request.contextPath}';
	$(function() {
		// 회원탈퇴 동의
		var agreeLeave = document.querySelector("#agreeLeave");
		var btnLeave = document.querySelector("#btnLeave");
		agreeLeave.addEventListener("input", changeBtn);
		function changeBtn() {
			var agreeLeaveResult = $("#agreeLeave").is(":checked");
			agreeLeaveResult ? btnLeave.disabled = false : btnLeave.disabled = true;
	    }
		
		// 회원탈퇴
		$("#btnLeave").on("click", function() {
			event.preventDefault();
			$("#LoadingLayerModal").modal({keyboard: false, backdrop: 'static'});
			var id = '${member.id}';
			$.ajax(cp+"/leave?id=" + id, {
				method:"post",
				success: function(data) {
					$("#LoadingLayerModal").modal('hide');
					location.href='index.html';
				}
			});
		});
	})
</script>
</html>