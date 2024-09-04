<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/kim/include/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css">
<link rel="stylesheet" href="/resources/kim/css/quiz.css">

<body class="bg-white text-black min-h-screen">
	<main class="grid grid-cols-3 gap-4 mt-4">

		<!-- 왼쪽 주요 콘텐츠 영역 -->
		<section class="col-span-2 space-y-4">
			<!-- 이미지 갤러리 (최근 인기 게시물 중 사진이 포함된 게시글) -->
<div class="bg-gray-100 p-4">
    <h4 class="text-xl font-bold mb-4">오늘의 베스트 샷!</h4>
    <div class="gallery-slider-container" onmouseover="pauseSlider()" onmouseout="startSlider()">
        <div class="gallery-slider">
            <c:forEach items="${recentImages}" var="image">
                <div class="gallery-item">
                    <a href="/kim/board/read?boardNo=${image.boardNo}">
                        <img src="/kim/upload/ckDisplay?fileName=${image.uploadPath}" alt="${image.title}">
                        <div class="gallery-info">
                            <h3>
                                <c:choose>
                                    <c:when test="${fn:length(image.title) > 15}">
                                        ${fn:substring(image.title, 0, 15)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${image.title}
                                    </c:otherwise>
                                </c:choose>
                            </h3>
                            <p>댓글수: ${image.replyCount}</p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</div>


			<!-- 추천 게시물 -->
			<div class="bg-gray-100 p-4">
			    <div class="grid grid-cols-2 gap-4"> <!-- gap 값을 4로 설정하여 간격을 더 넓게 -->
			        <!-- 왼쪽 div (높은 수준의 키워드에 해당하는 게시물) -->
			        <div class="bg-gray-200 p-4">
			            <h5 class="text-xl font-bold">${leftKeyword} 찾고 계신가요?</h5>
			            <h6>(높은 선호도)</h6>
			            <div class="mt-2">
			                <c:forEach items="${leftBoardList}" var="post">
			                    <div class="flex-container">
			                        <a href="/kim/board/read?boardNo=${post.boardNo}" class="flex-item">
			                            <span>${post.title}</span>
			                        </a>
			                        <span class="text-gray-500 flex-item">${post.views}</span>
			                        <span class="text-gray-500 flex-item">
			                            <fmt:formatDate value="${post.regdate}" pattern="MM-dd" />
			                        </span>
			                    </div>
			                </c:forEach>
			            </div>
			        </div>
			
			        <!-- 오른쪽 div (낮은 수준의 키워드에 해당하는 게시물) -->
			        <div class="bg-gray-200 p-4">
			            <h5 class="text-xl font-bold">오늘은 ${rightKeyword}?</h5>
			            <h6>(낮은 선호도)</h6>
			            <div class="mt-2">
			                <c:forEach items="${rightBoardList}" var="post">
			                    <div class="flex-container">
			                        <a href="/kim/board/read?boardNo=${post.boardNo}" class="flex-item">
			                            <span>${post.title}</span>
			                        </a>
			                        <span class="text-gray-500 flex-item">${post.views}</span>
			                        <span class="text-gray-500 flex-item">
			                            <fmt:formatDate value="${post.regdate}" pattern="MM-dd" />
			                        </span>
			                    </div>
			                </c:forEach>
			            </div>
			        </div>
			    </div>
			</div>
			<!-- 3. 이미지 슬라이드 -->
			<div class="bg-gray-100 p-4">
			    <div class="image-slider-container">
			        <div class="image-slider">
			            <!-- 마지막 슬라이드의 복제본을 맨 앞에 추가 -->
			            <div class="slide">
			                <a href="https://camdoc.io/" target="_blank" rel="noopener noreferrer"><img src="/resources/kim/image/mslide1.png" alt="Slide 3"></a>
			            </div>
			            <div class="slide">
			                <a href="https://www.ocamall.com" target="_blank" rel="noopener noreferrer"><img src="/resources/kim/image/mslide2.png" alt="Slide 1"></a>
			            </div>
			            <div class="slide">
			                <a href="https://alice.lotteins.co.kr/product/trip/main" target="_blank" rel="noopener noreferrer"><img src="/resources/kim/image/mslide3.png" alt="Slide 2"></a>
			            </div>
			            <div class="slide">
			                <a href="https://camdoc.io/" target="_blank" rel="noopener noreferrer"><img src="/resources/kim/image/mslide1.png" alt="Slide 3"></a>
			            </div>
			            <!-- 첫 번째 슬라이드의 복제본을 맨 뒤에 추가 -->
			            <div class="slide">
			                <a href="https://www.ocamall.com" target="_blank" rel="noopener noreferrer"><img src="/resources/kim/image/mslide2.png" alt="Slide 1"></a>
			            </div>
			        </div>
			        <button class="prev" onclick="moveSlide(-1)">&#10094;</button>
			        <button class="next" onclick="moveSlide(1)">&#10095;</button>
			    </div>
			</div>

<!-- 4. 유저 선호도에 따른 추천 게시판 Today Best (1순위, 2순위, 3순위) -->
<div class="bg-gray-100 p-4">
    <div class="space-y-4"> <!-- 위아래 간격 조정 -->
        <!-- 1순위 게시판 -->
        <div class="bg-gray-200 p-4">
            <h5 class="text-xl font-bold">지금 ${boardTypeName1} 게시판에서 가장 Hot! 한 글이에요!</h5>
            <div class="mt-2">
                <c:forEach items="${favoriteBoard1}" var="post">
                    <div class="flex-container">
                        <a href="/kim/board/read?boardNo=${post.boardNo}" class="flex-item">
                            <span>${post.title}</span>
                        </a> 
                        <span class="text-gray-500 flex-item">${post.views}</span> 
                        <span class="text-gray-500 flex-item">
                            <fmt:formatDate value="${post.regdate}" pattern="MM-dd" />
                        </span>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div class="grid grid-cols-2 gap-4"> <!-- 2순위와 3순위를 나란히 배치 -->
            <!-- 2순위 게시판 -->
            <div class="bg-gray-200 p-4 mb-3">
                <h5 class="text-base font-bold">${boardTypeName2}게시판의 멋진글!</h5>
                <div class="mt-2">
                    <c:forEach items="${favoriteBoard2}" var="post">
                        <div class="flex-container">
                            <a href="/kim/board/read?boardNo=${post.boardNo}" class="flex-item">
                                <span>${post.title}</span>
                            </a> 
                            <span class="text-gray-500 flex-item">${post.views}</span> 
                            <span class="text-gray-500 flex-item">
                                <fmt:formatDate value="${post.regdate}" pattern="MM-dd" />
                            </span>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- 3순위 게시판 -->
            <div class="bg-gray-200 p-4">
                <h5 class="text-base font-bold">${boardTypeName3}에서 붐비는글이에요!</h5>
                <div class="mt-2">
                    <c:forEach items="${favoriteBoard3}" var="post">
                        <div class="flex-container">
                            <a href="/kim/board/read?boardNo=${post.boardNo}" class="flex-item">
                                <span>${post.title}</span>
                            </a> 
                            <span class="text-gray-500 flex-item">${post.views}</span> 
                            <span class="text-gray-500 flex-item">
                                <fmt:formatDate value="${post.regdate}" pattern="MM-dd" />
                            </span>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
			<div id="quiz-container">
			<p>3초 캠핑 상식 퀴즈 !    (문제 <span id="currentQuestionNumber">${currentQuestionNumber}</span> / <span id="totalQuestions">${totalQuestions})</span></p>
			    <div id="question-box">
			        <p></p>
			    </div>
			    <div id="question-box">    
			        <h2 id="question-text">${question}</h2>
			    </div>
			    <div id="answer-box">
			        <button id="yes-button" onclick="submitAnswer(true)">YES!</button>
			        <button id="no-button" onclick="submitAnswer(false)">NO!</button>
			    </div>
			    <div id="score-box">
			        정답 <span id="score">${score}</span> / ${totalQuestions}
			    </div>
			</div>

    </div>
</div>


		</section>

		<!-- 오른쪽 사이드바 -->
		<aside class="space-y-4">
			
			<!-- 3. 로그인 상태에 따른 유저 정보 -->
			<div class="bg-gray-100 p-4" style="display: flex; align-items: center; justify-content: center">
				<div class="flex items-center justify-between p-2 relative rounded">
					<div class="flex items-center">
						<div class="login-container">
						    <c:choose>
						        <c:when test="${not empty loginSessionDto}">
						            <!-- 로그인된 상태 -->
						            <div id="userInfo" class="user-info">
						                <span class="text-xl">닉네임: ${loginSessionDto.nickname}</span><br/>
						                <span class="text-sm">레벨: ${loginSessionDto.userlevel} | 포인트: ${loginSessionDto.point}</span>
						            </div>
						            <a href="/kim/user/logout" class="login-btn btn-warning">로그아웃</a>
						        </c:when>
						        <c:otherwise>
						            <!-- 로그아웃 상태 -->
						            <a href="/kim/user/login" class="login-btn btn-warning">로그인</a>
						            <div class="login-links">
						                <a href="/kim/user/join" class="signup-btn">회원가입</a>
						            </div>
						            <!-- 아이디/비밀번호 찾기 버튼 -->
									<div class="login-links">
									    <a href="/kim/user/findid" class="find-btn">아이디 찾기</a>
									    <a href="/kim/user/findpassword" class="find-btn">비밀번호 찾기</a>
									</div>
						        </c:otherwise>
						    </c:choose>
						</div>
					</div>
				</div>
			</div>
			
			<!-- test -->

			<!-- 이번 주 명예의 전당 -->
			<div class="bg-gray-100 p-4">
				<h2 class="text-lg font-bold">이번 주 명예의 전당</h2>
			    <ul class="mt-2 space-y-2">
			        <c:forEach items="${weeklyBestListFive}" var="post" varStatus="num">
			            <div class="flex items-center justify-between p-2 bg-gray-300 rounded">
			                <span>${num.index + 1}</span> 
			                <a class="a_bno" href="/kim/board/read?boardNo=${post.boardNo}">
			                    <span class="flex-1 ml-2">${post.title}</span>
			                </a>
			                <span class="text-gray-500">${post.views}</span>
			            </div>
			        </c:forEach>
			    </ul>
			</div> 
			
			<!-- 오늘의 인기 게시글 -->
			<div class="bg-gray-100 p-4">
				<h2 class="text-lg font-bold">오늘의 인기 게시글!</h2>
			    <ul class="mt-2 space-y-2">
			        <c:forEach items="${todayBestListFive}" var="post" varStatus="num">
			            <div class="flex items-center justify-between p-2 bg-gray-300 rounded">
			                <span>${num.index + 1}</span> 
			                <a class="a_bno" href="/kim/board/read?boardNo=${post.boardNo}">
			                    <span class="flex-1 ml-2">${post.title}</span>
			                </a>
			                <span class="text-gray-500">${post.views}</span>
			            </div>
			        </c:forEach>
			    </ul>
			</div> 
				<div class="bg-gray-100 p-4 mt-4">
				    <h2 class="text-lg font-bold">지금 이 태그가 핫해요!</h2>
				    <div class="hashtag-container mt-2">
				        <!-- 해시태그를 배치 -->
				        <a href="/tag/${popularHashtags[0].tag}" class="hashtag tag1">#${popularHashtags[0].tag}</a>
				        <a href="/tag/${popularHashtags[7].tag}" class="hashtag tag2">#${popularHashtags[7].tag}</a>
				        <a href="/tag/${popularHashtags[13].tag}" class="hashtag tag3">#${popularHashtags[13].tag}</a>
				        <a href="/tag/${popularHashtags[1].tag}" class="hashtag tag4">#${popularHashtags[1].tag}</a>
				        <a href="/tag/${popularHashtags[11].tag}" class="hashtag tag5">#${popularHashtags[11].tag}</a>
				        <a href="/tag/${popularHashtags[4].tag}" class="hashtag tag6">#${popularHashtags[4].tag}</a>
				        <a href="/tag/${popularHashtags[8].tag}" class="hashtag tag7">#${popularHashtags[8].tag}</a>
				        <a href="/tag/${popularHashtags[3].tag}" class="hashtag tag8">#${popularHashtags[3].tag}</a>
				        <a href="/tag/${popularHashtags[9].tag}" class="hashtag tag9">#${popularHashtags[9].tag}</a>
				        <a href="/tag/${popularHashtags[10].tag}" class="hashtag tag10">#${popularHashtags[10].tag}</a>
				        <a href="/tag/${popularHashtags[19].tag}" class="hashtag tag11">#${popularHashtags[19].tag}</a>
				        <a href="/tag/${popularHashtags[16].tag}" class="hashtag tag12">#${popularHashtags[16].tag}</a>
				        <a href="/tag/${popularHashtags[2].tag}" class="hashtag tag13">#${popularHashtags[2].tag}</a>
				        <a href="/tag/${popularHashtags[6].tag}" class="hashtag tag14">#${popularHashtags[6].tag}</a>
				        <a href="/tag/${popularHashtags[14].tag}" class="hashtag tag15">#${popularHashtags[14].tag}</a>
				        <a href="/tag/${popularHashtags[5].tag}" class="hashtag tag16">#${popularHashtags[5].tag}</a>
				        <a href="/tag/${popularHashtags[12].tag}" class="hashtag tag17">#${popularHashtags[12].tag}</a>
				        <a href="/tag/${popularHashtags[18].tag}" class="hashtag tag18">#${popularHashtags[18].tag}</a>
				        <a href="/tag/${popularHashtags[15].tag}" class="hashtag tag19">#${popularHashtags[15].tag}</a>
				        <a href="/tag/${popularHashtags[17].tag}" class="hashtag tag20">#${popularHashtags[17].tag}</a>
				    </div>
				</div>



		</aside>
	</main>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/resources/kim/js/indexksy.js"></script>
<script src="/resources/kim/js/quiz.js"></script>
</body>
<link rel="stylesheet" href="/resources/kim/css/indexksy.css">
<script>

/* 이미지 슬라이드 */
let slideIndex = 1;
const slides = document.querySelectorAll('.slide');
const totalSlides = slides.length;

/* 상단 갤러리 슬라이드 */

let currentTranslateX = 0;
    let sliderContainer = document.querySelector('.gallery-slider');
    let isPaused = false;
    const speed = 0.5; // 속도 설정 (숫자가 클수록 빠름)

    function animateSlider() {
        if (!isPaused) {
            currentTranslateX -= speed;
            if (Math.abs(currentTranslateX) >= sliderContainer.scrollWidth / 2) {
                currentTranslateX = 0; // 슬라이더를 처음 위치로 재설정
            }
            sliderContainer.style.transform = `translateX(\${currentTranslateX}px)`;
        }
        requestAnimationFrame(animateSlider);
    }

    function pauseSlider() {
        isPaused = true;
    }

    function startSlider() {
        isPaused = false;
    }

    document.addEventListener('DOMContentLoaded', () => {
        // 슬라이더 콘텐츠를 두 번 복제하여 추가
        const originalContent = sliderContainer.innerHTML;
        sliderContainer.innerHTML += originalContent;

        animateSlider();
        sliderContainer.addEventListener('mouseover', pauseSlider);
        sliderContainer.addEventListener('mouseout', startSlider);
    });
 
 
/* 상단 갤러리 슬라이드 */

function showSlides() {
    const slider = document.querySelector('.image-slider');
    slider.style.transform = `translateX(\${-slideIndex * 100}%)`;
    slider.style.transition = "transform 1s ease-in-out";
    
    // 마지막 슬라이드에서 첫 슬라이드로 자연스럽게 넘어가기 위한 처리
    if (slideIndex === totalSlides - 1) {
        setTimeout(() => {
            slider.style.transition = "none";  // 애니메이션 효과 제거
            slideIndex = 1;
            slider.style.transform = `translateX(\${-slideIndex * 100}%)`;
        }, 1000);  // 슬라이드 이동 후 1초 후에 위치 조정
    }

    // 첫 슬라이드에서 마지막 슬라이드로 자연스럽게 넘어가기 위한 처리
    if (slideIndex === 0) {
        setTimeout(() => {
            slider.style.transition = "none";  // 애니메이션 효과 제거
            slideIndex = totalSlides - 2;
            slider.style.transform = `translateX(\${-slideIndex * 100}%)`;
        }, 1000);  // 슬라이드 이동 후 1초 후에 위치 조정
    }
}

function moveSlide(step) {
    slideIndex += step;

    if (slideIndex >= totalSlides) {
        slideIndex = 1;
    } else if (slideIndex < 0) {
        slideIndex = totalSlides - 2;
    }

    showSlides();
}

// 자동 슬라이드 기능 추가
const autoSlideInterval = setInterval(function() {
    moveSlide(1);
}, 3000); // 3초마다 슬라이드 이동

// 초기 슬라이드 설정
showSlides();

/* 이미지 슬라이드 */

</script>

</html>
<%@ include file="/WEB-INF/views/kim/include/footer.jsp"%>
