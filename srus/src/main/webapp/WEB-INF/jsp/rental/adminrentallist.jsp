<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
				<div class="preloader__progress">
					<span></span>
				</div>
			</div>
		</div>
		<%@ include file="/WEB-INF/jsp/layout/topnavyadmin.jsp"%>
	
		<!-- Content -->
		<main class="main">
			<section class="container section section-first">
				<div class="row justify-content-center">
					<!-- Header post -->
					<header class="col-12 col-lg-12 col-xl-10 post-header">
						<h1 class="title title--h1 js-lines">대여 목록 보기</h1>
					</header>
				<div class="sub-header filters-room sticky">
					<div class="container">
						<div class="row">
							<div class="col-12 col-md-6 col-lg-6 col-xl-4"></div>
							<div class="col-12 col-md-6 col-lg-6 col-xl-4">
								<input type="text" class="inputText inputText__icon" name="memberId" placeholder="사용자 아이디 입력">
							</div>
							<div>
								<input type="button" name="button_search" value="검색" onclick="drawTable()" class="btn btn__second w-20" />
							</div>
						</div>
					 </div>
				</div>
					<!-- Content post -->
					<div class="col-12" id=table></div>
				</div>
			</section>
		</main> 
		<!-- Footer -->
		<%@ include file="/WEB-INF/jsp/layout/bottom.jsp" %>
		
		<!-- JavaScripts -->
		<script src="/js/jquery-3.4.1.min.js"></script>
		<script src="/js/plugins.js"></script>
		<script src="/js/common.js"></script>
		<script>
			$(document).ready(function() {
				drawTable();
	
				$("button_search").click(function() {
					drawTable();
				});
	
			});
	
			function drawTable() {
				$
						.ajax({
							url : "${pageContext.request.contextPath}/rental",
							type : "GET",
							data : {
								memberId : $("input[name=memberId]").val()
							},
							headers : {
								"Content-Type" : "application/json;charset=UTF-8"
							},
							success : function(rows) {
								var script = "<table class=\"table\" style=\"text-align:center;\">";
								script += "<thead>";
								script += "<tr class=\"paragraph--column\">";
								script += "<th>일련번호</th><th>대여 시작일</th><th>대여 종료일</th><th>대여함 번호</th><th>아이디</th><th>결제 금액</th><th>결제 일자</th><th>취소 일자</th>";
								script += "</tr>";
								script += "</thead>";
	
								for (var i = 0; i < rows.length; i++) {
									script += "    <tr class=\"paragraph--row\">";
									script += "   <td>" + (i+1) + "</td>";
									script += "   <td>" + rows[i].startDate + "</td>";
									script += "   <td>" + rows[i].endDate + "</td>";
									script += "   <td>" + rows[i].rentalBoxNo + "<span>번 대여함</span></td>";
									script += "   <td>" + rows[i].memberId + "</td>";
									script += "   <td>" + rows[i].amountOfPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "<span> 원</span></td>";
									script += "   <td>" + rows[i].paymentDate + "</td>";
									if (rows[i].cancellationDate == null) {
										script += "   <td></td>";
									} else {
										script += "   <td>"
												+ rows[i].cancellationDate
												+ "</td>";
									}
									script += "</tr>";
								}
								script += "</table>";
	
								$("#table").html(script);
							}
						})
			};
		</script>
	</body>
</html>