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
			<div class="detailWrap mx-auto p-0">
			   	<c:choose>
	       			<c:when test="${empty member}">
	               		<div class="col my-5 text-center text-danger">입력하신 정보와 일치하는 회원이 없습니다.</div>
						<div class="text-center">
							<button class="twoButton btn btn-info d-inline mb-5" onclick="location.href='${pageContext.request.contextPath}/findpwd'">비밀번호 찾기</button>
							<button class="twoButton btn btn-info d-inline mb-5" onclick="location.href='${pageContext.request.contextPath}/contract'">회원가입</button>
						</div>
	            	</c:when>
	       			<c:otherwise>
	       				<div class="col mx-auto my-5 p-0 text-center">
							<p><span class="text-info">임시 비밀번호</span>를 이메일로 보내드렸습니다.</p>
						</div>
						<p class="col text-center text-secondary small mb-5">
		               		임시 비밀번호로 로그인 하신 후 <br>
		               		[마이페이지 > 회원정보] 메뉴에서 비밀번호를 변경해주세요. <br>
		               		메일이 수신 되지 않은 경우 스팸메일함을 확인해주세요. <br>
		               		수신이 불가능한 이메일인 경우 고객센터로 문의해주시기 바랍니다.
	               		<p>
	               		<div class="text-center">
		               		<button onclick="location.href='${pageContext.request.contextPath}/index.html'" class="twoButton btn btn-info d-inline mb-5">메인화면</button>
		               		<button onclick="location.href='${pageContext.request.contextPath}/login?url='" class="twoButton btn btn-info d-inline mb-5">로그인</button>
	               		</div>
	           		</c:otherwise>
	       		</c:choose>
			</div>
		</section>	
	</main>
	<jsp:include page="../common/footer.jsp" />	
</body>
</html>