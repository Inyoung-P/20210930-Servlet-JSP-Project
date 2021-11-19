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
					<li class="list-inline-item m-0 p-0"><a href="findid" class="twoLink border border-muted rounded m-0 bg-light text-decoration-none text-info">아이디 찾기</a></li>
					<li class="list-inline-item m-0 p-0"><a href="findpwd" class="twoLink border border-muted rounded m-0 bg-light text-decoration-none text-secondary">비밀번호 찾기</a></li>
				</ul>
			</div>
			<div class="detailWrap mx-auto p-0">
			   	<c:choose>
	       			<c:when test="${empty member}">
	               		<div class="text-center text-danger my-5">입력하신 정보와 일치하는 아이디가 없습니다.</div>
						<div class="text-center">
							<button class="twoButton btn btn-info d-inline mb-5" onclick="location.href='${pageContext.request.contextPath}/findid'">아이디 찾기</button>
							<button class="twoButton btn btn-info d-inline mb-5" onclick="location.href='${pageContext.request.contextPath}/contract'">회원가입</button>
						</div>
	            	</c:when>
	       			<c:otherwise>
	               		<p class="col text-center my-5">입력하신 정보와 일치하는 아이디는 <span class="text-info" id="protectFindId"></span> 입니다.<p>
	               		<p class="col text-center text-secondary small mb-5">
		               		개인정보보호를 위하여 아이디 중 일부는 *로 표기됩니다. <br>
		               		전체 아이디를 보시려면 아래 [아이디 전체보기]를 클릭하세요. <br>
		               		회원님의 이메일로 아이디가 발송됩니다.
	               		<p>
	               		<div class="text-center">
		               		<button class="twoButton btn btn-info d-inline mb-5" id="btnSendID">아이디 전체보기</button>
		               		<button onclick="location.href='${pageContext.request.contextPath}/login?url='" class="twoButton btn btn-info d-inline mb-5" id="btnLogin">로그인</button>
	               		</div>
	           		</c:otherwise>
	       		</c:choose>
       			<div class="modal" id="LoadingLayerModal">
					<div class="modal-dialog text-center">
						<div class="spinner-border text-info mx-auto" id="LoadingLayer"></div>
						<p class="text-light mt-2">요청 중입니다. 잠시만 기다려 주세요.</p>
					</div>
				</div>
	    		<div class="modal fade" id="sendIDModal">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title">아이디 발송 완료</h4>
							</div>
							<div class="modal-body small">
								아이디를 "${member.email}"으로 발송하였습니다. <br>
								메일이 수신되지 않은 경우 스팸메일함을 확인해 주세요. <br>
								수신이 불가능한 이메일인 경우 고객센터로 문의해주시기 바랍니다.
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-info" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>	
	<jsp:include page="../common/footer.jsp" />			
</body>
<script>
	var cp = '${pageContext.request.contextPath}';
	var findId = "${member.id}";
	$(function() {
		// 아이디 찾기(일부)
		if(findId) {
			var findIdLength = findId.length;
			var protectFindId = findId.substring(0,3);
			for(var i = 0; i < findIdLength-3 ; i++) {
				protectFindId += '*'; 
			}
			$("#protectFindId").text(protectFindId);
		}
		// 전체 아이디 메일 발송
		$("#btnSendID").on("click", function(e) {
			$("#LoadingLayerModal").modal({keyboard: false, backdrop: 'static'});
			e.preventDefault();
			var id = "${member.id}";
			var email = "${member.email}";
			$.ajax(cp+"/sendId?id="+id+"&email="+email, {
				success: function() {
					$("#LoadingLayerModal").modal('hide');
					$("#sendIDModal").modal();
				}
			});
		})
	});
</script>
</html>