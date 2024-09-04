<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/common/css/admin.css">
<%@ include file="/WEB-INF/views/jang/include/header.jsp"%>
<meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Dashboard - NiceAdmin Bootstrap Template</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="/resources/common/img/favicon.png" rel="icon">
  <link href="/resources/common/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

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
<style>
.chart-background{
	stroke-width : 1px;
	stroke: gray;
}
.card-chart.hovered .chart-background{
    stroke-width : 1px;
	stroke: black;
	cursor: pointer;
}
.card-chart.hovered,
.card-chart.hovered * {
    cursor: pointer;
}
.pie-chart{
	display:none;
}
.modal-header {
    display: flex;
    justify-content: space-between; /* 요소 간의 간격을 자동으로 조정 */
}

.modal-check {
    flex: 1; /* 각 input 요소가 동일한 공간을 차지 */
    margin-right: 5px; /* 요소들 사이에 간격 추가 */
}

/* 모달 제목 스타일 */
.custom-modal .modal-title {
    font-size: 1.5rem;
    font-weight: bold;
    color: #333;
}

/* 라디오 버튼 스타일 */
.custom-modal .modal-check input[type="radio"] {
    margin-right: 5px;
}

.custom-modal .modal-check {
    flex: 1;
    text-align: center;
    font-size: 1.1rem;
    color: #555;
}

/* 모달 본문 스타일 */
.custom-modal .modal-body {
    padding: 20px;
    background-color: #f9f9f9;
}

/* 목표 설정 폼 스타일 */
.custom-modal #frmGoal {
    margin-top: 20px;
}

.custom-modal #frmGoal .form-group {
    margin-bottom: 15px;
}

.custom-modal #frmGoal label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
    color: #333;
}

.custom-modal #frmGoal input[type="text"],
.custom-modal #frmGoal textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 1rem;
    background-color: #fff;
    box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
}

.custom-modal #frmGoal input[type="text"]:focus,
.custom-modal #frmGoal textarea:focus {
    border-color: #5b9bd5;
    outline: none;
    box-shadow: 0 0 5px rgba(91, 155, 213, 0.5);
}

/* 버튼 스타일 */
.custom-modal .btn {
    padding: 10px 20px;
    font-size: 1rem;
    border-radius: 4px;
}

.custom-modal .btn-secondary {
    background-color: #6c757d;
    border-color: #6c757d;
    color: #fff;
}

.custom-modal .btn-primary {
    background-color: #007bff;
    border-color: #007bff;
    color: #fff;
}

.custom-modal .btn-secondary:hover,
.custom-modal .btn-primary:hover {
    background-color: #0056b3;
    border-color: #004085;
    color: #fff;
}

/* 숨겨진 요소들을 위한 기본 설정 */
.custom-modal #hiddenElements {
    display: none;
}

/* SVG 컨테이너 스타일 */
.custom-modal #svgModal {
    display: block;
    margin: 0 auto; /* SVG를 중앙에 정렬 */
}


</style>
<script>
$(function() {
    // sidebar 열린 nav 설정
    $("li.summary a").removeClass("collapsed");
    $("li.summary ul").addClass("show");
    $("li.summary ul li.summary a").addClass("active");

    // 리스트 받아오기
    let boardSummaryList = ${boardSummaryList};
    let replySummaryList = ${replySummaryList};
    let userRegSummaryList = ${userRegSummaryList};

    // 위의 변수를 JSON 문자열로 변환하고, 이를 자바스크립트 객체로 변환
    let boardSummaryListJson = JSON.stringify(boardSummaryList);
    let replySummaryListJson = JSON.stringify(replySummaryList);
    let userRegSummaryListJson = JSON.stringify(userRegSummaryList);
    let boardSummaryJsObjects = JSON.parse(boardSummaryListJson);
    let replySummaryJsObjects = JSON.parse(replySummaryListJson);
    let userRegSummaryJsObjects = JSON.parse(userRegSummaryListJson);
    
 	// 변수 설정
    const svg = document.getElementById("svg");
    const polylinePoints = []; // 꺾은선 그래프의 포인트 저장 배열
    
	// 카드들 생성 및 배치
	let card1 = drawCard(width, height, "#eff0f2");
	addElementsToCard(card1, {
	    addBarChart: true,
	    addPieChart: true,
	    addLegend: true,
	    summaryJsObjects: boardSummaryJsObjects,
	    width: width,
	    height: height,
	    count: "count",
	    labelName: "boardType",
    	transform: "translate(0, 50) scale(0.8)",
    	textContent: "게시판"
	}, svg);  
	
	let card2 = drawCard(width, height, "#eff0f2");
	addElementsToCard(card2, {
	    addBarChart: true,
	    addPieChart: true,
	    addLegend: true,
	    summaryJsObjects: userRegSummaryJsObjects,
	    width: width,
	    height: height,
	    count: "count",
	    labelName: "regDate",
    	transform: "translate(270, 50) scale(0.8)",
    	textContent: "가입유저"
	}, svg);
	
	let card3 = drawCard(width, height, "#eff0f2");
	addElementsToCard(card3, {
	    addBarChart: true,
	    addPieChart: true,
	    addLegend: true,
	    summaryJsObjects: replySummaryJsObjects,
	    width: width,
	    height: height,
	    count: "count",
	    labelName: "boardType",
    	transform: "translate(0, 270) scale(0.8)",
    	textContent: "댓글"
	}, svg);
	
	let card4 = drawCard(width, height, "#eff0f2");
	addElementsToCard(card4, {
	    addBarChart: true,
	    addPieChart: true,
	    addLegend: true,
	    summaryJsObjects: boardSummaryJsObjects,
	    width: width,
	    height: height,
	    count: "count",
	    labelName: "boardType",
    	transform: "translate(270, 270) scale(0.8)",
    	textContent: "게시판"
	}, svg);
	
	
	// 차트 hover, click 이벤트 처리
	let index = 0; // 클릭 횟수를 추적하기 위한 변수
	setHoverListener();
	setClickListener(index);

	// 모달 svg 선언
	let svgModal = document.getElementById("svgModal"); 

    // 라디오 버튼 클릭 이벤트 리스너
    $('input[name="selection"]').on('change', function() {
    	
    	$('input[name="selection"]').prop('checked', false);
    	
		$('#svgModal').remove();
        $('#frmGoal').hide();		
        // 새로운 SVG 태그를 동적으로 생성
        let svgModal = document.createElementNS("http://www.w3.org/2000/svg", "svg");
        svgModal.setAttribute("id", "svgModal");
        svgModal.setAttribute("width", "100%");
        svgModal.setAttribute("height", "400");
        svgModal.setAttribute("xmlns", "http://www.w3.org/2000/svg");

        // modal-body에 새로운 SVG 태그를 추가
        $('.modal-body').append(svgModal);

        let summaryJsObjects;
        let labelName;
        let textContext;	
        
        const selection = $(this).val();
        console.log("selection:", selection);
        if (selection === 'board') {
            summaryJsObjects = boardSummaryJsObjects;
            labelName = "boardType";
            textContext = "게시판";
        } else if (selection === 'reply') {
            summaryJsObjects = replySummaryJsObjects;
            labelName = "boardType";
            textContext = "댓글";
        } else if (selection === 'user') {
            summaryJsObjects = userRegSummaryJsObjects;
            labelName = "regDate";
            textContext = "가입유저";
        }
        
        console.log("summayJsObjects: " , summaryJsObjects);
        console.log("labelName: " , labelName);
        console.log("textContext: " , textContext);
        
        let card5 = drawCard(width, height, "#eff0f2");
    	addElementsToCard(card5, {
    	    addBarChart: true,
    	    addPieChart: true,
    	    addLegend: true,
    	    summaryJsObjects: summaryJsObjects,
    	    width: width,
    	    height: height,
    	    count: "count",
    	    labelName: labelName,
        	transform: "translate(50, 50) scale(1.5)",
        	textContent: textContext
    	}, svgModal);
	
        $('#btnModalNext').show();
        $('#btnModalSave').hide(); 

	});
    
    // 모달 다음 버튼
    $('#btnModalNext').on('click', function() {
        // SVG 태그를 감추고 목표 설정 폼을 표시
        let svgElement = $('#svgModal');
        svgElement.hide();

        // 숨겨진 목표 설정 폼을 가져와서 보여주기
        let frmGoal = $('#hiddenElements #frmGoal').clone(); // 숨겨진 폼 복사
        frmGoal.show(); // 폼을 보이게 설정
        svgElement.after(frmGoal); // SVG 태그 뒤에 삽입

        // "다음" 버튼을 숨기고 "저장" 버튼을 보이게 함
        $(this).hide();
        $('#btnModalSave').show();
    });
    
    // 모달 저장 버튼
    $('#btnModalSave').click(function(){
		$('#frmGoal input[type="text"]').val(''); 
		$('#frmGoal textarea').val('');
		
		let initialSvg = '<svg id="svgModal" width="100%" height="400" xmlns="http://www.w3.org/2000/svg"></svg>';
		$('#modalAim .modal-body').empty();
		$('#modalAim .modal-body').append(initialSvg)
    });
    
    // 모달 취소 버튼
    $('#btnModalCancel').click(function(){
		$('#frmGoal input[type="text"]').val(''); 
		$('#frmGoal textarea').val('');
		
		let initialSvg = '<svg id="svgModal" width="100%" height="400" xmlns="http://www.w3.org/2000/svg"></svg>';
		$('#modalAim .modal-body').empty();
		$('#modalAim .modal-body').append(initialSvg)
    });
});
</script>
	

 <!-- ======= Header ======= -->
<%@ include file="/WEB-INF/views/common/administor/sidebar.jsp" %>
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>Dashboard</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/admin/main">Home</a></li>
          <li class="breadcrumb-item aim" data-bs-toggle="modal" data-bs-target="#modalAim" ><a>목표설정하기</a></li>
        </ol>
      </nav>
    </div><!-- End Page Title -->
	<section class="section dashboard">
		<svg id="svg" height="100%" width="100%" fill="white" viewBox="0 0 500 500">
		    <rect x="0" y="0" width="100%" height="100%" fill="white" rx="20"/>
		</svg>
	</section>
  

  </main><!-- End #main -->

	<!-- modal -->
	<div class="modal fade custom-modal" id="modalAim" tabindex="-1">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <a id="targetURL" class="modal-title">목표 설정하기</a>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-header">
	                <div class="modal-check">
	                    <input type="radio" name="selection" value="board">게시판 수
	                </div>
	                <div class="modal-check">
	                    <input type="radio" name="selection" value="reply">댓글 수
	                </div>
	                <div class="modal-check">
	                    <input type="radio" name="selection" value="user">유저 수
	                </div>
	            </div>
	            <div class="modal-body" style="overflow-y: hidden; padding: 0;">
	                <svg id="svgModal" width="100%" height="400" xmlns="http://www.w3.org/2000/svg"></svg>
	            </div>
	            <div class="modal-footer">
	                <button id="btnModalNext" type="button" class="btn btn-secondary">다음</button>
	                <button id="btnModalSave" type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="display:none;">저장</button>
	                <button id="btnModalCancel" type="button" class="btn btn-primary" data-bs-dismiss="modal">취소</button>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- End modal -->

	<!-- hidden div -->
	<div id="hiddenElements" style="display: none;">
	    <form id="frmGoal" style="display: none;">
	        <div class="form-group">
	            <label for="goal">목표 설정:</label>
	            <input type="text" class="form-control" id="goal" name="goal" placeholder="목표를 입력하세요">
	        </div>
	        <div class="form-group">
	            <label for="strategy">보완점 또는 전략:</label>
	            <textarea class="form-control" id="strategy" name="strategy" rows="4" placeholder="보완점 또는 전략을 입력하세요"></textarea>
	        </div>
	    </form>
	    <svg id="svgTemplate" width="100%" height="400" xmlns="http://www.w3.org/2000/svg"></svg>
	</div>
	<!-- End hidden div -->


  <!-- ======= Footer ======= -->
  <footer id="footer" class="footer">
    <div class="copyright">
      &copy; Copyright <strong><span>NiceAdmin</span></strong>. All Rights Reserved
    </div>
    <div class="credits">
      <!-- All the links in the footer should remain intact. -->
      <!-- You can delete the links only if you purchased the pro version. -->
      <!-- Licensing information: https://bootstrapmade.com/license/ -->
      <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
      Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
   
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
  <script src="/resources/common/js/summary.js"></script>
</body>

</html>