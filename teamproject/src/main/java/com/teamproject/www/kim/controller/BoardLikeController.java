package com.teamproject.www.kim.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.teamproject.www.kim.domain.BoardLikeDto;
import com.teamproject.www.kim.service.BoardLikeService;
import com.teamproject.www.kim.service.UserService;

@RestController
@RequestMapping("/kim/boardlike")
public class BoardLikeController {

    @Autowired
    private BoardLikeService boardLikeService;
    
    @Autowired
    private UserService userService;

    @PostMapping("/add")
    public void addLike(@RequestBody BoardLikeDto boardLikeDto,
                        HttpServletResponse response, HttpSession session) {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        int result = boardLikeService.addLike(boardLikeDto);

//        // 키워드 추출 및 파일 기록 로직 추가
//        if (result == 1) {
//            Object loginSessionObject = session.getAttribute("loginSessionDto");
//            // kim에서 로그인후 kim 게시글 좋아요
//            if (loginSessionObject instanceof com.teamproject.www.kim.domain.LoginSessionDto) {
//                com.teamproject.www.kim.domain.LoginSessionDto loginSession = 
//                    (com.teamproject.www.kim.domain.LoginSessionDto) loginSessionObject;
//                String userId = loginSession.getUserid();
//                Map<String, Integer> wordCountMap = boardLikeService.getMostFrequentWords(userId);
//                boardLikeService.appendKeywordsToLatestFile(userId, wordCountMap);
//            // jang에서 로그인 후 kim 게시글 좋아요 했을때 파일 생성후 content 정보 기록
//            } else if (loginSessionObject instanceof com.teamproject.www.jang.domain.LoginSessionDto) {
//                com.teamproject.www.jang.domain.LoginSessionDto loginSession = 
//                    (com.teamproject.www.jang.domain.LoginSessionDto) loginSessionObject;
//                String userId = loginSession.getUserid();
//                userService.createLogFileForUser(userId);
//                Map<String, Integer> wordCountMap = boardLikeService.getMostFrequentWords(userId);
//                boardLikeService.appendKeywordsToLatestFile(userId, wordCountMap);
//            // lee에서 로그인 후 kim 게시글 좋아요 했을때 파일 생성후 content 정보 기록
//            } else if (loginSessionObject instanceof com.teamproject.www.lee.domain.user.LoginSessionDto) {
//                com.teamproject.www.lee.domain.user.LoginSessionDto loginSession = 
//                    (com.teamproject.www.lee.domain.user.LoginSessionDto) loginSessionObject;
//                String userId = loginSession.getUserid();
//                userService.createLogFileForUser(	userId);
//                Map<String, Integer> wordCountMap = boardLikeService.getMostFrequentWords(userId);
//                boardLikeService.appendKeywordsToLatestFile(userId, wordCountMap);
//            } else {
//                // 로그를 남기거나 예외 처리할 수 있습니다.
//                System.out.println("알 수 없는 세션 데이터 또는 세션에 데이터가 없습니다.");
//            }
//        }
        
        // 관심 키워드 저장 로직 추가
        if (result == 1) {
            boardLikeService.updateInterestsWithKeywords(boardLikeDto);
            
            Integer boardTypeNo = boardLikeService.getBoardTypeNoByBoardNo(boardLikeDto.getBoardNo());
            boardLikeService.updateUserPreference(boardLikeDto.getUserId(), boardTypeNo);
        }

        try {
            if (result == 1) {
                response.getWriter().write("좋아요");
            } else if (result == 0) {
                response.getWriter().write("좋아요 취소");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("fail like.");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }




//    @PostMapping("/remove")
//    public ResponseEntity<String> removeLike(@RequestBody BoardLikeDto boardLikeDto) {
//        boolean result = boardLikeService.removeLike(boardLikeDto);
//        if (result) {
//            return ResponseEntity.ok("추천이 제거되었습니다.");
//        } else {
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("추천 제거에 실패했습니다.");
//        }
//    }

    @GetMapping("/count/{boardno}")
    public ResponseEntity<Integer> countLikes(@PathVariable("boardno") Integer boardNo) {
        int count = boardLikeService.countLikes(boardNo);
        return ResponseEntity.ok(count);
    }
}
