<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Header 상단 메뉴 include-->
<header class="header">
	<nav class="navbar navbar-white navbar-overlay">
		<a class="logo-link" href="/main">
			<img class="logotype" src="/images/ui/logo-white.svg" alt="AnotherSpace">
		</a>
		<div class="navbar__menu">
			<!-- 왼쪽 상단 메뉴 -->
			<ul class="nav">
				<li class="nav__item _is-current"><a class="nav__link" href="/member"><span data-hover="Member List">사용자 목록 보기</span></a></li>
				<li class="nav__item"><a class="nav__link" href="/rentalbox"><span data-hover="RentalBox List">무인 대여함 보기</span></a></li>
				<li class="nav__item"><a class="nav__link" href="/rental"><span data-hover="Rental List">대여 정보 보기</span></a></li>
				<li class="nav__item"><a class="nav__link" href="/usagehistory"><span data-hover="Usage History">이용 내역 보기</span></a></li>
				<li class="nav__item"><a class="btn btn__medium" href="/login"><i class="btn-icon-left icon-bookmark"></i>로그인</a></li>
			</ul>
		</div>
	   <div>
		<c:if test="${member.id ne null}">
			<a class="btn btn__medium" href="/logout"><i class="btn-icon-left icon-bookmark"></i>로그아웃</a>
		</c:if>
		<c:if test="${member.id eq null}">
			<a class="btn btn__medium" href="/login"><i class="btn-icon-left icon-bookmark"></i>로그인</a>
		</c:if>
		</div>
	</nav>
</header>
<!-- /Header -->