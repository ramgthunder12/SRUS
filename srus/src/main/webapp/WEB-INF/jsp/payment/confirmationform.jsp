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
    	<%@ include file="/WEB-INF/jsp/layout/topnavy.jsp" %>
	<!-- Content -->
	<main class="main reservation-page">
        <div class="reservation-page__left">
		    <div class="reservation-page__wrap">
		        <h2 class="title title--h2 text-center">결제 확인</h2>
			    <p class="paragraph text-center">결제하기 전 대여 정보를 확인해주세요</p>
			    <div class="row mt-2 mt-sm-4">
			        <div class="col-12">
				        <div class="reservation-card-confirm">
						    <h4 class="title title--h4">대여하기</h4>
							<div class="d-flex align-items-end justify-content-center">
							    <div class="date-reserv">
							        <div class="date-reserv__label title title--overhead-small">대여 시작일</div>
								    <div class="date-reserv__date">${rental.startDate}</div>
							    </div>
							    <div class="line"></div>
							    <div class="date-reserv">
							        <div class="date-reserv__label title title--overhead-small">대여 종료일</div>
								    <div class="date-reserv__date">${rental.endDate}</div>
							    </div>
							</div>
							<div class="total-reserv">결제 금액: <span>${rental.amountOfPayment}원</span></div>
						</div>
					</div>
				    <div class="col-12 col-sm-6 mt-2 mt-sm-3 order-2 order-sm-1">
				        <a href="/rental/step2/${rental.rentalBoxNo}" class="btn btn__medium btn__second w-100">뒤로</a>
				    </div>
				    <div class="col-12 col-sm-6 mt-2 mt-sm-3 order-1 order-sm-2">
					   <input type="button" name="paymentbtn" onclick="payment_click();" class="btn btn__medium w-100" value="결제하기"/></div>
			    </div>
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
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <script>
	    function payment_click() {
			var IMP = window.IMP; // 생략가능
			IMP.init('imp32083772'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
			IMP.request_pay({
			    pg : 'inicis', // version 1.1.0부터 지원.
			    pay_method : 'card',
			    merchant_uid : 'merchant_' + new Date().getTime(),
			    name : ${rental.rentalBoxNo} + ' 번 무인 대여함 대여',
			  	amount : 1,
			    // amount : ${rental.amountOfPayment},
			    buyer_name : '${rental.memberId}',
			    buyer_email : '${member.email}',
			    buyer_tel : '${member.phoneNumber}',
			    m_redirect_url : 'https://localhost/payment/success'
			}, function(rsp) {
			    if ( rsp.success ) {
			        var msg = '결제가 완료되었습니다.';
			        msg += '고유ID : ' + rsp.imp_uid;
			        msg += '상점 거래ID : ' + rsp.merchant_uid;
			        msg += '결제 금액 : ' + rsp.paid_amount;
			        msg += '카드 승인번호 : ' + rsp.apply_num;
			        //무인 대여함 번호, 아이디,결재 금액, 결제 일자, 대여 시작일, 대여 종료일 ,merchantUid 해야한다.
				        post_to_url('/rental',{'rentalBoxNo':${rental.rentalBoxNo},
				        'memberId':'${rental.memberId}',
				        'paymentDate':'${rental.paymentDate}',
			        	'amountOfPayment': rsp.paid_amount,
			        	'startDate':'${rental.startDate}',
			        	'endDate':'${rental.endDate}',
			        	'merchantUid':rsp.merchant_uid});
			    } else {
			        var msg = '결제에 실패하였습니다.';
			        window.location.href = '/payment/confirmationform?rentalBoxNo=${rental.rentalBoxNo}&startDate=${rental.startDate}&endDate=${rental.endDate}';
			    	alert(msg);
			    }
			});
	    }
			
	 		function post_to_url(path, params, method) {
			    method = method || "post"; // Set method to post by default, if not specified.
			    // The rest of this code assumes you are not using a library.
			    // It can be made less wordy if you use one.
			    var form = document.createElement("form");
			    form.setAttribute("method", method);
			    form.setAttribute("action", path);
			    for(var key in params) {
			        var hiddenField = document.createElement("input");
			        hiddenField.setAttribute("type", "hidden");
			        hiddenField.setAttribute("name", key);
			        hiddenField.setAttribute("value", params[key]);
			        form.appendChild(hiddenField);
			    }
			    document.body.appendChild(form);
			    form.submit();
			}
	</script>

</body>
</html>