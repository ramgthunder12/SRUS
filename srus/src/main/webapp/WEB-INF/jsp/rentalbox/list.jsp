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
		<%@ include file="/WEB-INF/jsp/layout/topnavyadmin.jsp" %>
		
		<!-- content -->
		<main class="main" >
			<section class="container section section-first">
				<div class="row justify-content-center">
					
					<!-- Header post -->
					<header class="col-12 col-lg-12 col-xl-10 post-header">
						<h1 class="title title--h1 js-lines">무인 대여함 목록</h1>
					</header>
					<form action="/rentalbox/form" method="GET" class="col-12">
						<table class="table" style="text-align:center;">
							<thead>
								<tr class="paragraph--column">
									<th>일련번호</th><th>대여함 번호</th><th>모델명</th><th>크기</th><th>설치 위치</th><th>1일 대여금액</th><th>구분</th>
								</tr>
						    </thead>
					        	<c:forEach var="rentalBox" varStatus="status" items="${rows}">
						         	<tr class="paragraph--row">
						         		<td><a href="/rentalbox/${rentalBox.no}/form" class="btn btn__medium btn__second w-10">${status.count}</a></td>
									    <td>${rentalBox.no}번 대여함</td>
									    <td><c:out value="${rentalBox.model}" /></td>
									    <td><c:out value="${rentalBox.size}" /></td>
									    <td><c:out value="${rentalBox.location}" /></td>
									    <td><fmt:formatNumber value="${rentalBox.charge}"/>원</td>
									    <c:if test="${rentalBox.division eq 'Y'}" >
									    	<td>사용 가능</td>
									    </c:if>
									    <c:if test="${rentalBox.division eq 'N'}">
									    	<td>사용 불가능</td>
									    </c:if>
								    </tr>
								</c:forEach>
			         	</table>
			         	<div class="col-12 col-sm-20 mt-2 mt-sm-3 order-1 order-sm-1">
		    				<button type="submit" class="btn btn__second w-20">등록하기</button>
					    </div>
					</form>
				</div>
				<div class="row" style="height : 4rem;"></div>
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