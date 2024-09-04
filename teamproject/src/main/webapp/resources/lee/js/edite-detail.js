import {
    ClassicEditor,
    AccessibilityHelp,
    AutoImage,
    AutoLink,
    Autosave,
    Bold,
    CloudServices,
    Essentials,
    ImageBlock,
    ImageInline,
    ImageInsert,
    ImageInsertViaUrl,
    ImageResize,
    ImageStyle,
    ImageToolbar,
    ImageUpload,
    Italic,
    Link,
    Paragraph,
    SelectAll,
    SimpleUploadAdapter,
    Undo
} from 'ckeditor5';

import translations from 'ckeditor5/translations/ko.js';


let editor;

const editorConfig = {
    toolbar: {
        items: ['undo', 'redo', '|', 'selectAll', '|', 'bold', 'italic', '|', 'link', 'insertImage', '|', 'accessibilityHelp'],
        shouldNotGroupWhenFull: false
    },
    plugins: [
        AccessibilityHelp,
        AutoImage,
        AutoLink,
        Autosave,
        Bold,
        CloudServices,
        Essentials,
        ImageBlock,
        ImageInline,
        ImageInsert,
        ImageInsertViaUrl,
        ImageResize,
        ImageStyle,
        ImageToolbar,
        ImageUpload,
        Italic,
        Link,
        Paragraph,
        SelectAll,
        SimpleUploadAdapter,
        Undo
    ],
    simpleUpload: {
        uploadUrl: '/lee/upload/uploadAction', // 업로드할 URL 설정
        headers: {
            'X-CSRF-TOKEN': 'CSRF-Token', // 필요한 경우
            Authorization: 'Bearer <JSON Web Token>' // 필요한 경우
        }
    },
    image: {
        toolbar: ['imageTextAlternative', '|', 'imageStyle:inline', 'imageStyle:wrapText', 'imageStyle:breakText', '|', 'resizeImage']
    },
    initialData: '',
    language: 'ko',
    link: {
        addTargetToExternalLinks: true,
        defaultProtocol: 'https://',
        decorators: {
            toggleDownloadable: {
                mode: 'manual',
                label: 'Downloadable',
                attributes: {
                    download: 'file'
                }
            }
        }
    },
    placeholder: '본문을 작성해 주세요!',
    translations: [translations],
    baseFloatZIndex: 2,
    readOnly: true, // 읽기 전용 모드 설정
};

document.addEventListener('DOMContentLoaded', () => {
    ClassicEditor.create(document.querySelector('#readEditor'), editorConfig,
   		 {
            ckfinder: {
                uploadUrl : "/uploadAction"
            }
        })
        .then(newEditor => {
            
            editor = newEditor;

            // 툴바 숨기기
            const toolbarElement = editor.ui.view.toolbar.element;
            toolbarElement.style.display = 'none';

            // 읽기 전용모드
            editor.enableReadOnlyMode("readEditor");
			
			// z-idex조정
			   const editorContainer = document.querySelector('.ck-editor__main');
            if (editorContainer) {
                editorContainer.style.zIndex = '3';
            }
            const toolbarContainer = document.querySelector('.ck-toolbar');
            if (toolbarContainer) {
                toolbarContainer.style.zIndex = '4';
            }
            const floatingUIContainer = document.querySelector('.ck.ck-reset_all');
            if (floatingUIContainer) {
                floatingUIContainer.style.zIndex = '5';
            }
			
			let imgs = $(".ck-content > figure > img");
			console.log("img : " + $(".ck-content > figure > img"));
			$(".ck-content > figure > img").css("z-index", "5");
			
            // 초기 데이터 설정
            let content = document.getElementById("content").value;
            editor.setData(content);
            
            // 수정버튼 클릭시
            $('#btnUpdate').click(function(){
              	// editor css
                $(".ck-reset_all").css("display", "block");
                $(".ck.ck-editor__editable_inline").css("border", "1px solid transparent");
                if (editor) {
                     editor.disableReadOnlyMode('readEditor');
                     console.log("읽기전용풀기");
                }
                
                //툴바 보이기
                toolbarElement.style.display = 'block';   
                
                //버튼 처리
                $("#btnUpdate").fadeOut(1000);
                $("#btnDelete").fadeOut(1000);
                $("#btnUpdateOk").fadeIn(1000);
                $("#btnUpdateCancle").fadeIn(1000);
                
                //제목 입력 
                $("#input-write").prop("readonly", false);
            });
            
            //수정 취소 버튼 클릭시
            $('#btnUpdateCancle').click(function(){
            	//툴바 감추기
            	toolbarElement.style.display = 'none';
            	
            	// 읽기 전용모드
            	editor.enableReadOnlyMode("readEditor"); 
            	
            	//외각선 없애기
				$(".ck").css("border", "none");
				$(".ck-editor__editable_inline").css("border", "none");
				$(".ck-reset_all").css("display", "none");
			
            	//버튼 처리
                $("#btnUpdate").fadeIn(1000);
                $("#btnDelete").fadeIn(1000);
                $("#btnUpdateOk").fadeOut(1000);
                $("#btnUpdateCancle").fadeOut(1000);
                
                //제목 입력 
                $("#input-write").prop("readonly", true);
            });
            
            //수정완료 버튼 클릭시
            $('#btnUpdateOk').click(function(){
                if (editor) {
                    const content = editor.getData();
                    console.log(content);		
					$("#content").val(content);
					//attachList 처리
					let imgPaths = getPaths(content);
					//console.log("path처리 완료");
					setInputByPaths(imgPaths);
					
                    $("#update-from").submit();
                }
            });
            console.log('Editor was initialized', editor);
        })
        
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
	    	//console.log(imgPaths);
	    	let inputTag = "";
	    	for(let i=0; i<imgPaths.length; i++){
	    		let path = imgPaths[i];
	    		console.log("path : ",  path);
	    		inputTag += `<input type="hidden" name="pathList[${i}].uploadpath" value="${path}">`;
	    	}
	    	console.log("inputTag done");
	    	console.log("inputTag : " + inputTag);
	    	$("#update-from").append(inputTag);
	    }//setInputByPaths
});

