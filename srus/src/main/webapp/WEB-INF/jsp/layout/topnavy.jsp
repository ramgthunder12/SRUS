<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Header -->
<header class="header">
	<nav class="navbar">
		<a class="logo-link" href="/main">
			<img class="logotype" src="/images/ui/logo-black.svg" alt="AnotherSpace">
		</a>
		<div class="navbar__menu">
			 <ul class="nav">
				<li class="nav__item _is-current" ><a class="nav__link" href="/rental/step1"><span data-hover="Rental">대여하기</span></a></li>
				<li class="nav__item"><a class="nav__link" href="/rental/${member.id}"><span data-hover="RentalList">대여 내역 조회</span></a></li>
				<li class="nav__item"><a class="nav__link" href="/usagehistory/${member.id}"><span data-hover="UsageHistory">이용 내역 조회</span></a></li>
				<li class="nav__item"><a class="nav__link" href="/member/${member.id}"><span data-hover="My Info">정보 조회</span></a></li>
				<li class="nav__item"><a class="btn btn__medium" href="/login"><i class="btn-icon-left icon-bookmark"></i>로그인</a></li>
			</ul>
		</div>
		<div>
		<c:if test="${member.id ne null}">
			<a class="btn btn__medium" href="/logout"><i class="btn-icon-left icon-bookmark"></i>로그아웃</a>
		</c:if>
		<c:if test="${member.id eq null}"><a class="btn btn__medium" href="/login"><i class="btn-icon-left icon-bookmark"></i>로그인</a></c:if>
		</div>
	</nav>
</header>
<!-- /Header -->
