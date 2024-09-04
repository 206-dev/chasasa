<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>차박차박</title>
<link rel="stylesheet" href="/resources/kim/css/index.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>												
<script src="/resources/kim/js/index.js" defer></script>

<script src="/resources/lee/js/user/point.js" defer></script>
    

<script>
$(function(){
	let userid = `${loginSessionDto.userid}`;
	if(userid!==""){
		let gradeno = `${loginSessionDto.gradeno}`;
		if(gradeno!==""){
			if(parseInt(gradeno)>1){
				$(".nav-list").css("grid-template-columns", "1fr 1fr 1fr 1fr 1fr 1fr");	
			}else{
				$(".nav-list").css("grid-template-columns", "1fr 1fr 1fr 1fr 1fr");
			}
		}
	
	}else{
		$(".nav-list").css("grid-template-columns", "1fr 1fr 1fr 1fr 1fr");
	};
});
</script>    

</head>
<body>
    <!-- 광고 -->
    <%@include file="/WEB-INF/views/lee/include/timeboard.jsp"%>
    <!-- header -->
    <!-- 이벤트 include -->
    <%@ include file="/WEB-INF/views/lee/include/checkday.jsp" %>
    <%@ include file="/WEB-INF/views/lee/include/lottery.jsp" %>			
    
    <header class="header-Container">
        <div class="navbar-Logo">
            <a href="/"><img alt="" src="/resources/lee/image/logo4.png"></a>
            <span class="font-size-10 bold-500 ml-5"> 차박을 좋아하는 사람들..</span>
        </div>
        <div class="kim-event-container">
        	<button class="event-btn" id="openLotteryBtn" style="margin-right: 10px; width: 100px">포인트 복권</button>
        	<button class="event-btn" id="openCheckBtn" style="width: 100px">출석 체크</button>							
        </div>
    </header>

    <!-- nav -->
    <nav class="navbar mt-5">
        <ul class="nav-list">
            <li class="nav-item">
                <a href="#" class="nav-link">공지사항</a>
                <ul class="sub-nav-list">
                    <li class="sub-nav-item"><a href="/jang/board/notice/list" class="sub-nav-link">공지사항</a></li>
                    <li class="sub-nav-item"><a href="/lee/board/list/join" class="sub-nav-link">가입인사</a></li>
                </ul>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">커뮤니티</a>
                <ul class="sub-nav-list">
                    <li class="sub-nav-item"><a href="/lee/board/list/free" class="sub-nav-link">자유게시판</a></li>
                    <li class="sub-nav-item"><a href="/kim/board/info" class="sub-nav-link">정보공유</a></li>
                    <li class="sub-nav-item"><a href="/lee/board/list/review" class="sub-nav-link">리뷰</a></li>
                    <li class="sub-nav-item"><a href="/lee/board/list/qna" class="sub-nav-link">질문게시판</a></li>
                </ul>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">모임</a>
                <ul class="sub-nav-list">
                    <li class="sub-nav-item"><a href="/lee/board/list/meet" class="sub-nav-link">벙캠/동행</a></li>
                    <li class="sub-nav-item"><a href="/lee/board/list/meetReview" class="sub-nav-link">모임후기</a></li>
                </ul>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">중고장터</a>
                <ul class="sub-nav-list">
                    <li class="sub-nav-item"><a href="/lee/board/list/buy" class="sub-nav-link">삽니다</a></li>
                    <li class="sub-nav-item"><a href="/lee/board/list/sell" class="sub-nav-link">팝니다</a></li>
                </ul>
            </li>
             <li class="nav-item">
            	<a href="#" class="nav-link">차타버스</a>
            	<ul class="sub-nav-list">
                    <li class="sub-nav-item"><a href="/lee/chataverse/loading" class="sub-nav-link">플레이</a></li>
                    <li class="sub-nav-item"><a href="/lee/chataverse/itemshop" class="sub-nav-link">상점</a></li>
                </ul>
            </li>
            <c:if test="${loginSessionDto.gradeno > 1}">
	            <li class="nav-item"><a href="/admin/main" class="nav-link">관리자</a></li>
            </c:if>
        </ul>
    </nav>
 
<section class="section-Container">
<%--  ${login} --%>