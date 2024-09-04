<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/lee/include/header.jsp" %>
<link rel="stylesheet" href="/resources/lee/css/write.css">

<!-- 에디터 -->
<link rel="stylesheet" href="/resources/lee/css/edite.css">
<!-- <link rel="stylesheet" href="/resources/lee/js/editeClickHandler.js"> -->
<link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/42.0.2/ckeditor5.css">
<script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/simple-upload-adapter/simple-upload-adapter.js"></script>
<!-- 에디터 -->
<script>
	$(function(){
		let regex = new RegExp("(.*?.)\.(exe|sh|zip|alz)$");
		let maxSize = 5242880;
		
		//이미지 보이기
		function showImage(fileNames){
			const textArea = $("#contnet");
			for(let i=0; i<fileNames.length; i++){
				console.log("fileNames : " + fileNames[i]);
				let filename = fileNames[i];
				$.ajax({
					type : "get",
					url : "/lee/upload/display",
					data: {fileName : filename},
					xhrFields: {
			        	responseType: 'blob' // 중요: 바이너리 데이터로 응답받기 위해 설정
			        },
					success : function(rData){
						console.log("이미지보이기 success")
						console.log(rData);
						let reader = new FileReader();
						reader.onload = function(e){
							let imgTag = `<img id="imagePreview" src="${e.target.result}">`;
							textArea.val(textArea.val() + imgTag);
						};
						reader.readAsDataURL(rData);
					},
					error: function(){
						alert("이미지를 불러오는 중 오류가 발생 했습니다.")
					}
				});
			}
		}
		
		//업로드 메서드
		function uploadFiles(files){
			let formData = new FormData();
			for(let i=0; i<files.length; i++){
				let fileName = files[i].name;
				let fileSize = files[i].size;
				if(!checkExtension(fileName, fileSize)){
					console.log("extension체크 실패");
					return false;
				}
				console.log("extension체크 송공");
				formData.append("uploadFile", files[i]);
				console.log("uploadFiles, fileName : " + fileName);
				console.log("uploadFiles, fileSize : " + fileSize);
			};
			
			console.log(formData);
			$.ajax({
				type: "post",
				url: "/lee/upload/uploadAction",
				contentType: false,
				processData: false,
				data: formData,
				success : function(rData){
					let fileNames = [];
					$.each(rData, function(index, value){
						let obj = value;
						let imgTag;
						let fileName = `/\${obj.uploadPath}/s_\${obj.uuid}_\${obj.fileName}`;
						let originalFileName = `/\${obj.uploadPath}/s_\${obj.uuid}_\${obj.fileName}`;
						fileNames[index] = originalFileName;
						if(!value.image){
							// 이미지가 아니면
							imgTag = `<img src="#" witdh="100"></img>`;
						}else{
							// 이미지라면
							imgTag = `<img src="/lee/upload/display?fileName=\${fileName}"></img>`;
						}
						let liTag = `<div class="list-style-none">
										\${imgTag}
										<span class="span-delete-image" data-filename="\${fileName}">
											x
										</span><br>
										<div>\${obj.fileName}</div><br>
									</div>`
						$("#uploadedList").append(liTag);
									
					});
					showImage(fileNames);
				}
			});
		};
		
		// 파일 선택 했을때
		$("#uploadImageFiles").change(function(){
			$("#btnUpload").trigger("click");
		});
	
		// 이미지 파일(첨부파일) 삭제
		$("#uploadedList").on("click", ".span-delete-image", function(){
			console.log("x누름");
			let that = $(this);
			let filename = that.data("filename");
			console.log("filename : ", filename);
			let sData = {fileName : filename};
			$.ajax({
				type    : "delete",
				url     : "/deleteImg",
				data    : sData,
				success : function(rData){
					console.log(rData);
					that.parent().fadeOut(1000);
				}
			});
		});
		
		// 파일 체크
		function checkExtension(fileName, fileSize){
			if(fileSize > maxSize){
				alert("파일 사이즈 초과");
				return false;
			};
			if(regex.test(fileName)){
				alert("해당 파일 종류는 업로드 할 수 없습니다.");
				return false;
			};
			return true;
		};
		
		// 업로드 버튼클릭
		$("#btnUpload").click(function(){
			console.log("업로드 버튼 클릭");
			const inputFiles = $("#uploadImageFiles");
			let files = inputFiles[0].files;
			uploadFiles(files);
		});
		
		// editor 작업
		const edtior = window.editor;
		//글등록
		$('#btn-write-done').click(function(){
             console.log("글등록버튼");
             if (editor) {
                 let content = editor.getData();
	
					$("#hidden-content").val(content);
					
					let imgPaths = getPaths(content);
					setInputByPaths(imgPaths);
// 					return false;
					$("#postForm").submit();
             };
         });
		
         function getPaths(content){
		    console.log("check..");
		    
		    let imgPaths = [];
		    const formats = [".jpeg", ".png", ".gif", ".bmp", ".webp"];
		    
		    while(true){
		        let startPoint = content.indexOf("/D");
		        let endPoint = content.length;
		        if(startPoint == -1){ return imgPaths; }
		        content = content.substring(startPoint);
	        
		        for(let format of formats){
		            let index = content.indexOf(format);
		            if(index != -1 && index < endPoint){
		                endPoint = index + (format === ".jpeg" || format === ".webp" ? 5 : 4);
	            	}//if
      			}//for
        
		        let path = content.substring(0, endPoint);
		        content = content.substring(endPoint);
		        imgPaths.push(path);
       
   			 }//while
	 	 }//getPaths
 		 function setInputByPaths(imgPaths){
	    	console.log("setInputByPaths...........");
	    	let inputTag = "";
	    	for(let i=0; i<imgPaths.length; i++){
	    		let path = imgPaths[i];
	    		console.log("path : ",  path);
	    		inputTag += `<input type="text" name="pathList[`+i+`].uploadpath" value="`+path+`">`;
	    	}
	    	console.log("inputTag done");
	    	console.log("inputTag : " + inputTag);
	    	$("#postForm").prepend(inputTag);
	     }//setInputByPaths	
		
	     $("#btn-write-cancle").click(function(){
	    	console.log("글쓰기 취소버튼");
// 	    	let boardtype = `${criteria.boardtype}`;
	    	let url = "/lee/board/list/" + `${boardtype.boardtype}`;
	    	console.log("url : " + url);
	    	$("#actionForm").attr("action", url).submit();
	     });
	});
</script>

<!-- write start -->
<div class="write-container">
<!-- 	<h3 class="board-title">글쓰기 게시판입니다</h3> -->
	<!-- post form -->	
	<form action="/lee/board/writeRun" class="write-from" id="postForm" method="post">
		 
      	 <input type="text" class="input-write" name="title" placeholder=" 제목을 입력 해 주세요."  required>
      	 <!-- 숨겨진 input -->
		 <textarea id="hidden-content" name="content" style="display:none;" ></textarea>
      	 <input type="hidden" class="input-write" name="userid" style="width: 200px;" value="${loginSessionDto.userid}">
         <input type="hidden" class="input-write" name="nickname" style="width: 200px;" value="${loginSessionDto.nickname}">
         <input type="hidden" class="input-write" name="boardtypeno" style="width: 200px;" value="${boardtype.boardtypeno}">
		 <div id="div_src">
   		 </div>	 
      	 <!-- 숨겨진 input -->
		 
		 <div>
		 <!-- 에디터 start -->
			<div>
				<div class="main-container">
					<div class="editor-container editor-container_classic-editor" id="editor-container">
						<div class="editor-container__editor">
							
							<div id="editor"></div>
						</div>
					</div>
				</div>
			</div>
			
			<script type="importmap">
				{
					"imports": {
						"ckeditor5": "https://cdn.ckeditor.com/ckeditor5/42.0.2/ckeditor5.js",
						"ckeditor5/": "https://cdn.ckeditor.com/ckeditor5/42.0.2/"
					}
				}
			</script>
			<script type="module" src="/resources/lee/js/edite.js"></script>
		 <!-- 에디터 end -->	
		 
		 </div>
         <div class="btn-container">
         	<button type="button" class="btn" id="btn-write-cancle">취소</button>
            <button type="button" class="btn" id="btn-write-done">작성완료</button>
         </div>
    </form>
    
</div>
<!-- write end -->



<%@ include file="/WEB-INF/views/lee/include/actionForm.jsp"%>
<%@ include file="/WEB-INF/views/lee/include/footer.jsp"%>