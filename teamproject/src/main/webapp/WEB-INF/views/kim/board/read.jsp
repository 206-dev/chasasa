<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.teamproject.www.kim.domain.UserVo"%>
<%@ include file="/WEB-INF/views/kim/include/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css">
<link rel="stylesheet" href="/resources/kim/css/indexksy.css">
<script src="/resources/kim/js/indexksy.js"></script>
<body class="bg-white text-black min-h-screen p-4">
    <main class="grid grid-cols-3 gap-4 mt-4">
        <section class="col-span-2 space-y-4">
            <div class="bg-gray-100 p-4 rounded">
                <h2 class="text-3xl font-bold">${boardVo.title}</h2> <!-- Updated title -->
                <div class="mt-2 flex justify-between text-gray-700">
                    <div>
                        <span>작성자: ${boardVo.nickname}</span> | <!-- Ensure 'nickname' is correct -->
                        <span>조회수: ${boardVo.views}</span> |
                        <span id="likeCountTop">추천수: ${boardVo.likes}</span> | 
                    </div>
                    <div>
                        <fmt:formatDate value="${boardVo.regdate}" pattern="yyyy-MM-dd HH:mm:ss" /> <!-- Updated date format -->
                    </div>
                </div>
                <div class="mt-2 flex justify-end text-gray-700">
                    <a href="/kim/board/modifyForm?boardNo=${boardVo.boardNo}" class="mr-4 bg-gray-400 text-black px-1 py-1 rounded">수정</a> <!-- Updated link -->
                    <button type="submit" id="btnDelete" class="mr-4 bg-gray-400 text-black px-1 py-1 rounded">삭제</button>
                    <form id="frmRemove" action="/kim/board/delete" method="post">
                        <input type="hidden" name="boardNo" value="${boardVo.boardNo}"/> <!-- Updated form field -->
                    </form>
                </div>
                <div class="mt-4">
                    <p>${boardVo.content}</p> <!-- Ensure 'content' is correct -->
                </div>
                <div class="mt-40 flex justify-center">
<!--                     <button class="mr-4 bg-red-500 text-black px-2 py-1 rounded">신고</button> -->
                    <span id="likeCountBottom">${boardVo.likes}</span>
                    <button id="likeBtn" class="mr-4 bg-yellow-500 text-black px-2 py-1 rounded">추천</button>
                    <a href="/kim/board/info"> <button class="mr-4 bg-green-500 text-black px-2 py-1 rounded">목록</button> </a>
                </div>
            </div>
            <div class="bg-gray-100 p-4 rounded mt-4">
                <div class="flex items-center">
                    <img src="/resources/kim/image/1111.png" alt="Profile Image" class="w-16 h-16 rounded-full">
                    <div class="ml-4">
                        <h3 class="text-xl font-bold">${boardVo.nickname}</h3> <!-- Updated -->
                        <p class="text-sm text-gray-500">등급: 우주고양이 (1000xp)</p>
<%--                         <p class="text-sm text-gray-500">등급: ${user.rank} (${user.exp}xp)</p> --%>
                    </div>
                </div>
            </div>
            <div class="bg-gray-100 p-4 rounded mt-4">
                <h3 class="text-lg font-bold">댓글</h3>
                <button id="btnReplyList" class="bg-blue-500 text-white px-4 py-2 rounded mb-4">댓글 보기</button>
                <div id="comments-container">
                    <table class="table" id="reply_table">
                        <!-- 댓글 목록이 여기에 추가됩니다 -->
                    </table>
                </div>
            </div>
            <div class="bg-gray-100 p-4 rounded mt-4">
                <textarea id="reply" name="reply" rows="4" placeholder="댓글을 입력하세요" class="w-full p-2 rounded"></textarea>
                <div class="mt-2 flex justify-end">
                    <button type="button" id="btnRegisterReply" class="bg-yellow-500 text-black px-4 py-2 rounded">댓글달기</button>
                </div>
            </div>
<div class="bg-gray-100 p-4">
    <div class="flex justify-center">
        <a href="/kim/board/info" class="mr-4 bg-yellow-600 text-black px-3 py-1 rounded">전체글</a>
        <form id="categoryForm" action="/kim/board/info" method="get" class="flex">
            <input type="hidden" name="type" value="${criteria.type}">
            <input type="hidden" name="keyword" value="${criteria.keyword}">
            <input type="hidden" name="pageNum" value="1">
            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
            <input type="hidden" name="sort" value="${criteria.sort}">
            <button class="mr-4 ${criteria.category == '음식' ? 'bg-yellow-500' : 'bg-gray-300'} text-black px-3 py-1 rounded" name="category" value="음식">음식</button>
            <button class="mr-4 ${criteria.category == '자동차' ? 'bg-yellow-500' : 'bg-gray-300'} text-black px-3 py-1 rounded" name="category" value="자동차">자동차</button>
            <button class="mr-4 ${criteria.category == '장소' ? 'bg-yellow-500' : 'bg-gray-300'} text-black px-3 py-1 rounded" name="category" value="장소">장소</button>
            <button class="mr-4 ${criteria.category == '핫딜' ? 'bg-yellow-500' : 'bg-gray-300'} text-black px-3 py-1 rounded" name="category" value="핫딜">핫딜</button>
            <button class="mr-4 ${criteria.category == '행사' ? 'bg-yellow-500' : 'bg-gray-300'} text-black px-3 py-1 rounded" name="category" value="행사">행사</button>
        </form>
    </div>
</div>


			<div class="bg-gray-100 p-4">
				<table class="mt-4 w-full bg-gray-100 text-black">
					<thead>
						<tr>
							<th class="text-xl">추천수</th>
							<th class="text-xl">제목</th>
							<th class="text-xl">닉네임</th>
							<th class="text-xl">조회수</th>
							<th class="text-xl">날짜</th>
						</tr>
					</thead>
                    <tbody>
                        <tr>
                            <td colspan="6"><hr class="table-hr"></td>
                        </tr>
                        <c:forEach items="${list}" var="boardVo">
                        
                            <tr class="spacer">
                                <td class="text-center">${boardVo.likes}</td>
                                <td class="text-center"><a class="a_bno" href="/kim/board/read?boardNo=${boardVo.boardNo}">${boardVo.title}</a>
    							<span class="badge badge-secondary"> [${boardVo.replycount}] </span></td>
                                <td class="text-center">${boardVo.nickname}</td>
                                <td class="text-center">${boardVo.views}</td>
                                <td class="text-center"><fmt:formatDate value="${boardVo.regdate}" pattern="yyyy-MM-dd" /></td>
                            </tr>
                        </c:forEach>
                    </tbody>
				</table>
			</div>

			<!-- 페이징과 정렬 기능 추가 -->
			<div class="flex items-center justify-between p-1 bg-gray-100">
				<div class="flex items-center space-x-2">
					<form id="sortForm" action="/kim/board/info" method="get">
						<input type="hidden" name="type" value="${criteria.type}">
						<input type="hidden" name="keyword" value="${criteria.keyword}">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"> 
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}"> 
						<input type="hidden" name="category" value="${criteria.category}">
						<select name="sort" class="bg-gray-300 p-1 rounded" onchange="document.getElementById('sortForm').submit();">
							<option value="recent" ${criteria.sort == 'recent' ? 'selected' : ''}>최신 순</option>
							<option value="likes" ${criteria.sort == 'likes' ? 'selected' : ''}>추천순</option>
							<option value="views" ${criteria.sort == 'views' ? 'selected' : ''}>조회수 순</option>
						</select>
					</form>
				</div>
<div class="flex justify-center">
    <nav>
        <ul class="flex list-none space-x-1">
            <c:if test="${pageMaker.prev}">
                <li><a
                    href="?pageNum=${pageMaker.startPage - 1}&amount=${pageMaker.cri.amount}&type=${criteria.type}&keyword=${criteria.keyword}&sort=${criteria.sort}&category=${criteria.category}&boardNo=${boardVo.boardNo}"
                    class="bg-gray-300 text-black px-3 py-1 rounded">이전</a></li>
            </c:if>
            <c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                <c:choose>
                    <c:when test="${pageMaker.cri.pageNum == i}">
                        <span class="bg-yellow-500 text-black px-3 py-1 rounded">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="?pageNum=${i}&amount=${pageMaker.cri.amount}&type=${criteria.type}&keyword=${criteria.keyword}&sort=${criteria.sort}&category=${criteria.category}&boardNo=${boardVo.boardNo}"
                            class="bg-gray-300 text-black px-3 py-1 rounded">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${pageMaker.next}">
                <li><a
                    href="?pageNum=${pageMaker.endPage + 1}&amount=${pageMaker.cri.amount}&type=${criteria.type}&keyword=${criteria.keyword}&sort=${criteria.sort}&category=${criteria.category}&boardNo=${boardVo.boardNo}"
                    class="bg-gray-300 text-black px-3 py-1 rounded">다음</a></li>
            </c:if>
        </ul>
    </nav>
</div>
<a href="/kim/board/write" class="bg-yellow-500 text-black p-1 rounded">글쓰기</a>
			</div>

			<div class="flex items-center justify-center p-1 bg-gray-100">
				<div class="flex items-center space-x-1">
					<form action="/kim/board/info" method="get">
						<select name="type" class="bg-gray-300 p-1 rounded">
							<option value="T" ${criteria.type == 'T' ? 'selected' : ''}>제목</option>
							<option value="C" ${criteria.type == 'C' ? 'selected' : ''}>내용</option>
							<option value="W" ${criteria.type == 'W' ? 'selected' : ''}>작성자</option>
							<option value="TC" ${criteria.type == 'TC' ? 'selected' : ''}>제목+내용</option>
							<option value="TW" ${criteria.type == 'TW' ? 'selected' : ''}>제목+작성자</option>
							<option value="CW" ${criteria.type == 'CW' ? 'selected' : ''}>내용+작성자</option>
							<option value="TCW" ${criteria.type == 'TCW' ? 'selected' : ''}>제목+내용+작성자</option>
						</select> <input type="text" name="keyword" placeholder="검색어를 입력하세요."
							value="${criteria.keyword}" class="bg-gray-200 p-1 rounded" /> <input
							type="hidden" name="category" value="${criteria.category}">
						<button type="submit" class="bg-yellow-500 text-black p-1 rounded">검색</button>
					</form>
				</div>
			</div>
			<!-- 페이징과 정렬 기능 추가 끝 -->
        </section>
        <aside class="space-y-4">
			<div class="bg-gray-100 p-4">
				<div class="flex items-center justify-between p-2 bg-gray-300 rounded">
					<div class="ml-6 flex items-center">
						<div class="login-container">
						    <c:choose>
						        <c:when test="${not empty loginSessionDto}">
						            <!-- 로그인된 상태 -->
						            <div id="userInfo" class="user-info">
						                <span class="text-xl">닉네임: ${loginSessionDto.nickname}</span><br/>
						                <span class="text-sm">레벨: ${loginSessionDto.userlevel} | 포인트: ${loginSessionDto.point}</span>
						            </div>
						            <a href="/kim/user/logout" class="login-btn btn-warning">로그아웃</a>
						        </c:when>
						        <c:otherwise>
						            <!-- 로그아웃 상태 -->
						            <a href="/kim/user/login?redirectURL=${pageContext.request.requestURI}?${pageContext.request.queryString}" class="login-btn btn-warning">로그인</a>
						            <div class="login-links">
						                <a href="/findIdPwd" class="link-left text-sm hover:text-yellow-500">아이디/비밀번호 찾기</a>
						                <a href="/signUp" class="link-right text-sm hover:text-yellow-500">회원가입</a>
						            </div>
						        </c:otherwise>
						    </c:choose>
						</div>
					</div>
					<!-- <button class="bg-yellow-500 text-black px-4 py-2 rounded">로그아웃</button> -->
				</div>
				<div class="mt-4 grid grid-cols-3 gap-2 text-center">
<!-- 					<a href="#" class="bg-gray-300 p-2 rounded">기능1</a>  -->
<!-- 					<a href="#"	class="bg-gray-300 p-2 rounded">기능2</a>  -->
<!-- 					<a href="#" class="bg-gray-300 p-2 rounded">기능3 </a> -->
					<!-- <a href="#" class="bg-gray-300 p-2 rounded">스크랩</a>  -->
					<!-- <a href="#" class="bg-gray-300 p-2 rounded">공지</a> -->
				</div>
			</div>
			<div class="bg-gray-100 p-4 rounded">
			    <h2 class="text-lg font-bold">주간 정보게시판 BEST</h2>
			    <ul class="mt-2 space-y-2">
			        <c:forEach items="${weeklyBestList}" var="boardVo" varStatus="num">
			            <div class="flex items-center justify-between p-2 bg-gray-300 rounded">
			                <span>${num.index + 1}</span> 
			                <a class="a_bno" href="/kim/board/read?boardNo=${boardVo.boardNo}">
			                    <span class="flex-1 ml-2">${boardVo.title}</span>
			                </a>
			                <span class="text-gray-500">${boardVo.views}</span>
			            </div>
			        </c:forEach>
			    </ul>
			</div> 
        </aside>
    </main>
    

<script>
let userid = "${loginSessionDto.userid}";
let nickname = "${loginSessionDto.nickname}";
let boardno = "${boardVo.boardNo}";

$(function() {
	
	// 추천 버튼 클릭 이벤트
    $("#likeBtn").click(function() {
        let likeData = {
            boardNo: boardno,
            userId: userid
        };
        console.log("likeData:", likeData);
        $.ajax({
            url: "/kim/boardlike/add",  // 추천 추가
            type: "POST",
            data: JSON.stringify(likeData),
            contentType: "application/json; charset=utf-8",
            success: function(response) {
                alert(response);
                updateLikeCount(boardno); // 추천 수 업데이트
            },
            error: function(xhr) {
                console.error(xhr);
                alert("추천을 추가하는데 실패했습니다.");
            }
        });
    });

    // 추천 수 업데이트 함수
    function updateLikeCount(boardNo) {
        $.get("/kim/boardlike/count/" + boardNo, function(data) {
            $("#likeCountTop").text("추천수: " + data); // 상단 추천수 갱신
            $("#likeCountBottom").text(data);           // 하단 추천수 갱신
        });
    }
	});
	
	
	
	
	// 댓글 보기 버튼
	$("#btnReplyList").click(function() {
	    $.get("/kim/reply/list/${boardVo.boardNo}", function(rData) {
	        // 기존 데이터 가져온 부분 삭제
	        $("#reply_table").empty();
	        $.each(rData, function(index, value) {
	            let obj = value;
	            let tr =  `<tr>
	                        <td>\${obj.comments}</td>
	                        <td>\${obj.nickname}</td>
	                        <td>\${formatDateBasedOnToday(obj.updatedate)}</td>
	                        <td><button class="btn-warning btnReplyModify" data-replyNo="\${obj.replyNo}" data-boardNo="\${obj.boardNo}">수정</button></td>
	                        <td><button class="btn-danger btnReplyRemove" data-replyNo="\${obj.replyNo}">삭제</button></td>
	                      </tr>`;
	            $("#reply_table").append(tr);
	        });
	    });
	});
   

	// 댓글 등록 버튼
	$("#btnRegisterReply").click(function() {
		
		
		let comments = $("#reply").val();
	    let sData = {
	        "boardNo": ${boardVo.boardNo},
	        "comments": comments,
	        "userId": userid,     // 서버로 전송할 임시 userId
	        "nickname": nickname  // 서버로 전송할 임시 nickname
	    };
	    console.log("sData", sData);

	    $.ajax({
	        type: "post",
	        url: "/kim/reply/write",
	        data: JSON.stringify(sData),
	        contentType: "application/json; charset=utf-8",
	        success: function(rData) {
	            console.log(rData);
	            // 댓글보기 버튼 클릭 시킴
	            $("#btnReplyList").trigger("click");
	            $("#reply").val('');
	        }
	    });
	});


	// 댓글 수정 버튼 클릭 시
	$("#reply_table").on("click", ".btnReplyModify", function() {
	    let replyRow = $(this).closest("tr");
	    let replyNo = $(this).attr("data-replyNo");
	    let boardNo = $(this).attr("data-boardNo");
	    let currentComments = $(this).parent().parent().find("td").eq(0).text().trim();
	    let currentReplyer = $(this).parent().parent().find("td").eq(1).text().trim();
	    
	    // 이미 열려 있는 수정 textarea가 있는지 확인하고 닫기
	    let openEditRow = $(".editRow");
	    if (openEditRow.length) {
	        // 기존 폼의 textarea 값 초기화
	        openEditRow.find("textarea").val("");
	        openEditRow.remove();
	    }

	    // 이미 수정 textarea가 있는지 확인
	    if (replyRow.next().is(".editRow")) {
	        replyRow.next().toggle(); // 폼이 이미 있으면 토글로 숨기기/보이기
	    } else {
	        let editHtml = `
	            <tr class="editRow">
	                <td colspan="6">
	                    <form id="frmModify" method="PUT" action="/kim/reply/modify">
	                        <input type="hidden" id="replyNo" name="replyNo" value="\${replyNo}">
	                        <input type="hidden" id="boardNo" name="boardNo" value="\${boardNo}">
	                        <textarea id="comments" name="comments" rows="4" class="w-full p-2 rounded">\${currentComments}</textarea>
	                        <input type="hidden" id="nickname" name="nickname" value=nickname>
	                        <input type="hidden" id="userId" name="userId" value=userId>
	                        <button type="button" class="bg-yellow-500 text-black px-4 py-2 rounded btn-save-reply">수정하기</button>
	                        <button type="button" class="bg-red-500 text-black px-4 py-2 rounded btn-modify-reply-cancle">취소</button>
	                    </form>
	                </td>
	            </tr>
	        `;
	        replyRow.after(editHtml);
	    }
	});

	// 삭제 버튼
	$("#btnDelete").click(function() {
	    if (confirm('정말로 이 게시글을 삭제하시겠습니까?')) {
	        $("#frmRemove").submit();
	    }
	});

	// 댓글 삭제 버튼 클릭 시
	$("#reply_table").on("click", ".btnReplyRemove", function() {
	    let replyNo = $(this).attr("data-replyNo");
	    let that = $(this);
	    
	    // 삭제하려는 행의 수정창이 열려 있는지 확인하고 닫기
	    let editRow = that.closest("tr").next(".editRow");
	    if (editRow.length) {
	        editRow.find("textarea").val("");
	        editRow.remove();
	    }

	    $.ajax({
	        type: "delete",
	        url: "/kim/reply/remove/" + replyNo + "/${boardVo.boardNo}",
	        data: JSON.stringify({ replyNo: replyNo }),
	        contentType: "application/json; charset=utf-8",
	        success: function(rData) {
	            console.log(rData);
	            console.log($(this).parent().parent().fadeOut(1000));
	            that.parent().parent().fadeOut(1000);
	            let strCnt = $("#btnReplyList > span").text();
	            let cnt = parseInt(strCnt) - 1;
	            $("#btnReplyList > span").text(cnt);
	        },
	        error: function(error) {
	            console.error("Error deleting reply:", error);
	        }
	    });

	});

	$("#reply_table").on("click", ".btn-modify-reply-cancle", function() {
	    let openEditRow = $(".editRow");
	    openEditRow.find("textarea").val("");
	    openEditRow.remove();
	});

	// 폼 제출
	$(document).on("click", ".btn-save-reply", function(event) {
	    event.preventDefault(); // 폼 기본 제출 동작 중지
	    let form = $(this).closest("form");

	    $.ajax({
	        type: "PUT",
	        url: form.attr("action"),
	        data: JSON.stringify({
	            "replyNo": form.find("#replyNo").val(),
	            "boardNo": form.find("#boardNo").val(),
	            "comments": form.find("#comments").val(),
	            "nickname": nickname  // 변수 nickname을 그대로 전달
	        }),
	        contentType: "application/json; charset=utf-8",
	        success: function(response) {
	            console.log("Update response:", response);
	            $("#btnReplyList").trigger("click");
	        },
	        error: function(error) {
	            console.error("Error updating reply:", error);
	        }
	    });
	});



</script>
</body>
<%@ include file="/WEB-INF/views/kim/include/footer.jsp"%>