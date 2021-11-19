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
		<section class="portfolio-details">
			<div class="container">
				<div class="portfolio-details-container">
					<div class="owl-carousel portfolio-details-carousel">
	 						<c:forEach items="${board.attachs}" var="attach" varStatus="vs">
								<img src="${pageContext.request.contextPath}/display?filename=${attach.path}/${attach.uuid}" class="img-fluid" alt="${attach.origin}">
	 						</c:forEach>
					</div>
<!-- 					<div class="portfolio-info">
						<h3>시베리아 호랑이</h3>
						<ul>
							<li><strong>이름</strong>: </li>
							<li><strong>나이</strong>: </li>
							<li><strong>구조일</strong>: 11 MAY, 2021</li>
							<li><strong>구조장소</strong>: 대전 ○○월드</li>
						</ul>
					</div> -->
				</div>
				<div class="portfolio-description">
					<h2 class="d-inline" style="word-break: break-all"><c:out value="${board.title}" /></h2><span class="d-inline text-secondary">&nbsp;&nbsp;&nbsp;${board.regDate}</span>
					<div class="portfolio-details-container mt-5 mb-5">
						<div style="word-break: break-all; white-space: pre;" id="galleryContent"><c:out value="${board.content}"/></div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12 d-flex justify-content-end">
						<c:if test="${member.id == 'admin'}">
							<button class="portfolio-button-bottom mr-2 galleryModify" data-bno="${board.bno}"><i class="fas fa-pencil-alt"></i> 수정</button>
							<button class="portfolio-button-bottom mr-2 galleryDelete" data-bno="${board.bno}"><i class="far fa-trash-alt"></i> 삭제</button>
							<div class="modal fade" id="deleteGallerydModal">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-body text-center">
											글을 삭제하시겠습니까?<br>
											삭제된 글은 복구할 수 없습니다.
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-info btnDeleteGallery">확인</button>
											<button type="button" class="btn btn-secondary" data-dismiss="modal" id="batNo">취소</button>
										</div>
									</div>
								</div>
							</div>
						</c:if>
						<button class="portfolio-button-bottom " onclick="location.href='${pageContext.request.contextPath}/gallery/list'"><i class="far fa-list-alt"></i> 목록</button>
					</div>
				</div>
			</div>
		</section>
		
		<div class="replyBox container">
			<div class="replys">
				<div class="text-center ">
					<h5 class="d-inline"><i class="far fa-comment-dots fa-flip-horizontal"></i></span> 댓글 </h5><span class="d-inline text-muted" id="replyCount"></span>
				</div>
				<hr class="m-3 mb-4">
				<div class="replyList reply row"></div>
				<hr class="m-3">
				<c:choose>
					<c:when test="${empty member}">
						<div class="row mx-auto">
							<a href="${pageContext.request.contextPath}/login" class="loginLink">로그인하셔서 댓글을 남겨보세요.</a>
						</div>
					</c:when>
					<c:when test="${not empty member && member.emailChecked == 1}">
						<form id="frmReplyWrite">
							<div class="row">
								<div class="col-md-12">
									<div class="media">
										<c:choose>
											<c:when test="${empty member.profileUuid}">
												<img class="mr-3 rounded-circle" alt="프로필 사진" src="${pageContext.request.contextPath}/img/basic.jpg" />
											</c:when>
											<c:otherwise>
												<img class="mr-3 rounded-circle" alt="프로필 사진" src="${pageContext.request.contextPath}/display?filename=profileImg/s_${member.profileUuid}" />
											</c:otherwise>
										</c:choose>
										<div class="media-body">
											<div class="row">
												<div class="col-9 d-flex">
													<h5><strong><c:out value="${member.nickname}" /></strong></h5>
												</div>
												<div class="col-3">
													<div class="pull-right reply text-right">
														<button class="btn p-0 text-info" id="btnReplyWrite"><i class="far fa-check-circle"></i> 등록</button> 
													</div>
												</div>
											</div> 
											<textarea class="replyContent form-control" placeholder="댓글을 남겨보세요." name="content" id="replyContent" required></textarea>
										</div>
									</div>
								</div>
							</div>
						</form>
					</c:when>
					<c:otherwise>
							<div class="row mx-auto">
								<span class="text-info">이메일 인증을 완료하셔야 댓글을 남길 수 있습니다.</span>
							</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
       	<div class="modal" id="LoadingLayerModal">
			<div class="modal-dialog text-center">
				<div class="spinner-border text-info mx-auto" id="LoadingLayer"></div>
				<p class="text-light mt-2">요청 중입니다. 잠시만 기다려 주세요.</p>
			</div>
		</div>		
	</main>
	<jsp:include page="../common/footer.jsp" />
</body>
	<script>
		var cp = '${pageContext.request.contextPath}';
		var bno = '${param.bno}';
		var id= '${member.id}';
		$(function() {
			
			// 로그인 시 현재 주소값 같이 보내기
			$(".loginLink").on("click", function(e) {
				e.preventDefault();
				var url = cp + "/login?url=" + window.location.href;
				location.href=url;
			})
			
			// 댓글 불러오기
			showList(); 
			function showList() {
				var url = cp + "/reply/list?bno=" + bno;
				var replyCount = 0;
				$.getJSON(url).done(function(data1) {
					var str = "";
					for(var i in data1) {
						str += '		<div class="col-md-12 mb-3">';
						str += '			<div class="media">';
						if(data1[i].profileUuid == null) {
							str += '			<img class="mr-3 rounded-circle" alt="프로필 사진" src="'+cp+'/img/basic.jpg" />';
						}
						else {
							str += '			<img class="mr-3 rounded-circle" alt="프로필 사진" src="${pageContext.request.contextPath}/display?filename=profileImg/s_'+data1[i].profileUuid+'" />';
							
						}
						str += '				<div class="media-body" style="word-break: break-all">';
						str += '					<div class="row">';
						str += '						<div class="col-9 d-flex">';
						str += '							<h5><strong>'+data1[i].nickname+'</strong></h5>&nbsp;&nbsp;&nbsp;<span>'+data1[i].regDate+'</span>';
						if ('admin' == data1[i].id) {
							str += '						&nbsp;&nbsp;<span class="badge badge-dark my-1 mb-2">관리자</span>';	
						}
						str += '						</div>';
						if (id == data1[i].id) {
							str += '						<div class="col-3">';
							str += '							<div class="pull-right reply text-right">';
							str += '								<button class="btnReplyDelete btn p-0 text-info" data-rno="'+ data1[i].rno +'"><i class="far fa-trash-alt"></i> 삭제</button>';
							str += '							</div>';
							str += '						</div>';	
						}
						str += '					</div>';
						str += '					'+data1[i].content+' ';
						str += '				</div>';
						str += '			</div>';
						str += '		</div>';
						replyCount += 1;
					}
					$(".replyList").html(str);
					$("#replyCount").text(replyCount);
				});
			};
			
			// 댓글 작성 - 로그인했을 때 & 이메일 인증 했을 경우에만 보임
			$("#frmReplyWrite").submit(function() {
				event.preventDefault();
				var contentLen = $("#replyContent").val().trim().length;
				if(!contentLen) {
					$("#replyContent").focus().val('').attr('placeholder', '댓글에 공백만 입력할 수 없습니다.');
					return;
				}
	 			var reply = {};
				reply.content = $(this.content).val();
				reply.id = id;
				reply.bno = bno;
				var data = JSON.stringify(reply);
				var frm = this;
				var url = cp + "/reply";
				$.ajax(url, {
					method:"post",
					data: {"jsonData" : data},
					success: function(data) {
						showList();
						location.reload();
					}
				});
			});
			
			// 댓글 삭제 - 삭제 버튼은 작성자 본인일때만 보임
			$(document).on("click", ".btnReplyDelete", function(e) {
				e.preventDefault();
				var rno = $(this).data("rno");
				var url = cp + "/reply?rno=" + rno;
				$.ajax(url, {
					method:"delete",
					success: function(data3) {
						$("#LoadingLayerModal").modal('hide');
						showList();
					}
				});
			});
			
			// 글 삭제 - 삭제 버튼은 작성자 본인일때만 보임
			$(document).on("click", ".galleryDelete", function(e) {
				e.preventDefault();
				$("#deleteGallerydModal").modal();
			});
			
			// 글 삭제 모달창에서 확인
			$(document).on("click", ".btnDeleteGallery", function(e) {
				e.preventDefault();
				$("#deleteGallerydModal").modal('hide');
				var url = cp + "/gallery/delete?bno=" + bno;
				$.ajax(url, {
					method:"delete",
					success: function(data4) {
						location.href= cp + '/gallery/list';
					}
				});
			});
			
			// 글 수정 - 수정 버튼은 작성자 본인일때만 보임
			$(document).on("click", ".galleryModify", function(e) {
				e.preventDefault();
				var bno = $(this).data("bno");
				location.href = cp + "/gallery/modify?bno=" + bno;
			});
		})
	</script>
</html>