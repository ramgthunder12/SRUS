<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>SRUS – Another space</title>

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
	            <svg class="mask-object" viewBox="0 0 97.08 51.71">
			        <defs>
				        <path fill="none" id="thePath1" d="M 27.32 1 v 8 H 11.9 v 8.46 A 9.3 9.3 0 0 1 19.35 14 c 3.42 0 6 0.95 7.77 2.87 s 2.63 5.61 2.63 11.06 V 35 a 42.36 42.36 0 0 1 -0.51 7.76 a 10.9 10.9 0 0 1 -2.17 4.59 a 10.48 10.48 0 0 1 -4.63 3.23 a 20.51 20.51 0 0 1 -7.24 1.12 A 20.09 20.09 0 0 1 6.74 50 a 10.07 10.07 0 0 1 -5.2 -5 C 0.51 42.82 0 39.4 0 34.76 V 32.05 H 12.43 v 3.11 A 46.85 46.85 0 0 0 12.77 42 a 2.15 2.15 0 0 0 2.33 2 a 2 2 0 0 0 1.5 -0.58 a 2 2 0 0 0 0.61 -1.26 c 0 -0.46 0.07 -2.41 0.11 -5.88 V 26.46 a 8.49 8.49 0 0 0 -0.59 -3.82 a 2 2 0 0 0 -1.93 -1 a 2.08 2.08 0 0 0 -1.45 0.52 a 2.36 2.36 0 0 0 -0.75 1.12 a 13.05 13.05 0 0 0 -0.17 2.79 H 0.12 L 0.65 1 Z"/>
				        <path fill="none" id="thePath2" d="M 63.31 17.81 V 34.42 a 39.32 39.32 0 0 1 -0.62 8.25 a 11.44 11.44 0 0 1 -2.55 4.83 a 11.07 11.07 0 0 1 -4.68 3.23 a 18.1 18.1 0 0 1 -6.12 1 a 22.69 22.69 0 0 1 -7.41 -1 a 10.23 10.23 0 0 1 -4.71 -3.21 a 13.74 13.74 0 0 1 -2.49 -4.6 A 28.8 28.8 0 0 1 34 35.19 V 17.81 c 0 -4.57 0.4 -8 1.19 -10.27 a 10.14 10.14 0 0 1 4.7 -5.48 A 16.69 16.69 0 0 1 48.42 0 a 17.94 17.94 0 0 1 7.32 1.43 a 12.27 12.27 0 0 1 4.83 3.49 a 11.5 11.5 0 0 1 2.17 4.65 A 42.32 42.32 0 0 1 63.31 17.81 Z M 50.88 13.63 a 19 19 0 0 0 -0.38 -5 a 1.7 1.7 0 0 0 -1.8 -1 a 1.76 1.76 0 0 0 -1.83 1.06 a 16.07 16.07 0 0 0 -0.45 4.91 v 24.3 c 0 2.89 0.14 4.63 0.41 5.23 a 1.79 1.79 0 0 0 1.8 0.89 a 1.76 1.76 0 0 0 1.82 -1 a 15.43 15.43 0 0 0 0.43 -4.7 Z"/>
				        <path fill="none" id="thePath3" d="M 97.08 17.81 V 34.42 a 39.49 39.49 0 0 1 -0.61 8.25 a 11.44 11.44 0 0 1 -2.55 4.83 a 11.14 11.14 0 0 1 -4.68 3.23 a 18.19 18.19 0 0 1 -6.12 1 a 22.72 22.72 0 0 1 -7.42 -1 A 10.25 10.25 0 0 1 71 47.47 a 13.74 13.74 0 0 1 -2.49 -4.6 a 28.38 28.38 0 0 1 -0.74 -7.68 V 17.81 c 0 -4.57 0.39 -8 1.18 -10.27 a 10.16 10.16 0 0 1 4.71 -5.48 A 16.67 16.67 0 0 1 82.2 0 a 18 18 0 0 1 7.32 1.43 a 12.27 12.27 0 0 1 4.83 3.49 a 11.48 11.48 0 0 1 2.16 4.65 A 42.32 42.32 0 0 1 97.08 17.81 Z M 84.66 13.63 a 18.37 18.37 0 0 0 -0.39 -5 a 1.7 1.7 0 0 0 -1.8 -1 a 1.78 1.78 0 0 0 -1.83 1.06 a 16.18 16.18 0 0 0 -0.44 4.91 v 24.3 c 0 2.89 0.13 4.63 0.41 5.23 a 1.79 1.79 0 0 0 1.8 0.89 a 1.76 1.76 0 0 0 1.82 -1 a 15.78 15.78 0 0 0 0.43 -4.7 Z"/>
					</defs>
				    <clipPath id="mask">
				        <use xlink:href="#thePath1"/>
				        <use xlink:href="#thePath2"/>
				        <use xlink:href="#thePath3"/>
				    </clipPath>
				    <image clip-path="url(#mask)" width="100%" height="100%" xlink:href="/images/big.jpg"></image>
				    <use xlink:href="#thePath1"/>
				    <use xlink:href="#thePath2"/>
				    <use xlink:href="#thePath3"/>
			    </svg>
			    <div class="paragraph">잘못된 요청입니다.</div>
	        </div>
	    </div>
	</main>
	<!-- /Content -->
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/jsp/layout/bottom.jsp" %>
	
	<!-- JavaScripts -->
	<script src="/js/jquery-3.4.1.min.js"></script>
	<script src="/js/plugins.js"></script>
    <script src="/js/common.js"></script>
	
</body>
</html>