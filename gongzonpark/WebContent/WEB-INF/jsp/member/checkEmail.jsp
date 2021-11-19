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
					이메일 인증
				</h4>
			</div>
		</section>
		<section class="article">
			<div class="detailWrap mx-auto my-5 p-0 text-center">
				<i class="fas fa-envelope-open-text display-1 text-info mb-4"></i>
				<h4 class="m-2"></h4><h4 class="mb-2">이메일 인증이 완료되었습니다.</h4>		
				<p class="mb-4">
					게시글과 댓글 작성 및 수정이 가능합니다.<br>
				</p>
				<div class="mx-auto bg-light border border-muted rounded p-3 text-left text-muted small">
					<p class="mb-0 text-center">
						만약 이메일 인증 전 해당 이메일이 아닌 다른 이메일로 변경하신 경우, <br>
						이메일 인증이 완료되었다고 안내되나, 이는 해당 이메일에 대한 인증이므로 <br>
						변경하신 이메일로 다시 인증해 주셔야 합니다.
					</p>
				</div>
				<div class="mt-5">
					<button onclick="location.href='${pageContext.request.contextPath}/index.html'" class="twoButton btn btn-info">메인화면</button>
					<button onclick="location.href='${pageContext.request.contextPath}/login'" class="twoButton btn btn-info">로그인</button>
				</div>
			</div>
		</section>
	</main>	
	<jsp:include page="../common/footer.jsp" />	
</body>
</html>