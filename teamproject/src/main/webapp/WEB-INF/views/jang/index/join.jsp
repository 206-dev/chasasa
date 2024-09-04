<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="/resources/jang/css/index.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>
<body>

<script type="text/javascript">
$(function(){
	// 회원가입 버튼 활성화 플래그
	let emailCheck = false;
	let userIdCheck = false;
	
    // 프로필 박스를 클릭하면 파일 선택 창을 여는 기능
    $(".profile-box").click(function(){
        $("#profileFile").trigger("click");
    });
    
    
     // 프로필 파일이 바뀌었을 때
    $("#profileFile").change(function(e){
    	// 비동기로 img 파일 저장
    	console.log(e);
    	let file = e.target.files; // list
    	console.log(file); 
    	
		if(file){
		    console.log("파일이 존재함");

	        // 서버에 전송할 데이터 객체
	        let formData = new FormData();
			for(let aFile of file){
				if (!aFile.type || !aFile.type.startsWith("image/") || aFile.type.trim() === "") {
      	            alert("이미지 파일만 선택할 수 있습니다.");
      	            e.target.value = ""; // 선택된 파일 초기화
      	            return;
      	        }
	        	formData.append("imageData", aFile);
			}
			
			console.log(formData);
			
			
	        // AJAX 요청
	        $.ajax({
	            url: "/jang/user/uploadProfile", 
	            type: "POST",
	            data: formData,
				contentType: false, // "application/json; chartset=utf-8" // x
				processData: false,
	            success: function(rData) {
	                console.log(rData);
	                $(".profile-box").empty();
	                $(".profile-box").append(`<img src="\${rData}" class="profile-img">`);
	                $("#profile").val(rData);
	                
	            },
	            error: function(xhr, status, error) {
	                console.error("에러 발생:", error);
	            }
	        });
	    };
    }); 
    
    // 아이디 중복체크
	$("#userId").keyup(function(){
		let inputVal = $("#userId").val();

	    // 입력된 값에서 영어 또는 숫자가 아닌 문자를 제거
	    let filteredVal = inputVal.replace(/[^A-Za-z0-9]/g, '');

	 	// 필터링된 값으로 input 필드를 업데이트
	    if (inputVal !== filteredVal) {
	        $(this).val(filteredVal);
	        return;
	    }
		
		$.get("/jang/user/checkId", {userId: $("#userId").val()}, function(rData){
			
			console.log(rData);
			if(rData){
				$("#checkId").text("사용 가능한 아이디입니다.");
				userIdCheck = true;
			}else{
				$("#checkId").text("사용 불가능한 아이디입니다.");
				userIdCheck = false;
			}
			
			console.log("id", userIdCheck);
			activeJoin(userIdCheck, emailCheck);
		})
		
	});
     
				
    // 이메일 형식 체크
    $("#email").keyup(function(){
	    let email = $("#email").val();
	    if(!email.includes("@")){
	    	eamilCheck = false;
	    	$("#lblEmail").text("형식을 확인해 주세요");
	    }
	    if(!email.includes(".")){
	    	eamilCheck = false;
	    	$("#lblEmail").text("형식을 확인해 주세요");
	    }
	    if(email.indexOf("@") > email.indexOf(".")){
	    	eamilCheck = false;
	    	$("#lblEmail").text("형식을 확인해 주세요");
	    }
	    
    	$("#lblEmail").text("인증을 해주세요");
	    emailCheck = true;
	    
	    console.log("eamil", emailCheck);
	    activeJoin(userIdCheck, emailCheck);
    });
    
    // 아이디, 이메일 형식 체크 후 버튼 활성화
    function activeJoin(userIdCheck, emailCheck){
    	if(userIdCheck && emailCheck){
    		$("#btnJoin").removeAttr("disabled");
    	}else{
			$("#btnJoin").attr("disabled","disabled");
    	}
    }
    
    
});
</script>
<div class="login">
    <div class="join-content">
        <h2>회원가입</h2>
            <div class="profile-container">
                <div class="profile-box">
                    클릭
                </div>
               	<input type="file" id="profileFile" name="profileFile" accept="image/*" style="display:none;">
            </div>
	        <form class="form-join" action="/jang/user/join" method="post">
	            <label id="checkId" for="userId">아이디:</label>
	            <input type="text" id="userId" name="userId" required>
	
	            <label for="userPw">비밀번호:</label>
	            <input type="password" id="userPw" name="userPw" required>
	
	            <label for="nickname">닉네임:</label>
	            <input type="text" id="nickname" name="nickname" required>
	
	            <label id="lblEmail" for="email">이메일:</label>
	            <input type="email" id="email" name="email" required>
	            
	            <input id="profile" type="hidden" name="profile" value="1"  style="display:none;">
	
	            <input id="btnJoin" class="btn" type="submit" value="회원가입" disabled="disabled">
	        </form>
        
        <div class="join-links-container">
            <a href="/jang/user/login">로그인</a> | <a href="/find-id">아이디 찾기</a> | <a href="/find-pw">비밀번호 찾기</a>
        </div>
    </div>
</div>

</body>
</html>
