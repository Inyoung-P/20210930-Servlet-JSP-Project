<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
					<h2>공존소식</h2>
					<p>구조한 동물들의 건강해진 모습을 보여드리고 있습니다.<br>고통스러운 시간을 이겨낸 동물들의 모습이 당신에게 작은 위로가 되길 바랍니다.</p>
				</div>
				<c:if test="${member.id == 'admin'&& member.emailChecked == 1}">
					<div class="row" data-aos="fade-in">
						<div class="col-lg-12 d-flex justify-content-center">
							<button class="portfolio-button" onclick="location.href='${pageContext.request.contextPath}/gallery/write'"><i class="fas fa-pencil-alt"></i> 글쓰기</button>
						</div>
					</div>
				</c:if>
				<div class="row portfolio-container" data-aos="fade-up">
					<c:set var="endCount" value="${page.cri.amount - (page.cri.amount - 1) % 3 + 2}" />
					<c:forEach begin="1" end="${endCount}" varStatus="stat">
						<c:set var="board" value="${list[stat.index-1]}"></c:set>
							<c:if test="${not empty board}">
								<div class="col-lg-4 col-md-6 portfolio-item">
									<div class="portfolio-wrap ">
	 									<img src="${pageContext.request.contextPath}/display?filename=${board.attachs[0].path}/s_${board.attachs[0].uuid}" class="img-fluid" alt="공존소식 썸네일">
										<div class="portfolio-links">
											<a href="${pageContext.request.contextPath}/gallery/detail?bno=${board.bno}"><c:out value="${board.title}" /></a>
										</div>
									</div>
								</div>						
							</c:if>
					</c:forEach>
				</div>
			</div>
			<div class="row" data-aos="fade-in">
				<div class="col-lg-12 d-flex justify-content-center">
					<ul class="portfolio-flters">
						<li class="${page.prev ? '' : 'hide'}">
							<a href="${pageContext.request.contextPath}/gallery/list?pageNum=${page.startPage-1}&amonut=${page.cri.amount}">Previous</a>
						</li>
						<c:forEach begin="${page.startPage}" end="${page.endPage}" var="p">
							<li class="${p == page.cri.pageNum ? 'filter-active' : ''}">
								<a href="${pageContext.request.contextPath}/gallery/list?pageNum=${p}&amonut=${page.cri.amount}">${p}</a>
							</li>
						</c:forEach>
						<li class="${page.next ? '' : 'hide'}">
							<a href="${pageContext.request.contextPath}/gallery/list?pageNum=${page.endPage+1}&amonut=${page.cri.amount}">Next</a>
						</li>
					</ul>
				</div>
			</div>
		</section>
	</main>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>