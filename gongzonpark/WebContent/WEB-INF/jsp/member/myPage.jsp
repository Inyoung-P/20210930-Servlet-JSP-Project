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
			<div class="detailWrap myPage mx-auto p-0">
				<form method="post" enctype="multipart/form-data" id="modifyProfileImg">
					<label>프로필</label>
					<i class="far fa-question-circle text-muted small" title="가로 세로가 같은 정사각형 사진 사용을 권장합니다."></i>
					&nbsp;<span class="msg text-right text-danger small m-0" id="modifyProfileImgMsg"></span>
					<div>
						<div class="profileImgBox d-inline-block mb-2">
							<c:choose>
								<c:when test="${empty member.profileUuid}">
									<img src="${pageContext.request.contextPath}/img/basic.jpg" alt="프로필 사진" id="profileImg">
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath}/display?filename=profileImg/s_${member.profileUuid}" alt="프로필 사진"  id="profileImg">
								</c:otherwise>
							</c:choose>
						</div>
						<div class="imgInput d-inline-block">
							<label for="image" class="m-0" title="사진 불러오기"></label>
							<input type="file" name="newProfileImg" id="image" accept="image/png, image/jpeg" onchange="setProfileImg(event);" />
						</div>
					</div>
					<button class="col btn btn-info mb-4" id="btnModifyProfileImg">프로필 변경</button>
				</form>
				<div class="modal fade" id="modifyProfileImgModal">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">프로필 변경 완료</h5>
							</div>
							<div class="modal-body text-center">
								프로필이 변경되었습니다.
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-info" data-dismiss="modal" id="closeModifyProfileModal">Close</button>
							</div>
						</div>
					</div>
				</div>
				<div>
					<label class="mt-4">아이디</label>
					<i class="far fa-question-circle text-muted small" title="아이디는 변경이 불가능합니다."></i>
					<input type="text" name="id" class="form-control mb-4 bg-white" value="${member.id}" readonly />
				</div>
				<div>
					<label for="newPwd" class="mt-4">비밀번호</label>
					<i class="far fa-question-circle text-muted small" title="8~16자의 영문과 숫자만 사용 할 수 있습니다."></i>
					&nbsp;<span class="msg text-right text-danger small m-0" id="modifyPwdMsg"></span>
					<input type="password" name="pwd" id="newPwd" class="form-control mb-3" placeholder="새 비밀번호" />
					<input type="password" name="pwd" id="newPwdCk" class="form-control mb-3" placeholder="비밀번호 재확인" />
					<button class="col btn btn-info mb-4" id="btnModifyPwd">비밀번호 변경</button>
					<div class="modal fade" id="modifyPwdModal">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">비밀번호 변경 완료</h5>
								</div>
								<div class="modal-body text-center">
									비밀번호가 변경되었습니다.
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-info" data-dismiss="modal" id="closeModifyPwdModal">Close</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div>
					<label for="newEmail" class="mt-4">이메일</label>
					<c:choose>
						<c:when test="${member.emailChecked == 1}">
							<span class="text-info small"> [인증완료]</span>
						</c:when>
						<c:when test="${member.emailChecked == 0}">
							<span class="text-danger small"> [미인증]</span>
						</c:when>
					</c:choose>
					<i class="far fa-question-circle text-muted small" title="이메일을 변경하시는 경우 변경된 이메일 주소로 인증 메일이 발송 됩니다. 이메일 인증이 완료될 때까지 게시판 이용(작성 및 수정)에 제한이 있습니다."></i>
					&nbsp;<span class="msg text-danger small" id="modifyEmailMsg"></span>
					<input type="email" name="email" id="newEmail" class="form-control mb-3" value="${member.email}" />
					<c:choose>
						<c:when test="${member.emailChecked == 1}">
							<button class="col btn btn-info mb-4" id="btnModifyEmail">이메일 변경</button>
						</c:when>
						<c:when test="${member.emailChecked == 0}">
							<button class="twoButton btn btn-info mb-4" id="resendCheckEmail">인증메일 재발송</button>
							<button class="twoButton btn btn-info mb-4" id="btnModifyEmail">이메일 변경</button>
						</c:when>
					</c:choose>
					<div class="modal fade" id="modifyEmailModal">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">이메일 변경 완료</h5>
								</div>
								<div class="modal-body text-center small">
									변경하신 메일주소로 인증을 위한 메일이 발송 되었습니다. <br>
									메일로 보내드린 링크주소로 이동하여 인증을 완료해 주세요. <br>
									인증 메일이 수신 되지 않은 경우 스팸메일함을 확인해 주세요. <br>
									[인증 메일 발송] 버튼을 눌러 메일을 다시 받으실 수 있습니다.
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-info" data-dismiss="modal" id="closeModifyEmailModal">Close</button>
								</div>
							</div>
						</div>
					</div>
					<div class="modal fade" id="resendCheckEmailModal">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">인증메일 재발송 완료</h5>
								</div>
								<div class="modal-body text-center small">
									인증메일을 "${member.email}"으로 재발송하였습니다. <br>
									메일로 보내드린 링크주소로 이동하여 인증을 완료해 주세요. <br>
									인증 메일이 수신되지 않은 경우 스팸메일함을 확인해 주세요. <br>
									또는 메일주소가 틀리지 않은지 확인해주시기 바랍니다.
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-info" data-dismiss="modal" id="closeResendCheckEmailModal">Close</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div>
					<label class="mt-4">이름</label>
					<i class="far fa-question-circle text-muted small" title="이름은 변경이 불가능합니다. 개명하신 경우 고객센터로 문의하여주시기 바랍니다."></i>
					<input type="text" name="name" class="form-control bg-white mb-4" value="${member.name}" readonly />
				</div>
				<div>
					<label for="newNickname" class="mt-4">별명</label>
					<i class="far fa-question-circle text-muted small" title="2~10자의 한글, 영문, 숫자를 사용 할 수 있습니다."></i>
					&nbsp;<span class="msg text-danger small" id="modifyNicknameMsg"></span>
					<input type="text" name="nickname" id="newNickname" class="form-control mb-3" value="${member.nickname}" />
					<button class="col btn btn-info mb-4" id="btnModifyNickname">별명 변경</button>
				</div>
				<div class="modal fade" id="modifyNicknameModal">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">별명 변경 완료</h5>
							</div>
							<div class="modal-body text-center">
								별명이 변경되었습니다.
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-info" data-dismiss="modal" id="closeModifyNicknameModal">Close</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col mx-auto mt-4 p-0">
					<button class="col btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/leave'">회원탈퇴</button>
				</div>
			</div>
		</section>
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
	//프로필 변경 ------------------------------------------------------------------------------------------------------
	var checkModifyProfileImg = false;
	function setProfileImg(event) {
		var reader = new FileReader();
		reader.onload = function(event) {
			$("#profileImg").attr("src", event.target.result);
			checkModifyProfileImg = true;
		}
		reader.readAsDataURL(event.target.files[0]);
	}

	$(function() {
		//프로필 변경
		$("#btnModifyProfileImg").on("click", function(e) {
			e.preventDefault();
			$("#LoadingLayerModal").modal({keyboard: false, backdrop: 'static'});
			if(checkModifyProfileImg) {
			    var form = $('#modifyProfileImg')[0];
			    var data = new FormData(form);
 			    $('#btnModifyProfileImg').prop('disabled', true);
			    $.ajax({
			        type: "POST",
			        enctype: 'multipart/form-data',
			        url: cp + "/modifyProfile",
			        data: data,
			        processData: false,
			        contentType: false,
			        cache: false,
			        timeout: 600000,
			        success: function (data) {
			        	$("#LoadingLayerModal").modal('hide');
			        	$('#btnModifyProfileImg').prop('disabled', false);
			        	$("#modifyProfileImgModal").modal();
			        }
			    });
			}
			else {
				$("#LoadingLayerModal").modal('hide');
				$("#modifyProfileImgMsg").text("프로필을 변경하시려면 카메라 아이콘을 클릭하여 이미지를 선택하세요.");
			}
		})
		$("#closeModifyProfileModal").on("click", function () {
			location.reload();
		})
		// 비밀번호 변경 ------------------------------------------------------------------------------------------------------
		
		$("#btnModifyPwd").on("click", function(e) {
			e.preventDefault();
			$("#LoadingLayerModal").modal({keyboard: false, backdrop: 'static'});
			var id = "${member.id}";
			var pwd = "${member.pwd}";
			var newPwd = $("#newPwd").val();
			var newPwdCk = $("#newPwdCk").val();
			if(!newPwd) {
				$("#LoadingLayerModal").modal('hide');
				$("#modifyPwdMsg").text("비밀번호를 변경하시려면 새 비밀번호를 입력하세요.");
				$("#newPwd").focus();
			}
			else if(!newPwdCk) {
				$("#LoadingLayerModal").modal('hide');
				$("#modifyPwdMsg").text("새 비밀번호 재확인을 입력하지 않았습니다.");
				$("#newPwdCk").focus();
			}
			else {
				$.ajax(cp+"/modifyPwd?id="+id+"&pwd="+pwd+"&newPwd="+newPwd+"&newPwdCk="+newPwdCk, {
					success: function(data1) {
						if(data1 == 1) {
							$("#LoadingLayerModal").modal('hide');
							$("#modifyPwdMsg").text("새 비밀번호가 현재 비밀번호와 일치합니다. 다시 입력하세요.");
							$("#newPwd").focus();
						}
						else if(data1 == 2) {
							$("#LoadingLayerModal").modal('hide');
							$("#modifyPwdMsg").text("첫 글자는 영문만 사용 가능합니다.");
							$("#newPwd").focus();
						}
						else if(data1 == 3) {
							$("#LoadingLayerModal").modal('hide');
							$("#modifyPwdMsg").text("8~16자 이내로 사용 가능합니다.");
							$("#newPwd").focus();
						}
						else if(data1 == 4) {
							$("#LoadingLayerModal").modal('hide');
							$("#modifyPwdMsg").text("영문, 숫자만 사용 가능합니다.");
							$("#newPwd").focus();
						}
						else if(data1 == 5) {
							$("#LoadingLayerModal").modal('hide');
							$("#modifyPwdMsg").text("새 비밀번호와 새비밀번호 재확인이 일치하지 않습니다.");
							$("#newPwdCk").focus();
						}
						else if(data1 == 6) {
							$("#LoadingLayerModal").modal('hide');
							$("#modifyPwdModal").modal();
						}
					}
				})
			}
		});
		$("#closeModifyPwdModal").on("click", function () {
			location.reload();
		})
		
		// 이메일 변경 ------------------------------------------------------------------------------------------------------
		
		$("#btnModifyEmail").on("click", function(e) {
			e.preventDefault();
			$("#LoadingLayerModal").modal({keyboard: false, backdrop: 'static'});
			var id = "${member.id}";
			var email = "${member.email}";
			var newEmail = $("#newEmail").val();
			if(!newEmail) {
				$("#LoadingLayerModal").modal('hide');
				$("#modifyEmailMsg").text("변경할 이메일을 입력하지 않았습니다.");
				$("#newEmail").focus();
			}
			else {
				$.ajax(cp+"/modifyEmail?id="+id+"&email="+email+"&newEmail="+newEmail, {
					success: function(data2) {
						if(data2 == 1) {
							$("#LoadingLayerModal").modal('hide');
							$("#modifyEmailMsg").text("새 이메일이 현재 이메일과 일치합니다. 다시 입력하세요.");
							$("#newEmail").focus();
						}
						else if(data2 == 2) {
							$("#LoadingLayerModal").modal('hide');
							$("#modifyEmailMsg").text("이미 사용 중인 이메일입니다.");
							$("#newEmail").focus();
						}
						else if(data2 == 3) {
							$("#LoadingLayerModal").modal('hide');
							$("#modifyEmailMsg").text("이메일 형식이 올바르지 않습니다. (@누락)");
							$("#newEmail").focus();
						}
						else if(data2 == 4) {
							$("#LoadingLayerModal").modal('hide');
							$("#modifyEmailMsg").text("이메일 형식이 올바르지 않습니다. (.누락)");
							$("#newEmail").focus();
						}
						else if(data2 == 5) {
							$("#LoadingLayerModal").modal('hide');
							$("#resendCheckEmailModal").modal();
						}
					}
				});
			}
		})
		$("#closeModifyEmailModal").on("click", function () {
			location.reload();
		})
		
		// 인증메일 재발송
		$("#resendCheckEmail").on("click", function(e) {
			e.preventDefault();
			$("#LoadingLayerModal").modal({keyboard: false, backdrop: 'static'});
			var id = "${member.id}";
			$.ajax(cp+"/resendCheckEmail?id="+id, {
				success: function() {
					$("#LoadingLayerModal").modal('hide');
					$("#resendCheckEmailModal").modal();
				}
			});
		})
		$("#closeResendCheckEmailModal").on("click", function () {
			location.reload();
		})
		
		// 별명 변경 ------------------------------------------------------------------------------------------------------
		
		$("#btnModifyNickname").on("click", function(e) {
			e.preventDefault();
			$("#LoadingLayerModal").modal({keyboard: false, backdrop: 'static'});
			var id = "${member.id}";
			var nickname = "${member.nickname}";
			var newNickname = $("#newNickname").val();
			if(!newNickname) {
				$("#LoadingLayerModal").modal('hide');
				$("#modifyNicknameMsg").text("변경할 별명을 입력하지 않았습니다.");
				$("#newNickname").focus();
			}
			else {
				$.ajax(cp+"/modifyNickname?id="+id+"&nickname="+nickname+"&newNickname="+newNickname, {
					success: function(data3) {
						if(data3 == 1) {
							$("#LoadingLayerModal").modal('hide');
							$("#modifyNicknameMsg").text("새 별명이 현재 별명과 일치합니다. 다시 입력하세요.");
							$("#newNickname").focus();
						}
						else if(data3 == 2) {
							$("#LoadingLayerModal").modal('hide');
							$("#modifyNicknameMsg").text("이미 사용 중인 별명입니다.");
							$("#newNickname").focus();
						}
						else if(data3 == 3) {
							$("#LoadingLayerModal").modal('hide');
							$("#modifyNicknameMsg").text("2~10자 이내로 사용 가능합니다.");
							$("#newNickname").focus();
						}
						else if(data3 == 4) {
							$("#LoadingLayerModal").modal('hide');
							$("#modifyNicknameMsg").text("한글, 영문, 숫자만 사용 가능합니다.");
							$("#newNickname").focus();
						}
						else if(data3 == 5) {
							$("#LoadingLayerModal").modal('hide');
							$("#modifyNicknameModal").modal();
						}
					}
				});
			}
		})
		$("#closeModifyNicknameModal").on("click", function () {
			location.reload();
		})
		
	})
</script>
</html>