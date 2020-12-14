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
		<link rel="stylesheet" type="text/css" href="/styles/style.css" />
		<link rel="shortcut icon" href="/images/favicons/favicon.png" type="image/png">
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
	
		<c:if test="${member.division eq 'A'}">
		<%@ include file="/WEB-INF/jsp/layout/topwhiteadmin.jsp"%>
		</c:if>
		<c:if test="${member.division eq 'M'}">
		<%@ include file="/WEB-INF/jsp/layout/topwhite.jsp"%>
		</c:if>
		<c:if test="${member eq null }">
		<%@ include file="/WEB-INF/jsp/layout/topwhite.jsp"%>
		</c:if>
	
		<!-- Content -->
		<main class="main">

			<!-- Intro -->
			<section class="intro">
				<div class="intro__bg-wrap">
					<div class="overlay intro__bg js-image js-parallax"
						data-image="/images/anotherspace.jpg"></div>
				</div>
				<div class="container intro__container">
					<div class="row h-100 align-items-center">
						<div class="col-12 col-md-12 col-xl-8">
							<span class="title title--overhead text-white js-lines">Welcome to 공간 대여 무인 시스템</span>
							<h1 class="title title--display-1 js-lines">
								Another Think<br/> Another Space<br/> Another Level
							</h1>
						</div>
					</div>
				</div>
			</section>
	
			<!-- /Intro -->

			<!-- JavaScripts -->
			<script src="/js/jquery-3.4.1.min.js"></script>
			<script src="/js/plugins.js"></script>
			<script src="/js/common.js"></script>
		</main>
		<!-- Footer -->
		<%@ include file="/WEB-INF/jsp/layout/bottom.jsp"%>
	</body>
</html>