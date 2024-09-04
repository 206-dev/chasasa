<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/lee/include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmf" %>
<link rel="stylesheet" href="/resources/lee/css/board.css">			
<script>
$(function(){
	let boardtypeno = parseInt(`${boardtype.boardtypeno}`);
// 	console.log("boardtypeno : " + boardtypeno);
	const map = new Map();
	map.set(1, "공지사항");
	map.set(2, "가입인사");
	map.set(3, "출석체크");
	map.set(4, "자유게시판");
	map.set(5, "정보게시판");
	map.set(6, "리뷰게시판");
	map.set(7, "질문게시판");
	map.set(8, "벙개/동행");
	map.set(9, "모임후기");
	map.set(10, "삽니다");
	map.set(11, "팝니다");
	map.set(12, "신고게시판");
	
	let boardname = map.get(boardtypeno);
	$("#boardname").html(boardname);
	
	//페이지 링크 클릭
	$(".page-link").click(function(e){
		let boardtype = `${boardtype.boardtype}`;
		console.log("boardtype : " + boardtype);
		url = "/lee/board/list/" + boardtype;
		console.log("링크 클릭");
		e.preventDefault();
		let pageNum = $(this).attr("href");
		console.log("pageNum : " + pageNum);
		$("#inputPageNum").val(pageNum);
		$("#actionForm").attr("action", url).submit();
	});
	
	//제목클릭
	$(".a_boardno").click(function(e){
		e.preventDefault();
		console.log("제목클릭");
		let boardno = $(this).attr("href");
		console.log("게시번호 : " + boardno);
		let arr = `<input type='hidden' name='boardno' value='\${boardno}'>`;
		$("#actionForm > input[name='boardno']").remove();
		$("#actionForm").append(arr)
						.attr("action", "/lee/board/detail")
						.submit();
	});
	
	let pageType = "${criteria.type}";
	console.log("pageType : " + pageType);
	switch(pageType){
		case "T":
			$("#typeT").prop("selected", true);
			break;
		case "C":
			$("#typeC").prop("selected", true);
			break;
		case "W":
			$("#typeW").prop("selected", true);
			break;
		case "TC":
			$("#typeTC").prop("selected", true);
			break;
		case "CW":
			$("#typeCW").prop("selected", true);
			break;
		case "TW":
			$("#typeTW").prop("selected", true);
			break;
	}
});
	
</script>
	<div class="leaderboard-div">
		<a href="#" class ="leaderboard-Container">
			<img alt="banner" src="/resources/common/banner/redearboard1.png" id="readerboard-img-1" class="readerboard-img" width="728" height="90">
			<img alt="banner" src="" id="readerboard-img-2" class="readerboard-img" width="728" height="90">
		</a>
<!-- 		<button class="btn ad_point_btn">광고보고 포인트 쌓기!</button> -->
	</div>
 	<!-- 게시판 테이블 start -->
	<div class="table-Container">
     	<h3 class="board-title" id="boardname">자유게시판</h3> 
<%--      	${list} --%>
<%-- 		   <span>boardtype : ${boardtype}</span> --%>
           <table class="table mt-10" border="1">
               <tr>
                   <th class="table-head">번호</th>
                   <th class="table-head">제목</th>
                   <th class="table-head">글쓴이</th>
                   <th class="table-head">등록일</th>
                   <th class="table-head">추천</th>
                   <th class="table-head">조회</th>
               </tr>
               <c:forEach var="dto" items="${list}">
                   <tr class="table-tr">
	                   <td>${dto.boardno}</td>
	                   <td class="table-text-left">
	                   	<a class="a_boardno" href="${dto.boardno}">${dto.title} 
	                   		<span class="reply-count" id="replyCount">${dto.replycount}</span> 
		                   	<span class=" 	
		                   		<c:if test="${dto.newWrite=='new'}">
		                   			new 
		                  	 	</c:if> 
		                   	ml-10 ">${dto.newWrite}</span>
	                   	</a>
	                   </td>
	                   <td class="table-text-right">${dto.nickname}</td>
	                   <td>${dto.regdate}</td>
	                   <td>${dto.likes}</td>
	                   <td>${dto.views}</td>
	               </tr>
               </c:forEach>
           </table>
           <!-- 게시판 테이블 end -->
           
           <!-- 페이징 start -->
           <div class="page-Container">
                <nav>
                    <ul class="page-ul">
                    	<c:if test="${pageMaker.prev == true}">
                    		<li class="page-item"><a href="${pageMaker.startPage - 10}" class="page-link">이전</a></li>
                    	</c:if>
                        
                        <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="v">
                        	<li class="page-item">
                        		<a href="${v}" class="page-link ${v == pageMaker.cri.pageNum ? 'active-link' : ''}">${v}</a>
                        	</li>
                        </c:forEach>
                        
                        <c:if test="${pageMaker.next == true}">
	                        <li class="page-item"><a href="${pageMaker.endPage + 1}" class="page-link">다음</a></li>
                        </c:if>
                    </ul>
                </nav>
            </div>
            <!-- 페이징 end -->
            <div class="flex justify-end div-write">
		        <a class="btn btn-yellow" href="/lee/board/write">글쓰기</a>        
            </div>

<!--             <div class="search-Container"> -->
            	<form action="/lee/board/list/${boardtype.boardtype}" class="search-Container">
	                <select name="type" id="selectSearch">
	                    <option value="T" id="typeT">제목</option>
	                    <option value="C" id="typeC">내용</option>
	                    <option value="W" id="typeW">작성자</option>
	                    <option value="TC" id="typeTC">제목+내용</option>
	                    <option value="CW" id="typeCW">내용+작성자</option>
	                    <option value="TW" id="typeTW">제목+삭성자</option>
	                </select>
	                <input type="text" name="keyword" value="${criteria.keyword}">
	                <button class="btn" type="submit">검색</button>
            	</form>
<!--             </div> -->
        </div>


<%@ include file="/WEB-INF/views/lee/include/actionForm.jsp" %>
<%@ include file="/WEB-INF/views/lee/include/footer.jsp"%>