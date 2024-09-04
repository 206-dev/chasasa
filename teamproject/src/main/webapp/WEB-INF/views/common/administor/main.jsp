<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/common/css/admin.css">
<%@ include file="/WEB-INF/views/jang/include/header.jsp"%>
<script>
$(function(){
	$(".card").click(function(e){
		let type = $(this).data("type");
		switch(type){
		case "report" :
			location.href="/admin/report";
			break;
		case "metaverse" :
			location.href="/admin/metaverse";
			break;
		case "summary" :
			location.href="/admin/summary";
			break;
		case "advertising" :
			location.href="/admin/advertising";
			break;
		}
	});

});
</script>

<div class="row">
	<div class="col-md-3">
		<div class="card border-primary mb-3" data-type="report" style="max-width: 20rem;">
			<div class="card-body">
				<img class="card-img report" alt="" src="/resources/common/image/main/report.png">				
			</div>
			<div class="card-header">신고</div>
		</div>
	</div>
	<div class="col-md-3">
		<div class="card border-secondary mb-3" data-type="metaverse" style="max-width: 20rem;">
			<div class="card-body">
				<img class="card-img metaverse" alt="" src="/resources/common/image/main/addItem.png">				
			</div>
			<div class="card-header">메타버스</div>
		</div>
	</div>
	<div class="col-md-3">
		<div class="card border-success mb-3" data-type="summary" style="max-width: 20rem;">
			<div class="card-body">
				<img class="card-img summary" alt="" src="/resources/common/image/main/summary.png">				
			</div>
			<div class="card-header">데이터 요약</div>
		</div>
	</div>
	<div class="col-md-3">
		<div class="card border-danger mb-3" data-type="advertising" style="max-width: 20rem;">
			<div class="card-body">
				<img class="card-img advertising" alt="" src="/resources/common/image/main/advertising.png">				
			</div>
			<div class="card-header">광고관리</div>
		</div>
	</div>
</div>




<%@ include file="/WEB-INF/views/jang/include/footer.jsp"%>