<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/lee/include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="/resources/lee/js/detail.js" defer></script>
<!-- CKEditor CDN 추가 -->
<!-- <script src="https://cdn.ckeditor.com/ckeditor5/35.3.0/classic/ckeditor.js"></script> -->
<link rel="stylesheet" href="/resources/lee/css/edite.css">
<link rel="stylesheet" href="/resources/lee/css/edite-detail.css">
<link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/42.0.2/ckeditor5.css">
<!-- <script src="/resources/lee/js/user/point.js" defer></script> -->
<script>
$(function(){
	// 댓글 TextArea 스크롤 크기 자동 조절
	function autoResizeTextarea(textarea) {
        textarea.css('height', 'auto');
        textarea.css('height', (textarea.prop('scrollHeight')) + 'px');
    }
    $('.ta-auto-resize').on('input', function() {
    	console.log("댓글 입력중..");
        autoResizeTextarea($(this));
    });
    // 초기 높이 설정
    $(".ta-auto-resize").each(function(){
        autoResizeTextarea($(this));
    })
	
    //editor css
	$(".ck.ck-editor__editable_inline").css("border", "none");

	// ***************************** 추천하기 ******************************
	$("#btnRecommend").click(function(){
		let boardno = ${dto.boardno};
		let wirter = `${dto.userid}`;
		let userid = `${loginSessionDto.userid}`;
		let data = {"boardno" : ${dto.boardno}};
		let sData = {
				"boardno" : boardno,
				"userid" : userid
		};
		let ssData = {
				"boardno" : boardno,
				"userid" : wirter
		}
		
		if(${loginSessionDto == null}){
			location.redirect.href="/lee/user/login";
		}
		
		// 로그인 한사람만
		console.log("글쓴이 id : " +  wirter);
		console.log("boardno : " + boardno);
		console.log("userid : " + userid);
		if(wirter == userid){
			alert("내글엔 추천할수 없어요!");
		}else{
			console.log("추천된다능");
			// 체크 했는지 체크
			$.ajax({
				type : "post",
				url : "/lee/boardlike/checkLike",
				data : JSON.stringify(sData),
				contentType: "application/json; charset=utf-8",
				success : function(rData){
					console.log("추천체크 성공");
					console.log(rData);
					if(rData==false){
						//추천 가능
						console.log("추천 된다능")
						$.ajax({
							type : "post",
							url : "/lee/boardlike/Like",
							data : JSON.stringify(ssData),
							contentType: "application/json; charset=utf-8",
							success : function(rData){
								$("#spanRecommend").text(rData);
								showLevelInfo(wirter);
								alert("추천완료!");
							}
						});
					}else{
						// 이미 추천함
						// 추천 취소
						url = "/lee/boardlike/delete/" + boardno + "/" + wirter;
						$.ajax({
							type : "delete",
							url : url,
							success : function(rData){
								console.log("취소 성공!");
								console.log(rData);
								$("#spanRecommend").text(rData);
								showLevelInfo(wirter);
								alert("추천 취소!");
							}
						});
					}
				}
			});
		}
		// 추천 중복 안됨
		return false;
	});
    
    //***************        댓글       ******************
    //댓글 보이기
	showReplys();
	// 덧글달기버튼 클릭
	$("#reply-ul").on("click", ".rereply", function(e){
		console.log(".rereply 클릭");
		let that = $(this);
		let isReply = that.attr("data-isreply");
		let replyno = that.attr("data-replyno");
		let li = that.parent().parent().parent().parent();
		let ul = li.parent();
		
		console.log("isReply : " + isReply);
		console.log("replyno : " + replyno);
		//textarea스크롤처리
		let rereplyClone = $(".rereply-ul > li").clone().css("list-style", "none");
		let textArea = rereplyClone.children(".form-reply").children(".ta-auto-resize");
		autoResizeTextarea(textArea);
		textArea.on('input', function() {
		   autoResizeTextarea(textArea);
		});
		
		// 댓글인지 대댓글인지 체크 후 처리
		if(isReply){
			console.log("본문댓글");
			rereplyClone.children(".form-reply").children(".box-item")
												.children(".btn-reply")
												.attr("data-isreply", true);
		}else{
			console.log("대댓글");
			rereplyClone.children(".form-reply").children(".box-item")
												.children(".btn-reply")
												.attr("data-replyno", replyno)
												.attr("data-isreply", false);
		};
		ul.children(".reply-li").remove();
		li.after(rereplyClone);
	});
    
	
	// *댓글달기
	$("#reply-ul").on('click', ".btn-reply", function(){
		console.log(".btn-reply 클릭");
		let that = $(this);
		let formReply = that.parent().parent(); 
				
		let isReply = that.attr("data-isreply");
		
		// sdata에 들어갈 변수들
		let boardno = `${dto.boardno}`;
		let comments = formReply.children(".comments").val();
		let userid = `${loginSessionDto.userid}`;
		let nickname = `${loginSessionDto.nickname}`;
		let replyno = that.attr("data-replyno");
		
		console.log("isReply : " + isReply);
		
		let sData;
		let url = "/lee/board/reply/register";
		
		if(isReply==true){
			console.log("댓글일때");
			sData = {
					"boardno" : boardno,
					"comments" : comments,
					"userid" : userid,
					"nickname" : nickname
			};
		}else{
			console.log("덧글일때");
			sData = {
					"boardno" : boardno,
					"comments" : comments,
					"userid" : userid,
					"nickname" : nickname,
					"replyno" : replyno
			};
		}
		console.log("sData");
		console.log(sData);

		$.ajax({
			type: "post",
			url: url, 
			data : JSON.stringify(sData),
			contentType: "application/json; charset=utf-8",
			success : function(rData){
				console.log(rData);
				$("#comments").val("");
				showReplys();
				showLevelInfo(userid);
			}
		});
	});
	
	//댓글 수정 버튼
	$("#reply-ul").on("click", ".btnReplyUpdate", function(e){
		let that = $(this);
		let btnUpdate = that.next();
		let btnCancle = btnUpdate.next();
		let textarea = that.parent().parent().parent().children(".ta-reply-item");

		console.log(that);
		console.log(btnUpdate);
		console.log(textarea);
		
		textarea.prop("readonly", false);
		textarea.css("border", "1px solid gray").css("border-radius", "10px");

		
		that.fadeOut(1000);
		btnUpdate.fadeIn(1000);
		btnCancle.fadeIn(1000);
		
	});
	//댓글 수정 취소 버튼
	$("#reply-ul").on("click", ".btnReplyUpdateCancle", function(){
		console.log("댓글 수정 취소");
		let that = $(this);
		let btnUpdateOk = that.prev();
		let btnUpdate = btnUpdateOk.prev();
		let textarea = that.parent().parent().parent().children(".ta-reply-item");
		
		textarea.prop("readonly", true);
		textarea.css("border", "none");
		
		that.fadeOut(1000);
		btnUpdateOk.fadeOut(1000);
		btnUpdate.fadeIn(1000);
		
	});
	//댓글 수정 완료 버튼
	$("#reply-ul").on("click", ".btnReplyUpdateOk", function(){
		console.log("댓글 수정 완료 버튼");
		let that = $(this);
		let textarea = that.parent().parent().parent().children(".ta-reply-item");
		
		let replyno = parseInt(that.attr("data-replyno"));
		let comments = textarea.val();

		let sData = {
			replyno : replyno,
			comments : comments
		};
		console.log("sData : ");
		console.log(sData);

		$.ajax({
			type : "put",
			url : "/lee/board/reply/update",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(sData),
			success : function(sData){
				console.log("댓글 수정 성공");
				showReplys();
			}
		});
		
	});
	
	// 댓글 삭제
	// 삭제버튼 누르면 confirm창으로 확인후 삭제처리
    $("#reply-ul").on('click', ".btnReplyDelete" ,function(e){
    	console.log(e);
    	let that = $(this);
    	let replyno = that.attr("data-replyno");
    	let userid = `${loginSessionDto.userid}`;
    	console.log("replyno : " + replyno);
    	
    	$("#btnReplyDeleteOk").attr("data-replyno", replyno);
    	let result = confirm("정말 삭제하시겠습니까?");
    	console.log("result :" + result);
		if(true){
			deleteReply(replyno, userid);
		}
    });
	
	// 삭제처리
	function deleteReply(replyno, userid){
		console.log("deleteReply()");
		console.log("replyno : " + replyno);
		let url = "/lee/board/reply/delete/" + replyno + "/"+ userid;
    	$.ajax({
			type: "delete",
			url: url,
			success : function(rData){
				console.log(rData);
				showReplys();
				showLevelInfo(userid);
			}
		});
	};

	// 삭제취소
	$("#btnReplyDeleteCancle").click(function(){
		$("#btnReplyDeleteOk").removeAttr("data_replyno");
		$("#reply-delete-modal").hide();
	});
	
	//댓글 좋아요 클릭
	$("#reply-ul").on("click", ".btn-like", function(e){
		console.log("좋아요 클릭")
		console.log(e);
		let that = $(this);
		let replyno  = that.attr("data-replyno");
		let userid = `${loginSessionDto.userid}`;
		let replyer = that.attr("data-replyuserid");
		let span = that.children("span");
		console.log("replyno : " + replyno);
		console.log("userid : " + userid);
		console.log("replyer : " + replyer);
		
		let sData = {
				"replyno" : replyno,
				"userid" : userid
		};
		let sLikeData = {
				"replyno" : replyno,
				"userid" : userid,
				"replyer" : replyer
		}
		
		console.log("sData : ");
		console.log(sData);
		console.log("sLikeData : ");
		console.log(sLikeData);
		
		
		// 로그인 페이지로 이동
		if(${loginSessionDto == null}){
			window.location.href = "/lee/user/login";
		}
		
		
		console.log("replyno : " + replyno);
		console.log("userid : " + userid);
		console.log("replyer : " + replyer);
		// 로그인 한사람만
		//댓글 추천 여부 확인
		$.ajax({
			type : "post",
			url : "/lee/replylike/checkLike",
			data : JSON.stringify(sData),
			contentType : "application/json; charset=utf-8",
			success : function(rData){
				console.log("댓글 좋아요 여부 성공");
				console.log(rData);
				if(rData){
					//댓글 좋아요
					console.log("댓글 좋아요 if문");
					console.log(sData);
					$.ajax({
						type : "post",
						url : "/lee/replylike/like",
						data : JSON.stringify(sLikeData),
						contentType : "application/json; charset=utf-8",
						success : function(rData){
							console.log("댓글 좋아요 성공");
							console.log(rData);
							span.html(rData);
							showLevelInfo();
						}
					});
				}else{
					//댓글 취소
					url = "/lee/replylike/delete/" + replyno +"/" + userid + "/" + replyer;
					$.ajax({
						type : "delete",
						url : url,
						success : function(rData){
							console.log("댓글 좋아요 취소 성공");
							console.log(rData);
							span.html(rData);
							showLevelInfo(userid);
						}
					});
					
				}
			}
		});
	});
  
	//댓글 보이기 메서드
	function showReplys(){
		console.log("showReply()");
		$("#reply-ul").empty();
		let boardno = `${dto.boardno}`;
		let userid = `${loginSessionDto.userid}`;
		let sUrl = "/lee/board/reply/list/"+boardno;
		console.log("userid : " + userid);
		console.log(typeof userid);
		
		$.ajax({
			type : "get",
			url : sUrl ,
			success : function(rData){
				console.log("댓글 보이기 요청 성공");
				let btnReply = `<li class="list-style-none mb-10">
									<div>
										<div>
											<div>`;
				if(userid===""){							
					btnReply+= 						`<a class="btn width-100" href="/lee/user/login">덧글달기</a>`;				 		
				}else{
					btnReply+= 						`<span class="btn rereply width-100" data-isreply=true>덧글달기</span>`;
				};
				
					btnReply+				`</div>
										</div>
									</div>
								</li>`;
				$("#reply-ul").append(btnReply);
				$.each(rData, function(index, value){
					let obj = value;
					let replyid = obj.userid;
					let userid = `${loginSessionDto.userid}`;
					let nickname = obj.nickname;
					let profile = obj.profile;
					console.log("nickname : " + nickname);
					console.log("replyid : " + replyid);
					console.log(typeof(userid));
					let li =
						`<li class="reply-item mt-10" style="margin-left: \${(obj.reply_level-1)*40}px; width: calc(100% - \${(obj.reply_level-1)*40}px)">
							<div class="user-profile flex">
								<img class="user-profile-img" alt="프로필" src=" `;
					if(profile !== null && profile != ""){
						li +=		`\${obj.profile}`;
					}else{
						li +=		`/resources/lee/image/empty_profile.jpg`;
					}	
						li +=	`">
							</div>
							<div class="width100per ml-20 reply-content">
								<div class="flex justify-between pl-10">
									<span class="yellow-border-box">\${obj.nickname}</span>
									<button class="btn-like" data-replyno="\${obj.replyno}" data-replyuserid="\${obj.userid}">
										<img class="like-img" alt="" src="/resources/lee/image/favorite.png"> 
										<span style="margin:0 0 4px 4px">\${obj.likes}</span>
									</button>
								</div>
								<form>
								
								</form>
								<textarea readonly class="ta-reply-item ta-auto-resize pl-10 mt-10" rows="" cols="">\${obj.comments}							
								</textarea>
								<div class="flex justify-between pl-10 reply-bottom-box">
									<div>
										<span>\${toDateString(obj.updatedate)}</span>`;
					if(userid !== "" && userid !== null){
						li+=			`<img class="reply-img" alt="reply" src="/resources/lee/image/reply.png">
										<span class="cursor-pointer hover-black rereply" data-replyno="\${obj.replyno}">덧글달기</span>
										`
					}else if(userid === "" || userid === null){
						li+=			`<img class="reply-img" alt="reply" src="/resources/lee/image/reply.png">
										<a class="cursor-pointer hover-black" href="/lee/user/login">덧글달기</a>`					
					};					
										
					li+=			`</div>
									<div class="flex reply-btn-container">`;
					if(replyid == userid){				
						li+=			`<button class="btn mr-10 btnReplyUpdate">수정</button>
										<button class="btn mr-10 btnReplyUpdateOk" data-replyno="\${obj.replyno}" style="display:none">수정완료</button>
										<button class="btn mr-10 btnReplyUpdateCancle" style="display:none">취소</button>
										<button class="btn btnReplyDelete" data-replyno="\${obj.replyno}">삭제</button>`;
					}else{
						li+= `<div class="kebab-container">
								<div class="kebab-menu">
									<div class="dot"></div>
									<div class="dot"></div>
									<div class="dot"></div>
								</div>
								<div class="kebab-content">
									<button type="button" class="kebab-btn">공유하기</button>
									<button type="button" class="kebab-btn report-click-btn" data-targetTypeNo="3" data-target="\${obj.replyno}">댓글 신고하기</button>
								</div>
							</div>`;
					};
					
						li+=			`</div>
								</div>
							</div>
						</li>`
					$("#reply-ul").append(li);
					$(".btn-like").hover(function(){
						$(this).css("border", "1px solid hotpink");
					}, function(){
						$(this).css("border", "1px solid pink");
					});
					$(".ta-auto-resize").each(function(){
				        autoResizeTextarea($(this));
				    });
				});//each
			}//success
		});
	};//show reply
	
	/////////////////////////////////////////// 댓글 end ///////////////////////////////////////////
	
	//목록
	$("#btnList").click(function(){
		let url = "/lee/board/list/" + `${boardtype.boardtype}`;
		$("#actionForm").attr("action", url).submit();
	});
	

});

</script>

<!-- Write Start -->
	<!-- DetailForm Start -->
	<div class="detail_top_container">
		<div class="user-container">
			<div class="user-profile">
				<img class="user-profile-img" alt="프로필" src="
					<c:choose>
						<c:when test="${dto.profile!=null&&dto.profile!=''}">
							${dto.profile}
						</c:when>
						<c:otherwise>
							/resources/lee/image/empty_profile.jpg
						</c:otherwise>
					</c:choose>	
				" width=110 height=110>
			</div>
			<div class="profile-container">
				<div class="mb-10">
					<input class="input-user" value="${dto.nickname}" readonly>
				</div>
				<div class="mb-10">
					<span>등록일</span> <input type="text" class="input-user" name="regdate" value="<fmf:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd hh:mm"/>" readonly> 
				</div>
				<div>
					<span>조회수 </span><input type="text" class="input-user" name="views" value="${dto.views}" readonly>
				</div>
			</div>
			
			<!-- report kebab start -->

			<c:if test="${loginSessionDto.userid != dto.userid}">
				<div class="kebab-container">
					<div class="kebab-menu">
						<div class="dot"></div>
						<div class="dot"></div>
						<div class="dot"></div>
					</div>
					<div class="kebab-content">
						<button type="button" class="kebab-btn">공유하기</button>
						<button type="button" class="kebab-btn report-click-btn" data-targetTypeNo="1" data-target="${dto.userid}">유저 신고하기</button>
					</div>
				</div>
			</c:if>
	
			
			
			<!-- report kebab end -->
			
		</div>
		
		<!-- report kebab start -->
		<c:if test="${loginSessionDto.userid != dto.userid}">
			<div class="kebab-container">
					<div class="kebab-menu">
						<div class="dot"></div>
						<div class="dot"></div>
						<div class="dot"></div>
					</div>
					<div class="kebab-content">
						<button type="button" class="kebab-btn">공유하기</button>
						<button type="button" class="kebab-btn report-click-btn" data-targetTypeNo="2"  data-target="${dto.boardno}">게시글 신고하기</button>
					</div>
			</div>
		</c:if>
		<!-- report kebab end -->
	</div>
	
	<form action="/lee/board/updateRun" id="update-from" class="write-from" method="post">
		
      	<input type="text" id="input-write" class="input-write" name="title" placeholder=" 제목을 입력 해 주세요." 
      			value="${dto.title}" readonly>
      	
		<!-- 모듈에서 가져올 html -->
		<textarea rows="" cols="" id="content" name="content" style="display:none;">${dto.content}</textarea>
		<input type="hidden" value="${dto.boardno}" name="boardno">
		
		<!-- CK에디터 start -->
			<div id="readEditor">
				
			</div>		
			<script type="importmap">
				{
					"imports": {
						"ckeditor5": "https://cdn.ckeditor.com/ckeditor5/42.0.2/ckeditor5.js",
						"ckeditor5/": "https://cdn.ckeditor.com/ckeditor5/42.0.2/"
					}
				}
			</script>
			<script type="module" src="/resources/lee/js/edite-detail.js"></script>
		<!-- CK에디터 end -->
		
        <div class="btn-container justify-between">
        	<!-- 로그인시 보이기 처리 -->
 			<div class="flex">
		        <button type="button" class="btn mr-10" id="btnList">목록</button>
 			</div>

        	<!-- 추천하기 -->
        	<div class="recommend-container">
        		<button type="button" class="btnRecommend" id="btnRecommend">
        			<img alt="" src="/resources/lee/image/thumb_up.png">
        		</button>
        		<span id="spanRecommend">${dto.likes}</span>
        	</div>
        	
        	<!-- 로그인시 보이기 처리 -->
		    <div class="flex" >
	        	<c:if test="${loginSessionDto.userid == dto.userid}">
		        		<button type="button" id="btnUpdate" class="btn mr-10">수정</button>
		        		<button type="button" id="btnDelete" class="btn mr-10">삭제</button>
		        		<button type="button" id="btnUpdateOk" class="btn mr-10" style="display:none">수정완료</button>
		        		<button type="button" id="btnUpdateCancle" class="btn mr-10"  style="display:none">취소</button>
	        	</c:if>
		        <a class="btn" href="/lee/board/write">글쓰기</a>
		    </div>
         </div>
    </form>
    
    <!-- Reply Start -->
	<div class="reply-container border-t-1 mt-20 pt-20 pb-20">
		<ul id="reply-ul">

		</ul>
	</div>
    <!-- Reply End -->
    
    <!-- ReplyForm Start -->
    <ul class="rereply-ul">
	    <li class="reply-form-container ml-20 mt-10 mb-10 reply-li">
	    	<div class="mt-10 mb-10">
	    		<span>욕설, 상처 줄 수 있는 악플은 삼가주세요.</span>
	    	</div>
			<div class="form-reply">
			    <textarea rows="" cols="" class="ta-reply ta-auto-resize comments" placeholder="댓글을 입력해주세요.."></textarea>
				<input type="hidden" class="replyer" value="${loginSessionDto.nickname}">
				<div class="box-item justify-end"> 
					<button class="btn mt-10 btn-reply" >댓글저장</button>
				</div>
			</div>
	    </li>
    </ul>
    <!-- ReplyForm End -->
    
    <!-- Delete Form Start -->
    <form action="/lee/board/deleteRun" method="post" id="formDelete">
    	<input type="hidden" name="boardno" value="${dto.boardno}">
    	<input type="hidden" name="userid" value="${dto.userid}">
    </form>
    <!-- Delete Form End -->
</div>
<!-- Write End -->

<%@ include file="/WEB-INF/views/lee/include/actionForm.jsp"%>
<%@ include file="/WEB-INF/views/lee/include/footer.jsp"%>