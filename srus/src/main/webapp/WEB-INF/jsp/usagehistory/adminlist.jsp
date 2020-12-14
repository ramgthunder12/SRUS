<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		<link rel="stylesheet" type="text/css" href="/styles/style.css" />
		
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
						<h1 class="title title--h1 js-lines">이용내역 보기</h1>
					</header>
				</div>
				
				<div class="sub-header filters-room sticky">
					<div class="container">
						<div class="row">
							<div class="col-12 col-md-6 col-lg-6 col-xl-4"></div>
							<div class="col-12 col-md-6 col-lg-6 col-xl-4">
								<div class="usageHistoryList">
									<select class="custom-select" name="selectRentalBox" id="selectRentalBoxID" onchange="selectRentalBox()">
											<option value="" selected disabled hidden onchange="">무인대여함 번호</option>
											<option value="0">전체</option>
											<c:forEach var="rentalBox" items="${rows}">
												<option value="${rentalBox.no}">${rentalBox.no}</option>
											</c:forEach>
									</select>
								</div>
							</div>
						</div>
					 </div>
				</div>
		
				<div id="table" class="table"></div>
				<div class="row" style="height : 4rem;"></div>
			</section>
		</main>
		<!-- Footer -->
		<%@ include file="/WEB-INF/jsp/layout/bottom.jsp" %>
	
		<!-- JavaScripts -->
		<script src="/js/jquery-3.4.1.min.js"></script>
		<script src="/js/plugins.js"></script>
		<script src="/js/common.js"></script>
			<script>
				var selectText = "";
				
				$(document).ready(function() {
					defualtTable();
				});
		
				function defualtTable() {
					$.ajax({
						url : "${pageContext.request.contextPath}/usagehistory",
						type : "get",
						data : { },
						headers : {
							"Content-Type" : "application/json;charset=UTF-8"
						},
						success : function(rows) {
							drawTable(rows);
						}
					})
				};
		
				function selectRentalBox() {
					var langSelect = document.getElementById("selectRentalBoxID");
					
					selectText = langSelect.options[langSelect.selectedIndex].value;		
					selectTable();
				};
		
				function selectTable() {
					$.ajax({
						url : "${pageContext.request.contextPath}/usagehistory",
						type : "get",
						data : { rentalBoxNo : selectText },
						headers : { "Content-Type" : "application/json;charset=UTF-8" },
						success : function(rows) {
							drawTable(rows);
						}
					});
				};
		
				function drawTable(rows) {
					var script = "";
		
					script += "<table class='table' style=\"text-align:center;\">";
					script += "<thead>";
					script += "<tr class=\"paragraph--column\">";
					script += "<th>일련번호</th><th>사용자 아이디</th><th>대여함 번호</th><th>이용 일자</th><th>구분</th>";
					script += "</tr>";
					script += "</thead>";
		
					for (var i = 0; i < rows.length; i++) {
						var usageDate = new Date(rows[i].usageDate);
						script += "    <tr class=\"paragraph--row\">";
						script += "    	   <td>" + rows[i].no + "</td>";
						if (rows[i].memberId == null) {
							script += "	       <td>" + "</td>";
						} else {
							script += "	       <td>" + rows[i].memberId + "</td>";
						}
						script += "	       <td>" +  rows[i].rentalBoxNo +"번 대여함" + "</td>";
						script += "	       <td>" + formatUsageDate(usageDate) + "</td>";
						if(rows[i].division == 'O') {
						script += "	       <td>열림</td>";
						} else {
							script += " <td>닫힘</td>";
						}
						script += "    </tr>";
					}
		
					script += "</table>";
		
					$("#table").html(script);
				};
					
				function formatUsageDate(usageDate) {
			        var year = usageDate.getFullYear();
			        var month = usageDate.getMonth() + 1;
			        var day = usageDate.getDate();
			        var hour = usageDate.getHours();
			        var minute = usageDate.getMinutes();
			        var second = usageDate.getSeconds();
		
			        return year + '-' + month + '-' + day + '<br/>' + hour + '시 ' + minute + '분 ' + second + '초';
				};
		</script>
	
	</body>
</html>
