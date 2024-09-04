<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/lee/include/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
        // link 태그 생성
        var link = document.createElement('link');
        link.rel = 'stylesheet';
        link.href = '/resources/lee/css/user/profile.css';

        // head 태그에 link 태그 추가
        document.head.appendChild(link);
    </script>
<script>
$(function(){
	let interval;
	let userid = "${profile.userid}"
	let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	let maxSize = 5242880; // 5MB
	// 첫번째 버튼 수정버튼 눌렀을때//////////////////////////////////////////////////////////////
	$(".profile-item").on("click", ".btn-item", function(i){
		let that = $(this);
		//숨겨놓은 form
		let form = that.parent().next();
		//버튼 '확인'으로 고정
		form.find("button").html("확인");
		let btnIdName = $(this).attr("id")
		let isShow = true;
		switch(btnIdName){
			// 프로필 /////////////////////////////////////////////////////////
			case "btnProfile" :
				console.log("프로필 수정버튼");
				showHiddenFrom(form);
				break;
				
			// 닉네임 /////////////////////////////////////////////////////////
			case "btnNickname" :
				console.log("닉네임 수정버튼");
				showHiddenFrom(form);
				break;
				
			// 이메일 /////////////////////////////////////////////////////////
			case "btnEmail" :
				console.log("이메일 수정버튼");
				clearInterval(interval);
				showHiddenFrom(form);
				$("#div-certi").hide();
				$("#divReamainTime").hide();
				break;
				
			// 비밀번호수정 /////////////////////////////////////////////////////////
			case "btnPw" :
				console.log("비밀번호 수정버튼");
				let userpw = $("#input-cur-pw").val();
				console.log("id, pw : " + userid + ", " + userpw);
				let sData = {
					"userid" : userid,
					"userpw" : userpw
				};//sData
				if($.trim(userpw) == ""){
					if(userpw.length > 0){
						alert("공백은안되요!.");
						return;
					}
					alert("비밀번호를 입력하세요.");
					return;
				}//if
				//비밀번호 체크
				$.ajax({
					type: "post",
					url: "/lee/user/checkUser",
					data: sData,
					success: function(rData){
						console.log("비밀번호체크 success 진입");
						console.log("sData");
						console.log(sData);
						console.log("rData");
						console.log(rData);
						if(rData===true){
							// true면 중복
							console.log("인증성공");
							form.append($("#input_userid"));
							showHiddenFrom(form);
						}else{
							//비밀번호 체크 실패
							console.log("인증실패");
							isShow = false; 
							alert("비밀번호를 다시 확인해주세요.");
						};
					}//success
				});//ajax
				break;
		}//switch
	});// 첫번째 버튼 수정버튼 눌렀을때
	
	function showHiddenFrom(form){
		$("form").fadeOut(1000);
		//생성할 form에 id input append
		form.append($("#input_userid"));
		$(".profile-item").css("display", "grid");
		form.fadeIn(1000);
	};
	
	//이미지 업로드
	//이미지 변경시 파일업로드
	$("#img-file").change(function(){
		console.log("이미지 변경됨");
		const inputFile = $("#img-file");
		console.log(inputFile[0].files);
		
		
		let imgfile = inputFile[0].files;
		
		uploadFile(imgfile);
	});
	function uploadFile(file) {
		console.log("uploadFile")
		// <form>
		let formData = new FormData();
	
	
		let fileName = file[0].name;
		let fileSize = file[0].size;
		if (!checkExtension(fileName, fileSize)) {
				return false;
		}
	
		formData.append("uploadFile", file[0]);
		console.log(formData);
// 		return false;
		$.ajax({
			type: "post",
			url: "/lee/upload/uploadProfileImg",
			contentType: false, // "application/json; chartset=utf-8" // x
			processData: false, // &name=hong&age=20 // x
			data: formData,
			success: function(rData) {
				console.log(rData); // String Path 
				$("#profileImg").attr("src", rData);
				$("#hiddenProfile").val(rData);
			}
		}); // $.ajax({
		
	}//uploadfile
	//이미지 사이즈 체크
	function checkExtension(fileName, fileSize) {
		if (fileSize > maxSize) {
			alert("파일 사이즈 초과");
			return false;
		}
		
		if (regex.test(fileName)) {
			alert("해당 파일 종류는 업로드 할 수 없습니다.");
			return false;
		}
		
		return true;
	}
	
	//**두번째버튼********************************************************************************//
	$(".profile-item").on("click", ".secondBtn", function(i){
		//두번째버튼
		console.log("두번째버튼 클릭");
		let that = $(this);
		console.log(that);
		let idName = that.attr("id");
// 		let form = that.parent().parent();
		switch(idName){
			//프로필 사진///////////////////////////////////////////////////////////////////////////
			case "btnProfileOk" : 
				console.log("프로필사진 업로드");
// 				let profile = $("#profileImg").attr("src");
// 				$("#login-profile-img").attr(profile);
// 				console.log("profile : " + profile);
				$("#formProfile").submit();
				break;
				
			//닉네임////////////////////////////////////////////////////////////////////////////////
			case "btnNickCheck" :
				//닉네임체크
				console.log("닉네임 체크");
				let wantNick = $("#nickname").val();
				console.log("wantNick : " + wantNick + ", userid : " + userid);
				let sData = {
					"userid" : userid,
					"nickname" : wantNick
				};
				$.ajax({
					type : "post",
					url : "/lee/user/checkNickname",
					data : sData,
					success : function(rData){
					console.log("닉네임 중복 체크");
					console.log(rData);
						if(rData){
							//변경가능
							that.html("완료");
							that.attr("id", "btnChangeNick");
							alert("닉네임 변경가능");
						}else{
							//변경불가
							alert("중복된 닉네임, 변경불가");
						}
					}
				});
				break;
			case "btnChangeNick" :
				//닉네임 변경
				that.attr("id", "btnNickCheck");
				$("#formNickname").submit();
				break;
				
			//이메일///////////////////////////////////////////////////////////////////////////////
			case "btnSendCerti" :
				//이메일 인증 번호 전송
				console.log("이메일 인증 클릭");
				let user_email = $.trim($("#email").val());
				console.log("email : " + user_email);
				if(user_email == "" ){
					alert("이메일을 입력해주세요.");
					return;
				};
				$.post({
					type : "post",
					url : "/lee/user/certiEmail",
					data : {email : user_email},
					success : function(rData){
						console.log("이메일인증 rData...");
						let timerDuration = 300;
						
						$("#email").prop("readonly", true);
	 					// 인증번호 세팅
						$("#certi").val(rData);
	 					// 타이머
						startTimer(timerDuration);
	 					// 인증 디브 보이기
		 				$("#div-certi").fadeIn(1000);
	 					// 타이머 보이기
						$("#divReamainTime").fadeIn(1000);
					}
				});
				break;
			case "btnCertiOk" :
				//이메일 인증 번호 확인
				let inputCerti = $("#inputCerti").val();
				let certi = $("#certi").val();
				if(inputCerti === certi){
					// 인증성공
					console.log("인증성공!");
					
					//타이머 멈춤
					clearInterval(interval);
					// 타이머 안보이게
					$("#divReamainTime").fadeOut(1000);
					// 인증 디브 안보이게
					$("#div-certi").fadeOut(1000);
					$("#btnSendCerti").html("완료");
					$("#btnSendCerti").attr("id", "btnEmailChange");
				}else{
					//인증실패
					alert("인증 번호를 확인 해 주세요.");
				};
				break;
			case "btnEmailChange" :
				//이메일 변경
				console.log("이메일변경");
				$("#formEmail").submit();
				break;
				
			//비밀번호/////////////////////////////////////////////////////////////////////////////////////	
			case "btnPwOk" :
				//비밀번호 변경버튼
				console.log("비밀번호 변경 완료 버튼");
				let userpw = $("#userpw").val();
				let userpw_check = $("#userpw_check").val();
				console.log("userpw : " + userpw + ", userpw_check : " + userpw_check);
				if(userpw === userpw_check){
					//폼전송
					console.log("폼전송");
					$("#formPassword").submit();
				}else{
					alert("비밀번호가 다릅니다.");
				}
				break;
		}//switch
	});//두번째버튼

		
	// 타이머 /////////////////////////////////////////////////////////////////////////////////////
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

<div class="profile-container">
    <div class="title-item">
        <h1>프로필</h1>
<%--         <span>${profile}</span>  --%>
    </div>
    <div class="div-profile">
        <div class="profile-item">
            <label for=""><span class="bold">아이디</span></label>
            <span>${profile.userid}</span>
            <input type="hidden" value="${profile.userid}" id="input_userid" name="userid">
        </div>
       
        <!-- 프로필사진 -------------------------------------------------------------------------------->
        <div class="profile-item">
            <label for=""><span class="bold">프로필</span></label>
            <span><img alt="profile" src="<c:choose>
									      	<c:when test="${profile.profile!=null}">${profile.profile}</c:when>
									        <c:otherwise>/resources/lee/image/empty_profile.jpg</c:otherwise>
									      </c:choose> 
           								 " id="profileImg" class="profileImg"></span>
            <button type="button" class="btn-item" id="btnProfile">수정</button>
        </div>
        <form class="form-item" action="/lee/user/profileUpdate" method="post" id="formProfile">
        	<div class="profile-item">
            	<label for=""><span class="color-gray">이미지파일</span></label>
            	<input type="file" id="img-file" >
            	<input type="hidden" id="hiddenProfile" name="profile">
            </div>
        	<div class="profile-item">
        		<label for=""></label>
            	<button type="button" class="secondBtn" id="btnProfileOk">완료</button>
            </div>
        </form>
  
  		<!-- 닉네임 -------------------------------------------------------------------------------->
        <div class="profile-item">
            <label for=""><span class="bold">닉네임</span></label>
            <span>${profile.nickname}</span>
            <button type="button" class="btn-item" id="btnNickname">수정</button>
        </div>
        <form class="form-item" action="/lee/user/changeNickname" method="post" id="formNickname">
        	<div class="profile-item">
            	<label for=""><span class="color-gray">중복확인</span></label>
            	<input type="text" class="input-item" placeholder="닉네임" name="nickname" id="nickname" required>
            	<button type="button" class="secondBtn" id="btnNickCheck">확인</button>
            </div>
        </form>
        
        <!-- 이메일 -------------------------------------------------------------------------------->
        <div class="profile-item">
            <label for=""><span class="bold">이메일</span></label>
            <span>
            	${profile.email}
            </span>
            <button type="button" class="btn-item" id="btnEmail">수정</button>
        </div>
        <form class="form-item" action="/lee/user/emailUpdate" method="post" id="formEmail">
        	<div class="profile-item">
            	<label for=""><span class="color-gray">변경 할 이메일</span></label>
            	<input type="email" class="input-item" placeholder="이메일" name="email" id="email" required>
            	<button type="button" class="secondBtn" id="btnSendCerti">확인</button>
            </div>
            <div class="profile-item div-certi " id="div-certi">
	            <label for="inputCerti"><span class="color-gray">이메일 인증</span></label>
	            <input type="text" placeholder="인증번호" id="inputCerti" class="input-item">
	            <div class="right-item">
	                <button type="button" class="secondBtn" id="btnCertiOk">확인</button>
	            </div>
	        </div>
            <div class="profile-item" >
	        	<label for=""></label>
	        	<div class="divReamainTime" id="divReamainTime" style="display:none">
					<span class="color-gray" >남은시간 : </span><span id="timer" style="color: red"></span>
	        	</div>
	        	<input type="hidden" id="certi">
		   </div>
        </form>
        
        <!-- 레벨 -------------------------------------------------------------------------------->
        <div class="profile-item">
            <label for=""><span class="bold">레벨</span></label>
            <span>${profile.userlevel}</span>
        </div>
        <!-- 포인트 -------------------------------------------------------------------------------->
        <div class="profile-item">
            <label for=""><span class="bold">포인트</span></label>
            <span>${profile.point}</span>
        </div>
        
        <!-- 비밀번호 -------------------------------------------------------------------------------->
        <div class="profile-item">
            <label for=""><span class="bold">비밀번호</span></label>
            <input type="password" id="input-cur-pw" class="input-item" placeholder="현재 비밀번호" required>
            <button type="button" class="btn-item" id="btnPw">수정</button>
        </div>
        <form class="form-item" action="updatePassword" method="post" id="formPassword">
        	<div class="profile-item">
            	<label for=""><span class="color-gray">변경할 비밀번호</span></label>
            	<input type="password" id="userpw" class="input-item" placeholder="비밀번호" name="userpw" required>
            	<button type="button" id="btnPwOk" class="secondBtn">완료</button>
            </div>
        	<div class="profile-item">
            	<label for=""><span class="color-gray">비밀번호 확인</span></label>
            	<input type="password" id="userpw_check" class="input-item" placeholder="비밀번호 확인" required>
            </div>
        </form>
        
    </div>
</div>


<%@ include file="/WEB-INF/views/lee/include/footer.jsp"%>