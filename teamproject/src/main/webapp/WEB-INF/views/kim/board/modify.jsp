<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/kim/include/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css">
<link rel="stylesheet" href="/resources/kim/css/indexksy.css">
<link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/42.0.2/ckeditor5.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="importmap">
    {
        "imports": {
            "ckeditor5": "https://cdn.ckeditor.com/ckeditor5/42.0.2/ckeditor5.js",
            "ckeditor5/": "https://cdn.ckeditor.com/ckeditor5/42.0.2/"
        }
    }
</script>

<script src="/resources/kim/js/indexksy.js"></script>
<script type="module" src="/resources/kim/js/ckeditor.js"></script>

<body class="bg-white text-black min-h-screen p-4">
    <main class="grid grid-cols-3 gap-4 mt-4">
        <section class="col-span-2 space-y-4">
            <form id="frmRegister" role="form" action="/kim/board/modify" method="post">
            	<input type="hidden" id="boardNo" name="boardNo" value="${boardVo.boardNo}" />
                <input type="hidden" id="content" name="content" required>
                <div class="bg-gray-100 p-4">
                    <select name="category" id="category" class="bg-gray-300 p-2 rounded">
					    <option value="[음식]" ${category == '음식' ? 'selected' : ''}>음식</option>
					    <option value="[자동차]" ${category == '자동차' ? 'selected' : ''}>자동차</option>
					    <option value="[장소]" ${category == '장소' ? 'selected' : ''}>장소</option>
					    <option value="[핫딜]" ${category == '핫딜' ? 'selected' : ''}>핫딜</option>
					    <option value="[행사]" ${category == '행사' ? 'selected' : ''}>행사</option>
					</select>
                </div>
                <div class="bg-gray-100 p-4">
                    <input type="text" id="title" name="title" placeholder="제목을 입력하세요"
                        class="w-full p-2 rounded" value="${boardVo.title}" required>
                </div>
                
                <div>
                    <div class="main-containerck">
                        <div class="editor-container editor-container_classic-editor" id="editor-container">
                            <div class="editor-container__editor"><div id="editor">${boardVo.content}</div></div>
                        </div>
                    </div>
                </div>
                
                <div class="bigPictureWrapper">
                    <div class="bigPicture"></div>
                </div>
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">첨부 파일</h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12">
                                <input type="file" id="fileInput" style="display: none;" multiple>
                                <div id="divDrop">
                                    <p>파일을 드래그 & 드롭 하거나 클릭하여 업로드하세요.</p>
                                </div>
                                <ul id="uploadedList" class="mt-4"></ul>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bg-gray-100 p-4 flex justify-end space-x-4">
                    <button type="submit" class="bg-yellow-500 text-black px-4 py-2 rounded">수정완료</button>
                    <a href="/kim/board/info" type="reset" class="bg-gray-500 text-black px-4 py-2 rounded">취소</a>
                </div>
            </form>
        </section>
        <aside class="space-y-4">
            <div class="bg-gray-100 p-4">
				<div class="flex items-center justify-between p-2 bg-gray-300 rounded">
					<div class="ml-6 flex items-center">
						<div class="login-container">
							<div id="userInfo" class="user-info">
								<span class="text-xl">닉네임: ${loginSessionDto.nickname}</span><br />
								<span class="text-sm">레벨: ${loginSessionDto.userlevel} |
									포인트: ${loginSessionDto.point}</span>
							</div>
							<a href="/kim/user/logout" class="login-btn btn-warning">로그아웃</a>
						</div>
					</div>
				</div>
				<div class="mt-4 grid grid-cols-3 gap-2 text-center">
                </div>
            </div>
            <div class="bg-gray-100 p-4">
                <h2 class="text-lg font-bold">주간 정보게시판 BEST</h2>
                <ul class="mt-2 space-y-2">
                    <c:forEach items="${weeklyBestList}" var="boardVo" varStatus="num">
                        <div class="flex items-center justify-between p-2 bg-gray-300 rounded">
                            <span>${num.index + 1}</span> 
                            <a class="a_bno" href="/kim/board/read?boardNo=${boardVo.boardNo}">
                                <span class="flex-1 ml-2">${boardVo.title}</span>
                            </a>
                            <span class="text-gray-500">${boardVo.views}</span>
                        </div>
                    </c:forEach>
                </ul>
            </div>
        </aside>
    </main>
</body>
<%@ include file="/WEB-INF/views/kim/include/footer.jsp"%>
