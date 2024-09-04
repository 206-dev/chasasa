package com.teamproject.www.kim.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamproject.www.common.domain.LoginSessionDto;
import com.teamproject.www.kim.domain.AttachBoardDto;
import com.teamproject.www.kim.domain.HashtagDto;
import com.teamproject.www.kim.domain.InformationBoardVo;
import com.teamproject.www.kim.domain.InformationCriteria;
import com.teamproject.www.kim.domain.InformationPageDto;
import com.teamproject.www.kim.domain.MainPageImageDto;
import com.teamproject.www.kim.domain.QuizResponse;
import com.teamproject.www.kim.mapper.AttachMapper;
import com.teamproject.www.kim.service.BoardService;
import com.teamproject.www.kim.service.QuizService;
import com.teamproject.www.kim.service.UserService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller("kimBoardController")
@RequestMapping("/kim/board/*")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
    private AttachMapper attachMapper;
	
	@Autowired
	private UserService userService;
	
	@Autowired
    private QuizService quizService;
	
//	// 메인게시판
//	@GetMapping("/main")
//	public String main(Model model, 
//	        @SessionAttribute("loginSessionDto") LoginSessionDto loginSession, HttpSession session) {
//		String userId = loginSession.getUserid();
//		
//		// QuizService 초기화
//        if (session.getAttribute("quizService") == null) {
//            session.setAttribute("quizService", new QuizService());
//        }
//        QuizService userQuizService = (QuizService) session.getAttribute("quizService");
//
//        // 퀴즈 초기화 정보 전달
//        model.addAttribute("question", userQuizService.getCurrentQuestion().getQuestion());
//        model.addAttribute("currentQuestionNumber", userQuizService.getCurrentQuestionNumber());
//        model.addAttribute("totalQuestions", userQuizService.getTotalQuestions());
//        model.addAttribute("score", userQuizService.getScore());
//		
//		// 유저 선호도에 따른 1순위, 2순위, 3순위 게시판 가져오기
//        List<InformationBoardVo> favoriteBoard1 = boardService.getFavoriteBoard(userId, 1);
//        List<InformationBoardVo> favoriteBoard2 = boardService.getFavoriteBoard(userId, 2);
//        List<InformationBoardVo> favoriteBoard3 = boardService.getFavoriteBoard(userId, 3);
//        
//        model.addAttribute("favoriteBoard1", favoriteBoard1);
//        model.addAttribute("favoriteBoard2", favoriteBoard2);
//        model.addAttribute("favoriteBoard3", favoriteBoard3);
//        
//        
//        // 선호 게시판 1, 2, 3 head
//        // 선호 게시판 타입 얻기
//        int boardType1 = boardService.getBoardTypeByRank(userId, 1);
//        int boardType2 = boardService.getBoardTypeByRank(userId, 2);
//        int boardType3 = boardService.getBoardTypeByRank(userId, 3);
//
//        // 게시판 이름 얻기
//        String boardTypeName1 = boardService.getBoardTypeName(boardType1);
//        String boardTypeName2 = boardService.getBoardTypeName(boardType2);
//        String boardTypeName3 = boardService.getBoardTypeName(boardType3);
//
//        // JSP로 전달
//        model.addAttribute("boardTypeName1", boardTypeName1);
//        model.addAttribute("boardTypeName2", boardTypeName2);
//        model.addAttribute("boardTypeName3", boardTypeName3);
//		// 선호 게시판 1, 2, 3 head
//        
//        
//		// 두 개의 랜덤 키워드를 선정
//        List<String> randomKeywords = boardService.getRandomKeywords(userId);
//
//        // 키워드에 해당하는 게시물 리스트 가져오기
//        List<InformationBoardVo> leftBoardList = boardService.getPostsByKeyword(userId, randomKeywords.get(0));
//        List<InformationBoardVo> rightBoardList = boardService.getPostsByKeyword(userId, randomKeywords.get(1));
//
//        model.addAttribute("leftBoardList", leftBoardList);
//        model.addAttribute("rightBoardList", rightBoardList);
//        model.addAttribute("leftKeyword", randomKeywords.get(0));
//        model.addAttribute("rightKeyword", randomKeywords.get(1));
//        // 메인페이지 사진 추가
//        List<MainPageImageDto> images = boardService.getRecentBoardImages();
//        model.addAttribute("recentImages", images);
//	    
//	    // 주간 베스트 게시물 리스트 추가
//	    List<InformationBoardVo> weeklyBestList = boardService.getWeeklyBest();
//	    model.addAttribute("weeklyBestList", weeklyBestList);
//	    
//	    // 이번 주 명예의 전당 게시물 리스트 추가
//        List<InformationBoardVo> weeklyBestListFive = boardService.getWeeklyBestListFive();
//        model.addAttribute("weeklyBestListFive", weeklyBestListFive);
//
//        // 오늘의 인기 게시물 리스트 추가
//        List<InformationBoardVo> todayBestListFive = boardService.getTodayBestListFive();
//        model.addAttribute("todayBestListFive", todayBestListFive);
//        // 인기 해시태그 가져오기
//        List<HashtagDto> popularHashtags = boardService.getPopularHashtags();
//        model.addAttribute("popularHashtags", popularHashtags);
//	    
//	    
//	    return "kim/board/main";
//	}
//	
//	@PostMapping("/quiz/answer")
//    @ResponseBody
//    public QuizResponse answerQuiz(@RequestParam("answer") boolean answer, HttpSession session) {
//        QuizService userQuizService = (QuizService) session.getAttribute("quizService");
//
//        userQuizService.answerQuestion(answer);
//
//        if (userQuizService.hasNextQuestion()) {
//            return new QuizResponse(
//                userQuizService.getCurrentQuestion().getQuestion(),
//                userQuizService.getCurrentQuestionNumber(),
//                userQuizService.getTotalQuestions(),
//                userQuizService.getScore(),
//                true,
//                null, // 메시지 초기화
//                null,  // 링크 초기화
//                null // boardtype 초기화
//            );
//        } else {
//            // 퀴즈가 종료되면 세션 초기화
//            session.removeAttribute("quizService");
//            
//            // 정답 개수에 따른 메시지와 링크 설정
//            String message;
//            String link;
//            String boardtype;
//            
//            int score = userQuizService.getScore();
//            
//            if (score == 1) {
//                message = "초보 캠퍼시군요 공지게시판에서 캠핑가이드를 읽어보세요!";
//                link = "/jang/board/notice/list";
//                boardtype = "공지";
//            } else if (score == 2) {
//                message = "뭘 좀 아시는군요? 정보게시판에서 노하우를 상승시켜봐요!";
//                link = "/kim/board/info";
//                boardtype = "정보"; 
//            } else if (score == 3) {
//                message = "캠핑 고수님..! 자유게시판에서 마음껏 소통해보세요!";
//                link = "/lee/board/list/free";
//                boardtype = "자유";
//            } else {
//                message = "환영합니다! 우리 캠핑에대해 차근차근 알아가봐요!";
//                link = "/kim/board/info"; // 기본 링크
//                boardtype = "정보";
//            }
//            
//            return new QuizResponse(
//                "퀴즈 완료! 캠핑에 대해 어느정도 알고 계시군요!",
//                userQuizService.getCurrentQuestionNumber(),
//                userQuizService.getTotalQuestions(),
//                userQuizService.getScore(),
//                false,
//                message,
//                link,
//                boardtype
//            );
//        }
//    }
//
//
//
//	
//	@GetMapping("/tag/{tag}")
//    public String redirectToRandomPostWithTag(@PathVariable("tag") String tag, Model model) {
//        Integer boardNo = boardService.getRandomPostBoardNoByTag(tag);
//        if (boardNo != null) {
//            return "redirect:/kim/board/read?boardNo=" + boardNo; // 랜덤으로 선택된 게시물로 리다이렉트
//        } else {
//            model.addAttribute("message", "해당 태그를 포함한 게시물을 찾을 수 없습니다.");
//            return "kim/board/main"; // 게시물이 없을 경우 메인으로 돌아감
//        }
//    }
	



	// 정보공유 게시판 (김세영)
	@GetMapping("/info")
	public String informationBoard(Model model, InformationCriteria criteria,
	        @RequestParam(value = "type", required = false) String type,
	        @RequestParam(value = "keyword", required = false) String keyword,
	        @RequestParam(value = "sort", required = false) String sort, 
	        @RequestParam(value = "category", required = false) String category,
	        HttpSession session) {
		
		System.out.println("Criteria: " + criteria.toString());
		
//	    String userid = (String) session.getAttribute("userid");
//	    if (userid != null) {
//	    	System.out.println("세션을 고칠 유저id" + userid);
//	        UserVo user = userService.getUserById(userid);
//	        
//	        if (user != null) {
//	            session.setAttribute("userlevel", user.getUserLevel());
//	            session.setAttribute("point", user.getPoint());
//	        }
//	    }
		
		// 조건이 변경될 때 페이지 번호를 1로 리셋
	    if (category != null && !category.equals(criteria.getCategory())) {
	        criteria.setPageNum(1);
	    }

		
	    if (criteria.getPageNum() == 0) {
	        criteria.setPageNum(1);
	    }
	    if (criteria.getAmount() == 0) {
	        criteria.setAmount(10);
	    }
	    
	    
	   
	    criteria.setType(type);
	    criteria.setKeyword(keyword);
	    criteria.setSort(sort);
	    criteria.setCategory(category);

	    List<InformationBoardVo> list = boardService.getListKsy(criteria);
	    int total = boardService.getTotalKsy(criteria);
	    InformationPageDto pageMaker = new InformationPageDto(criteria, total);
	    model.addAttribute("list", list);
	    model.addAttribute("pageMaker", pageMaker);
	    model.addAttribute("criteria", criteria);
	    
	    // 주간 베스트 게시물 리스트 추가
	    List<InformationBoardVo> weeklyBestList = boardService.getWeeklyBest();
        model.addAttribute("weeklyBestList", weeklyBestList);
        
        // 오늘의 BEST 게시물 리스트 추가
        List<InformationBoardVo> todayBestList = boardService.getTodayBest();
        model.addAttribute("todayBestList", todayBestList);
        
        // 상단 공지 2개 가져오기
        List<InformationBoardVo> latestAnnounce = boardService.getLatestAnnounce();
        model.addAttribute("latestAnnounce", latestAnnounce);
        
		return "kim/board/info";
        
        
	}

	// **김세영 글쓰기 폼**
	@GetMapping("/write")
	public void write(Model model) {
		
		// 주간 베스트 게시물 리스트 추가
	    List<InformationBoardVo> weeklyBestList = boardService.getWeeklyBest();
        model.addAttribute("weeklyBestList", weeklyBestList);
	}
	
	// 김세영 글쓰기 처리
	@PostMapping("/writeRun")
	public String writeRun(InformationBoardVo vo, 
			@RequestParam("content") String content, 
	                      @RequestParam("category") String category,
	                      RedirectAttributes rttr, 
	                      HttpSession session) { 
		
	    System.out.println("메서드 호출됨");
	    log.info("Received Content: " + vo.getContent());
	    
	    // 불필요한 <p> 태그와 쉼표 제거
	    content = content.replaceAll("^\\s*,\\s*<p>|</p>$", "").replaceAll("<p>\\s*</p>", "").trim();

	    // 클렌징 후 content를 vo에 다시 설정
	    vo.setContent(content);

	    log.info("Received Content After Cleansing: " + vo.getContent());
	    
	    // 선택한 카테고리를 제목 앞에 붙임
	    String fullTitle = "[" + category + "] " + vo.getTitle();
	    vo.setTitle(fullTitle);

	    // 게시물 등록
	    Long boardNo = boardService.write(vo);

	    // 세션에 저장된 CKEditor 이미지 정보를 처리
	    List<AttachBoardDto> ckeditorImages = (List<AttachBoardDto>) session.getAttribute("ckeditorImages");

	    if (ckeditorImages != null) {
	        for (AttachBoardDto dto : ckeditorImages) {
	            dto.setBoardNo(boardNo);
	            attachMapper.insertKsy(dto);
	        }
	        session.removeAttribute("ckeditorImages");
	    }

	    rttr.addFlashAttribute("resultWriter", boardNo);
	    return "redirect:/kim/board/read?boardNo=" + boardNo;
	}
	
	//해시태그 검색
	@GetMapping("/hashtagCount")
    @ResponseBody
    public Map<String, Integer> getHashtagCount(@RequestParam("hashtag") String hashtag) {
		System.out.println(hashtag);
        int count = boardService.countPostsByHashtag(hashtag);
        Map<String, Integer> result = new HashMap<>();
        result.put("count", count);
        return result;
    }

	
	// 김세영 글읽기
	@GetMapping("/read")
	public String read(@RequestParam("boardNo") Long boardNo, @ModelAttribute InformationCriteria criteria, Model model, 
			@RequestParam(value = "type", required = false) String type,
	        @RequestParam(value = "keyword", required = false) String keyword,
	        @RequestParam(value = "sort", required = false) String sort, 
	        @RequestParam(value = "category", required = false) String category,
	        HttpSession session,
	        InformationBoardVo vo) {
		InformationBoardVo boardVo = boardService.get(boardNo);
		

		
		
		model.addAttribute("boardVo", boardVo);
		
		
		criteria.setType(type);
	    criteria.setKeyword(keyword);
	    criteria.setSort(sort);
	    criteria.setCategory(category);
	    
	    boolean result = boardService.modifyReadcnt(boardNo);
	    boardVo.setViews(boardVo.getViews() + 1);
		log.info("조회수 증가됨");
        
        // 게시판 리스트 불러오기
	    List<InformationBoardVo> list = boardService.getListKsy(criteria);
	    int total = boardService.getTotalKsy(criteria);
	    InformationPageDto pageMaker = new InformationPageDto(criteria, total);
	    model.addAttribute("list", list);
	    model.addAttribute("pageMaker", pageMaker);
	    model.addAttribute("criteria", criteria);
        
	    // 주간 베스트 게시물 리스트 추가
	    List<InformationBoardVo> weeklyBestList = boardService.getWeeklyBest();
	    model.addAttribute("weeklyBestList", weeklyBestList);
	    
        return "kim/board/read";
	}
	
	// 김세영 글 수정페이지로 이동
	@GetMapping("/modifyForm")
	public String modifyForm(@RequestParam("boardNo") Long boardNo, Model model) {
	    
		InformationBoardVo boardVo = boardService.get(boardNo);
		
		// 제목에서 카테고리 추출하기 (제목의 맨 앞에 있는 카테고리만 추출)
        String title = boardVo.getTitle();
        String category = "";
        String modifiedTitle = title;  // 카테고리를 제거한 제목
        if (title.startsWith("[") && title.indexOf("]") > 1) {
            category = title.substring(1, title.indexOf("]"));
            modifiedTitle = title.substring(title.indexOf("]") + 1).trim();
        }
        
     // 수정된 제목을 boardVo에 설정
        boardVo.setTitle(modifiedTitle);
	    
	    
	    model.addAttribute("boardVo", boardVo);
	    model.addAttribute("category", category); 
	    
	 // 주간 베스트 게시물 리스트 추가
	    List<InformationBoardVo> weeklyBestList = boardService.getWeeklyBest();
	    model.addAttribute("weeklyBestList", weeklyBestList);
	    return "kim/board/modify";
	}
	
	
	
	@PostMapping("/modify")
	public String modify(InformationBoardVo vo, @RequestParam("content") String content, @RequestParam("category") String category, RedirectAttributes rttr, HttpSession session) {
		
		System.out.println("Content: " + vo.getContent());
		
	    // 현재 제목에서 기존의 대괄호와 카테고리를 제거
	    String title = vo.getTitle();
	    if (title.startsWith("[") && title.contains("]")) {
	        title = title.substring(title.indexOf("]") + 1).trim();
	    }

	    // 새로운 카테고리와 제목 결합
	    String fullTitle = category + " " + title;
	    vo.setTitle(fullTitle);
	    
	    // 불필요한 <p> 태그와 쉼표 제거
	    content = content.replaceAll("^\\s*,\\s*<p>|</p>$", "").replaceAll("<p>\\s*</p>", "").trim();

	    // 클렌징 후 content를 vo에 다시 설정
	    vo.setContent(content);
	    
	    // 글 수정 처리
	    Long boardNo = boardService.modify(vo);
	    
	    // CKEditor 이미지 파일 처리
	    List<AttachBoardDto> ckeditorImages = (List<AttachBoardDto>) session.getAttribute("ckeditorImages");
	    if (ckeditorImages != null) {
	        for (AttachBoardDto dto : ckeditorImages) {
	            dto.setBoardNo(boardNo);  // 게시글 번호 설정
	            attachMapper.insertKsy(dto);  // 이미지 정보 삽입
	        }
	        session.removeAttribute("ckeditorImages");  // 세션에서 이미지 정보 제거
	    }
	    
	    // 수정 결과를 리다이렉트 속성에 추가하고, 상세보기 페이지로 리다이렉트
	    rttr.addFlashAttribute("resultModify", boardNo);
	    return "redirect:/kim/board/read?boardNo=" + boardNo;
	}
	
    // 김세영 글 삭제
    @PostMapping("/delete")
    public String delete(@RequestParam Long boardNo, RedirectAttributes rttr) {
        boardService.delete(boardNo);
        rttr.addFlashAttribute("resultDelete", boardNo);
        return "redirect:/kim/board/info"; // 삭제 후 게시글 목록 페이지로 리디렉션
    }
    //테스트 데이터
//    @GetMapping("/likedWordFrequency")
//    public String getLikedWordFrequency(@RequestParam("userid") String userid, Model model) {
//        Map<String, Integer> wordFrequency = boardService.getMostFrequentWords(userid);
//        model.addAttribute("wordFrequency", wordFrequency);
//        return "kim/board/wordFrequencyView"; // JSP 또는 템플릿 엔진에 결과를 렌더링
//    }

}
