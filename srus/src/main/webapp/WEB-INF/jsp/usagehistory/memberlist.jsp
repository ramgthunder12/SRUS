<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://sargue.net/jsptags/time" prefix="javatime" %>
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
						<h1 class="title title--h1 js-lines">이용내역 보기</h1>
					</header>
					<table class="table" style="text-align:center;">
						<thead>
							<tr class="paragraph--column">
								<th>일련번호</th><th>대여함 번호</th><th>구분</th><th>이용 일자</th>
					 	   </tr>
					    </thead>
				        <c:forEach var="usageHistory" items="${rows}" varStatus="status">
					     	<tr class="paragraph--row">
					     		<td>${status.count}</td>
				         		<td>${usageHistory.rentalBoxNo}번 대여함</td>
				         		<c:if test="${usageHistory.division eq 'O' }">
				         			<td>열림</td>
								 </c:if>
				        		<c:if test="${usageHistory.division eq 'C' }">
					         			<td>닫힘</td>
				         		</c:if>
				         		<td>
					         		<c:choose>
						         		<c:when test="${usageHistory.usageDate.getSecond() eq 0}">
							     			<fmt:parseDate value="${usageHistory.usageDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
											<fmt:formatDate pattern="yyyy-MM-dd '<br>'HH시mm분00초" value="${ parsedDateTime }" /> 
						         		</c:when>
						         		<c:otherwise>
							         		<fmt:parseDate value="${usageHistory.usageDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
											<fmt:formatDate pattern="yyyy-MM-dd '<br>'HH시mm분ss초" value="${ parsedDateTime }" /> 
										</c:otherwise>
					         		</c:choose>
				         		</td>
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