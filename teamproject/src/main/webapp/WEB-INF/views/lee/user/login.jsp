<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인:차박차박</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/lee/css/user/login.css">
<script src="/resources/lee/js/user/login.js"></script>
<script>
$(function(){
	loadId();
	function loadId(){
		let savedId = getCookie("userid");	
		if(savedId !== null && savedId !== ""){
			$("#userid").val(savedId);
			$("#checked").prop("checked", true);
		}
		console.log("savedId : " + savedId);
	}
	
	
	function getCookie(name){
		let cookies = document.cookie.split(';');
		console.log("cookies : " + cookies);
		if(cookies !== null){
			for(let i=0; i<cookies.length; i++){
				let cookie = cookies[i].trim();
//	 			console.log("cookie : " + cookie);
				if(cookie.indexOf(name + '=') === 0){
					return cookie.substring(name.length + 1);
				}
			}
		}
		return null;
	}
});
</script>
</head>
<body>
	<div class="logoContainer">
		<a href="/"><img alt="logo" src="/resources/lee/image/logo4.png"></a>
	</div>
    <div class="form-content">
    	<!-- <span class="close-modal" id="close-modal">&times;</span> -->
   		<h2>로그인</h2>
	    <form class="form-item" id="form-login" action="/lee/user/loginRun" method="post">
	    	<label for="username">아이디:</label>
	        <input type="text" id="userid" placeholder="아이디" name="userid">
	        <label for="password">비밀번호:</label>
	        <input type="password" id="userpw" placeholder="비밀번호">
	        <p id="checkResult"></p>
	        <div class="idCheckContainer">
	        	<input type="checkbox" name="checked" id="checked"><span>아이디 저장</span>
	        </div>
	        <button type="button" class="btn" id="btnLogin">Login</button>
	   </form>
	   <div class="form-links-container">
	       <a href="/lee/user/join">회원가입</a>
	       <a href="/lee/user/forgot-id">아이디 찾기</a>
	       <a href="/lee/user/forgot-password">비밀번호 찾기</a>
	   </div>
   </div>

</body>
</html>