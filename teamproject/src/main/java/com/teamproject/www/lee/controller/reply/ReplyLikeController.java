package com.teamproject.www.lee.controller.reply;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.teamproject.www.lee.domain.reply.ReplyLikeDto;
import com.teamproject.www.lee.service.replylike.ReplyLikeService;

import lombok.extern.log4j.Log4j;

@RestController("leeReplyLikeController")
@RequestMapping("/lee/replylike/*")
@Log4j
@Qualifier("leeReplyLikeService")
public class ReplyLikeController {
	@Autowired
	private ReplyLikeService replyLikeService;
	
	// 댓글 좋아요 했는지 조회
	@PostMapping("/checkLike")
	public boolean checkLike(@RequestBody ReplyLikeDto dto) {
		log.info("replyLikeController, checkLike..........");
		log.info("controller, checkLike  dto : " + dto);
		return replyLikeService.checkLike(dto);
	}
	
	// 댓글 좋아요
	@PostMapping("/like")
	public int like(@RequestBody ReplyLikeDto dto) {
		log.info("replyLikeController, like.............. ");
		log.info("dto : " + dto);
		return replyLikeService.replyLike(dto);
	}
	
	//추천 취소하기
	@DeleteMapping("/delete/{replyno}/{userid}/{replyer}")
	public int delete(@PathVariable("replyno") int replyno,
					  @PathVariable("userid") String userid,
					  @PathVariable("replyer") String replyer) {
		log.info("boardlikeController, delete...........................");
		log.info("replyno : " + replyno);
		log.info("userid : " + userid);
		log.info("replyer : " + replyer);
		
//		return true;
		ReplyLikeDto dto = new ReplyLikeDto();
		dto.setReplyno(replyno);
		dto.setUserid(userid);
		dto.setReplyer(replyer);
		return replyLikeService.delete(dto);
	}
}
