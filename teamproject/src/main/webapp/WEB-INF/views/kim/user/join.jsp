<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>차박차박 - 회원가입</title>
    <link rel="stylesheet" href="/resources/kim/css/indexksy.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* 추가된 스타일 */
        .container-center {
            display: flex;
            justify-content: center;
            align-items: center;
            height: calc(100vh - 20px); /* 화면의 높이를 100%로 설정 */
        }
        .existing-account-btn{
		    color:gray;
		}
		.existing-account-btn:hover{
		    color:black;
		}
		
		.join-item{
		    display: flex;
		    flex-direction: column;
		    width: fit-content;
		    margin: 10px auto;
		}
		.joinbtn-box{
			display: inline-flex;
			align-items: center;
		}
		.ml-little{
			margin-left: 5px;
		}
		
		.joininput-box {
		    width: 370px;
		    padding: 0.75rem;
		    border: 1px solid #d9d9d9;
		    border-radius: 8px;
		    background-color: #f5f5f5;
		    color: #333;
		    font-size: 1rem;
		}
		        
    </style>
</head>
<body class="bg-gray-100">
    <div class="container-center"> <!-- 추가된 wrapper div -->
        <div class="join-container">
        	<a href="/">
            <img src="/resources/kim/image/chabak.png" alt="차박차박 로고" class="mb-6 mx-auto block" style="width: 150px; border-radius: 10px; margin: 10px 0">
            </a>
            
            <form id="joinForm" action="/kim/user/joinRun" method="post">
                <div class="join-item">
                    <input type="text" id="userid" name="userid" placeholder="아이디" class="joininput-box" required>
                    <div class="joinbtn-box">
	                    <button type="button" id="checkUserId" class="check-btn async-btn">아이디 중복확인</button>
	                    <span id="userIdMsg" class="text-sm ml-little"></span>                    
                    </div>
                </div>
                <div class="join-item">
                    <input type="password" id="userpw" name="userpw" placeholder="비밀번호" class="joininput-box" required>
                </div>
                <div class="join-item">
                    <input type="password" id="userPwCheck" name="userPwCheck" placeholder="비밀번호 확인" class="joininput-box" required>
                    <span id="userPwMsg" class="text-sm ml-little"></span>
                </div>
                <div class="join-item">
                    <input type="text" id="nickname" name="nickname" placeholder="닉네임" class="joininput-box" required>
                    <div class="joinbtn-box">
	                    <button type="button" id="checkNickname" class="check-btn async-btn">닉네임 중복확인</button>
	                    <span id="nicknameMsg" class="text-sm ml-little"></span>
                    </div>
                </div>
                <div class="join-item">
                    <input type="email" id="email" name="email" placeholder="이메일" class="joininput-box">
                    <div class="joinbtn-box">
	                    <button type="button" id="checkEmail" class="check-btn async-btn">이메일 중복확인</button>
	                    <span id="emailMsg" class="text-sm ml-little"></span>
                    </div>
                    <div class="joinbtn-box">
					    <button type="button" id="sendEmailVerification" class="check-btn async-btn">이메일 인증</button>
					    <span id="emailVerifyMsg" class="text-sm ml-little"></span>
                    </div>
                </div>
				<!-- 인증 코드 입력란 -->
				<div class="join-item" id="verificationCodeSection" style="display:none;">
				    <input type="text" id="verificationCode" name="verificationCode" placeholder="인증 코드" class="input-box" required>
				    <button type="button" id="verifyCodeButton" class="check-btn async-btn">인증 확인</button>
				    <span id="verificationCodeMsg" class="text-sm"></span>
				    <span id="timer" class="text-sm timer"></span>
				</div>
                <button type="submit" class="login-btn mt-4" style="width: 348px; margin: 10px auto">회원가입</button>
            </form>
            
            <a href="/kim/user/login" class="existing-account-btn mt-4" style="text-decoration: none; margin-top: 10px">이미 계정이 있습니다.</a>
        </div>
    </div> <!-- 추가된 wrapper div 끝 -->

    <script>
        $(document).ready(function() {
        	<c:if test="${not empty error}">
            	alert("${error}");
        	</c:if>
        	
        	
            // 비밀번호 일치 확인
            $('#userPwCheck').on('keyup', function() {
                var pw = $('#userpw').val();
                var pwCheck = $(this).val();
                
                if (pw !== pwCheck) {
                    $('#userPwMsg').text('비밀번호가 일치하지 않습니다.').css('color', 'red');
                } else {
                    $('#userPwMsg').text('비밀번호가 일치합니다.').css('color', 'green');
                }
            });

         // 아이디 중복 체크
            $('#checkUserId').on('click', function() {
                var userId = $('#userid').val();
                
                $.ajax({
                    url: '/kim/user/checkUserId',
                    type: 'POST',
                    data: { userId: userId },
                    success: function(response) {
                    	console.log(response);
                        if (response.userIdAvailability === 'available') {
                            $('#userIdMsg').text('사용 가능한 아이디입니다.').css('color', 'green');
                        } else {
                            $('#userIdMsg').text('이미 사용 중인 아이디입니다.').css('color', 'red');
                        }
                    }
                });
            });

            // 닉네임 중복 체크
            $('#checkNickname').on('click', function() {
                var nickname = $('#nickname').val();
                
                $.ajax({
                    url: '/kim/user/checkNickname',
                    type: 'POST',
                    data: { nickname: nickname },
                    success: function(response) {
                    	console.log(response);
                        if (response.nicknameAvailability === 'available') {
                            $('#nicknameMsg').text('사용 가능한 닉네임입니다.').css('color', 'green');
                        } else {
                            $('#nicknameMsg').text('이미 사용 중인 닉네임입니다.').css('color', 'red');
                        }
                    }
                });
            });

            // 이메일 중복 체크
            $('#checkEmail').on('click', function() {
                var email = $('#email').val();
                
                $.ajax({
                    url: '/kim/user/checkEmail',
                    type: 'POST',
                    data: { email: email },
                    success: function(response) {
                    	console.log(response);
                        if (response.emailAvailability === 'available') {
                            $('#emailMsg').text('사용 가능한 이메일입니다.').css('color', 'green');
                        } else {
                            $('#emailMsg').text('이미 사용 중인 이메일입니다.').css('color', 'red');
                        }
                    }
                });
            });
            
            
            // 이메일 인증 버튼 클릭 이벤트
            $('#sendEmailVerification').on('click', function() {
                var email = $('#email').val();
                
                if (email === '') {
                    alert('이메일을 입력하세요.');
                    return;
                }
                
                $.ajax({
                    url: '/kim/user/sendEmailVerification',
                    type: 'POST',
                    data: { email: email },
                    success: function(response) {
                        if (response.success) {
                            $('#emailVerifyMsg').text('인증 코드가 이메일로 발송되었습니다.').css('color', 'green');
                            $('#verificationCodeSection').show(); // 인증 코드 입력란 표시
                            startTimer(180); // 3분 타이머 시작 (180초)
                        } else {
                            $('#emailVerifyMsg').text('이메일 발송에 실패했습니다. 다시 시도해주세요.').css('color', 'red');
                        }
                    }
                });
            });
            
            // 타이머 함수
            function startTimer(duration) {
                var timer = duration, minutes, seconds;
                var timerElement = $('#timer');
                
                var interval = setInterval(function() {
                    minutes = parseInt(timer / 60, 10);
                    seconds = parseInt(timer % 60, 10);

                    minutes = minutes < 10 ? "0" + minutes : minutes;
                    seconds = seconds < 10 ? "0" + seconds : seconds;

                    timerElement.text("남은 시간: " + minutes + ":" + seconds);

                    if (--timer < 0) {
                        clearInterval(interval);
                        timerElement.text("인증 시간이 만료되었습니다.");
                    }
                }, 1000);
            }
            
         	// 인증 코드 확인 버튼 클릭 이벤트
            $('#verifyCodeButton').on('click', function() {
                var inputCode = $('#verificationCode').val();
                
                if (inputCode === '') {
                    alert('인증 코드를 입력하세요.');
                    return;
                }
                
                $.ajax({
                    url: '/kim/user/verifyEmailCode',
                    type: 'POST',
                    data: { verificationCode: inputCode },
                    success: function(response) {
                        if (response.success) {
                            $('#verificationCodeMsg').text('인증이 성공적으로 완료되었습니다.').css('color', 'green');
                        } else {
                            $('#verificationCodeMsg').text('인증 코드가 올바르지 않습니다.').css('color', 'red');
                        }
                    }
                });
            });
            
        });
        
        
        
        
    </script>
</body>
</html>
