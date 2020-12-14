<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>SRUS – Another space</title>

		<!-- Favicons -->
		<link rel="apple-touch-icon" sizes="144x144" href="/images/favicons/apple-touch-icon-144x144.png">
		<link rel="apple-touch-icon" sizes="114x114" href="/images/favicons/apple-touch-icon-114x114.png">
		<link rel="apple-touch-icon" sizes="72x72" href="/images/favicons/apple-touch-icon-72x72.png">
		<link rel="apple-touch-icon" sizes="57x57" href="/images/favicons/apple-touch-icon-57x57.png">
		<link rel="shortcut icon" href="/images/favicons/favicon.png" type="image/png">

		<!-- Styles -->
		<link rel="stylesheet" type="text/css" href="/styles/style.css"/>
	</head>
	<body>

		<!-- Preloader -->
		<div class="preloader">
			<div class="preloader__wrap">
				<div class="preloader__progress"><span></span></div>
			</div>
		</div>
		<%@ include file="/WEB-INF/jsp/layout/topnavy.jsp" %>
		
		<!-- content -->
		<main class="main">
			<section class="container section section-first">
				<div class="row justify-content-center">
					
					<!-- Header post -->
					<header class="col-12 col-lg-12 col-xl-10 post-header">
						<h1 class="title title--h1 js-lines">무인 대여함 선택하기</h1>
					</header>
					<table class="table" style="text-align:center;">
						<thead>
							<tr class="paragraph--column">
								<th>대여함 번호</th>
								<th>설치 위치</th>
								<th>크기<br/>(가로(m)*세로(m))</th>
								<th>1일 대여 금액</th>
								<th>모델명</th>
							</tr>
						</thead>
						<c:forEach var="rentalBox" items="${rows}">
							<c:if test="${rentalBox.division eq 'Y'}">
								<tr class="paragraph--row">
									<td><a href="/rental/step2/${rentalBox.no}" class="btn btn__medium btn__second w-10">${rentalBox.no}번 대여함</a></td>
									<td><c:out value="${rentalBox.location}" /></td>
									<td><c:out value="${rentalBox.size}" /></td>
									<td><fmt:formatNumber value="${rentalBox.charge}"/>원</td>
									<td><c:out value="${rentalBox.model}" /></td>
								</tr>
							</c:if>
						</c:forEach>
					</table>
				</div>
			</section>
		</main>
		<!-- Footer -->
		<%@ include file="/WEB-INF/jsp/layout/bottom.jsp" %>
		
		<!-- JavaScripts -->
		<script src="/js/jquery-3.4.1.min.js"></script>
		<script src="/js/plugins.js"></script>
		<script src="/js/common.js"></script>
	</body>
</html>