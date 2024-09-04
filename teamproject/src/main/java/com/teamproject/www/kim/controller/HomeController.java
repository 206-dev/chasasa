package com.teamproject.www.kim.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.teamproject.www.common.domain.LoginSessionDto;
import com.teamproject.www.kim.domain.HashtagDto;
import com.teamproject.www.kim.domain.InformationBoardVo;
import com.teamproject.www.kim.domain.MainPageImageDto;
import com.teamproject.www.kim.domain.QuizResponse;
import com.teamproject.www.kim.service.BoardService;
import com.teamproject.www.kim.service.QuizService;

@Controller
@RequestMapping(value = "/", method = RequestMethod.GET)
public class HomeController {
	
	@Autowired
	private BoardService boardService;

	// 메인게시판
	@GetMapping("/")
	public String main(Model model, HttpSession session) {
		LoginSessionDto loginSession = (LoginSessionDto) session.getAttribute("loginSessionDto");
    	String userId = loginSession != null ? loginSession.getUserid() : null;
		
		// QuizService 초기화
        if (session.getAttribute("quizService") == null) {
            session.setAttribute("quizService", new QuizService());
        }
	        QuizService userQuizService = (QuizService) session.getAttribute("quizService");
	
	        // 퀴즈 초기화 정보 전달
	        model.addAttribute("question", userQuizService.getCurrentQuestion().getQuestion());
	        model.addAttribute("currentQuestionNumber", userQuizService.getCurrentQuestionNumber());
	        model.addAttribute("totalQuestions", userQuizService.getTotalQuestions());
	        model.addAttribute("score", userQuizService.getScore());
			
	        if (userId != null) {
	
			// 유저 선호도에 따른 1순위, 2순위, 3순위 게시판 가져오기
	        List<InformationBoardVo> favoriteBoard1 = boardService.getFavoriteBoard(userId, 1);
	        List<InformationBoardVo> favoriteBoard2 = boardService.getFavoriteBoard(userId, 2);
	        List<InformationBoardVo> favoriteBoard3 = boardService.getFavoriteBoard(userId, 3);
	        
	        
	        
	        model.addAttribute("favoriteBoard1", favoriteBoard1);
	        model.addAttribute("favoriteBoard2", favoriteBoard2);
	        model.addAttribute("favoriteBoard3", favoriteBoard3);
	        
	        
	        
	        // 선호 게시판 1, 2, 3 head
	        // 선호 게시판 타입 얻기
	        int boardType1 = boardService.getBoardTypeByRank(userId, 1);
	        int boardType2 = boardService.getBoardTypeByRank(userId, 2);
	        int boardType3 = boardService.getBoardTypeByRank(userId, 3);
	
	        // 게시판 이름 얻기
	        String boardTypeName1 = boardService.getBoardTypeName(boardType1);
	        String boardTypeName2 = boardService.getBoardTypeName(boardType2);
	        String boardTypeName3 = boardService.getBoardTypeName(boardType3);
	
	        // JSP로 전달
	        model.addAttribute("boardTypeName1", boardTypeName1);
	        model.addAttribute("boardTypeName2", boardTypeName2);
	        model.addAttribute("boardTypeName3", boardTypeName3);
			// 선호 게시판 1, 2, 3 head
	        
	        
			// 두 개의 랜덤 키워드를 선정
	        List<String> randomKeywords = boardService.getRandomKeywords(userId);
	
	        // 키워드에 해당하는 게시물 리스트 가져오기
	        List<InformationBoardVo> leftBoardList = boardService.getPostsByKeyword(userId, randomKeywords.get(0));
	        List<InformationBoardVo> rightBoardList = boardService.getPostsByKeyword(userId, randomKeywords.get(1));
	
	        model.addAttribute("leftBoardList", leftBoardList);
	        model.addAttribute("rightBoardList", rightBoardList);
	        model.addAttribute("leftKeyword", randomKeywords.get(0));
	        model.addAttribute("rightKeyword", randomKeywords.get(1));
        } else {
        	String guest = "guest";
        	// 유저 선호도에 따른 1순위, 2순위, 3순위 게시판 가져오기
	        List<InformationBoardVo> favoriteBoard1 = boardService.getFavoriteBoard(guest, 1);
	        List<InformationBoardVo> favoriteBoard2 = boardService.getFavoriteBoard(guest, 2);
	        List<InformationBoardVo> favoriteBoard3 = boardService.getFavoriteBoard(guest, 3);
	        
	        model.addAttribute("favoriteBoard1", favoriteBoard1);
	        model.addAttribute("favoriteBoard2", favoriteBoard2);
	        model.addAttribute("favoriteBoard3", favoriteBoard3);
	        
	        
	        // 선호 게시판 1, 2, 3 head
	        // 선호 게시판 타입 얻기
	        int boardType1 = boardService.getBoardTypeByRank(guest, 1);
	        int boardType2 = boardService.getBoardTypeByRank(guest, 2);
	        int boardType3 = boardService.getBoardTypeByRank(guest, 3);
	
	        // 게시판 이름 얻기
	        String boardTypeName1 = boardService.getBoardTypeName(boardType1);
	        String boardTypeName2 = boardService.getBoardTypeName(boardType2);
	        String boardTypeName3 = boardService.getBoardTypeName(boardType3);
	
	        // JSP로 전달
	        model.addAttribute("boardTypeName1", boardTypeName1);
	        model.addAttribute("boardTypeName2", boardTypeName2);
	        model.addAttribute("boardTypeName3", boardTypeName3);
			// 선호 게시판 1, 2, 3 head
	        
	        
			// 두 개의 랜덤 키워드를 선정
	        List<String> randomKeywords = boardService.getRandomKeywords(guest);
	
	        // 키워드에 해당하는 게시물 리스트 가져오기
	        List<InformationBoardVo> leftBoardList = boardService.getPostsByKeyword(guest, randomKeywords.get(0));
	        List<InformationBoardVo> rightBoardList = boardService.getPostsByKeyword(guest, randomKeywords.get(1));
	
	        model.addAttribute("leftBoardList", leftBoardList);
	        model.addAttribute("rightBoardList", rightBoardList);
	        model.addAttribute("leftKeyword", randomKeywords.get(0));
	        model.addAttribute("rightKeyword", randomKeywords.get(1));
        }
        // 메인페이지 사진 추가
        List<MainPageImageDto> images = boardService.getRecentBoardImages();
        model.addAttribute("recentImages", images);
	    
	    // 주간 베스트 게시물 리스트 추가
	    List<InformationBoardVo> weeklyBestList = boardService.getWeeklyBest();
	    model.addAttribute("weeklyBestList", weeklyBestList);
	    
	    // 이번 주 명예의 전당 게시물 리스트 추가
        List<InformationBoardVo> weeklyBestListFive = boardService.getWeeklyBestListFive();
        model.addAttribute("weeklyBestListFive", weeklyBestListFive);

        // 오늘의 인기 게시물 리스트 추가
        List<InformationBoardVo> todayBestListFive = boardService.getTodayBestListFive();
        model.addAttribute("todayBestListFive", todayBestListFive);
        // 인기 해시태그 가져오기
        List<HashtagDto> popularHashtags = boardService.getPopularHashtags();
        model.addAttribute("popularHashtags", popularHashtags);
	    
	    
	    return "kim/board/main";
	}
	
	@PostMapping("/quiz/answer")
    @ResponseBody
    public QuizResponse answerQuiz(@RequestParam("answer") boolean answer, HttpSession session) {
        QuizService userQuizService = (QuizService) session.getAttribute("quizService");

        userQuizService.answerQuestion(answer);

        if (userQuizService.hasNextQuestion()) {
            return new QuizResponse(
                userQuizService.getCurrentQuestion().getQuestion(),
                userQuizService.getCurrentQuestionNumber(),
                userQuizService.getTotalQuestions(),
                userQuizService.getScore(),
                true,
                null, // 메시지 초기화
                null,  // 링크 초기화
                null // boardtype 초기화
            );
        } else {
            // 퀴즈가 종료되면 세션 초기화
            session.removeAttribute("quizService");
            
            // 정답 개수에 따른 메시지와 링크 설정
            String message;
            String link;
            String boardtype;
            
            int score = userQuizService.getScore();
            
            if (score == 1) {
                message = "초보 캠퍼시군요 공지게시판에서 캠핑가이드를 읽어보세요!";
                link = "/jang/board/notice/list";
                boardtype = "공지";
            } else if (score == 2) {
                message = "뭘 좀 아시는군요? 정보게시판에서 노하우를 상승시켜봐요!";
                link = "/kim/board/info";
                boardtype = "정보"; 
            } else if (score == 3) {
                message = "캠핑 고수님..! 자유게시판에서 마음껏 소통해보세요!";
                link = "/lee/board/list/free";
                boardtype = "자유";
            } else {
                message = "환영합니다! 우리 캠핑에대해 차근차근 알아가봐요!";
                link = "/kim/board/info"; // 기본 링크
                boardtype = "정보";
            }
            
            return new QuizResponse(
                "퀴즈 완료! 캠핑에 대해 어느정도 알고 계시군요!",
                userQuizService.getCurrentQuestionNumber(),
                userQuizService.getTotalQuestions(),
                userQuizService.getScore(),
                false,
                message,
                link,
                boardtype
            );
        }
    }

 	@GetMapping("/tag/{tag}")
    public String redirectToRandomPostWithTag(@PathVariable("tag") String tag, Model model) {
        Integer boardNo = boardService.getRandomPostBoardNoByTag(tag);
        if (boardNo != null) {
            return "redirect:/kim/board/read?boardNo=" + boardNo; // 랜덤으로 선택된 게시물로 리다이렉트
        } else {
            model.addAttribute("message", "해당 태그를 포함한 게시물을 찾을 수 없습니다.");
            return "kim/board/main"; // 게시물이 없을 경우 메인으로 돌아감
        }
    }
}