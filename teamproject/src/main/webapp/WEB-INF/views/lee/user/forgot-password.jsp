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
</head>
<body>
	<div class="logoContainer">
		<a href="/"><img alt="logo" src="/resources/lee/image/logo4.png"></a>
	</div>
    <div class="form-content">
   		<h4>비밀번호 찾기</h4>
   		<span>회원정보에 등록한 이메일로 새로운 비밀번호를 발송합니다.</span>
   		<span>아이디를 입력해주세요.</span>
	    <form class="form-item" id="form-login" action="/lee/user/resetPassword" method="post">
	        <input type="text" id="u_id" placeholder="아이디" name="userid" required>
		    <button type="submit" class="btn" id="btnFindPw">비밀번호 찾기</button>
		    <a href="/lee/user/login" class="btn">로그인</a>
	    </form>
   </div>

</body>
</html>