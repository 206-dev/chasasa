<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="/www/resources/css/join.css">
</head>
<script>
$(function(){
	$("#btnJoin").click(function(){
		console.log("회원가입 버튼 클릭");	
		$("#join-form").submit();
	});
});
</script>

<body>

<div class="join-container">
    <div class="title-item">
        <h1>차박ChaBak</h1>
    </div>
    <form action="/www/joinrun" class="join-form" id="join-form">
        <div class="join-item">
            <label for=""><span class="join-span">아이디</span> </label>
            <input type="text" name="u_id" placeholder=" 아이디">
        </div>
        <div class="join-item">
            <label for=""><span>비밀번호</span></label>
            <input type="password" name="u_pw" placeholder=" 비밀번호">
        </div>
        <div class="join-item">
            <label for=""><span>비밀번호 확인</span></label>
            <input type="password" placeholder=" 비밀번호 확인">
        </div>
        <div class="join-item">
            <label for=""><span>닉네임</span></label>
            <input type="text" name="u_nickname" placeholder=" 닉네임">
        </div>
        <div class="join-item">
            <label for=""><span>이메일</span></label>
            <input type="text" name="u_email" placeholder=" 이메일">
            <span>@</span>
            <select name="" id="">
                <option value="">도메인선택</option>
                <option value="">naver.com</option>
                <option value="">hanmail.net</option>
                <option value="">daum.net</option>
                <option value="">nate.com</option>
                <option value="">gmail.com</option>
                <option value="">직접입력</option>
            </select>
            <button>인증</button>
        </div>
        <div class="join-item">
            <label for=""><span>이메일 인증</span></label>
            <input type="text">
            <div class="right-item">
                <button class="btn-email-check-ok">확인</button>
            </div>
        </div>
        <div class="join-item">
            <button class="btn-join" id="btnJoin">가입하기</button>
        </div>
    </form>
</div>
</body>
</html>