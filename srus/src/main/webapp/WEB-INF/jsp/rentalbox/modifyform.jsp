<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
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

    <div class="scroll-line"></div>

   <%@ include file="/WEB-INF/jsp/layout/topnavyadmin.jsp" %>
   
	<!-- Content -->
	<main class="main">
        <section class="container section section-first">
		    <div class="row justify-content-center">
			    <!-- Header post -->
			    <header class="col-12 col-lg-12 col-xl-10 post-header">
				    <div class="title title--overhead js-lines"></div>
				    <h1 class="title title--h2 js-lines">${row.no}번 무인대여함 수정</h1>
				</header>
				<form class="row mt-2 mt-sm-4" action="/rentalbox/${row.no}" method="POST">
			        <div class="col-12">
				        <div class="form-group">
				            <label class="label" for="model">모델명</label>
                            <div class="position-relative">
                                <input type="text" class="inputText inputText__icon" id="model" name="model" placeholder="모델명을 입력해주세요." required="required" 
							    	maxlength="30" autocomplete="off" title="모델명을 제대로 입력해 주세요. 최소 1자리, 최대 30자리입니다." value="${row.model}" pattern="[a-zA-Z0-9?,./;:\|`~!@#$%^&*()_-+=]{1,30}">
					            <span class="input-icon icon-file-text"></span>
							</div>	
					    </div>
				        <div class="form-group">
				            <label class="label" for="location">위치</label>
							<div class="position-relative">
							    <input type="text" class="inputText inputText__icon" id="location" name="location" placeholder="지역을 입력해주세요." required="required" 
							    	maxlength="50" autocomplete="off" title="지역명을 제대로 입력해 주세요. 최소 1자리, 최대 50자리입니다." value="${row.location}" pattern="[a-zA-Z0-9?,./;:\|`~!@#$%^&*()_-+=]{1,50}">
					            <span class="input-icon icon-navigation-2"></span>
							</div>
					    </div>
					      <div class="form-group">
				            <label class="label" for="size">크기</label>
							<div class="position-relative">
							    <input type="text" class="inputText inputText__icon" id="size" name="size" placeholder="크기를 입력해주세요. ex.3*3" required="required" 
							    	autocomplete="off" title="ex.3*3 형식으로 입력해주세요." value="${row.size}" pattern="([0-9]{1,10})([*]{1,1})([0-9]{1,10})">
					            <span class="input-icon icon-maximize"></span>
							</div>
					    </div>
					    <div class="form-group">
				            <label class="label" for="charge">요금</label>
							<div class="position-relative">
							    <input type="text" class="inputText inputText__icon" id="charge" name="charge" placeholder="금액을 입력해주세요." required="required" 
							    	maxlength="10" autocomplete="off" title="요금은 숫자만 허용합니다. 최소 1자리, 최대 10자리입니다." value="${row.charge}" pattern="[0-9]{1,10}">
					            <span class="input-icon icon-dollar-sign"></span>
							</div>
					    </div>
					    <div class="form-group">
						    <label class="label" for="division">구분</label>
						    <c:if test="${row.division eq 'Y'}">
							    <select name="division" class="custom-select">
							        <option value='Y' selected>사용 가능</option>
								    <option value='N'>사용 불가능</option>
								    <option value='D'>삭제</option>
							    </select>
						    </c:if>
						    <c:if test="${row.division eq 'N'}">
							    <select name="division" class="custom-select">
							        <option value='Y'>사용 가능</option>
								    <option value='N'selected>사용 불가능</option>
								    <option value='D'>삭제</option>
							    </select>
						    </c:if>
						</div>
				    </div>
				    
				     <input type="hidden" id="no" name="no" value="${row.no}">
			        
				    <div class="col-12 col-sm-6 mt-2 mt-sm-3 order-2 order-sm-1">
				        <a href="/rentalbox" class="btn btn__second w-100">목록으로</a>
				    </div>
					<div class="col-12 col-sm-6 mt-2 mt-sm-3 order-2 order-sm-1">
						<input type="hidden" name="_method" value="PUT"/> 
	    				<button type="submit" class="btn medium w-100">수정하기</button>
				    </div>
			    </form>
			</div>
			
		</section>
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