package com.teamproject.www.lee.controller.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.teamproject.www.lee.domain.board.BoardLikeDto;
import com.teamproject.www.lee.service.boardlike.BoardLikeService;

import lombok.extern.log4j.Log4j;

@RestController("leeBoardLikeController")
@RequestMapping("/lee/boardlike/*")
@Log4j
@Qualifier("leeBoardLikeService")
public class BoardLikeController {
	@Autowired
	private BoardLikeService boardLikeService;
	
	//추천 했는지 확인
	@PostMapping("/checkLike")
	public boolean checkLike(@RequestBody BoardLikeDto dto) {
		log.info("controller........ checkLike..........");
		log.info("controller, checkLike  dto : " + dto);
		return boardLikeService.checkLike(dto);
	}
	
	//추천하기
	@PostMapping("/Like")
	public int commend(@RequestBody BoardLikeDto dto) {
		System.out.println("dto" + dto);
		return boardLikeService.like(dto);
	}
	
	//추천 취소하기
	@DeleteMapping("/delete/{boardno}/{userid}/{replyuserid}")
	public int delete(@PathVariable("boardno") int boardno,
					  @PathVariable("userid") String userid ) {
		log.info("boardlikeController, delete...........................");
		log.info("boardno : " + boardno);
		log.info("userid : " + userid);
		BoardLikeDto dto = new BoardLikeDto();
		dto.setBoardno(boardno);
		dto.setUserid(userid);
		return boardLikeService.deleteMyLike(dto);
	}
}
