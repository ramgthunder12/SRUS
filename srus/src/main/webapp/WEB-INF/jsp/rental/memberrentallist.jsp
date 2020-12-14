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
						<h1 class="title title--h1 js-lines">대여 정보 보기</h1>
					</header>
					<jsp:useBean id="today" class="java.util.Date" />
					<fmt:formatDate var="now" value="${today}" pattern="yyyy-MM-dd" />
					
					<table class="table" style="text-align:center;">
						<thead>
						<tr class="paragraph--column">
							<th>일련번호</th>
							<th>대여함 번호</th>
							<th>대여 시작일</th>
							<th>대여 종료일</th>
							<th>결제 금액</th>
							<th>결제 일자</th>
							<th>취소 일자</th>
					    </tr>
					    </thead>
				        <c:forEach var="rental" items="${rows}" varStatus="status">
					        <tr class="paragraph--row">
					         	<td>${status.count}</td>
					         	<td>${rental.rentalBoxNo}<span>번 대여함</span></td><td>${rental.startDate}</td><td>${rental.endDate}</td>
					         	<td><fmt:formatNumber value="${rental.amountOfPayment}"/><span> 원</span></td><td>${rental.paymentDate}</td>
					         	<c:if test="${rental.cancellationDate ne null}"><td>${rental.cancellationDate}</td></c:if>
					         	<c:if test="${rental.cancellationDate eq null}">
					         		<c:choose>
						         		<c:when test="${now>rental.startDate}">
						         			<td><div><button type="button" class="btn btn__second" disabled="true">취소 불가</button></div></td>
						        		</c:when>
						        		<c:otherwise>
						    				<td><div><button type="button" onclick="location.href='/payment/cancel?no=${rental.no}'"class="btn btn__second">대여 취소</button></div></td>				         			
						    			</c:otherwise>
					         		</c:choose>
					        	</c:if>
					    	</tr>
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