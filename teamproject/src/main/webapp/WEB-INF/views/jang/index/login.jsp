<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>												
<link rel="stylesheet" href="/resources/jang/css/index.css">
</head>

<body>
<script type="text/javascript">
$(function(){
	$("#frmLogin").submit(function(){
		$("input[name=saveId]").val($("#login-userId").val());
	});
	
	// 아이디 저장
	let cookie = document.cookie;
	let cookiePair = cookie.split("=");
	if(cookiePair){
		$("#userId").val(cookiePair[1]);
	}
});

</script>
	<!-- login-start -->
	<div id="loginlogin" class="login">
		<div class="login-content">
			<!-- <span class="close-login" id="close-login">&times;</span> -->
			<h2>로그인</h2>
			<form id="frmLogin" action="/jang/user/login" method="post" class="form-login">
				<input type="hidden" name="currentUrl" value="${currentUrl}"/>
				<label for="username">아이디:</label>
				<input id="userId" type="text" name="userId" placeholder=" 아이디">
				<label for="password">비밀번호:</label>
				<input id="userPw" type="password" name="userPw" placeholder=" 비밀번호">
				<input name="currentUrl" type="hidden" value="${currentUrl}">
				<div class="idCheckContainer">
					<input type="checkbox" name="saveId"> <span>아이디 저장</span>
				</div>
				<button id="btnLogin" type="submit" class="btn">Login</button>
			</form>
			<div class="login-links-container">
				<a href="/jang/user/join">회원가입</a> <a href="#">아이디 찾기</a> <a href="#">비밀번호
					찾기</a>
			</div>
		</div>
	</div>

</body>
</html>