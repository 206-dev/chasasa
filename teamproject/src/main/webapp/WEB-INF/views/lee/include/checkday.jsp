<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/lee/css/checkday.css">
<script>
	$(function(){
		
		// 출석체크 ----------------------------------------------------------------
		$(document).click(function(e){
			let checkModalContainer = $("#checkModalContainer");
			let checkModal = $("#checkModal");
			let openCheckBtn = $("#openCheckBtn");	    
			// 모달을 여는 버튼 클릭 시 닫히지 않도록 처리
		    if (!checkModal.is(e.target) && checkModal.has(e.target).length === 0 && !openCheckBtn.is(e.target)) {
		        if (checkModalContainer.is(':visible')) {
		            checkModalContainer.fadeOut(1000);
		            $("body").css("overflow", "auto");
		        }
		    }
		});
			
		// 캘린더 만들기
		function createCalendar(){
			const today = new Date();
			const year = today.getFullYear();
			const month = today.getMonth();
			const calender = $("#calender");
			calender.find('div').not('.days').remove();
			const firstDay = new Date(year, month, 1).getDay();
			const lastDate = new Date(year, month+1, 0).getDate();
			$("#month").html(month+1 + "월");
			
			let days = [];
			
			for(let i=0; i < firstDay; i++){
				days.push('<div></div>');
			}
			
			for(let i=1; i<=lastDate; i++){
				days.push('<div class="day" data-day="'+i+'">'+ i +'</div>');
			}
			
			calender.append(days.join(''));
			
			//오늘자 출첵여부 체크해서 버튼 활성화?
			$.ajax({
				type : "get",
				url : "/checkDay/today",
				success : function(rData){
					console.log(rData);
					if(rData){
						$("#checkDayBtn").css("display", "block");
					}else{
						$("#checkDayBtn").css("display", "none");
					}
				}
			});
		}

		function setCheckedDays(){

			// 이번달 출첵리스트 가져오기
			let userid = `${loginSessionDto.userid}`;
			if(userid!==""){
				let daysDivs = $("#calender .day");
				console.log("daysDivs : ", daysDivs);
				
				$.ajax({
					type : "get",
					url : "/checkDay/getList",
					success : function(rData){
						console.log("rData : ", rData);
						for(let i=0; i<rData.length; i++){
							let checkedDay = rData[i];
							for(let j=0; j<daysDivs.length; j++){
								let dayDiv = $(daysDivs[j]);
								let day = parseInt(dayDiv.attr("data-day"));
								
								if(checkedDay === day){
									dayDiv.css("background-color", "rgb(43 171 97)").css("color", "white");
									break;
								}
							}
		                }	
		            }
				})//ajax	
			}
		}
		
		//출석체크 오픈 버튼
		$("#openCheckBtn").click(function(){
			let userid = `${loginSessionDto.userid}`;
			if(userid === ''){
				location.href = "/lee/user/login";
			}else{
				createCalendar();
				setCheckedDays();
				$("#checkModalContainer").fadeIn(1000);	
				$("body").css("overflow", "hidden");
			}
		});
		
		//출첵 하기
		$("#checkDayBtn").click(function(){
			let userid = `${loginSessionDto.userid}`; 
			if(userid!==""){
				$.ajax({
					type : "get",
					url : "/checkDay/regist",
					success : function(rData){
						console.log(rData);
						if(rData){
							createCalendar();
							setCheckedDays();
							showLevelInfo(userid);
							alert("출석 완료!");
						};
					}
				});
			};
			
		});
	});
</script>
<div class="check-modal-container" id="checkModalContainer">
   	<div class="check-modal" id="checkModal">	
   		<span class="month" id="month"></span>
   		<div class="calender-container" id="calender">
   			 <!-- 요일 -->
		    <div class="days day-sun">일</div>
		    <div class="days day-name">월</div>
		    <div class="days day-name">화</div>
		    <div class="days day-name">수</div>
		    <div class="days day-name">목</div>
		    <div class="days day-name">금</div>
		    <div class="days day-name">토</div>
   		</div>
   		<div class="checkDay-rule-container">
   			<h3>규칙</h3>
   			<ul>
   				<li>하루출석 10POINT</li>
   			</ul>
   		</div>
   		<button class="event-btn calenda-btn" id="checkDayBtn">출석 하기</button>
   	</div>
</div>