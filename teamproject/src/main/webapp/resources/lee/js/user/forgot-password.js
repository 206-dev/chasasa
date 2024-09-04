$(function(){
	//모달
	$("#btnLogin").click(function(){
  		console.log("로그인 버튼 클릭");
 		let id = $("#userid").val();
  		let pw = $("#userpw").val();
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
})