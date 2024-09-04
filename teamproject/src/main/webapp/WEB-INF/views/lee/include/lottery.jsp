<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/lee/css/lottery.css">
<script>
	$(function(){
		// 복권 ----------------------------------------------------------------
		$(document).click(function(e){
			let checkModalContainer = $("#lotteryModalContainer");
			let checkModal = $("#lotteryModal");
			let openCheckBtn = $("#openLotteryBtn");	    
			// 모달을 여는 버튼 클릭 시 닫히지 않도록 처리
		    if (!checkModal.is(e.target) && checkModal.has(e.target).length === 0 && !openCheckBtn.is(e.target)) {
		        if (checkModalContainer.is(':visible')) {
		            checkModalContainer.fadeOut(1000);
		            $("body").css("overflow", "auto");
		        }
		    }
		});
			

		let userid = `${loginSessionDto.userid}`;
		//복권 오픈 버튼
		$("#openLotteryBtn").click(function(){
			if(userid === ''){
				location.href = "/lee/user/login";
			}else{
				checklottery();
				$("#lotteryModalContainer").fadeIn(1000);	
				$("body").css("overflow", "hidden");
			}
		});
		
		//복권 버튼 -> 체크
		function checklottery(){
			let lotterybtns = $(".lottery-box .lottery-btn");
			console.log(lotterybtns);
			
			$.ajax({
				type : "get",
				url : "/lee/user/getMyPoint",
				success : function(getPoint){
					let myPoint = getPoint
					console.log("myPoint : ", myPoint);
					
					for(let i=0; i<lotterybtns.length; i++){
						let lotterybtn = $(lotterybtns[i]);
						let cost = parseInt(lotterybtn.attr("data-cost"));
						console.log("cost : ", cost);
						console.log("cost type : ", typeof(cost));
						
						$.ajax({
							type : "get",
							url : "/lottery/check/"+cost,
							success : function (rData){
								console.log(cost, " rData : ", rData);
								if(cost > myPoint){
									//포인트부족
									lotterybtn.html("포인트부족").prop("disable", true)
									  .css("background-color", "rgb(255 104 104)")
									  .css("color", "white").css("cursor", "default")
									  .css("border", "1px solid rgb(255 104 104)");
								}
								if(!rData){
									//구입완료
									lotterybtn.html("구입완료").prop("disable", true)
											  .css("background-color", "rgb(81, 81, 81)")
											  .css("color", "white").css("cursor", "default")
											  .css("border", "1px solid rgb(81, 81, 81)");
									
									
								}
							}
						});
					}
				}
			})
			
			
		}
		
		
		//복권 구입
		$(".lottery-box").on("click", ".lottery-btn", function(){
			console.log("복권 구입 시도");
			let userid = `${loginSessionDto.userid}`;
			console.log("userid : ", userid);
			if(userid !== ""){
				let that = $(this);
				let cost = parseInt(that.attr("data-cost"));
				$.ajax({
					type : "get",
					url : "/lee/user/getMyPoint",
					success : function(getPoint){
						let myPoint = getPoint
						if(myPoint >= cost){
							console.log("구입가능");
							$.ajax({
								type : "get",
								url : "/lottery/buy/"+cost,
								success : function(rData){
									if(rData){
										console.log("rData : ", rData);
										let result = rData.result;
										console.log("result : ", result);
										showLevelInfo(userid)
										checklottery(userid);
										alert(result);
									}else{
										alert("구매 실패!")
									}
								}
							});
						}else{
							alert("포인트가 부족합니다.");
						}
					}
				});
				
			};
			
			//포인트 있는지 체크
			
			// -> controller -> service -> 갬블후 point차감 결과 리턴
		});
		

	});
</script>
<div class="lottery-modal-container" id="lotteryModalContainer">
   	<div class="lottery-modal" id="lotteryModal">
   		<div class="lottery-container">
   			<h3>LOTTERY 규칙</h3>
   			<ol>
   				<li>하루에 한번씩 구입 가능합니다.</li>
   				<li>1등은 100배(0.1%), 2등은 10배(1%), 3등은 5배(10%), 4등은 2배(30%) 입니다.</li>
   				<li>과도한 포인트 갬블은 정신 건강에 해로울 수 있습니다.</li>
   			</ol>
   		</div>
   		
   		<div class="lottery-container">
   			<h3>LOTTERY TICKET</h3>
   			<ul>
   				<li>
	   				<div class="lottery-box">
			   			<div class="lottery-item">
							50 POINT LOTTERY
						</div>
						<button class="lottery-btn" data-cost="50">
							구입
						</button>   
			   		</div>	
		   		</li>
   				<li>
   					<div class="lottery-box">
			   			<div class="lottery-item">
							100 POINT LOTTERY
						</div>
						<button class="lottery-btn" data-cost="100">
							구입
						</button>   
			   		</div>	
   				</li>
   				<li>
   					<div class="lottery-box">
			   			<div class="lottery-item">
							500 POINT LOTTERY
						</div>
						<button class="lottery-btn" data-cost="500">
							구입
						</button>   
			   		</div>	
   				</li>
   			</ul>
   		</div>

   	</div>
</div>