<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>매콤한녀석들</title>
    <link rel="stylesheet" href="/resources/jang/css/index.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>		
    <script src="/resources/jang/js/index.js" defer></script>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>							
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>							
</head>
<body>
<script type="text/javascript">
	$(function(){
		let loginUser = "${loginSessionDto.nickname}";
		
		window.updateLoginButtons = function(){
			if(loginUser != ""){
				$("#btnLogin").attr("style", "display:none;");
				$("#btnLogout").removeAttr("style");
				$("#divLogin input").val(loginUser);
			} else{
				$("#btnLogin").removeAttr("style");
				$("#btnLogout").attr("style", "display:none;");
			}
		}
		
		updateLoginButtons();
		
		// 로그인
		$("#btnLogin").click(function(){
			let currentUrl = window.location.href;
			currentUrl = currentUrl.substring(currentUrl.indexOf("t/") + 2);
			location.href="/jang/user/login?currentUrl=" + encodeURIComponent(currentUrl);
			// window.updateLoginButtons();
		});
		
		// 로그아웃
		$("#btnLogout").click(function(){
			let currentUrl = window.location.href;
			currentUrl = currentUrl.substring(currentUrl.indexOf("t/") + 2);
			console.log(currentUrl);
			location.href="/jang/user/logout?currentUrl=" + encodeURIComponent(currentUrl);
			// window.updateLoginButtons();
		});
		
		// 메타버스 클릭
		$("#metaverse").click(function(e) {
		    e.preventDefault();

		    let url = '/jang/metaverse/main';
		    let windowName = 'MetaverseWindow';
		    let windowFeatures = 'width=600,height=600,left=100,top=100,toolbar=no,menubar=no,location=no,status=no,resizable=no,scrollbars=yes';

		    window.open(url, windowName, windowFeatures);
		});
		
	});
</script>
    <!-- 광고 -->
    <div class="ad-Container ad-left">
<!--         <img class="ad-img-left" src="/resources/image/ad1.png" alt=""> -->
    </div>
    <div class="ad-Container ad-rigth">
<!--         <img class="ad-img-right" src="/resources/mage/ad2.png" alt=""> -->
    </div>

    <!-- header -->
    <header class="header-Container">
        <div class="navbar-Logo">
            <a href="/"><span>CHABAK 차박</span></a>
        </div>
        <div id="divLogin" class="login-Container">
            <input type="text" class="search">
            <button class="btn" id="btnLogin">Login</button> 
            <button class="btn" id="btnLogout" style="display:none;">Logout</button>
        </div>
    </header>

    <!-- nav -->
    <nav class="navbar">
        <ul class="nav-list">
            <li class="nav-item">
                <a href="/jang/board/notice/list" class="nav-link">공지사항</a>
                <ul class="sub-nav-list">
                    <li class="sub-nav-item"><a href="/jang/board/notice/list" class="sub-nav-link">공지사항</a></li>
                    <li class="sub-nav-item"><a href="/lee/board/list/join" class="sub-nav-link">가입인사</a></li>
                    <li class="sub-nav-item"><a href="/lee/board/list/check" class="sub-nav-link">출석체크</a></li>
                </ul>
            </li>
            <li class="nav-item">
                <a href="/lee/board/list/free" class="nav-link">커뮤니티</a>
                <ul class="sub-nav-list">
                    <li class="sub-nav-item"><a href="/lee/board/list/free" class="sub-nav-link">자유게시판</a></li>
                    <li class="sub-nav-item"><a href="/lee/board/list/info" class="sub-nav-link">정보공유</a></li>
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
                <a href="/jang/board/market/list" class="nav-link">중고장터</a>
                <ul class="sub-nav-list">
                    <li class="sub-nav-item"><a href="/lee/board/list/buy" class="sub-nav-link">삽니다</a></li>
                    <li class="sub-nav-item"><a href="/lee/board/list/sell" class="sub-nav-link">팝니다</a></li>
                </ul>
            </li>
            <li id="metaverse" class="nav-item"><a href="#" class="nav-link">메타버스</a></li>
            <li class="nav-item"><a href="/admin/main" class="nav-link">신고하기</a></li>
        </ul>
    </nav>
    <section class="section-Container">