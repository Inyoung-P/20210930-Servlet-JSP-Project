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
					<h2>공존소식 글쓰기</h2>
				</div>
			</div>
		</section>
		<section class="article">
			<div class="detailWrap mx-auto p-0">
				<form method="post" class="form-group m-0" enctype="multipart/form-data">
					<fieldset>
						<input type="file" name="file1" accept="image/png, image/jpeg, image/gif" class="mb-1"><br>
						<input type="file" name="file2" accept="image/png, image/jpeg, image/gif" class="mb-1"><br>
						<input type="file" name="file3" accept="image/png, image/jpeg, image/gif"><br>
					
						<input type="text" name="title" class="form-control mt-2 mb-2 h-100" placeholder="제목을 입력하세요." required />
						<textarea name="content" class="form-control mb-4" placeholder="내용를 입력하세요." required></textarea>
						<button class="col btn btn-info" id="">저장</button>
					</fieldset>
				</form>
			</div>
		</section>
	</main>
	<jsp:include page="../common/footer.jsp" />
</body>
<script>
function setGalleryFileImg1(event) {
	var reader = new FileReader();
	reader.onload = function(event) {
		$("#galleryFileImg1").attr("src", event.target.result);
	}
	reader.readAsDataURL(event.target.files[0]);
}
</script>
</html>