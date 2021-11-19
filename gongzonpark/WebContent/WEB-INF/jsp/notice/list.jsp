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
					<h2>공지사항</h2>
					<p>공존공원의 공지사항입니다.</p>
				</div>
				<c:if test="${member.id == 'admin'&& member.emailChecked == 1}">
					<div class="row" data-aos="fade-in">
						<div class="col-lg-12 d-flex justify-content-center">
							<button class="portfolio-button" onclick="location.href='${pageContext.request.contextPath}/notice/write'"><i class="fas fa-pencil-alt"></i> 글쓰기</button>
						</div>
					</div>
				</c:if>
			</div>
			<div class="container mb-5" data-aos="fade-in">
				<table class="col-lg-12 table table-hover mx-auto">
	                <tbody class="bg-light">
	                    <tr class="thead bg-secondary text-light text-center">
	                        <th class="col-1 py-2">번호</th>
	                        <th class="col-4 py-2">제목</th>
	                        <th class="col-1 py-2">첨부파일</th>
	                        <th class="col-2 py-2">작성자</th>
	                        <th class="col-1 py-2">작성일</th>
	                    </tr>
	                    <c:forEach items="${list}" var="b">
	                    	<tr class="text-center">
	                        	<td class="py-2">${b.bno}</td>
	                        	<td class="py-2 pl-3 text-left"><a href="${pageContext.request.contextPath}/notice/detail?bno=${b.bno}" class="titleTable text-truncate"><c:out value="${b.title}" /></a> <span class="text-muted small">[${b.replyCnt}]</span></td>
	                        	<td class="attachTable py-2">
	                        		<c:if test="${not empty b.attachs}">
	                        			<i class="fas fa-paperclip"></i>
	                        		</c:if>
	                        	</td>
	                        	<td class="py-2"><c:out value="${b.nickname}" /></td>
	                         	<td class="py-2">${b.regDate}</td>
	                    	</tr>
	                    </c:forEach>
	                </tbody>
	            </table>
			</div>
			<div class="row">
				<div class="col-lg-12 d-flex justify-content-center">
					<ul class="portfolio-flters">
						<li class="${page.prev ? '' : 'hide'}">
							<a href="${pageContext.request.contextPath}/notice/list?pageNum=${page.startPage-1}&amonut=${page.cri.amount}">Previous</a>
						</li>
						<c:forEach begin="${page.startPage}" end="${page.endPage}" var="p">
							<li class="${p == page.cri.pageNum ? 'filter-active' : ''}">
								<a href="${pageContext.request.contextPath}/notice/list?pageNum=${p}&amonut=${page.cri.amount}">${p}</a>
							</li>
						</c:forEach>
						<li class="${page.next ? '' : 'hide'}">
							<a href="${pageContext.request.contextPath}/notice/list?pageNum=${page.endPage+1}&amonut=${page.cri.amount}">Next</a>
						</li>
					</ul>
				</div>
			</div>	
		</section>
	</main>			
	<jsp:include page="../common/footer.jsp" />
</body>
</html>