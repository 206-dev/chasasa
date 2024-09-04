<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>차박차박</title>
<link rel="stylesheet" href="/resources/lee/css/index.css">
<link rel="stylesheet" href="/resources/common/css/banner.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>												
<!-- <script src="/resources/lee/js/index.js" defer></script> -->
<script src="/resources/lee/js/user/point.js" defer></script>
    
<script>
$(function(){
	showRank();
	//유저랭크 갱신 비동기
	
	function showRank(){	
		$("#rankContainer").empty();
		
		$.ajax({
			type: "get",
			url: "/lee/user/getRanker",
			success : function(rData){
// 				console.log(rData);
				let div = "";
				$.each(rData, function(index, value){
					let obj = value;
					div+=`<div class="rank-box">
							 <div class="rank-item">
					    		RANK \${obj.rank}	
					    	 </div>
					    	 <div>
						    	<span class="bold-800">\${obj.nickname}</span>  		
					    	 </div>
					         <div>
						    	<div>
						    		<span class="level-count mr-5">레벨</span><span>\${obj.userlevel}</span>
						    	</div>	
					    	 </div>
					       </div>`
				});
// 				console.log("div : ", div);
				$("#rankContainer").append(div);
				let userid = `${loginSessionDto.userid}`;
				if(userid !== null && userid !== ""){
					$.ajax({
						type : "get",
						url : "/lee/user/myRank",
						success : function(rData){
							let div = `<div class="rank-box">
					    		<div class="myrank-item">
					    			MY RANK
					    		</div>
					    		<div></div>
					    		<span class="bold-800">\${rData} 위</span>
					    	</div>`;
					    	$("#rankContainer").append(div);
						}
					});
				}
			}
		})//
		
	}
	
	let userid = `${loginSessionDto.userid}`;
	showLevelInfo(userid);
	
	
	//////////////////////////////////////////////////////// 광고
	//더미 데이터
	let bannerDatas = [
				  {
					"name" : "redearboard1",
					"type" : "reader-board",
					"src" : "/resources/common/banner/redearboard1.png"
				  },
				  {
				    "name" : "redearboard2",
				    "type" : "reader-board",
					"src" : "/resources/common/banner/redearboard2.png"
				  },
				  {
					"name" : "redearboard3",
					"type" : "reader-board",
					"src" : "/resources/common/banner/redearboard3.png"
				  },
				  {
				    "name" : "redearboard4",
				    "type" : "reader-board",
					"src" : "/resources/common/banner/redearboard4.png"
				  },
				  {
				    "name" : "redearboard5",
				    "type" : "reader-board",
					"src" : "/resources/common/banner/redearboard5.png"
				  },
				  {
				    "name" : "redearboard6",
				    "type" : "reader-board",
					"src" : "/resources/common/banner/redearboard6.png"
				  },
				  {
				    "name" : "redearboard7",
				    "type" : "reader-board",
					"src" : "/resources/common/banner/redearboard7.png"
				  },
				  {
				    "name" : "redearboard8",
				    "type" : "reader-board",
					"src" : "/resources/common/banner/redearboard8.png"
				  },
				  {
				    "name" : "redearboard9",
				    "type" : "reader-board",
					"src" : "/resources/common/banner/redearboard9.png"
				  },
				  {
				    "name" : "redearboard10",
				    "type" : "reader-board",
					"src" : "/resources/common/banner/redearboard10.png"
				  },
				  {
				    "name" : "redearboard11",
					"type" : "reader-board",
					"src" : "/resources/common/banner/redearboard11.png"
				  },
				  {
					"name" : "redearboard12",
					"type" : "reader-board",
					"src" : "/resources/common/banner/redearboard12.png"
				  },
				  {
					"name" : "redearboard13",
					"type" : "reader-board",
					"src" : "/resources/common/banner/redearboard13.png"
				  },
				  {
					"name" : "redearboard14",
					"type" : "reader-board",
					"src" : "/resources/common/banner/redearboard14.png"
				  }];
	
	
	let readerBoardList = new Array();
	for(let i=0; i<bannerDatas.length; i++){
		readerBoardList.push(bannerDatas[i]);
	}
	console.log("readerBoardList : ", readerBoardList);

	
	function shuffleRedaerBoards() {
	    let count = readerBoardList.length;
	    
	    for (let i=0; i<count; i++) {
	        let randomNum = getRandomNum(count); // 0부터 i까지의 숫자 중 랜덤 선택
	        let temp = readerBoardList[randomNum];
	        readerBoardList[randomNum] = readerBoardList[i]
	        readerBoardList[i] = temp;
	    }
	}
	
	// 리더보드리스트 length 에서 랜덤 함수 가져옴. (배열숫자 0~(사이즈-1))
	function getRandomNum(count){
		let maxNum = count - 1;
		let minNum = 0;
		let randomNum = Math.floor(Math.random()*(maxNum-minNum+1));
		return randomNum;
	}
	
	function showReaderBoardBanner() {
	    let index = 0;
	    let activeImage = 1;
	    let isToggle = true;

	    // 초기 이미지를 설정
	    $("#readerboard-img-1").attr("src", readerBoardList[index].src).addClass("active");

	    setInterval(() => {    
	        index++;
	        if (index === readerBoardList.length) {
	            index = 0;
	        }
	
	        let currentImage;
	        let nextImage;
	        if(isToggle){
	        	currentImage = $("#readerboard-img-1");
	 	        nextImage = $("#readerboard-img-2");
	        }else{
	        	currentImage = $("#readerboard-img-2");
	 	        nextImage = $("#readerboard-img-1");
	        }
	       

	        // 다음 이미지를 준비: 아래쪽에서 대기
	        $(nextImage).attr("src", readerBoardList[index].src).css({
	            top: '100%', 
	            opacity: 0
	        });

	        // 현재 이미지를 위로 슬라이드하면서 사라지게 함
	        $(currentImage).animate({ top: '-100%', left: "0", opacity: '0' }, 2000, function () {
	            $(this).attr("class", "previouse readerboard-img").css("opacity", "0");
	        });

	        // 다음 이미지를 슬라이드하면서 화면에 나타나게 함
	        $(nextImage).animate({	top: '0', opacity: '1' }, 2000, function () {
	            $(this).attr("class", "active readerboard-img");
	            
	            
	        });
	        // 활성 이미지 ID 토글
	       if(isToggle){
	    	   isToggle = false;
	       }else{
	    	   isToggle = true;
	       }

	    }, 5000);
	}

	shuffleRedaerBoards();
	console.log("readerBoardList : ", readerBoardList);
	showReaderBoardBanner();
});
</script>
	<style>
		.report-modal-container{
			position:absolute;
			top:0;
			left:0;
			width: 100%;
			height: 100%;
			background: rgba(0,0,0,0.4);
			z-index: 100;
			display: none;
		}
		.report-modal{
			position: absolute;
			background-color: white;
			left: 50%;
			top: 200px;
			transform: translateX(-50%);
			display: inline-grid;
			padding: 10px;
			border-radius: 1rem;
			border: 2px solid gray;
			gap: 1rem;
		}
		
		.report-select{
			padding: 4px 2px;
   			border-radius: 10px;
		}
		.report-option{
			padding: 4px 2px;
		}
		
		.report-btn-container{
			display: grid;
			grid-template-columns: 1fr 1fr;
			gap: 0.5rem;
			
		}
		.report-btn{
			border-radius: 10px;
		    border: none;
		    outline: none;
		    background-color: #666161;
		    padding: 4px;
		    color: white;
		    cursor: pointer;
		    width: 105px;
		}
		.report-btn:hover {
			background-color: rgb(255, 170, 0);
		}
		
		.ta-report{
			height: 120px;
		    border: 2px solid gray;
		    border-radius: 8px;
		    outline: none;
		    resize: none;
		    overflow-y : scroll;
		    overflow-x : hidden;
		    padding: 4px;
		}
		.ta-report::-webkit-scrollbar{
			width: 0;
			display: none;
		}
		.ta-report{
			-ms-overflow-style: none;
			scrollbar-width: none;
		}
	</style> 
</head>

<body>
 <!-- 광고 -->
	<%@include file="/WEB-INF/views/lee/include/timeboard.jsp"%>
    
    <!-- 신고하기 모달 start -->
	<script>
	
		$(function(){
			///////////////////////////////////// 신고 케밥
			$(document).click(function(e){
				let $menu = $(".kebab-content");
				
				if(!$(e.target).closest(".kebab-menu").length){
					if($menu.is(':visible')){
						$menu.css("display", "none");
					}
				}
			});
			let isKebab = false;
			//캐밥 버튼 눌렀을때
			$(".kebab-container").on("click", ".kebab-menu", function(){
				console.log("케밥 누름");
				console.log($(this));
				let kebabContent = $(this).next();
				console.log("kebabContent : ", kebabContent);
				if(isKebab){
					kebabContent.css("display", "none");
					isKebab = false;
				}else{
					kebabContent.css("display", "grid");
					isKebab = true;
				}
			});
			
			// 댓글캐밥 눌렀을때 reply-btn-container
			$("#reply-ul").on("click" ,".kebab-menu", function(){
				 console.log("케밥 누름");
					console.log($(this));
					let kebabContent = $(this).next();
					console.log("kebabContent : ", kebabContent);
					if(isKebab){
						kebabContent.css("display", "none");
						isKebab = false;
					}else{
						kebabContent.css("display", "grid");
						isKebab = true;
					}
			 });
			
			//신고하기 눌렀을때
			$(".kebab-content").on("click", ".report-click-btn",function(){
				let userid = `${loginSessionDto.userid}`;
				console.log("신고하기 누름");
				console.log("userid : ", userid);
				if(userid===null||userid===""){
					console.log("로그인 안함");
					location.href = "/lee/user/login";
					return;
				}
				
				let select = $("#reportSelect");
				select.empty();
				let that = $(this);
				console.log(that);
				let targetTypeNo = that.attr("data-targetTypeNo");
				let target = that.attr("data-target");
				
				$(".report-btn-container .ok-report").attr("data-target", target)
													 .attr("data-targetTypeNo", targetTypeNo);
				
				console.log("target : ", target);
				console.log("targetTypeNo : ", targetTypeNo);
				$("#report-modal2").css("display", "none");
				$("#report-modal1").css("display", "inline-grid");
				$("#reportModalContainer").css("display", "block");
				
				$.ajax({
					type: "get",
					url: "/lee/report/reasonType",
					success : function(rData){
						
						let optionTag = "";
						$.each(rData, function(index, value){
							let obj = value;
							let reasonTypeNo = obj.reasonTypeNo;
							let reasonType = obj.reasonType;
							optionTag += `<option class="report-option" value="`;
							optionTag += reasonTypeNo;
							optionTag += `">`;
							optionTag += reasonType;
							optionTag += `</option>`;	
						});// each
						select.prepend(optionTag);
					}
				});
			});// 신고버튼 클릭
			
			// 댓글 신고하기 눌렀을때 reply-btn-container
			$("#reply-ul").on("click" ,".report-click-btn", function(){
				let userid = `${loginSessionDto.userid}`;
				console.log("신고하기 누름");
				console.log("userid : ", userid);
				if(userid===null||userid===""){
					console.log("로그인 안함");
					location.href = "/lee/user/login";
					return;
				}
				
				let select = $("#reportSelect");
				select.empty();
				let that = $(this);
				console.log(that);
				let targetTypeNo = that.attr("data-targetTypeNo");
				let target = that.attr("data-target");
				
				$(".report-btn-container .ok-report").attr("data-target", target)
													 .attr("data-targetTypeNo", targetTypeNo);
				
				console.log("target : ", target);
				console.log("targetTypeNo : ", targetTypeNo);
				$("#report-modal2").css("display", "none");
				$("#report-modal1").css("display", "inline-grid");
				$(".report-modal").css("top", 'auto').css("bottom", "600px");
				$("#report-modal1").css("top", 'auto').css("bottom", "600px");
				$("#report-modal2").css("top", 'auto').css("bottom", "600px");
				$("#reportModalContainer").css("display", "block");
				
				$.ajax({
					type: "get",
					url: "/lee/report/reasonType",
					success : function(rData){
						
						let optionTag = "";
						$.each(rData, function(index, value){
							let obj = value;
							let reasonTypeNo = obj.reasonTypeNo;
							let reasonType = obj.reasonType;
							optionTag += `<option class="report-option" value="`;
							optionTag += reasonTypeNo;
							optionTag += `">`;
							optionTag += reasonType;
							optionTag += `</option>`;	
						});// each
						select.prepend(optionTag);
					}
				});
			 });
			
			//취소버튼
			$(".report-btn-container").on("click", ".cancle-report", function(){
				$("#reportModalContainer").css("display", "none");
			});
			//다음 버튼
			$(".report-btn-container").on("click", ".next-report", function(){
				let reasonTypeNo = $("#reportSelect").val();
				console.log("reasonTypeNo : ", reasonTypeNo);
				$("#report-modal2 .report-btn-container .ok-report").attr("data-reasonTypeNo", reasonTypeNo);	
			
				$("#report-modal1").css("display", "none");
				$("#report-modal2 .ta-report").val("");
				$("#report-modal2").css("display", "inline-grid");
			});//다음버튼
			
			//완료 버튼
			$(".report-btn-container").on("click", ".ok-report", function(){
				let target = $(this).attr("data-target");
				let targetTypeNo = $(this).attr("data-targetTypeNo")
				let reasonTypeNo = $(this).attr("data-reasonTypeNo");
				let content = $("#report-modal2 .ta-report").val();
				let targetUrl = window.location.href;
				console.log("target : ", target);
				console.log("targetTypeNo : ", targetTypeNo);
				console.log("reasonTypeNo : ", reasonTypeNo);
				console.log("content : ", content);
				console.log("targetUrl : ", targetUrl);
				let sData = {
						"target" : target,
						"targetTypeNo" : targetTypeNo,
						"reasonTypeNo" : reasonTypeNo,
						"content" : content,
						"targetUrl" : targetUrl
				}
				
				$.ajax({
					type : "post",
					url : "/lee/report/regist",
					data : JSON.stringify(sData),
					contentType : "application/json; charset=utf-8",
					success : function(rData){
						console.log(rData);
						$("#reportModalContainer").css("display", "none");
						if(rData){
							alert("신고 접수 완료");
						}else{
							alert("신고 접수 실패");	
						}
					}			
				});
			});//완료버튼
			let userid = `${loginSessionDto.userid}`;
			if(userid!==""){
				let gradeno = `${loginSessionDto.gradeno}`;
				if(gradeno!==""){
					if(parseInt(gradeno)>1){
						$(".nav-list").css("grid-template-columns", "1fr 1fr 1fr 1fr 1fr 1fr");	
					}else{
						$(".nav-list").css("grid-template-columns", "1fr 1fr 1fr 1fr 1fr");
					}
				}
			
			}else{
				$(".nav-list").css("grid-template-columns", "1fr 1fr 1fr 1fr 1fr");
			}
		
		});//
				
	</script>
	<%@ include file="/WEB-INF/views/lee/include/checkday.jsp" %>
	<%@ include file="/WEB-INF/views/lee/include/lottery.jsp" %>
	<div class="report-modal-container" id="reportModalContainer">
		<div class="report-modal" id="report-modal1">
			<label >사유선택</label>
			<select class="report-select" id="reportSelect">

			</select>
			<div class="report-btn-container">
				<button class="report-btn cancle-report">취소</button>
				<button class="report-btn next-report">다음</button>
			</div>
		</div>
		<div class="report-modal" id="report-modal2">
			<label>신고내용</label>
			<textarea class="ta-report"></textarea>
			<div class="report-btn-container">
				<button class="report-btn cancle-report">취소</button>
				<button class="report-btn ok-report">완료</button>
			</div>
		</div>
	</div>
	
	<!-- 신고 모달 end -->
   



    <!-- header -->
    <header class="header-Container">
        <div class="navbar-Logo">
            <a href="/" class="logo-link"><img alt="" src="/resources/lee/image/logo4.png"></a>
            <span class="font-size-10 bold-500 ml-10 mb-5"> 차박을 좋아하는 사람들..</span>
        </div>
        <div class="event-container">
        	<button class="event-btn mr-10" id="openLotteryBtn">포인트 복권</button>
        	<button class="event-btn" id="openCheckBtn">출석 체크</button>
        </div>
    </header>
    


    <!-- nav -->
    <nav class="navbar mt-10">
        <ul class="nav-list">
            <li class="nav-item">
                <a href="/jang/board/notice/list" class="nav-link">공지사항</a>
                <ul class="sub-nav-list">
                    <li class="sub-nav-item"><a href="/jang/board/notice/list" class="sub-nav-link">공지사항</a></li>
                    <li class="sub-nav-item"><a href="/lee/board/list/join" class="sub-nav-link">가입인사</a></li>
<!--                     <li class="sub-nav-item"><a href="/lee/board/list/check" class="sub-nav-link">출석체크</a></li> -->
                </ul>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">커뮤니티</a>
                <ul class="sub-nav-list">
                    <li class="sub-nav-item"><a href="/lee/board/list/free" class="sub-nav-link">자유게시판</a></li>
                    <li class="sub-nav-item"><a href="/kim/board/info" class="sub-nav-link">정보공유</a></li>
                    <li class="sub-nav-item"><a href="/lee/board/list/review" class="sub-nav-link">리뷰</a></li>
                    <li class="sub-nav-item"><a href="/lee/board/list/qna" class="sub-nav-link">질문게시판</a></li>
                </ul>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">모임</a>
                <ul class="sub-nav-list">
<!--                     <li class="sub-nav-item"><a href="/lee/board/list/free" class="sub-nav-link">정모 공지</a></li> -->
                    <li class="sub-nav-item"><a href="/lee/board/list/meet" class="sub-nav-link">벙캠/동행</a></li>
                    <li class="sub-nav-item"><a href="/lee/board/list/meetReview" class="sub-nav-link">모임후기</a></li>
                </ul>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">중고장터</a>
                <ul class="sub-nav-list">
                    <li class="sub-nav-item"><a href="/lee/board/list/buy" class="sub-nav-link">삽니다</a></li>
                    <li class="sub-nav-item"><a href="/lee/board/list/sell" class="sub-nav-link">팝니다</a></li>
                </ul>
            </li>
            <li class="nav-item">
            	<a href="#" class="nav-link">차타버스</a>
            	<ul class="sub-nav-list">
<!--                     <li class="sub-nav-item"><a href="/lee/board/list/free" class="sub-nav-link">정모 공지</a></li> -->
                    <li class="sub-nav-item"><a href="/lee/chataverse/loading" class="sub-nav-link">플레이</a></li>
                    <li class="sub-nav-item"><a href="/lee/chataverse/itemshop" class="sub-nav-link">상점</a></li>
                </ul>
            </li>
            <c:if test="${loginSessionDto.gradeno > 1}">
	            <li class="nav-item"><a href="/admin/main" class="nav-link">관리자</a></li>
            </c:if>
        </ul>
    </nav>
    <div class="login-profile-container">
    	<div class="rank-container"  id="rankContainer">
	    	
 
	    	
    	</div>
    	<div class="login-profile-box">
    		<c:if test="${loginSessionDto != null}">
    			<img alt="profile" src="

    			" class="profile-img" id="login-profile-img">
	    		<div class="login-profile">
	    					<div class="namelevel">
		    					<a href="#"><img class="img-mail" alt="" src="/resources/lee/image/mail.png"></a>
							    <a href="/user/profile" class="bold-800 ml-5">${loginSessionDto.nickname}</a>
								<span class="level-count ml-20" >레벨</span>
						   		<span class="ml-5" id="profile_level">
<%-- 						   			${loginSessionDto.userlevel} --%>
						   		</span>
	    					</div>
					   		<div class="expContainer">
					   			<div class="expTextBox">
					   				<span id="my_point"></span>
					   				<span>/</span>
					   				<span id="next_point"></span>
					   			</div>
								<div class="exp" id="div_exp"></div>
							</div>
				</div>
			</c:if>
			<div>
				<!-- 로그인/로그아웃 버튼 로그인 시 display 처리 -->
				<c:choose>
	            	<c:when test="${loginSessionDto == null}">
			            <a class="btn2 btn-yellow" href="/lee/user/login">로그인</a>
	            	</c:when>
	            	<c:otherwise>
			            <a class="btn2 btn-yellow mb-10"  id="btnLogout" href="/lee/user/logout">로그아웃</a>
			            <a class="btn2 btn-yellow" href="/lee/user/profile">설정</a>
	            	</c:otherwise>
            	</c:choose>
            	
			</div>
    	</div>
    </div>
   
<section class="section-Container">
<%--  ${login} --%>