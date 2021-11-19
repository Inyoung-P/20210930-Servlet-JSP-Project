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
				<div class="section-title" data-aos="fade-in" data-aos-delay="100">
					<h2>공존소식 글 수정</h2>
				</div>
				<form method="post" class="form-group m-0" enctype="multipart/form-data">
					<div class="portfolio-description pt-0">
						<input type="hidden" name="bno" value="${board.bno}" />
						<label for="galleryTitle">제목</label>&nbsp;&nbsp;&nbsp;<span class="text-muted small" id="titleCount"></span>
						<input type="text" name="title" class="form-control mt-2 mb-3" placeholder="제목을 30자 이내로 입력하세요." id="galleryTitle" value="${board.title}" />
						<label for="galleryContent">내용</label>&nbsp;&nbsp;&nbsp;<span class="text-muted small" id="contentCount"></span>
						<textarea name="content" rows="10" class="form-control mb-3" placeholder="내용를 입력하세요." id="galleryContent" >${board.content}</textarea>
						<label>첨부파일</label>
						<div class="fileInput">
							<label for="file1" class="mb-1" title="첨부파일 불러오기"></label>
							<input type="file" name="file1" id="file1" class="mb-1" />
							<span class="text-secondary" id="fileName1"></span>
							<button class="hide" id="deleteFile1" onclick="deleteFileInput1()"><i class="fas fa-times"></i></button>
							<input type="hidden" name="changeFile1" id="checkChangeFile1" />
							<input type="hidden" name="beforeFile1" value="${board.attachs[0].uuid}" />
						</div>
						<div class="fileInput">
							<label for="file2" class="mb-1" title="첨부파일 불러오기"></label>
							<input type="file" name="file2" id="file2" class="mb-1" />
							<span class="text-secondary" id="fileName2"></span>
							<button class="hide" id="deleteFile2" onclick="deleteFileInput2()"><i class="fas fa-times"></i></button>
							<input type="hidden" name="changeFile2" id="checkChangeFile2" />
							<input type="hidden" name="beforeFile2" value="${board.attachs[1].uuid}" />
						</div>						
						<div class="fileInput">
							<label for="file3" class="mb-1" title="첨부파일 불러오기"></label>
							<input type="file" name="file3" id="file3" class="mb-1" />
							<span class="text-secondary" id="fileName3"></span>
							<button class="hide" id="deleteFile3" onclick="deleteFileInput3()"><i class="fas fa-times"></i></button>
							<input type="hidden" name="changeFile3" id="checkChangeFile3" />
							<input type="hidden" name="beforeFile3" value="${board.attachs[2].uuid}" />
						</div>							
					</div>
					<div class="row">
						<div class="col-lg-12 d-flex justify-content-end">
							<button class="portfolio-button-bottom mr-2" id="btnModifyGallery"><i class="far fa-save"></i> 수정</button>
							<button class="portfolio-button-bottom" id="btnCancleModifyGallery" onclick="cancleModifyGallery()"><i class="fas fa-times"></i> 취소</button>
							<div class="modal fade" id="cancleModifyGalleryModal">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-body text-center">
											글 수정을 취소하시겠습니까?<br>
											수정된 내용은 저장되지 않습니다.
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-info" onclick="btnGalleryDetail()">확인</button>
											<button type="button" class="btn btn-secondary" data-dismiss="modal" id="batNo">취소</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</section>
	</main>
	<jsp:include page="../common/footer.jsp" />
</body>
<script>
	var cp = '${pageContext.request.contextPath}';
	var loginId = '{member.id}';
	$(function() {
		
		init();
		function init() {
			// 첨부파일 삭제버튼
			if('${board.attachs[0].origin}' != '') {
				$("#fileName1").text('${board.attachs[0].origin}');
				$("#deleteFile1").removeClass('hide');
			}
			if('${board.attachs[1].origin}' != '') {
				$("#fileName2").text('${board.attachs[1].origin}');
				$("#deleteFile2").removeClass('hide');
			}
			if('${board.attachs[2].origin}' != '') {
				$("#fileName3").text('${board.attachs[2].origin}');
				$("#deleteFile3").removeClass('hide');
			}
		}
		
		// 제목 글자수 제한
	    $('#galleryTitle').on('keyup', function() {
	        $('#titleCount').text("( "+$(this).val().length+" / 30자 )");
	 
	        if($(this).val().length > 30) {
	            $(this).val($(this).val().substring(0, 30));
	            $('#titleCount').text("( 30 / 30자 )");
	        }
	    });
		
		// 내용 글자수 제한
	    $('#galleryContent').on('keyup', function() {
	        $('#contentCount').text("( "+$(this).val().length+" / 2000자 )");
	 
	        if($(this).val().length > 2000) {
	            $(this).val($(this).val().substring(0, 2000));
	            $('#contentCount').text("( 2000 / 2000자 )");
	        }
	    });
		
		// 글 수정
 		$("#btnModifyGallery").click(function() {
			event.preventDefault();
			var titleLen = $("#galleryTitle").val().trim().length;
			var contentLen = $("#galleryContent").val().trim().length;
			if(!titleLen) {
				$("#galleryTitle").focus().val('').attr('placeholder', '제목에 공백만 입력할 수 없습니다.');
				return;
			}
			else if(!contentLen) {
				$("#galleryContent").focus().val('').attr('placeholder', '내용에 공백만 입력할 수 없습니다.');
				return;
			}
			else {
			    // 첨부파일1 변경
			    if(!$("#file1").val() && changeFile1) $("#checkChangeFile1").val(true);
			    else if($("#file1").val() && changeFile1) $("#checkChangeFile1").val(true);
			    
			    // 첨부파일2 변경
			    if(!$("#file2").val() && changeFile2) $("#checkChangeFile2").val(true);
			    else if($("#file2").val() && changeFile2) $("#checkChangeFile2").val(true);
			    
			    // 첨부파일3 변경
			    if(!$("#file3").val() && changeFile3) $("#checkChangeFile3").val(true);
			    else if($("#file3").val() && changeFile3) $("#checkChangeFile3").val(true);
				$(this).unbind('click').click();
			}
		});
		// 첨부파일 1
	    $("#file1").change(function () {
	        var str = $(this).val();
	        var fileName = str.split('\\').pop().toLowerCase();
	 		$("#fileName1").text(fileName);
	 		$("#deleteFile1").removeClass('hide');
	 		changeFile1 = true;
	    });
		 // 첨부파일 2
	    $("#file2").change(function () {
	        var str = $(this).val();
	        var fileName = str.split('\\').pop().toLowerCase();
	 		$("#fileName2").text(fileName);
	 		$("#deleteFile2").removeClass('hide');
	 		changeFile2 = true;
	    });
	 	// 첨부파일 3
	    $("#file3").change(function () {
	        var str = $(this).val();
	        var fileName = str.split('\\').pop().toLowerCase();
	 		$("#fileName3").text(fileName);
	 		$("#deleteFile3").removeClass('hide');
	 		changeFile3 = true;
	    });
	})
	// 글 수정 취소
	function cancleModifyGallery() {
		event.preventDefault();
		$("#cancleModifyGalleryModal").modal();
	}
	// 글 수정 취소 확인 모달창의 확인 버튼
	function btnGalleryDetail() {
		event.preventDefault();
		location.href= cp + '/gallery/detail?bno='+'${board.bno}';	
	}
	// 첨부파일1 삭제
	var changeFile1 = false;
	function deleteFileInput1() {
		event.preventDefault();
		$("#file1").val('');
		$("#fileName1").text('');
		$("#deleteFile1").addClass('hide');
		changeFile1 = true;
	}
	// 첨부파일2 삭제
	var changeFile2 = false;
	function deleteFileInput2() {
		event.preventDefault();
		$("#file2").val('');
		$("#fileName2").text('');
		$("#deleteFile2").addClass('hide');
		changeFile2 = true;
	}
	// 첨부파일3 삭제
	var changeFile3 = false;
	function deleteFileInput3() {
		event.preventDefault();
		$("#file3").val('');
		$("#fileName3").text('');
		$("#deleteFile3").addClass('hide');
		changeFile3 = true;
	}
</script>
</html>