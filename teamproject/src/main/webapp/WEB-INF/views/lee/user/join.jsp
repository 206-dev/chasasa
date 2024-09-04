<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="/resources/lee/css/user/join.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>
<script>
$(function(){
	let interval;
	
	//아이디 중복체크
	$("#checkId").click(function(){
		console.log("아이디중복 체크");
		let userid = $.trim($("#userid").val());
		if(userid == ""){
			$("#resultCheckUserid").css("display", "block").css("color", "red").html("아이디를 입력하세요");
			return;
		}
		console.log("userid : ", userid);
		$.ajax({
			type : "get",
			url : "/lee/user/joinCheckUserid/" + userid,
			success : function(rData){
				console.log(rData);
				if(rData){
					$("#resultCheckUserid").css("display", "block").css("color", "red").html("이미사용 중 입니다");
				}else{
					$("#resultCheckUserid").css("display", "block").css("color", "green").html("사용가능");
				}
			}
		})
	});
	
	//닉네임 중복체크
	$("#checkNickname").click(function(){
		console.log("닉네임 체크");
		let nickname = $.trim($("#nickname").val());
		if(nickname == ""){
			$("#resultCheckNickname").css("display", "block").css("color", "red").html("닉네임을 입력하세요");
			return;
		}
		console.log("nickname : ", nickname);
		$.ajax({
			type : "get",
			url : "/lee/user/joinCheckNickname/" + nickname,
			success : function(rData){
				console.log(rData);
				if(rData){
					$("#resultCheckNickname").css("display", "block").css("color", "red").html("이미사용 중 입니다");
				}else{
					$("#resultCheckNickname").css("display", "block").css("color", "green").html("사용가능");
				}
			}
		})
	});
	
	$("#btnJoin").click(function(){
		console.log("회원가입 버튼 클릭");	
		$("#join-form").submit();
	});
	
	// 인증번호 발송
	$("#btnSendCerti").click(function(){
		let getEmail = $("#email").val();
		console.log("getEmail : " + getEmail);
		
		$.post({
			type : "post",
			url : "/lee/user/certiEmail",
			data : {email : getEmail},
			success : function(rData){
				let timerDuration = 300;
				
				console.log(rData);
				// 인증번호 세팅
				$("#certi").val(rData);
				// 타이머
				startTimer(timerDuration);
				
				// 인증 디브 보이기
// 				$("#div-certi").fadeIn(1000);
				
				// 타이머 보이기
				$("#divReamainTime").fadeIn(1000);
			}
		});
	});
	
	//인증번호 확인
	$("#btnCheckCerti").click(function(){
		let inputCerti = $("#inputCerti").val();
		let certi = $("#certi").val();
		if(inputCerti === certi){
			// 인증성공
			console.log("인증성공!");
			
			// 타이머 안보이게
			$("#divReamainTime").fadeOut(1000);
			clearInterval(interval);
			// 인증 디브 안보이게
			$("#div-certi").fadeOut(1000);
			
			// 회원가입버튼 보이게
			$("#btnJoin").fadeIn(1000);
		}else{
			//인증실패
			alert("인증 번호를 확인 해 주세요.");
		};
		return false;
	});
	
	//타이머
	function startTimer(timerDuration) {
        var timer = timerDuration, minutes, seconds;
        interval = setInterval(function() {
            minutes = parseInt(timer / 60, 10);
            seconds = parseInt(timer % 60, 10);

            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;

            $('#timer').text(minutes + ":" + seconds);

            if (--timer < 0) {
                clearInterval(interval);
                //시간 초과시 인증번호 삭제
                $("#certi").val("");
            }
        }, 1000);
    }
});
</script>

<body>
	<div class="logoContainer">
		<a href="/"><img alt="logo" src="/resources/lee/image/logo4.png"></a>
	</div>
<div class="join-container">
    <div class="title-item">
        <h1>차박ChaBak</h1>
    </div>
    <form action="/lee/user/joinRun" class="join-form" id="join-form" method="post">
        <div class="join-item">
            <label for=""><span class="join-span">아이디</span> </label>
            <input type="text" name="userid" placeholder=" 아이디" id="userid">
            <div class="right-item">
                <button type="button" class="btn-item" id="checkId">중복확인</button>
            </div>
        </div>
        <span id="resultCheckUserid" class="ml-120 mt-5 resultCheck">성공</span>
        <div class="join-item">
            <label for=""><span>비밀번호</span></label>
            <input type="password" name="userpw" placeholder=" 비밀번호">
        </div>
        <div class="join-item">
            <label for=""><span>비밀번호 확인</span></label>
            <input type="password" placeholder=" 비밀번호 확인">
        </div>
        <div class="join-item">
            <label for=""><span>닉네임</span></label>
            <input type="text" name="nickname" placeholder=" 닉네임" id="nickname">
            <div class="right-item">
                <button type="button" class="btn-item" id="checkNickname">중복 확인</button>
            </div>
        </div>
        <span id="resultCheckNickname" class="ml-120 mt-5 resultCheck">성공</span>
        <div class="join-item">
            <label for="u_email"><span>이메일</span></label>
            <input type="text" name="email" placeholder=" 이메일" id="email" required>
            <div class="right-item">
                <button type="button" class="btn-item" id="btnSendCerti">본인 인증</button>
            </div>
        </div>
        
        <div class="join-item div-certi" id="div-certi">
            <label for="inputCerti"><span>이메일 인증</span></label>
            <input type="text" placeholder="인증번호" id="inputCerti">
            <div class="right-item">
                <button type="button" class="btn-item" id="btnCheckCerti">인증번호 확인</button>
            </div>
        </div>
        <div class="divReamainTime" id="divReamainTime">
		         <span>남은시간 : </span><span id="timer"></span>
	    </div>
        <input type="hidden" id="certi">
        <div class="join-item">
            <button class="btn-join" id="btnJoin" style="display:none">가입하기</button>
        </div>
    </form>
</div>
</body>
</html>