$(function(){
	//로그인
	$("#btnLogin").click(function(){
  		console.log("로그인 버튼 클릭");
 		let userid = $("#userid").val();
  		let userpw = $("#userpw").val();
  		console.log("userid : " + userid);
   		console.log("userpw : " + userpw);
   		
  		let sData = {
   			"userid" : userid,
   			"userpw" : userpw
  		};
  		console.log("sData");
   		console.log(sData);
   		$.ajax({
   			type : "post",
   			data : sData,
   			url : "/lee/user/checkUser",
   			success : function(rData){
   				console.log(rData);
   				if(rData == true){
   					console.log("회원존재");
   					$("#form-login").submit();
   				}else{
   					console.log("아이디나 비밀번호가 틀림");
   					$("#checkResult").text("아이디나 비밀번호를 다시 확인해주세요.")
   									 .css("color", "red");
   				}
   			}
   		});
   	});//모달
   	
   	
   	//비밀번호찾기
   	let resetPwResult = "${resetPwResult}";
	if (resetPwResult == "success") {
		alert("변경된 비밀번호를 이메일로 전송했습니다.");
	}else if(resetPwResult == "fail"){
		alert("이메일로 전송실패 했습니다. 아이디를 확인해 주세요.");
	}
	
   	//아이디찾기
   	let resultFindId = "${resultFindId}";
	if (resultFindId == "success") {
		alert("아디를를 이메일로 전송했습니다.");
	}else if(resetPwResult == "fail"){
		alert("이메일로 전송실패 했습니다. 이메일을 확인해 주세요.");
	}
})