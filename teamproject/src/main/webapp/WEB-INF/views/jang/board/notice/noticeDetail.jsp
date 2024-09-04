<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/WEB-INF/views/lee/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/jang/css/noticeDetail.css">
<link rel="stylesheet" href="/resources/jang/css/editorStyle.css">
<link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/42.0.2/ckeditor5.css">
<script type="importmap">
		{
			"imports": {
				"ckeditor5": "https://cdn.ckeditor.com/ckeditor5/42.0.2/ckeditor5.js",
				"ckeditor5/": "https://cdn.ckeditor.com/ckeditor5/42.0.2/"
			}
		}
		</script>
<script type="module" src="/resources/jang/js/editorModule.js"></script>
    
<style>
</style>

<script type="text/javascript">
$(function(){
<%@ include file="/resources/jang/js/noticeFunction.js"%>
	
	
	
	// 작성자 로그인시 수정/삭제 버튼 보이기
	let userId = "${loginSessionDto.nickname}";
	let nickname = "${noticeDto.nickname}";
	if(nickname == userId){
		$("#btnModify").css("display", "inline-block");
        $("#btnDelete").css("display", "inline-block");
	}
	
	//에디터 readonly
	editor.enableReadOnlyMode("item_detail_textarea");
	
	//에디터 setData
	editor.setData(`${noticeDto.content}`);
	
    $("#btnList").click(function(){
        let type = "${pageMaker.cri.type != null ? pageMaker.cri.type : ''}";
        let keyword = "${pageMaker.cri.keyword != null ? pageMaker.cri.keyword : ''}";
        submitForm("/jang/board/notice/list", ${pageMaker.cri.pageNum}, ${pageMaker.cri.amount}, type, keyword, null);
    });

    $("#btnModify").click(function (){
        $("#btnModify").css("display", "none");
        $("#btnDelete").css("display", "none");
        $("#btnModifyOk").css("display", "inline-block");
        $("#btnModifyCancel").css("display", "inline-block");
		
        editor.disableReadOnlyMode("item_detail_textarea");
        
    });
    
    $("#btnModifyCancel").click(function(){
    	$("#btnModifyOk").css("display", "none");
        $("#btnModifyCancel").css("display", "none");
        $("#btnModify").css("display", "inline-block");
        $("#btnDelete").css("display", "inline-block");
        
      //에디터 editable
        editor.enableReadOnlyMode("item_detail_textarea");
    });
    
    $("#btnModifyOk").click(function(){
    	let content = editor.getData();
    	let boardNo = ${noticeDto.boardNo};
    	// console.log(content);
		// console.log(boardNo);
		 
		let sData = {
			"content" : content,
			"boardNo" : boardNo
		};
		
		$.ajax({
			url : "/jang/board/notice/modify",
			type : "post",
			data : sData,
			success : function(rData){
				console.log(rData);
				editor.setData(rData.data);
				editor.enableReadOnlyMode("item_detail_textarea");
			}
		}); 
		
		$("#btnModifyOk").css("display", "none");
        $("#btnModifyCancel").css("display", "none");
        $("#btnModify").css("display", "inline-block");
        $("#btnDelete").css("display", "inline-block");
        
    });
    	
    $("#btnDelete").click(function(){
    	
    	let isRemove = confirm("삭제하시겠습니까?");
    	// console.log(isRemove);
    	if(isRemove){
    		let type = "${pageMaker.cri.type != null ? pageMaker.cri.type : ''}";
            let keyword = "${pageMaker.cri.keyword != null ? pageMaker.cri.keyword : ''}";
            $("#actionForm").attr("method", "post")
           					.append(`<input type="hidden" name="boardNo">`);
            $("#actionFrom input[name=boardNo]").val(${noticeDto.boardNo});
            submitForm("/jang/board/notice/remove/" + ${noticeDto.boardNo}, ${pageMaker.cri.pageNum}, ${pageMaker.cri.amount}, type, keyword, null);
    	}
    });
});
</script>




<div class="container">
    <h1>공지사항 상세</h1>
    <div class="notice-detail-wrapper">
        <table class="notice-detail">
            <tr>
                <th>제목</th>
            </tr>
            <tr>
                <td>${noticeDto.title}</td>
            </tr>
            <tr>
                <th>내용</th>
            </tr>
            <tr class="tr-content">
                <td><textarea id="editor" name="content" class="form-control"></textarea></td>
            </tr>
            <tr>
                <th>작성자</th>
            </tr>
            <tr> 
                <td>${noticeDto.nickname}</td>
            </tr>
            <tr>
                <th>등록일</th>
            <tr>
                <td><fmt:formatDate value="${noticeDto.regdate}" pattern="yyyy-MM-dd"/></td>
            </tr>
        </table>
    </div>
    <div class="actions">
        <button id="btnModify" type="button" style="display:none;">수정</button>
        <button id="btnModifyOk" type="button" style="display:none;">완료</button>
        <button id="btnModifyCancel" type="button" style="display:none;">취소</button>
        <button id="btnDelete" type="button" style="display:none;">삭제</button><br>
        <button id="btnList" type="button">목록</button>
    </div>
</div>

<%-- <form action="/board/notice/remove/${noticeDto.boardNo}" id="frmRemove" method="post"> --%>
<!-- </form> -->

<%@ include file="/WEB-INF/views/jang/include/footer.jsp"%>
<%@ include file="/WEB-INF/views/jang/include/action_form.jsp"%>
