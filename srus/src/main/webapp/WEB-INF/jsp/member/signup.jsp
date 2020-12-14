<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    
	<!-- Content -->
	<main class="main reservation-page">
        <div class="reservation-page__left">
		    <div class="reservation-page__wrap">
		        <h2 class="title title--h2 text-center">회원 가입</h2>
			    <p class="paragraph text-center"></p>
			    <form class="row mt-2 mt-sm-4" action="/member" method="post">
			    	<input type="hidden" name="division" value="M">
			    	
			        <div class="col-12">
				        <div class="form-group">
				            <label class="label" for="name">아이디</label>
                            <div class="position-relative">
							    <input type="text" class="inputText inputText__icon" id="id" name="id" placeholder="아이디를 입력해주세요." required="required" 
							    	autocomplete="off" title="아이디는 소문자, 대문자, 숫자만 허용합니다. 최소 5자리 ,최대 20자리입니다." pattern="[a-zA-Z0-9]{5,20}">
					            <span class="input-icon icon-user"></span>
							</div>
							<p id="label_idCheckMessage"/>
					    </div>
					    <div class="form-group">
				            <label class="label" for="name">비밀번호</label>
                            <div class="position-relative">
							    <input type="password" class="inputText inputText__icon" id="password" name="password" placeholder="비밀번호를 입력해주세요." 
							    	required="required" autocomplete="off" title="비밀번호는 소문자, 대문자, 숫자, 특수기호 ?,./;:\|`~!@#$%^&*()_-+= 만 허용합니다. 최소 5자리, 최대 16자리입니다." 
							    	pattern="[a-zA-Z0-9?,./;:\|`~!@#$%^&*()_-+=]{5,16}">
					            <span class="input-icon icon-user"></span>
							</div>
					    </div>
				        <div class="form-group">
				            <label class="label" for="email">이메일</label>
                            <div class="position-relative">
							    <input type="email" class="inputText inputText__icon" id="email" name="email" placeholder="이메일을 입력해주세요." 
							    	required="required" autocomplete="off" title="이메일 형식에 맞지 않습니다." pattern="^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+).(\.[0-9a-zA-Z_-]+){1,2}$">
					            <span class="input-icon icon-mail"></span>
							</div>	
					    </div>
				        <div class="form-group">
				            <label class="label" for="phone">핸드폰 번호</label>
							<div class="position-relative">
                                <input type="tel" class="inputText inputText__icon" id="phoneNumber" name="phoneNumber" placeholder="000-0000-0000"
                                	required="required" autocomplete="off" maxlength="13" title="000-0000-0000 형식입니다." pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}">
					            <span class="input-icon icon-phone"></span>
							</div>
					    </div>
				    </div>
					<div class="col-12 col-sm-6 mt-2 mt-sm-3 order-2 order-sm-1">
				        <a href="/main" class="btn btn__medium btn__second w-100">취소</a>
				    </div>
				    <div class="col-12 col-sm-6 mt-2 mt-sm-3 order-1 order-sm-2">
				        <button type="submit" id="btn_register" class="btn btn__medium w-100">가입하기</button>
				    </div>
			    </form>
			</div>
		</div>
		<div class="reservation-page__right js-image js-scale-down" data-image="/images/ex2.jpg"></div>
	</main>
	<!-- Footer -->
	<%@ include file="/WEB-INF/jsp/layout/bottom.jsp" %>

	<!-- JavaScripts -->
	<script src="/js/jquery-3.4.1.min.js"></script>
	<script src="/js/plugins.js"></script>
    <script src="/js/common.js"></script>
	<script>
		var id = $("#id");
		$("#id").on('blur', function() {
			idCheck();
		});
		function idCheck() {
			var label_idCheckMessage = document.getElementById('label_idCheckMessage');
			var btn_register = document.getElementById('btn_register');
			$.ajax( {
				url : '${pageContext.request.contextPath}/member/idcheck?id=' + id.val(),
				type : 'get',
				headers : { "Content-Type" : "application/json;charset=UTF-8" },
				success : function(result) {
						if (result.isDuplicated) {
							label_idCheckMessage.textContent = '이미 중복된 아이디가 존재합니다.';
							btn_register.disabled = true;
						} else {
							label_idCheckMessage.textContent = '중복되지 않은 아이디입니다.';
							btn_register.disabled = false;
						}
					}
		})};
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