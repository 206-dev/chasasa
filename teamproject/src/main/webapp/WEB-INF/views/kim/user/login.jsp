<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>차박차박 - 로그인</title>
    <link rel="stylesheet" href="/resources/kim/css/indexksy.css">
</head>
<body class="bg-gray-100 flex items-center justify-center" style="height: calc(100vh - 20px)">
    <div class="login-container">
    	<a href="/" class="logo-link" style="border-radius: 10px">
    		<img src="/resources/kim/image/chabak.png" alt="차박차박 로고" class="mb-6 mx-auto block" style="width: 150px; border-radius: 10px">
    	</a>
        
        
        
        <form action="/kim/user/loginRun" method="post">
            <div class="mb-4">
                <input type="text" name="userId" placeholder="아이디" 
                       class="input-box" value="${cookie.userid.value}" required style="margin-bottom: 5px;">
            </div>
            <div class="mb-6">
                <input type="password" name="userPw" placeholder="비밀번호" class="input-box" required style="margin-bottom: 10px;">
            </div>
            <button type="submit" class="login-btn" style="width: 346px">로그인</button>

            <div class="flex items-center justify-between mt-4">
                <label class="flex items-center text-sm text-gray-700">
                    <input type="checkbox" name="rememberMe" class="mr-2" 
                           ${cookie.userid != null ? 'checked' : ''}> 아이디 기억
                </label>
            </div>
        </form>

        <a href="/kim/user/join" class="login-btn kim-join-btn" style="width: 306px; margin-top: 10px">회원가입</a>
        <div class="login-links">
									    <a href="/kim/user/findid" class="find-btn">아이디 찾기</a>
									    <a href="/kim/user/findpassword" class="find-btn">비밀번호 찾기</a>
									</div>
    </div>

</body>
<script>
    var message = "${message}";
    var error = "${error}";
    if (message) {
        alert(message);
    }
    if (error) {
        alert(error);
    }
</script>
</html>

