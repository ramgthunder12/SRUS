<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8" />
	<title>SRUS – Another space</title>
	
	<!-- Meta Data -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
		content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="format-detection" content="address=no" />
	<meta name="author" content="ArtTemplates" />
	<meta name="description"
		content="AnotherSpace — SRUS" />
	
	<!-- Twitter data -->
	<meta name="twitter:card" content="summary_large_image">
	<meta name="twitter:site" content="@ArtTemplates">
	<meta name="twitter:title" content="AnotherSpace">
	<meta name="twitter:description"
		content="AnotherSpace — SRUS">
	<meta name="twitter:image" content="/images/social.jpg">
	
	<!-- Open Graph data -->
	<meta property="og:title" content="ArtTemplate" />
	<meta property="og:type" content="website" />
	<meta property="og:url" content="your url website" />
	<meta property="og:image" content="/images/social.jpg" />
	<meta property="og:description"
		content="AnotherSpace — SRUS" />
	<meta property="og:site_name" content="AnotherSpace" />
	
	<!-- Favicons -->
	<link rel="apple-touch-icon" sizes="144x144"
		href="/images/favicons/apple-touch-icon-144x144.png">
	<link rel="apple-touch-icon" sizes="114x114"
		href="/images/favicons/apple-touch-icon-114x114.png">
	<link rel="apple-touch-icon" sizes="72x72"
		href="/images/favicons/apple-touch-icon-72x72.png">
	<link rel="apple-touch-icon" sizes="57x57"
		href="/images/favicons/apple-touch-icon-57x57.png">
	<link rel="shortcut icon" href="/images/favicons/favicon.png"
		type="image/png">
	
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

	<!-- Content -->
	<main class="main reservation-page">
		<div class="reservation-page__left">

			<div class="reservation-page__wrap">
				<a class="itemGallery__link" href="/main" data-size="600x600"> 
					<img class="cover ls-is-cached lazyloaded" src="/images/logo.jpg" alt="AnotherSpace">
				</a>

				<form id="payment-form" class="row mt-2 mt-sm-4" action="/login" method="post">
					<div class="col-12">
						<div class="form-group">
							<label class="label" for="id">아이디</label> 
							<input type="text" class="inputText" id="id" name="id" placeholder="아이디를 입력해주세요." required="required" autocomplete="off">
						</div>
					</div>
					<div class="col-12">
						<div class="form-group">
							<label class="label" for="password">비밀번호</label> 
							<input type="password" class="inputText" id="password" name="password" placeholder="비밀번호를 입력해주세요." required="required" autocomplete="off">
						</div>
						<p class="paragraph text-center" style="color: red">${errorMessage}</p>
					</div>
					<div class="col-12 col-sm-20 mt-2 mt-sm-3 order-1 order-sm-1">
						<button type="submit" class="btn btn__medium w-100">로그인</button>
					</div>
					<div class="col-12 col-sm-3 mt-8 mt-sm-3 order-2 order-sm-2">
						<a href="/member/findid" class="label">아이디 찾기</a>
					</div>
					<div class="col-12 col-sm-3 mt-2 mt-sm-3 order-2 order-sm-3">
						<a href="/member/findpassword" class="label">비밀번호 찾기</a>
					</div>
					<div class="col-12 col-sm-3 mt-2 mt-sm-3 order-2 order-sm-4">
						<a href="/member/form" class="label">회원 가입</a>
					</div>
				</form>
			</div>
		</div>
		<div class="reservation-page__right js-image js-scale-down" data-image="/images/ex2.jpg"></div>
	</main>
	<!-- Footer -->
	<%@ include file="/WEB-INF/jsp/layout/bottom.jsp" %>
	<!-- /Content -->
	<!-- JavaScripts -->
	<script src="/js/jquery-3.4.1.min.js"></script>
	<script src="/js/plugins.js"></script>
	<script src="/js/jquery.creditCardValidator.js"></script>
	<script src="/js/common.js"></script>
	
</body>
</html>