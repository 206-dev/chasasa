package com.teamproject.www.lee.service.reply;

import java.util.List;

import com.teamproject.www.lee.domain.reply.ReplyInsertDto;
import com.teamproject.www.lee.domain.reply.ReplyListDto;
import com.teamproject.www.lee.domain.reply.ReplyUpdateDto;

public interface ReplyService {
	// 댓글LIST 가져오기
	public List<ReplyListDto> getList(int boardno);
	// 댓글달기
	public boolean registerReply(ReplyInsertDto dto);
	// 댓글 삭제 댓글 번호로
	public boolean delete(int replyno, String userid);
	// 댓글 삭제 게시글 번호로
	public boolean deleteByBoardNo(int boardno, String userid);
	// 댓글 수정
	public boolean update(ReplyUpdateDto dto);
	// 댓글 좋아요
//	public boolean like(ReplyLikeDto dto);
	
}
