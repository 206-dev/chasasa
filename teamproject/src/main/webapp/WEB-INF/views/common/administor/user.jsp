<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/common/css/admin.css">

<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->
<link href="/resources/common/img/favicon.png" rel="icon">
<link href="/resources/common/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

<link href="/resources/common/css/style.css" rel="stylesheet">

<script src="/resources/jang/js/index.js" defer></script>
<%@ include file="/WEB-INF/views/jang/include/header.jsp"%>
<script>
$(function(){
    // sidebar 열린 nav 설정
    $("li.summary a").removeClass("collapsed");
    $("li.summary ul").addClass("show");
    $("li.summary ul li.summary a").addClass("active");
    
    //유저 체크
    $("#btnUserCheck").click(function(){
    	console.log("유저 체크 버튼");
    	let userid = $("#userid").val();
    	console.log("userid : ", userid)
    	$.ajax({
    		type : "get",
    		url : "/lee/user/joinCheckUserid/" + userid,
    		success : function(rData){
    			console.log("rData : ", rData);
    			if(rData){
    				//유저존재
    				//해당 유저 등급 가져오기
    				$.ajax({
    					type : "get",
    					url : "/admin/getGarde/" + userid,
    					success : function(gradeData){
    						let grade = gradeData;
    						if(grade === 3){
    							alert("해당 아이디는 마스터입니다.");
    							return;
    						}
    						console.log("grade : ", grade);
    						$("#inputUserid").val(userid);
    						$("#gradeSelect").val(grade);
    						$("#gradeModifyDiv").fadeIn(1000);
    					}
    				})
    			}
    		}
    	})
//     	/joinCheckUserid/{userid}
    })// 유저체크
    
    // 등급 변경버튼
    $("#updateGradeBtn").click(function(){
    	console.log("등급 변경 버튼");
    	let userid = $("#inputUserid").val();
    	let gradeno = $("#gradeSelect").val();
    	console.log("userid : ", userid);
    	console.log("gradeno : ", gradeno);
    	let sData = {
    			"userid" : userid,
    			"gradeno" : gradeno
    		};
    	console.log("sData : ", sData);
    	$.ajax({
    		type : "post",
    		url : "/admin/modifyGrade",
    		data : JSON.stringify(sData),
    		contentType : "application/json; charset=utf-8",
			success : function(rData){
				console.log("rData : ", rData);
				if(rData){
					alert("유저 등급 변경 완료");
					$("#gradeModifyDiv").fadeOut(1000);
				}else{
					alert("유저 등급 변경 실패");
				}
			}    	
    	})
    });
})
</script>
<style>
.admin-user-container{
	border: 2px solid #474545;
	border-radius: 10px;
	padding : 1rem;
}
.admin-user-btn{
	padding: 2px 10px;
	background-color: white;
	border: 1px solid #474545;
	border-radius: 10px;
	cursor: pointer;
}
.admin-user-btn:hover{
	background-color: #474545;
	color: white; 
}
.gradeModifyDiv{
	display: none;
}
.input_userid{
	outline: none;
	border : none;
}
.mt-10{
	margin-top: 10px;
}
.ml-10{
	margin-left: 10px;
}
</style>
<main id="main" class="main">
	<div class="admin-user-container">
		<label>
			아이디 : 
		</label>
		<input type="text" id="userid">
		<button class="admin-user-btn ml-10" id="btnUserCheck">
			조회
		</button>
	</div>
	<div class="admin-user-container mt-10 gradeModifyDiv" id="gradeModifyDiv">
		<div>
			<span>아이디 : </span> <input type="text" class="input_userid" id="inputUserid" readonly/>		
		</div>
		<div class="mt-10">
			<select id="gradeSelect">
				<option value="1">
					일반유저
				</option>
				
				<option value="2">
					관리자
				</option>
			</select>
			<button class="admin-user-btn ml-10" id="updateGradeBtn">변경</button>
		</div>
	</div>
</main>


<%@ include file="/WEB-INF/views/common/administor/sidebar.jsp" %>