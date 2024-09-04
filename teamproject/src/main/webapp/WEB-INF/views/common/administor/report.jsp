<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/jang/include/header.jsp"%>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>Tables / Data - NiceAdmin Bootstrap Template</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->
<link href="/resources/common/image/index/favicon.png" rel="icon">
<link href="/resources/common/image/index/apple-touch-icon.png" rel="apple-touch-icon">


<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="/resources/common/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<link href="/resources/common/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
<link href="/resources/common/vendor/quill/quill.snow.css" rel="stylesheet">
<link href="/resources/common/vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="/resources/common/vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="/resources/common/vendor/simple-datatables/style.css" rel="stylesheet">
<link href="/resources/common/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/common/css/admin.css">

<!-- Template Main CSS File -->
<link href="/resources/common/css/style.css" rel="stylesheet">

<!-- =======================================================
  * Template Name: NiceAdmin
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Updated: Apr 20 2024 with Bootstrap v5.3.3
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>
<script type="text/javascript">
$(function(){
	// sidebar 열린 nav 설정
	$("li.report a").removeClass("collapsed");
	$("li.report ul").addClass("show");
	$("li.report ul li.report-handler a").addClass("active");

	
	// Long을 yyyy-MM-dd 형식으로 변환
	function formatDate(dateString) {
    	let date = new Date(dateString);
        let year = date.getFullYear();
        let month = ('0' + (date.getMonth() + 1)).slice(-2);
        let day = ('0' + date.getDate()).slice(-2);
        return `\${year}-\${month}-\${day}`;
    }
	
	// 테이블 항목 클릭시 이벤트 처리
	// 모달창 띄우기, 모달에 해당 유저의 경고/정지 내역 표시
	$(".trReport").click(function(){
		let content = $(this).data("content");
		let reportNo = $(this).data("reportno");
		let target = $(this).find(".tdTarget").text();
	    let targetType = $(this).find(".tdTargetType").text();
	    let reasonType = $(this).find(".tdReasonType").text();
	    let targetURL = $(this).data("targeturl");
	    console.log("targetURL", targetURL);
	    
	    $("#reportContent").html(content);
	    $("#targetURL").attr("data-target", target);
	    $("#targetURL").attr("data-targeturl", targetURL);
		 
	    $.ajax({
	        type: "get",
	        url: "/admin/user/action-history?target=" + target + "&targetType=" + targetType,
	        data: target,
	        async: false,
	        success: function(rData){
	            console.log(rData);
	          	let trData = ``;
	          	for(let i = 0; i < rData.length; i++){
	          		let startTime = formatDate(rData[i].startTime);
	          		let endTime = formatDate(rData[i].endTime);
	          		
	          		trData += `<tr>
	          			  	     	<td>\${rData[i].userId}</td>
	          			  	     	<td>\${rData[i].actionType}</td>
	          			  	     	<td>\${rData[i].reasonType}</td>
	          			  	     	<td>\${startTime}</td>
	          			  	     	<td>\${endTime}</td>
	          			  	     	<td>\${rData[i].issuedBy}</td>
	          			  	     	<td>\${rData[i].status}</td>
	          				   </tr>`;
	          	}
	            $("#tbActionList").empty();
	            $("#tbActionList").append(trData);
	            
	        }
	    });
 
		$("#inputReportNo").val(reportNo);
		$("#inputReasonType").val(reasonType);
		$("#inputTarget").val(target);
		$("#inputTargetType").val(targetType);
		$("#inputIssuedBy").val(`${loginSessionDto.userid}`);
	});
	
	// 모달창의 신고내용 버튼 클릭 시 해당 페이지를 새창으로 띄움
	$("#targetURL").click(function(e){
		e.preventDefault();
		 
	    let url = $(this).attr("data-targeturl");
	   	console.log(url);
	    let windowName = 'MetaverseWindow';
	    let windowFeatures = 'width=600,height=600,left=100,top=100,toolbar=no,menubar=no,location=no,status=no,resizable=no,scrollbars=yes';

	    window.open(url, windowName, windowFeatures);
	});
	
	// 일시정지 선택시 기간 옵션 노출
    $("#cmbActionType").change(function() {
        if ($(this).val() === "suspend") {
            $('#cmbPeriodContainer').show(); // 일시정지 선택 시 보임
        } else {
            $('#cmbPeriodContainer').hide(); // 다른 옵션 선택 시 숨김
        }
    });
    
	// 경고/정지 내용 등록
    $("#btnAction").click(function(){
    	$("#frmModal").submit();
    });
	
	$("#btnCancel").click(function(){
		console.log("클릭");
		$("#frmModal").hide();
	});
});
</script>


<%@ include file="/WEB-INF/views/common/administor/sidebar.jsp" %>

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>신고 처리</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="/admin/main">홈</a></li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<section class="section">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">신고 처리</h5>
							<table class="table datatable">
								<thead>
									<tr>
										<th>대상</th>
										<th>신고사유</th>
										<th>타입</th>
										<th>등록날짜</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${reportList}" var="vo">
										<tr class="trReport"data-bs-toggle="modal" data-bs-target="#modalDialogScrollable" 
										data-content="${vo.content}" data-targeturl="${vo.targetURL}" data-reportno="${vo.reportNo}" >
											<td class="tdTarget">${vo.target}</td>
											<td class="tdReasonType">${vo.reasonType}</td>
											<td class="tdTargetType">${vo.targetType}</td>
											<td><fmt:formatDate value="${vo.reportDate}"
													pattern="yyyy/MM/dd" /></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>


						</div>
					</div>

				</div>
			</div>
			
		</section>
	<!-- End #main -->



	<!-- ======= Footer ======= -->
	<footer id="footer" class="footer">
		<div class="copyright">
			&copy; Copyright <strong><span>NiceAdmin</span></strong>. All Rights
			Reserved
		</div>
		<div class="credits">
			<!-- All the links in the footer should remain intact. -->
			<!-- You can delete the links only if you purchased the pro version. -->
			<!-- Licensing information: https://bootstrapmade.com/license/ -->
			<!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
			Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
		</div>
	</footer>
	<!-- End Footer -->

	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<!-- Vendor JS Files -->
	<script src="/resources/common/vendor/apexcharts/apexcharts.min.js"></script>
	<script
		src="/resources/common/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/common/vendor/chart.js/chart.umd.js"></script>
	<script src="/resources/common/vendor/echarts/echarts.min.js"></script>
	<script src="/resources/common/vendor/quill/quill.js"></script>
	<script
		src="/resources/common/vendor/simple-datatables/simple-datatables.js"></script>
	<script src="/resources/common/vendor/tinymce/tinymce.min.js"></script>
	<script src="/resources/common/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<script src="/resources/common/js/main.js"></script>
	
			<!-- modal -->
			<div class="modal fade" id="modalDialogScrollable" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <a id="targetURL" class="modal-title">신고 내용</a>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div id="reportContent" class="modal-body">
                    	
                    </div>
                    <div class="modal-body">
                    	<table class="table datatable">
                    		<thead>
	                    		<tr>
	                    			<th>아이디</th>
	                    			<th>경고/정지</th>
	                    			<th>사유</th>
	                    			<th>시작일</th>
	                    			<th>만료일</th>
	                    			<th>발부자</th>
	                    			<th>상태</th>
	                    		</tr>
                    		</thead>
                    		<tbody id="tbActionList">
                    		
                    		</tbody>
                    	</table>
                    </div>
                    <div class="modal-header">
                    	
                    </div>
					<div class="container">
						<form id="frmModal" action="/admin/user/restriction" method="post">
						<span>경고/정지</span>
					    <select name="actionType" id="cmbActionType" class="cmb">
					        <option value="warning">경고</option>
					        <option value="suspend">일시정지</option>
					        <option value="ban">영구정지</option>
					    </select>
				       <div id="cmbPeriodContainer" style="display:none;">
					        <span>기간</span>
					        <select name="period" class="cmb">
					            <option value="1">1일</option>
					            <option value="3">3일</option>
					            <option value="7">7일</option>
					            <option value="30">30일</option>
					        </select>
					    </div>
					    <input id="inputReportNo" type="hidden" name="reportNo">
					    <input id="inputReasonType" type="hidden" name="reasonType">
					    <input id="inputIssuedBy" type="hidden" name="issuedBy">
					    <input id="inputTarget" type="hidden" name="target">
					    <input id="inputTargetType" type="hidden" name="targetType">
						</form>
					</div>
					<div class="modal-footer">
                      <button id="btnAction" type="button" class="btn btn-secondary" data-bs-dismiss="modal">적용</button>
                      <button id="btnCancel" type="button" class="btn btn-primary" data-bs-dismiss="modal">취소</button>
                    </div>
                  </div>
                </div>
              </div>
			<!-- End modal -->
			
		</div>
	</div>
	
	</main>
</body>
</html>

<!-- End Default Accordion Example -->
