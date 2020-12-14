<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8" />
    <title>SRUS – Another space</title>

	<!-- Meta Data -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="format-detection" content="telephone=no"/>
    <meta name="format-detection" content="address=no"/>
    <meta name="author" content="ArtTemplates" />
    <meta name="description" content="AnotherSpace — SRUS" />

    <!-- Twitter data -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:site" content="@ArtTemplates">
    <meta name="twitter:title" content="AnotherSpace">
    <meta name="twitter:description" content="AnotherSpace — SRUS">
    <meta name="twitter:image" content="/images/social.jpg">

    <!-- Open Graph data -->
    <meta property="og:title" content="ArtTemplate" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="your url website" />
    <meta property="og:image" content="/images/social.jpg" />
    <meta property="og:description" content="AnotherSpace — SRUS" />
    <meta property="og:site_name" content="AnotherSpace" />

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
	
	<c:if test="${member.division eq 'A'}"><%@ include file="/WEB-INF/jsp/layout/topnavyadmin.jsp" %></c:if>
	<c:if test="${member.division eq 'M'}"><%@ include file="/WEB-INF/jsp/layout/topnavy.jsp" %></c:if>
     
	<!-- Content -->
	<main class="main reservation-page">
        <div class="reservation-page__left">
		    <div class="reservation-page__wrap">
		        <h2 class="title title--h2 text-center">내 정보 보기</h2>
			    <p class="paragraph text-center"></p>
			    <form class="row mt-2 mt-sm-4" action="/member/${row.id}" method="post">
			        <div class="col-12">
				        <div class="form-group">
				            <label class="label" for="name">아이디</label>
                            <div class="position-relative">
							    <input type="text" class="inputText inputText__icon" id="id" name="id" placeholder="${row.id}" disabled>
					            <span class="input-icon icon-user"></span>
							</div>
					    </div>
				        <div class="form-group">
				            <label class="label" for="email">이메일</label>
                            <div class="position-relative">
							    <input type="email" class="inputText inputText__icon" id="email" name="email" placeholder="${row.email}" disabled>
					            <span class="input-icon icon-mail"></span>
							</div>	
					    </div>
				        <div class="form-group">
				            <label class="label" for="phone">핸드폰 번호</label>
							<div class="position-relative">
                                <input type="tel" class="inputText inputText__icon" id="phoneNumber" name="phoneNumber" placeholder="${row.phoneNumber}" disabled>
					            <span class="input-icon icon-phone"></span>
							</div>
					    </div>
					    <div class="form-group">
				            <label class="label" for="cardName">카드명</label>
							<div class="position-relative">
                                <input type="text" class="inputText inputText__icon" id="cardName" name="cardName" placeholder="${row.cardName}" disabled>
					            <span class="input-icon icon-credit-card"></span>
							</div>
					    </div>
				    </div>
			        
					<div class="col-12 col-sm-6 mt-2 mt-sm-3 order-2 order-sm-1">
						<input type="hidden" name="_method" value="DELETE"/> 
	    				<button type="submit" class="btn btn__second w-100">회원 탈퇴</button>
				    </div>
				    <div class="col-12 col-sm-6 mt-2 mt-sm-3 order-2 order-sm-1">
				        <a href="/member/${row.id}/form" class="btn btn__medium w-100">수정하기</a>
				    </div>
			    </form>
			</div>
		</div>
		<div class="reservation-page__right js-image" data-image="/images/ex2.jpg"></div>
	</main>
	<!-- Footer -->
	<%@ include file="/WEB-INF/jsp/layout/bottom.jsp" %>
	
	<!-- JavaScripts -->
	<script src="/js/jquery-3.4.1.min.js"></script>
	<script src="/js/plugins.js"></script>
    <script src="/js/common.js"></script>

</body>
</html>