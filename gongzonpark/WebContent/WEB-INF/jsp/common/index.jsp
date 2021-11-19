<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head profile="http://www.w3.org/2005/10/profile">
	<jsp:include page="head.jsp" />
</head>
<body>
	<jsp:include page="headerIndex.jsp" />

	<!-------------------------------- home -------------------------------->
	<section id="home">
		<div class="home-container" data-aos="fade-up">
			<h1>공존을 위한 우리 모두의 공원</h1>
			<h2>인간도 동물이며 자연의 일부이기에, 공존공원은 모두가 평화로운 공존을 꿈꾸고 있습니다. <br>부디 이 평화로움 속에서 당신이 편안하길 바랍니다.</h2>
			<a href="#rule" class="btn-get-started scrollto"><i class="bx bx-chevrons-down"></i></a>
		</div>
	</section>

	<main class="main">
		<!-------------------------------- rule -------------------------------->
		<section id="rule" class="rule">
			<div class="container">
				<div class="row no-gutters">
					<div class="content col-xl-5 d-flex align-items-stretch" data-aos="fade-up">
						<div class="content">
							<h3><b>공존공원은,</b></h3>
							<p>
								동물들이 있지만 동물원은 아닙니다.<br>
								산책로가 있지만 개방되어 있지 않습니다.<br><br>
								공존공원만큼은,<br>
								사람보다는 동물들과 숲을 먼저 생각할게요.<br>
								너그럽게 이해 부탁드립니다.					
							</p>
							<a href="${pageContext.request.contextPath}/notice/detail?bno=27" class="rule-btn">후원하기<i class="bx bx-chevron-right"></i></a>
						</div>
					</div>
					<div class="col-xl-7 d-flex align-items-stretch">
						<div class="icon-boxes d-flex flex-column justify-content-center">
							<div class="row">
								<div class="col-md-6 icon-box" data-aos="fade-up" data-aos-delay="100">
									<i class="fas fa-horse"></i>
									<h4>동물을 수집하지 않습니다.</h4>
									<p>
										공존공원은 관람을 위하여 살아있는 동물을 수집하는 동물원이 아닙니다. 동물들을 구조하여 치료하는 보호 공원입니다.
									</p>
								</div>
								<div class="col-md-6 icon-box" data-aos="fade-up" data-aos-delay="200">
									<i class="fas fa-kiwi-bird"></i>
									<h4>가까이에서 볼 수 없습니다.</h4>
									<p>
										공존공원의 동물들은 자연으로 돌아가기 위해 적응 연습을 하고 있습니다. 잘 치료 받고 적응할 수 있도록 멀리서 응원해주세요.
									</p>
								</div>
								<div class="col-md-6 icon-box" data-aos="fade-up" data-aos-delay="300">
									<i class="fas fa-dog"></i>
									<h4>번식에 관여하지 않습니다.</h4>
									<p>
										공존공원은 동물들의 번식에 직접적으로 관여하지 않고 있으며 자연적인 번식이 발생하였을 때도 개입을 최소화하고 있습니다.
									</p>
								</div>
								<div class="col-md-6 icon-box" data-aos="fade-up" data-aos-delay="400">
									<i class="fas fa-otter"></i>
									<h4>끝까지 함께 합니다.</h4>
									<p>
										나이가 많고 몸이 아픈 동물들은 갈 곳이 없습니다. 동물들이 공존공원에서 편안히 여생을 보낼 수 있도록 최선을 다하고 있습니다.
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
  	
		<!------------------------------ program ------------------------------->
		<section id="program" class="program">
			<div class="container" data-aos="zoom-in">
				<div class="text-center">
					<h3>공존공원 산책 프로그램</h3>
					<p>
						공존공원을 산책하며 공존에 대해 사색을 하는 프로그램을 운영하고 있습니다. <br><br>
						아침을 좋아하신다면 해가 뜰 때 오셔서 밝아지는 하늘을 보며 숲 냄새를 맡아보세요. <br>
						해가 지는 시간에 오신다면 따듯한 빛으로 가득한 숲이 감동을 줄 거예요.<br>
						비가 오는 날에는 우비와 장화를 빌려드릴게요. 도시의 소음이 섞이지 않은 숲의 빗소리를 들어보세요.  
					</p>
					<a class="program-btn" href="${pageContext.request.contextPath}/notice/detail?bno=28">프로그램 예약</a>
				</div>
			</div>
		</section>
  	
    	<!------------------------------ gongzonNews ------------------------------>
		<section id="gongzonNews" class="portfolio">
			<div class="container">
				<div class="section-title" data-aos="fade-in" data-aos-delay="100">
					<h2>공존소식</h2>
					<p>구조한 동물들의 건강해진 모습을 보여드리고 있습니다.</p>
				</div>
				<div class="row" data-aos="fade-in">
					<div class="col-lg-12 d-flex justify-content-center">
						<button class="portfolio-button" onclick="location.href='${pageContext.request.contextPath}/gallery/list'"><i class="fas fa-search-plus"></i> 더보기</button>
					</div>
				</div>
				<div class="row portfolio-container" data-aos="fade-up">		
					<c:forEach items="${listCategory2}" var="gallery1">
						<div class="col-lg-4 col-md-6 portfolio-item">
							<div class="portfolio-wrap ">
								<img src="${pageContext.request.contextPath}/display?filename=${gallery1.attachs[0].path}/s_${gallery1.attachs[0].uuid}" class="img-fluid" alt="게시글 썸네일">
								<div class="portfolio-links">
									<a href="gallery/detail?bno=${gallery1.bno}"><c:out value="${gallery1.title}" /></a>
								</div>
							</div>
						</div>					
					</c:forEach>	
				</div>
			</div>
		</section>	
  		
  		<!----------------------------- community ------------------------------>
		<section id="community" class="community section-bg">
			<div class="container">
				<div class="section-title" data-aos="fade-in" data-aos-delay="100">
					<h2>커뮤니티</h2>
					<p>자유롭게 글을 남겨주세요. 질문을 남겨주시면 꼭 답변 남겨드릴게요.</p>
				</div>
				<div class="row" data-aos="fade-in">
					<div class="col-lg-12 d-flex justify-content-center">
						<button class="portfolio-button" onclick="location.href='${pageContext.request.contextPath}/board/list'"><i class="fas fa-search-plus"></i> 더보기</button>
					</div>
				</div>
				<div class="owl-carousel testimonials-carousel">
					<c:forEach items="${listCategory1}" var="board">
					
						<div class="community-item" data-aos="fade-up">
							<a href="${pageContext.request.contextPath}/board/detail?bno=${board.bno}">
								<p>
									<strong><c:out value="${board.title}" /></strong>
									<span><c:out value="${board.content}" /></span>
								</p>
							</a>
							<c:choose>
								<c:when test="${empty board.profileUuid}">
									<img src="${pageContext.request.contextPath}/img/basic.jpg" class="testimonial-img" alt="작성자의 프로필 사진">
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath}/display?filename=profileImg/s_${board.profileUuid}" class="testimonial-img" alt="작성자의 프로필 사진">
								</c:otherwise>
							</c:choose>
							<h3><c:out value="${board.nickname}" /></h3>
							<h4>${board.regDate}</h4>
						</div>
					</c:forEach>
				</div>
			</div>
		</section>
	</main>
  	
	<jsp:include page="footerIndex.jsp" />
</body>
</html>