package com.teamproject.www.lee.controller.reply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.teamproject.www.lee.domain.reply.ReplyInsertDto;
import com.teamproject.www.lee.domain.reply.ReplyListDto;
import com.teamproject.www.lee.domain.reply.ReplyUpdateDto;
import com.teamproject.www.lee.service.reply.ReplyService;

import lombok.extern.log4j.Log4j;

@RestController("leeReplyController")
@RequestMapping("/lee/board/reply/*")
@Log4j
@Qualifier("leeReplyService")
public class ReplyController {
	@Autowired
	private ReplyService replyService;
	

	//댓글 리스트 가져오기
	@GetMapping("/list/{boardno}")
	public List<ReplyListDto> getList(@PathVariable("boardno") int boardno) {
		log.info("replyController, getList..........................");
		List<ReplyListDto> list = replyService.getList(boardno);
//		log.info("list : + " + list);
		return list;
	}
	
	//댓글달기
	@PostMapping("/register")
	public boolean register(@RequestBody ReplyInsertDto dto) {
		log.info("reply register, dto : " + dto);
		return replyService.registerReply(dto);
	}
	
	//댓글삭제
	@DeleteMapping("/delete/{replyno}/{userid}")
	public boolean delete(@PathVariable("replyno") int replyno, @PathVariable("userid") String userid) {
		log.info("reply, delete..");
		log.info("replyno : " + replyno);
		log.info("userid : " + userid);
		return replyService.delete(replyno, userid);
	}
	
	//댓글수정
	@PutMapping("/update")
	public boolean update(@RequestBody ReplyUpdateDto dto) {
		log.info("reply, update.. dto : " + dto);
		return replyService.update(dto);
	}
}
