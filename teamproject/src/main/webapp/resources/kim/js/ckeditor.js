import {
    ClassicEditor,
    AccessibilityHelp,
    Alignment,
    AutoImage,
    Autosave,
    Bold,
    CloudServices,
    Essentials,
    FontBackgroundColor,
    FontColor,
    FontFamily,
    FontSize,
    GeneralHtmlSupport,
    Highlight,
    ImageBlock,
    ImageInsert,
    ImageInsertViaUrl,
    ImageResize,
    ImageStyle,
    ImageToolbar,
    ImageUpload,
    Italic,
    Link,
    LinkImage,
    MediaEmbed,
    Paragraph,
    SelectAll,
    SimpleUploadAdapter,
    SpecialCharacters,
    Underline,
    Undo
} from 'https://cdn.ckeditor.com/ckeditor5/42.0.2/ckeditor5.js';

import translations from 'https://cdn.ckeditor.com/ckeditor5/42.0.2/translations/ko.js';

const editorConfig = {
    toolbar: {
        items: [
            'undo',
            'redo',
            '|',
            'selectAll',
            '|',
            'fontSize',
            'fontFamily',
            'fontColor',
            'fontBackgroundColor',
            '|',
            'bold',
            'italic',
            'underline',
            '|',
            'link',
            'insertImage',
            'mediaEmbed',
            'highlight',
            '|',
            'alignment',
            '|',
            'accessibilityHelp'
        ],
        shouldNotGroupWhenFull: false
    },
    plugins: [
        AccessibilityHelp,
        Alignment,
        AutoImage,
        Autosave,
        Bold,
        CloudServices,
        Essentials,
        FontBackgroundColor,
        FontColor,
        FontFamily,
        FontSize,
        GeneralHtmlSupport,
        Highlight,
        ImageBlock,
        ImageInsert,
        ImageInsertViaUrl,
        ImageResize,
        ImageStyle,
        ImageToolbar,
        ImageUpload,
        Italic,
        Link,
        LinkImage,
        MediaEmbed,
        Paragraph,
        SelectAll,
        SimpleUploadAdapter,
        SpecialCharacters,
        Underline,
        Undo
    ],
    fontFamily: {
        supportAllValues: true
    },
    fontSize: {
        options: [10, 12, 14, 'default', 18, 20, 22],
        supportAllValues: true
    },
    htmlSupport: {
        allow: [
            {
                name: /^.*$/,
                styles: true,
                attributes: true,
                classes: true
            }
        ]
    },
    image: {
        toolbar: [
            'imageTextAlternative',
            '|',
            'imageStyle:alignBlockLeft',
            'imageStyle:block',
            'imageStyle:alignBlockRight',
            '|',
            'resizeImage'
        ],
        styles: {
            options: ['alignBlockLeft', 'block', 'alignBlockRight']
        }
    },
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
    placeholder: '글을 작성해보세요',
    translations: [translations],
    simpleUpload: {
        uploadUrl: '/kim/upload/ckUploadFormAction',
        headers: {
            'X-CSRF-TOKEN': 'CSRF-Token',
            'Authorization': 'Bearer <JSON Web Token>'
        }
    }
};

document.addEventListener('DOMContentLoaded', () => {
    ClassicEditor.create(document.querySelector('#editor'), editorConfig)
        .then(editor => {
        	// 커서 이동 및 편집기 이벤트 처리
			editor.model.document.on('change', (eventInfo, batch) => {
			    const selection = editor.model.document.selection;
			    const position = selection.getFirstPosition();
			    const parentElement = position.parent;
			
			    // 커서가 해시태그 스팬 내부에 위치했는지 확인
                if (parentElement.is('element', 'span') && parentElement.hasClass('hashtag-span')) {
                    editor.model.change(writer => {
                        // 해시태그 스팬 다음의 공백 이후로 커서를 이동
                        const nextPosition = editor.model.createPositionAfter(parentElement.nextSibling);
                        writer.setSelection(nextPosition);
                    });
                }
			});
        	
            // CKEditor 내에서 키 입력을 감지하고 해시태그 입력 UI를 띄우는 부분
            editor.model.document.on('change:data', () => {
                try {  // **추가된 부분: 예외 처리 시작**

                    let position = editor.model.document.selection.getFirstPosition();
let textNode = position.textNode || position.nodeBefore || position.nodeAfter;

                    // 커서 위치와 관계없이 텍스트에서 '#'이 마지막으로 입력되었는지 확인
        if (textNode && textNode.is('text') && textNode.data.endsWith('#')) {
            // '#'이 입력되면 해시태그 입력 창을 띄우고, 그 이전에 # 문자를 제거
            editor.model.change(writer => {
                const range = writer.createRange(
                    writer.createPositionAt(textNode.parent, textNode.endOffset - 1),
                    writer.createPositionAt(textNode.parent, textNode.endOffset)
                );
                writer.remove(range);
            });

            // 해시태그 입력창 호출
            createHashtagInput(editor);
        }
    } catch (error) {
        console.error('Error in change:data handler:', error);
                }
            });
        
            const form = document.querySelector('#frmRegister');
            
            
            form.addEventListener('submit', (event) => {
                event.preventDefault();

                let content = editor.getData().trim();
                console.log("Content to submit:", content);
                
                // 첫 번째 줄이 빈 <p></p> 태그로 시작하면 제거
                content = content.replace(/<p>\s*,\s*<\/p>/g, '').replace(/<p><\/p>/g, '');
                content = content.replace(/<p>\s*,\s*<\/p>/g, '');

                if (!content || content === "") {
                    alert("내용을 입력해주세요.");
                    return;
                }

                let formData = new FormData(form);
                formData.append('content', content);
                console.log("Content to submit:", content);

                let images = [];
                for (const value of editor.model.document.getRoot().getChildren()) {
                    if (value.name === 'imageBlock') {
                        images.push(value.getAttribute('src'));
                    }
                }

                // 이미지 인덱스를 CKEditor에서 먼저 추가하고
				let ckEditorImageCount = 0;
				
				images.forEach((imageUrl, index) => {
				    if (imageUrl && imageUrl.startsWith('/kim/upload/ckDisplay?fileName=')) {
				        const fileName = imageUrl.split('fileName=')[1];
				        if (fileName) {
				            const [uploadPath, uuidFileName] = fileName.split('/');
				            const [uuid, originalFileName] = uuidFileName.split('_');
				
				            if (uuid && originalFileName && uploadPath) {
				                formData.append(`attachList[${ckEditorImageCount}].uuid`, uuid);
				                formData.append(`attachList[${ckEditorImageCount}].fileName`, originalFileName);
				                formData.append(`attachList[${ckEditorImageCount}].uploadPath`, uploadPath);
				                ckEditorImageCount++;
				            }
				        }
				    }
				});


                // CKEditor에서 업로드된 이미지 수를 고려해 인덱스를 설정
				$("#uploadedList > li").each(function (i) {
				    let fileName = $(this).data("filename");
				    let uploadPath = $(this).data("uploadpath");
				    let uuid = $(this).data("uuid");
				    let image = $(this).data("image");
				
				    formData.append(`attachList[${i + ckEditorImageCount}].fileName`, fileName);
				    formData.append(`attachList[${i + ckEditorImageCount}].uploadPath`, uploadPath);
				    formData.append(`attachList[${i + ckEditorImageCount}].uuid`, uuid);
				    formData.append(`attachList[${i + ckEditorImageCount}].image`, image ? 'I' : 'F');
				});

                $.ajax({
                    url: form.action,
                    type: form.method,
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        window.location.href = '/kim/board/info';
                    },
                    error: function(error) {
                        console.error('Error:', error);
                        alert('전송 중 오류가 발생했습니다. 다시 시도해주세요.');
                    }
                });
            });
        })
        .catch(error => {
            console.error('Editor initialization error:', error);
        });
});


function createHashtagInput(editor) {
    const hashtagInput = document.createElement('input');
    hashtagInput.setAttribute('type', 'text');
    hashtagInput.setAttribute('placeholder', '해시태그 입력');
    hashtagInput.className = 'hashtag-input';

    // 해시태그 입력창의 스타일을 동적으로 조정하기 위해 position을 설정
    hashtagInput.style.position = 'absolute';

    // 현재 커서 위치를 가져옴
    const domSelection = window.getSelection();
    const range = domSelection.getRangeAt(0);
    const rect = range.getBoundingClientRect();

    // 커서 위치에 따라 입력창의 위치를 설정
    hashtagInput.style.top = `${rect.bottom + window.scrollY}px`;
    hashtagInput.style.left = `${rect.left + window.scrollX}px`;

    // 해시태그 입력창을 에디터 내부에 추가
    document.body.appendChild(hashtagInput);

    // 게시물 수를 표시할 div 추가
    const hashtagCountDiv = document.createElement('div');
    hashtagCountDiv.className = 'hashtag-count';
    document.body.appendChild(hashtagCountDiv);

    hashtagInput.focus();

    // 포커스를 잃으면 해시태그 입력창 제거
    const handleBlur = () => {
        hashtagInput.remove();
        hashtagCountDiv.remove();
    };

    hashtagInput.addEventListener('blur', handleBlur);

    // Enter 키로 해시태그 입력 완료
    hashtagInput.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            e.preventDefault();  // 기본 Enter 동작을 막음
            const hashtag = hashtagInput.value.trim();
            if (hashtag.includes(' ')) {
                alert('단어를 한 개만 입력하고 enter 키로 입력해보세요!');

                // `blur` 이벤트 핸들러 제거
                hashtagInput.removeEventListener('blur', handleBlur);
                hashtagInput.remove();
                hashtagCountDiv.remove();

                // content 편집창으로 다시 포커스 이동
                editor.editing.view.focus();
            } else {
                // 해시태그를 버튼형식으로 삽입
                editor.model.change(writer => {
                    const specialChar = '\u00AD'; // 소프트 하이픈
const viewFragment = editor.data.processor.toView(
    `&nbsp;<button class="hashtag-button">${specialChar}#${hashtag}${specialChar}</button>&nbsp;`
);

                    const modelFragment = editor.data.toModel(viewFragment);
                    const insertPosition = editor.model.document.selection.getFirstPosition();
                    
                    // 모델에 해시태그 삽입
                    editor.model.insertContent(modelFragment, insertPosition);

                    // 삽입된 해시태그와 공백 뒤에 커서 위치시키기
                    const newPosition = editor.model.createPositionAfter(insertPosition.nodeAfter.nextSibling);
                    writer.setSelection(newPosition);
                    
                });

                // `blur` 이벤트 핸들러 제거
                hashtagInput.removeEventListener('blur', handleBlur);
                hashtagInput.remove();
                hashtagCountDiv.remove();

                editor.editing.view.focus();
            }
        }
    });

    // 해시태그 입력 중 실시간 게시물 수 업데이트
    hashtagInput.addEventListener('keyup', () => {
        const rawHashtag = hashtagInput.value.trim();
        const hashtag = `${rawHashtag}`; //# 하나 붙여서 검색
        if (hashtag !== '') {
            // 비동기 요청을 보내 게시물 수를 가져옴
            fetch(`/kim/board/hashtagCount?hashtag=${encodeURIComponent(hashtag)}`)
                .then(response => response.json())
                .then(data => {
                    console.log('Received data:', data);  // 디버깅용 로그
                    hashtagCountDiv.textContent = `이 태그로 작성된 ${data.count} 개의 게시물이 있어요 인기 태그를 넣어서 작성해보세요!`;
                    
                    // 입력창 아래에 위치
                    const rect = hashtagInput.getBoundingClientRect();
                    hashtagCountDiv.style.top = `${rect.bottom + window.scrollY + 5}px`; 
                    hashtagCountDiv.style.left = `${rect.left + window.scrollX}px`;
                })
                .catch(error => {
                    console.error('Error fetching hashtag count:', error);
                    hashtagCountDiv.textContent = '오류 발생';
                });
        } else {
            hashtagCountDiv.textContent = ''; // 입력이 없으면 아무것도 표시하지 않음
        }
    });
}












// 기존 드래그&드롭 파일 업로드 기능
$(function () {
    let regex = new RegExp("(.*?)\\.(exe|sh|zip|alz)$");
    let maxSize = 5242880; // 5MB

    function showImage(fileCallPath) {
        console.log("showImage...:", fileCallPath);
        $(".bigPictureWrapper").css("display", "flex").show();
        $(".bigPicture").html(`<img src="/kim/upload/display?fileName=${fileCallPath}">`)
            .animate({
                width: "100%",
                height: "100%"
            }, 1000);

        setTimeout(function () {
            $(".bigPicture").animate({
                width: "0%",
                height: "0%"
            }, 1000);
            $(".bigPictureWrapper").fadeOut(1000);
        }, 2000);
    }

    function uploadFiles(files) {
        let formData = new FormData();
        for (let i = 0; i < files.length; i++) {
            let fileName = files[i].name;
            let fileSize = files[i].size;
            if (!checkExtension(fileName, fileSize)) {
                return false;
            }
            formData.append("uploadFile", files[i]);
        }
        console.log(formData);

$.ajax({
    type: "post",
    url: "/kim/upload/uploadFormAction",
    contentType: false,
    processData: false,
    data: formData,
    success: function (rData) {
        console.log(rData);
        $.each(rData, function (index, obj) {
            let imgTag;

            // todayFolderPath 변수에 담긴 값을 사용하여 경로 생성
            let todayFolderPath = `${obj.todayFolderPath}`;

            // 전체 파일 경로를 생성
            let fileName = `${todayFolderPath}/${obj.uuid}_${obj.fileName}`;

            if (!obj.image) {
                // 이미지가 아닌 파일의 경우
                imgTag = `<a href='/download?fileName=${fileName}'>
                                <img src='/resources/kim/image/default.png' width='100'></a>`;
            } else {
                // 이미지 파일의 경우, 썸네일 경로와 원본 경로 생성
                let path = `${todayFolderPath}/s_${obj.uuid}_${obj.fileName}`; // 썸네일 경로 생성
                let callPath = `${todayFolderPath}/${obj.uuid}_${obj.fileName}`; // 원본 경로

                imgTag = `<img class="imgImage" src="/kim/upload/display?fileName=${path}" 
                                data-callpath="${callPath}">`;
            }

            // li 태그 생성 및 추가
            let liTag = `<li
                            data-filename="${obj.fileName}" // 파일 이름만 저장
                            data-uploadpath="${obj.uploadPath}" // 경로만 저장
                            data-uuid="${obj.uuid}"
                            data-image="${obj.image}"
                            >${imgTag} <br> ${obj.fileName} <span style="cursor:pointer;"
                            data-filename="${fileName}">&times;</span></li>`; // 전체 경로를 삭제용으로 저장

            $("#uploadedList").append(liTag);
        });
    }
});

    }

    function checkExtension(fileName, fileSize) {
        if (fileSize > maxSize) {
            alert("파일 사이즈 초과");
            return false;
        }
        if (regex.test(fileName)) {
            alert("해당 파일 종류는 업로드 할 수 없습니다.");
            return false;
        }
        return true;
    }

    $("#divDrop").on("dragenter dragover", function (e) {
        e.preventDefault();
    });

    $("#divDrop").on("drop", function (e) {
        e.preventDefault();
        console.log(e.originalEvent.dataTransfer.files);
        let files = e.originalEvent.dataTransfer.files;
        uploadFiles(files);
    });

    $("#divDrop").on("click", function () {
        $("#fileInput").click();
    });

    $("#fileInput").on("change", function (e) {
        let files = e.target.files;
        uploadFiles(files);
    });

    $("#uploadedList").on("click", ".imgImage", function () {
        let callPath = $(this).data("callpath");
        showImage(callPath);
    });

    $("#uploadedList").on("click", "li > span", function () {
        let that = $(this);
        let filename = that.data("filename");
        console.log("filename:", filename); // 추가된 부분: filename 값 확인용 로그
        let sData = { fileName: filename };
        console.log("sData:", sData);
        $.ajax({
            type: "delete",
            url: "/kim/upload/delete",
            data: JSON.stringify(sData), // JSON 형태로 데이터 전송
            contentType: "application/json; charset=utf-8", // contentType 설정
            success: function (rData) {
                console.log(rData);
                that.parent().remove(); // 성공 시 목록에서 항목 제거
            },
            error: function (error) {
                console.error("Error deleting file:", error);
            }
        });
    });
});
