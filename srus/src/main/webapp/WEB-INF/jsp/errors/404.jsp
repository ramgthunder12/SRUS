<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

    <!-- Mapbox-->
    <script src='https://api.mapbox.com/mapbox-gl-js/v1.4.1/mapbox-gl.js'></script>
    <link href='https://api.mapbox.com/mapbox-gl-js/v1.4.1/mapbox-gl.css' rel='stylesheet' />
	
</head>
<body>
    <!-- Preloader -->
    <div class="preloader">
	    <div class="preloader__wrap">
		    <div class="preloader__progress"><span></span></div>
		</div>
	</div>

	<c:if test="${member.division eq 'A'}">
		<%@ include file="/WEB-INF/jsp/layout/topnavyadmin.jsp" %>
	</c:if>
	<c:if test="${member.division eq 'M'}">
		<%@ include file="/WEB-INF/jsp/layout/topnavy.jsp" %>
	</c:if>
	<!-- /Header -->
	
	<!-- Content -->
	<main class="main">
        <div class="container-center">
            <div class="js-parallax-mouse">
	            <svg class="mask-object" viewBox="0 0 431 176">
			        <defs>
				        <path fill="none" id="thePath" d="M416.1 142.5v31.4h-39.6v-31.4h-74.2v-19L370 5.9h46.1v101.3h14.6v35.3h-14.6zm-196.4 32.6c-34.8 0-63.1-21.1-63.1-57.8v-59c0-36.5 28.3-57.8 63.1-57.8 34.6 0 62.6 21.4 62.6 57.8v59c.1 36.7-28 57.8-62.6 57.8zm-105.1-1.2H75v-31.4H.9v-19L68.5 5.9h46.1v101.3h14.6v35.3h-14.6v31.4z"/>
					</defs>
				    <clipPath id="mask">
				        <use xlink:href="#thePath"/>
				    </clipPath>
				    <image clip-path="url(#mask)" width="500" height="250" xlink:href="/images/big.jpg"></image>
				    <use xlink:href="#thePath"/>
			    </svg>
			    <div class="paragraph">잘못된 요청입니다.</div>
	        </div>
	    </div>
	</main>
	<!-- /Content -->
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/jsp/layout/bottom.jsp" %>

    <!-- Button Live Chat -->
	<div class="btn-floating js-show-to-scroll"><i class="icon-bubble"></i></div>
	
	<!-- JavaScripts -->
	<script src="/js/jquery-3.4.1.min.js"></script>
	<script src="/js/plugins.js"></script>
    <script src="/js/common.js"></script>

</body>
</html>