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
					<h2>공지사항 글쓰기</h2>
					<p>아래와 같은 게시글은 사전통지 없이 관리자에 의해 삭제될 수 있습니다.<br>
					(타인의 명예를 훼손하거나 모욕하는 게시글, 광고성 게시글,<br>
					타인의 지적재산권 등의 권리를 침해하는 게시글,<br>
					해킹행위 또는 컴퓨터바이러스의 유포 게시글)</p>
				</div>
				<form method="post" class="form-group m-0" enctype="multipart/form-data">
					<div class="portfolio-description pt-0">
						<label for="boardTitle">제목</label>&nbsp;&nbsp;&nbsp;<span class="text-muted small" id="titleCount"></span>
						<input type="text" name="title" class="form-control mt-2 mb-3" placeholder="제목을 30자 이내로 입력하세요." id="boardTitle" />
						<label for="boardContent">내용</label>&nbsp;&nbsp;&nbsp;<span class="text-muted small" id="contentCount"></span>
						<textarea name="content" rows="10" class="form-control mb-3" placeholder="내용를 입력하세요." id="boardContent" ></textarea>
						<label>첨부파일</label>
						<div class="fileInput">
							<label for="file1" class="mb-1" title="첨부파일 불러오기"></label>
							<input type="file" name="file1" id="file1" class="mb-1" />
							<span class="text-secondary" id="fileName1"></span>
							<button class="hide" id="deleteFile1" onclick="deleteFileInput1()"><i class="fas fa-times"></i></button>
						</div>
						<div class="fileInput">
							<label for="file2" class="mb-1" title="첨부파일 불러오기"></label>
							<input type="file" name="file2" id="file2" class="mb-1" />
							<span class="text-secondary" id="fileName2"></span>
							<button class="hide" id="deleteFile2" onclick="deleteFileInput2()"><i class="fas fa-times"></i></button>
						</div>						
						<div class="fileInput">
							<label for="file3" class="mb-1" title="첨부파일 불러오기"></label>
							<input type="file" name="file3" id="file3" class="mb-1" />
							<span class="text-secondary" id="fileName3"></span>
							<button class="hide" id="deleteFile3" onclick="deleteFileInput3()"><i class="fas fa-times"></i></button>
						</div>							
					</div>
					<div class="row">
						<div class="col-lg-12 d-flex justify-content-end">
							<button class="portfolio-button-bottom mr-2" id="btnWriteBoard"><i class="far fa-save"></i> 등록</button>
							<button class="portfolio-button-bottom" id="btnCancleWriteBoard" onclick="cancleWriteBoard()"><i class="fas fa-times"></i> 취소</button>
							<div class="modal fade" id="cancleWriteBoardModal">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-body text-center">
											글 작성을 취소하시겠습니까?<br>
											작성된 내용은 저장되지 않습니다.
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-info" onclick="btnBoardList()">목록</button>
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
	$(function() {
	
		// 제목 글자수 제한
	    $('#boardTitle').on('keyup', function() {
	        $('#titleCount').text("( "+$(this).val().length+" / 30자 )");
	 
	        if($(this).val().length > 30) {
	            $(this).val($(this).val().substring(0, 30));
	            $('#titleCount').text("( 30 / 30자 )");
	        }
	    });
		// 내용 글자수 제한
	    $('#boardContent').on('keyup', function() {
	        $('#contentCount').text("( "+$(this).val().length+" / 2000자 )");
	 
	        if($(this).val().length > 2000) {
	            $(this).val($(this).val().substring(0, 2000));
	            $('#contentCount').text("( 2000 / 2000자 )");
	        }
	    });
		
		// 글 작성
		$("#btnWriteBoard").click(function() {
			event.preventDefault();
			var titleLen = $("#boardTitle").val().trim().length;
			var contentLen = $("#boardContent").val().trim().length;
			if(!titleLen) {
				$("#boardTitle").focus().val('').attr('placeholder', '제목에 공백만 입력할 수 없습니다.');
				return;
			}
			else if(!contentLen) {
				$("#boardContent").focus().val('').attr('placeholder', '내용에 공백만 입력할 수 없습니다.');
				return;
			}
			else {
			    $(this).unbind('click').click();
			}
		});
		
		// 첨부파일 1
	    $("#file1").change(function () {
	        var str = $(this).val();
	        var fileName = str.split('\\').pop().toLowerCase();
	 		$("#fileName1").text(fileName);
	 		$("#deleteFile1").removeClass('hide');
	 		
	    });
		 // 첨부파일 2
	    $("#file2").change(function () {
	        var str = $(this).val();
	        var fileName = str.split('\\').pop().toLowerCase();
	 		$("#fileName2").text(fileName);
	 		$("#deleteFile2").removeClass('hide');
	    });
	 	// 첨부파일 3
	    $("#file3").change(function () {
	        var str = $(this).val();
	        var fileName = str.split('\\').pop().toLowerCase();
	 		$("#fileName3").text(fileName);
	 		$("#deleteFile3").removeClass('hide');
	    });
	})

	// 글 작성 취소
	function cancleWriteBoard() {
		event.preventDefault();
		$("#cancleWriteBoardModal").modal();
	}
	// 글 작성 취소 시 모달창의 목록버튼
	function btnBoardList() {
		event.preventDefault();
		location.href= cp + '/notice/list';	
	}
	// 첨부파일1 삭제
	function deleteFileInput1() {
		event.preventDefault();
		$("#file1").val('');
		$("#fileName1").text('');
		$("#deleteFile1").addClass('hide');
	}
	// 첨부파일2 삭제
	function deleteFileInput2() {
		event.preventDefault();
		$("#file2").val('');
		$("#fileName2").text('');
		$("#deleteFile2").addClass('hide');
	}
	// 첨부파일3 삭제
	function deleteFileInput3() {
		event.preventDefault();
		$("#file3").val('');
		$("#fileName3").text('');
		$("#deleteFile3").addClass('hide');
	}
</script>
</html>