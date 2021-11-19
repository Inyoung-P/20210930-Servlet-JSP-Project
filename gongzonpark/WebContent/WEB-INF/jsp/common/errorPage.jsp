<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../common/head.jsp" />
</head>
<body>
<jsp:include page="headerIndex.jsp" />
	<section id="home"></section>
	<div class="modal" id="LoadingLayerModal">
		<div class="modal-dialog text-center">
			<p class="text-warning display-1"><i class="fas fa-exclamation-triangle"></i></p>
			<p class="text-light mt-2">
				죄송합니다. <br>
				세션이 만료되었거나 정상적인 접근이 아닙니다. <br>
				같은 문제가 여러번 반복된다면 고객센터로 문의하여 주시기 바랍니다.<br><br>
				<span class="text-warning">아무 곳이나 클릭하시면 메인화면으로 돌아갑니다.</span>
			</p>
		</div>
			</div>	
<jsp:include page="../common/footer.jsp" />
</body>
<script>
var cp = '${pageContext.request.contextPath}';
$(function() {
	init();
	function init() {
		$("#LoadingLayerModal").modal({keyboard: false, backdrop: 'static'});	
	}
	
	$(document).on("click", function(e) {
		location.href = cp + "/index.html";
	});
})
</script>
</html>