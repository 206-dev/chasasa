<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기</title>
    <link rel="stylesheet" href="/resources/kim/css/indexksy.css">
</head>
<body class="bg-white text-black min-h-screen flex items-center justify-center">
    <div class="login-container">
    	<a href="/" class="logo-link" style="border-radius: 10px">
    		<img src="/resources/kim/image/chabak.png" alt="차박차박 로고" class="mb-6 mx-auto block" style="width: 150px; border-radius: 10px">
    	</a>
        <h2 class="text-xl font-bold">아이디 찾기</h2>
        <form action="/kim/user/findId" method="post">
            <input type="email" name="email" placeholder="이메일을 입력하세요" class="input-box" required />
            <button type="submit" class="findIdRun-btn">아이디 찾기</button>
        </form>
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
