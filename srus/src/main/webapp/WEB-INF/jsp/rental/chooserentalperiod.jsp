<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
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

	<!-- Header -->
	<!-- /Header -->

	<%@ include file="/WEB-INF/jsp/layout/topwhite.jsp"%>
	<!-- Content -->
	<main class="main">
		<!-- Intro -->
		<section class="intro">
			<div class="intro__bg-wrap">
				<div class="overlay intro__bg js-image js-parallax js-scale-down"
					data-image="/images/black.jpg"></div>
			</div>
			<div class="container intro__container">
				<div class="row h-100 align-items-center align-items-center justify-content-center">
					<div class="col-12 col-xl-8 text-center">
						<span class="title title--overhead text-white js-lines"></span>
						<h1 class="title title--display-1 js-lines">${row.no}번 대여함</h1>
					</div>
				</div>
			</div>
			<!-- Scroll To -->
			<a class="scroll-to" href="!#content">
			Scroll
			<span class="scroll-to__line"></span>
			</a>
		</section>
		<!-- /Intro -->

		<!-- Room base info -->
		<div class="bottom-panel bottom-panelRoom">
			<div class="bottom-panel__wrap">
				<div class="row h-100 align-items-center">
					<div class="col-12 col-md-12 col-xl-8">
						<div class="row room-details">
							<div class="col-4 room-details__item slash">
								<i class="icon-maximize"></i>${row.size}</div>
							<div class="col-4 room-details__item">
								<i class="icon-navigation-2"></i>${row.location}</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /Room base info -->

		<!-- Content -->
		<section id="content" class="container">
			<div class="row sticky-parent">
				<div class="col-md-12 col-xl-8 order-2 order-xl-1 mt-4 mt-sm-5">
					<!-- Description room -->
					<h3 class="title title--h2">${row.location} ${row.model}무인 대여함</h3>
						Another space에 나만의 공간을 마련하고 잠시 불필요한 짐을 보관하세요.<br>
						여러분의 삶에 변화가 찾아옵니다.
						
					</p>
					
					<h4 class="title title--h3">이사할 때</h4>
					<p>
					입주 날짜가 안 맞아도 걱정하지 마세요. 가구부터 개인 용품까지 안전 보관을 도와 드립니다.<br>
					짐은 저희에게 맡겨두시고 다른 볼일 편안하게 보세요.
					</p>
					
					<h6 class="title title--h3">취미 생활</h6>
					<p>
					수집가나 장비가 필요한 스포츠를 취미로 하시는 분들은 보관 장소에 대한 어려움을 겪습니다.<br>
					즐거워야 하는 취미 용품에 스트레스받지 마시고 쾌적한 환경에 보관하세요.<br>
					필요할 때 언제든 꺼내 쓸 수 있습니다.
					</p>
					
					<h6 class="title title--h3">높은 보안성</h6>
					<p>
					골동품이나 아끼는 물건을 집에 두는 것이 가장 안전할까요?<br>
					철저한 보안 시설인 Another space에 보관하시고 마음의 안정을 찾아보세요.<br>
					</p>

					<!-- Rating & Review -->
				</div>

				<!-- Sidebar Booking -->
				<div class="col-md-12 col-xl-4 order-1 order-xl-2">
					<div class="sidebar-booking sticky-column">
						<div class="sidebar-booking__priceWrap">
							<div class="priceWrap-title">금액</div>
							<div class="priceWrap-price">
								${row.charge}원 <span> 하루</span>
							</div>
						</div>

						<form class="sidebar-booking__wrap" action="/payment/confirmationform" method="get">
							<!-- Dates -->
							<div class="form-group">
								<label class="label" for="startDate">Dates</label>
								<div class="form-dual form-dual--mobile">
									<div class="form-dual__left">
										<input type="hidden" id="rentalBoxNo" name="rentalBoxNo" value="${row.no}">
										<input type="text" class="inputText inputText__icon readonly dateSelector" id="startDate" name="startDate" placeholder="시작일"
										required="required" autocomplete="off"> 
										<span class="input-icon icon-calendar"></span>
									</div>
									<div class="form-dual__right">
										<input type="text" class="inputText inputText__icon readonly dateSelector" id="endDate" name="endDate" placeholder="종료일"
										required="required" autocomplete="off"> 
										<span class="input-icon icon-calendar"></span>
									</div>
								</div>
							</div>

							<div class="row">

								<div class="col-12 mt-1">
									<button type="submit" class="btn btn__medium w-100">결제</button>
								</div>
								<span class="sidebar-booking__note">Until you pay for anything</span>
							</div>
						</form>
					</div>
				</div>
				<!-- /Sidebar Booking -->
			</div>
		</section>
		<!-- /Content -->
	</main>
	<!-- /Content -->
	<!-- Footer -->
	<%@ include file="/WEB-INF/jsp/layout/bottom.jsp" %>

	<!-- JavaScripts -->
	<script src="/js/jquery-3.4.1.min.js"></script>
	<script src="/js/plugins.js"></script>
	<script src="/js/common.js"></script>
	<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
	<script>
    	console.log( " 대여 불가능 날짜 : " + '${unrentalDateList}');
    	
	    var dateSelector = document.querySelector('.dateSelector');
	    dateSelector.flatpickr({
	    	dateFormat: "Y-m-d",
	        minDate: 'today',
	        closeOnSelect: false,
	        allowInput: true,
	        position: 'auto',
	        monthSelectorType: 'static',
            yearSelectorType: 'static',
	        nextArrow: '<svg viewBox="0 0 32 32"><path fill-rule="evenodd" d="M32 16c0-8.83656-7.1634-16-16-16C7.16344 0 0 7.16344 0 16c0 8.8366 7.16344 16 16 16 8.8366 0 16-7.1634 16-16zM16 31c8.2843 0 15-6.7157 15-15 0-8.28427-6.7157-15-15-15C7.71573 1 1 7.71573 1 16c0 8.2843 6.71573 15 15 15z" clip-rule="evenodd" opacity=".2"/><path d="M15.4697 13.0303c-.2929-.2929-.2929-.7677 0-1.0606.2929-.2929.7677-.2929 1.0606 0l3.5 3.5c.2929.2929.2929.7677 0 1.0606l-3.5 3.5c-.2929.2929-.7677.2929-1.0606 0-.2929-.2929-.2929-.7677 0-1.0606l2.2196-2.2197H12.5c-.4142 0-.75-.3358-.75-.75s.3358-.75.75-.75h5.1893l-2.2196-2.2197z"/></svg>',
            prevArrow: '<svg viewBox="0 0 32 32"><path fill-rule="evenodd" d="M0 16C0 7.16344 7.16344 0 16 0c8.8366 0 16 7.16344 16 16 0 8.8366-7.1634 16-16 16-8.83656 0-16-7.1634-16-16zm16 15C7.71573 31 1 24.2843 1 16 1 7.71573 7.71573 1 16 1c8.2843 0 15 6.71573 15 15 0 8.2843-6.7157 15-15 15z" clip-rule="evenodd" opacity=".2"/><path d="M16.5303 13.0303c.2929-.2929.2929-.7677 0-1.0606-.2928-.2929-.7677-.2929-1.0606 0l-3.5 3.5c-.2929.2929-.2929.7677 0 1.0606l3.5 3.5c.2929.2929.7678.2929 1.0606 0 .2929-.2929.2929-.7677 0-1.0606L14.3107 16.75H19.5c.4142 0 .75-.3358.75-.75s-.3358-.75-.75-.75h-5.1893l2.2196-2.2197z"/></svg>',
	        
	    	
	        plugins: [
                new rangePlugin({
                    input: '#endDate'
                })
            ],
           "locale": "ko",
           
	        disable : ${unrentalDateList}
        });
	</script>
</body>
</html>