package com.teamproject.www.lee.mapper.reply;

import java.util.List;

import com.teamproject.www.lee.domain.reply.ReplyInsertDto;
import com.teamproject.www.lee.domain.reply.ReplyListDto;
import com.teamproject.www.lee.domain.reply.ReplyUpdateDto;

public interface ReplyMapper {
	// 댓글달기
	public int insertReply(ReplyInsertDto dto);
	// 댓글리스트 가져오기
//	public List<> getList();
	public List<ReplyListDto> getList(int boardno);
	// 댓글 갯수 가져오기
	public List<Integer> getListReplyno(int boardno);
	// 댓글삭제 replyno
	public int delete(int replyno);
	// 댓글 리스트 가져오기 with boardno
	public List<Integer> getReplynoListWithBoardno(int boardno);
	// 댓글수정
	public int update(ReplyUpdateDto dto);
	// 댓글 좋아요
	public int like(int replyno);
	// 댓글 좋아요 취소
	public int disLike(int replyno);
	
	// 댓글 게시판번호로 삭제
	
}
