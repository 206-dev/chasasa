import translations from 'ckeditor5/translations/ko.js';

let editor;

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
        withCredentials: true,
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
    translations: [translations]
    //,readOnly: true // 읽기 전용 모드 설정
};

document.addEventListener('DOMContentLoaded', () => {
    ClassicEditor.create(document.querySelector('#editor'), editorConfig)
        .then(newEditor => {
            editor = newEditor;
            window.editor = editor;
            console.log('Editor was initialized', editor);
           
        })
        .catch(error => {
            //console.error(error.stack);
        });
});







