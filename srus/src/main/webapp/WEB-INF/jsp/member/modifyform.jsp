<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
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
	<%@ include file="/WEB-INF/jsp/layout/topnavy.jsp"%>

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
				<h2 class="title title--h2 text-center">내 정보 수정</h2>
				<p class="paragraph text-center"></p>
				<form class="row mt-2 mt-sm-4" action="/member/${row.id}" method="post">
					<div class="col-12">
						<div class="form-group">
							<label class="label" for="email">이메일</label>
							<div class="position-relative">
								<input type="email" class="inputText inputText__icon" id="email" name="email" value="${row.email}" placeholder="이메일을 입력해주세요." required="required"
									autocomplete="off" title="이메일 형식에 맞지 않습니다." pattern="^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+).(\.[0-9a-zA-Z_-]+){1,2}$">
								<span class="input-icon icon-mail"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="label" for="phone">핸드폰 번호</label>
							<div class="position-relative">
								<input type="tel" class="inputText inputText__icon" id="phoneNumber" name="phoneNumber" value="${row.phoneNumber}" placeholder="000-0000-0000" required="required"
									autocomplete="off" maxlength="13" title="000-0000-0000 형식입니다." pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}">
								<span class="input-icon icon-phone"></span>
							</div>
						</div>
						<div class="form-group">
							<c:if test="${row.cardName ne null}">
								<label class="label" for="cardName">Your card</label>
								<div class="position-relative">
									<input type="text" class="inputText inputText__icon" id="cardName" name="cardName" value="${row.cardName}">
									<span class="input-icon icon-credit-card"></span>
								</div>
							</c:if>
						</div>
					</div>

					<div class="col-12 col-sm-20 mt-2 mt-sm-3 order-1 order-sm-1">
						<input type="hidden" name="_method" value="PUT" />
						<button type="submit" class="btn btn__large w-100">수정</button>
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
	<script>
		var autoHypenPhone = function(str) {
			str = str.replace(/[^0-9]/g, '');
			var tmp = '';
			if (str.length < 4) {
				return str;
			} else if (str.length < 7) {
				tmp += str.substr(0, 3);
				tmp += '-';
				tmp += str.substr(3);
				return tmp;
			} else if (str.length < 11) {
				tmp += str.substr(0, 3);
				tmp += '-';
				tmp += str.substr(3, 3);
				tmp += '-';
				tmp += str.substr(6);
				return tmp;
			} else {
				tmp += str.substr(0, 3);
				tmp += '-';
				tmp += str.substr(3, 4);
				tmp += '-';
				tmp += str.substr(7);
				return tmp;
			}

			return str;
		}

		var phoneNum = document.getElementById('phoneNumber');

		phoneNum.onkeyup = function() {
			console.log(this.value);
			this.value = autoHypenPhone(this.value);
		}
	</script>
</body>
</html>