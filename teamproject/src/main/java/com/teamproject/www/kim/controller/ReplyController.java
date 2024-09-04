package com.teamproject.www.kim.controller;

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

import com.teamproject.www.kim.domain.InformationReplyVo;
import com.teamproject.www.kim.service.ReplyService;

@RestController("kimReplyController")
@RequestMapping("/kim/reply/*")
@Qualifier("kimReplyService")
public class ReplyController {

	@Autowired
	private ReplyService replyService;
	
	// 댓글 등록
	@PostMapping("/write")
	public boolean write(@RequestBody InformationReplyVo replyVo) {
		
		
		boolean result = replyService.register(replyVo);
		return result;
	}
	
	// 댓글 수정
	@PutMapping("/modify")
	public boolean modify(@RequestBody InformationReplyVo replyVo) {
        System.out.println("Modify request received for: " + replyVo);
        System.out.println("Nickname: " + replyVo.getNickname());  // 여기에 로그 추가
        boolean result = replyService.modify(replyVo);
        System.out.println("Modify result: " + result);
        return result;
	}
	
	@DeleteMapping("/remove/{replyNo}/{boardNo}")
	public boolean remove(@PathVariable("replyNo") Long replyNo, @PathVariable("boardNo") Long boardNo) {
		boolean result = replyService.remove(replyNo, boardNo);
		return result;
	}
	
	// 댓글 리스트 불러오기
	@GetMapping("/list/{boardNo}")
	public List<InformationReplyVo> list(@PathVariable("boardNo") Long boardNo) {
        System.out.println("Fetching replies for boardNo: " + boardNo);
        List<InformationReplyVo> list = replyService.getList(boardNo);
        System.out.println("Replies: " + list);
        return list;
	}
}
