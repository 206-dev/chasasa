<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/WEB-INF/views/lee/include/header.jsp" %>
<link rel="stylesheet" href="/resources/jang/css/list.css">
<!-- script -->
<script type="text/javascript">
$(function(){
<%@ include file="/resources/jang/js/noticeFunction.js"%>
<%
java.util.Date now = new java.util.Date();
pageContext.setAttribute("now", now);
%>
    // 페이지 로드 시 초기 정렬 상태를 반영
    let initialSort = '${pageMaker.cri.sort}';
    let initialOrder = '${pageMaker.cri.order}';
    updateSortIcons(initialSort, initialOrder);
	setSearch();
    
	// 매니저 이상의 유저만 작성하기 버튼 보이기
	if(`${loginSessionDto}` !== ""){
		let strGrade = `${loginSessionDto.gradeno}`;
		let grade = parseInt(strGrade);
		if(grade >= 2){
			$(".btn-write").attr("style" , "display=block;");
		}
	}
	
	
	
    function setSearch(){
    	let type = "${pageMaker.cri.type}"
    	let keyword = "${pageMaker.cri.keyword}"
    	
    	if(type == null){
    		$("option[value=T]").attr("selected","selected");
    	} else{
    		$("option[value='${pageMaker.cri.type}']").attr("selected","selected");
    	}
    	
    	if(keyword != null){
    		$("#keyword").val(keyword);
    	}
    	
    	
    }
    
    function updatePagination(pageMaker){
    	let pagination = $(".page-ul");
    	pagination.empty();
    	if(pageMaker.prev){
	    	pagination.prepend(`<li class="page-item"><a class="pageNumber page-link" href="\${(pageMaker.startPage - 1)}" class="page-link">이전</a></li>`);
    	}
		for(let i = pageMaker.startpage; i <= pageMaker.endPage; i++){
			pagination.prepend(`<li class="page-item \${pageMaker.cri.pageNum == v ? 'active' :''}"><a class="pageNumber page-link" href="\${v}" >\${v}</a></li>`);
		}  
		if(pageMaker.next){
	    	pagination.prepend(`<li class="page-item"><a class="pageNumber page-link" href="\${(pageMaker.endPage + 1)}" ">다음</a></li>`);
    	}
    }
    
    function formatDate(dateString) {
    	let date = new Date(dateString);
        let year = date.getFullYear();
        let month = ('0' + (date.getMonth() + 1)).slice(-2);
        let day = ('0' + date.getDate()).slice(-2);
        return `\${year}-\${month}-\${day}`;
    }
    
    $(".pageNumber").click(function(e){
        e.preventDefault();
        console.log(".pageNumber click..." );
        
        let pageNum = $(this).attr("href");
        let amount = ${pageMaker.cri.amount};
        let type = $("#btnSearch").parent().find("select").val();
        let keyword = $("#keyword").val();
		console.log("pageNum : ", pageNum);
		console.log("amount : ", amount);
		console.log("type : ", type);
		console.log("keyword : ", keyword);
		
        submitForm("/jang/board/notice/list", pageNum, amount, type, keyword, null);
    });

    $("#btnSearch").click(function(){
        console.log("btnSearch click..");
        let type = $("#btnSearch").parent().find("select").val();
        let keyword = $("#btnSearch").parent().find("input").val();
        submitForm("/jang/board/notice/list", 1, 10, type, keyword, null);
    });
    
    $(".btn-write").click(function(){
    	let currentUrl = window.location.href;
		currentUrl = currentUrl.substring(currentUrl.indexOf("t/") + 2);
// 		console.log(currentUrl);
		location.href="/jang/board/notice/postForm?currentUrl=" + encodeURIComponent(currentUrl);
    });
    $("tbody").on("click", ".notice-title", function(e){
    	e.preventDefault();
    	console.log(e);
//     	let targetEle = e.originalEvent.srcElement; // html로 event 실행 객체 찾기
    	let targetEle = $(e.target); // jqeury로 event 실행 객체 찾기
//     	console.log("target:" , targetEle);
        let pageNum = ${pageMaker.cri.pageNum != null ? pageMaker.cri.pageNum : 1};
        let amount = ${pageMaker.cri.amount != null ? pageMaker.cri.amount : 10};
        let type = "${pageMaker.cri.type != null ? pageMaker.cri.type : ''}";
        let keyword = "${pageMaker.cri.keyword != null ? pageMaker.cri.keyword : ''}";
        let boardNo = targetEle.attr("href");
        submitForm("/jang/board/notice/detail", pageNum, amount, type, keyword, boardNo);
    });
    
    // e.originalEvent.srcElement
    
//     $(".notice-title").click(function (e){
//         e.preventDefault();
//         let pageNum = ${pageMaker.cri.pageNum != null ? pageMaker.cri.pageNum : 1};
//         let amount = ${pageMaker.cri.amount != null ? pageMaker.cri.amount : 10};
//         let type = "${pageMaker.cri.type != null ? pageMaker.cri.type : ''}";
//         let keyword = "${pageMaker.cri.keyword != null ? pageMaker.cri.keyword : ''}";
//         let boardNo = $(this).attr("href");
//         console.log(boardNo);
//         submitForm("/board/notice/detail", pageNum, amount, type, keyword, boardNo);
//     });
	
    $(".sortable").click(function(){
    	let pageNum = ${pageMaker.cri.pageNum};
    	let amount = ${pageMaker.cri.amount};
    	let type = "${pageMaker.cri.type}";
    	let keyword = "${pageMaker.cri.keyword != null ? pageMaker.cri.keyword : ''}";
    	let sort = $(this).data("sort");
    	let order = $(this).hasClass("sort-asc") ? "desc" : "asc";
    	$.ajax({
    		url : '/jang/board/notice/list-data',
    		type : 'get',
    		data : {
    			pageNum : pageNum,
    			amount : amount,
    			type : type,
    			keyword : keyword,
    			sort : sort,
    			order : order
    		},
			success : function(data){
				
				let tbody = '';
				$.each(data.list, function(index, dto){
					console.log("dto.newPost", dto.newPost);
					let newLabel = dto.newPost ? '<span class="new-label">NEW</span>' : '';
					let formattedDate = formatDate(new Date(dto.regdate));
					tbody += `<tr>
				                <td>\${dto.boardNo}</td>
				                <td class="table-Text-Left" >
				                    <span class="notice-label">공지</span>
				                    <a class="notice-title" href="\${dto.boardNo}">\${dto.title}</a>
					                 \${newLabel}
				                </td>
				                <td>\${dto.nickname}</td>
				                <td>\${formattedDate}</td>
				                <td>\${dto.views}</td>
				            </tr>`;
				});
			    
			    $("tbody").empty();
			    $("tbody").append(tbody);
			    updateSortIcons(sort, order);
			    
			    $("#actionForm > input[name=sort]").val(sort);
		        $("#actionForm > input[name=order]").val(order);
			}
    	});
   	
    }); 
    
    
});
</script>
		<h3>공지사항</h3>
        <div class="table-Container">
        	
            <table class="table" border="1">
	            <thead>
	                <tr>
	                    <th class="table-head sortable" data-sort="boardNo">번호 <span class="sort-icon"></span></th>
				        <th class="table-head sortable" data-sort="title">제목 <span class="sort-icon"></span></th>
				        <th class="table-head sortable" data-sort="nickname">글쓴이 <span class="sort-icon"></span></th>
				        <th class="table-head sortable" data-sort="regdate">등록일 <span class="sort-icon"></span></th>
				        <th class="table-head sortable" data-sort="views">조회수 <span class="sort-icon"></span></th>
	<!--                <th class="table-head">추천</th> -->
	                </tr>
             	</thead>
                <tbody>
	                <c:forEach items="${list}" var="dto">
	                <tr>
	                    <td>${dto.boardNo}</td>
	                    <td class="table-Text-Left" >
		                    <span class="notice-label">공지</span>
		                    <a class="notice-title" href="${dto.boardNo}">${dto.title}</a>
		                    <c:if test="${dto.newPost}">
		                        <span class="new-label">NEW</span>
		                    </c:if>
	                    </td>
	                    <td>${dto.nickname}</td>
	                    <td><fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd"/></td>
	                    <td>${dto.views}</td>
	                </tr>
	                </c:forEach>
                </tbody>
            </table>
            
			<!-- 페이징 start -->
            <div class="page-Container">
                <nav >
                    <ul class="page-ul">
                    <c:if test="${pageMaker.prev}">
                        <li class="page-item"><a class="pageNumber page-link" href="${(pageMaker.startPage - 1)}" class="page-link">이전</a></li>
                    </c:if>
                       	<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="v">
                        <li class="page-item ${pageMaker.cri.pageNum == v ? 'active' :''}"><a class="pageNumber page-link" href="${v}" >${v}</a></li>
                       	 </c:forEach>
                   	<c:if test="${pageMaker.next}">
                        <li class="page-item"><a class="pageNumber page-link" href="${(pageMaker.endPage + 1)}">다음</a></li>
                   	</c:if>
                    </ul>
                </nav>
            </div>
            <!-- 페이징 end -->
			
			<!-- 게시글검색 start -->
            <div class="search-Container">
			    <button class="btn btn-write" style="display:none;">작성하기</button>
			    <div class="search-group">
			        <select id="type">
			            <option value="T">제목</option>
			            <option value="I">아이디</option>
			            <option value="C">내용</option>
			            <option value="TC">제목+내용</option>
			        </select>
			        <input type="text" id="keyword">
			        <button class="btn" id="btnSearch">검색</button>
			    </div>
			</div>
			<!-- 게시글검색 end -->
        </div>
   
<%@ include file="/WEB-INF/views/jang/include/footer.jsp"%>
<%@ include file="/WEB-INF/views/jang/include/action_form.jsp"%>