<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<header id="header" class="fixed-top header-transparent">
		<div class="container d-flex align-items-center">
			<div class="logo mr-auto">
				<h1 class="text-light"><a href="${pageContext.request.contextPath}/index.html"><i class="fas fa-globe-asia"></i> 공존공원</a></h1>
			</div>
			<nav class="nav-menu d-none d-lg-block">
				<ul>
					<li class="active"><a href="${pageContext.request.contextPath}/index.html">Home</a></li>
					<li><a href="#rule">공존원칙</a></li>
					<li><a href="#program">프로그램</a></li>
					<li><a href="#gongzonNews">공존소식</a></li>
					<li><a href="#community">커뮤니티</a></li>
					<li><a href="${pageContext.request.contextPath}/notice/list">공지사항</a></li>
					<c:choose>
	       			<c:when test="${empty member}">
	       			<li class="drop-down p-0"><a href="${pageContext.request.contextPath}/login" class="loginLink" id="loginNavLink">로그인 <i class="fas fa-user-circle"></i></a>
						<ul>
							<li><a href="${pageContext.request.contextPath}/login" class="loginLink">로그인</a></li>
							<li><a href="${pageContext.request.contextPath}/findid">ID/PW 찾기</a></li>
							<li><a href="${pageContext.request.contextPath}/contract">회원가입</a></li>
						</ul>
					</li>
	       			</c:when>
	       			<c:otherwise>
		        	<li class="drop-down p-0"><a href="${pageContext.request.contextPath}/checkmember" id="loginNavLink">${member.nickname} <i class="fas fa-user-circle"></i></a>
						<ul>
							<li><a href="${pageContext.request.contextPath}/checkmember">마이페이지</a></li>
							<li><a href="${pageContext.request.contextPath}/logout">로그아웃</a></li>
						</ul>
					</li>      				
	       			</c:otherwise>
	        		</c:choose>	
				</ul>
			</nav>
		</div>
	</header>
	<script>
	var cp = '${pageContext.request.contextPath}';
	$(function() {
		// 로그인 시 현재 주소값 같이 보내기
		$(".loginLink").on("click", function(e) {
			e.preventDefault();
			var url = cp + "/login?url=" + window.location.href;
			location.href=url;
		})
	})	
	</script>