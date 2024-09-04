import {
	ClassicEditor,
	AccessibilityHelp,
	Alignment,
	Autoformat,
	AutoImage,
	Autosave,
	BalloonToolbar,
	Bold,
	CodeBlock,
	Essentials,
	FontBackgroundColor,
	FontColor,
	FontFamily,
	FontSize,
	GeneralHtmlSupport,
	Heading,
	ImageBlock,
	ImageCaption,
	ImageInline,
	ImageInsert,
	ImageInsertViaUrl,
	ImageResize,
	ImageStyle,
	ImageTextAlternative,
	ImageToolbar,
	ImageUpload,
	Italic,
	List,
	ListProperties,
	Paragraph,
	SelectAll,
	ShowBlocks,
	SimpleUploadAdapter,
	SpecialCharacters,
	Strikethrough,
	Table,
	TableCaption,
	TableCellProperties,
	TableColumnResize,
	TableProperties,
	TableToolbar,
	TextTransformation,
	Underline,
	Undo
} from 'ckeditor5';

import translations from 'ckeditor5/translations/ko.js';

const editorConfig = {
	toolbar: {
		items: [
			'undo',
			'redo',
			'|',
			'showBlocks',
			'selectAll',
			'|',
			'heading',
			'|',
			'fontSize',
			'fontFamily',
			'fontColor',
			'fontBackgroundColor',
			'|',
			'bold',
			'italic',
			'underline',
			'strikethrough',
			'|',
			'specialCharacters',
			'insertImage',
			'insertTable',
			'codeBlock',
			'|',
			'alignment',
			'|',
			'bulletedList',
			'numberedList',
			'|',
			'accessibilityHelp'
		],
		shouldNotGroupWhenFull: false
	},
	plugins: [
		AccessibilityHelp,
		Alignment,
		Autoformat,
		AutoImage,
		Autosave,
		BalloonToolbar,
		Bold,
		CodeBlock,
		Essentials,
		FontBackgroundColor,
		FontColor,
		FontFamily,
		FontSize,
		GeneralHtmlSupport,
		Heading,
		ImageBlock,
		ImageCaption,
		ImageInline,
		ImageInsert,
		ImageInsertViaUrl,
		ImageResize,
		ImageStyle,
		ImageTextAlternative,
		ImageToolbar,
		ImageUpload,
		Italic,
		List,
		ListProperties,
		Paragraph,
		SelectAll,
		ShowBlocks,
		SimpleUploadAdapter,
		SpecialCharacters,
		Strikethrough,
		Table,
		TableCaption,
		TableCellProperties,
		TableColumnResize,
		TableProperties,
		TableToolbar,
		TextTransformation,
		Underline,
		Undo
	],
	balloonToolbar: ['bold', 'italic', '|', 'insertImage', '|', 'bulletedList', 'numberedList'],
	fontFamily: {
		supportAllValues: true
	},
	fontSize: {
		options: [10, 12, 14, 'default', 18, 20, 22],
		supportAllValues: true
	},
	heading: {
		options: [
			{
				model: 'paragraph',
				title: 'Paragraph',
				class: 'ck-heading_paragraph'
			},
			{
				model: 'heading1',
				view: 'h1',
				title: 'Heading 1',
				class: 'ck-heading_heading1'
			},
			{
				model: 'heading2',
				view: 'h2',
				title: 'Heading 2',
				class: 'ck-heading_heading2'
			},
			{
				model: 'heading3',
				view: 'h3',
				title: 'Heading 3',
				class: 'ck-heading_heading3'
			},
			{
				model: 'heading4',
				view: 'h4',
				title: 'Heading 4',
				class: 'ck-heading_heading4'
			},
			{
				model: 'heading5',
				view: 'h5',
				title: 'Heading 5',
				class: 'ck-heading_heading5'
			},
			{
				model: 'heading6',
				view: 'h6',
				title: 'Heading 6',
				class: 'ck-heading_heading6'
			}
		]
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
			'toggleImageCaption',
			'imageTextAlternative',
			'|',
			'imageStyle:inline',
			'imageStyle:wrapText',
			'imageStyle:breakText',
			'|',
			'resizeImage'
		]
	},
	simpleUpload: {
        uploadUrl: '/jang/upload/image', // 이미지 업로드 엔드포인트 설정
        headers: {
            // CSRF 토큰 또는 인증 헤더 추가 (필요 시)
            'X-CSRF-TOKEN': 'CSRF-Token',
            Authorization: 'Bearer <JSON Web Token>'
        }
    },
	initialData:'',
	list: {
		properties: {
			styles: true,
			startIndex: true,
			reversed: true
		}
	},
	placeholder: '내용을 입력하세요',
	table: {
		contentToolbar: ['tableColumn', 'tableRow', 'mergeTableCells', 'tableProperties', 'tableCellProperties']
	},
	translations: [translations]
};

 function adjustCkEditorWidth() {
    $('.ck-editor').each(function() {
        var $td = $(this).closest('td');
        var tdWidth = $td.width();
        $(this).css('width', tdWidth + 'px');
    });
}
        

window.ClassicEditor = ClassicEditor;


ClassicEditor
	.create(document.querySelector('#editor'), editorConfig)
	.then(editor => {
	
			// 초기 설정
            adjustCkEditorWidth();
            
			// 에디터를 전역변수로 사용
			window.editor = editor;
			
            // 윈도우 크기 변화 시 설정
            $(window).resize(function() {
                adjustCkEditorWidth();
            });

            // 스타일 추가
            $('style').append(`
                .ck-editor { width: 100%; }
                .notice-detail-wrapper {
                    width: 100%;
                    overflow-x: auto;
                    box-sizing: border-box;
                }
                .notice-detail {
                    width: 100%;
                    table-layout: fixed;
                }
                @media (min-width: 768px) {
                    .ck-editor { max-width: 100%; }
                }
                @media (max-width: 767px) {
                    .ck-editor { width: 100%; }
                }
            `);
            
            // 툴바 변수지정
            const toolbarElement = editor.ui.view.toolbar.element;
            
            // readonly에 따라 툴바 display 설정
            editor.on( 'change:isReadOnly', ( evt, propertyName, isReadOnly ) => {
            if ( isReadOnly ) {
                toolbarElement.style.display = 'none';
            } else {
                toolbarElement.style.display = 'flex';
            }
            
        } );
            
        }) // then
	.catch(error => {console.error(error);
	});

