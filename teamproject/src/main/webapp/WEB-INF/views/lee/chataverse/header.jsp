<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 캐시 컨트롤 -->
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
<!-- 캐시 컨트롤 -->
<title>Choice Your Gender</title>
<link rel="stylesheet" href="/resources/lee/css/chataverse/index.css">
<script src="/resources/lee/js/user/point.js" defer></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="/resources/lee/js/chataverse/index.js" defer></script>
<script>
const USERID = `${loginSessionDto.userid}`;
$(function(){
	if(USERID !== "" && USERID !== null){
		showLevelInfo(USERID);
	}
	const HEADER = $("#headerContainer");
	let headerHeight = HEADER.outerHeight();
	
	$(window).mousemove(function(e){
		if(e.clientY <= headerHeight){
			HEADER.css("top", "0");
		}else{
			HEADER.css("top", "-" + headerHeight + "px");
		}
	});
// 	console.log(`${loginSessionDto}`);
});
</script>
</head>
<body>
<header class="headerContainer" id="headerContainer">
	<a class="btn btn_backhome" href="/">돌아가기</a>
	<div>
<%-- 		${loginSessionDto} --%>
	</div>
    	<div class="login-profile-box">
    		<img alt="profile" src="" class="profile-img" id="login-profile-img">
	   		<div class="login-profile">
	   			<div class="namelevel">
	   				<div class="namelevel-item">
		    			<a href="#"><img class="img-mail" alt="" src="/resources/lee/image/mail.png"></a>
						<a href="/user/profile" class="bold-800 ml-5">${loginSessionDto.nickname}</a>
	   				</div>
					<div class="namelevel-item">
						<span class="level-count ml-20" >레벨</span>
						<span class="ml-5" id="profile_level"></span>
					</div>
	   			</div>
				<div class="expContainer">
				   	<div class="expTextBox">
				   	<span id="my_point"></span>
				   	<span>/</span>
				   	<span id="next_point"></span>
				</div>
				<div class="exp" id="div_exp"></div>
				</div>
			</div>
   		</div>
<!-- 		<div class="head-hidden-div" id="headHiddenDiv"> -->
		
<!-- 		</div> -->
</header>

<section class="sectionContainer">