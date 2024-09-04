package com.teamproject.www.lee.mapper.replylike;


import com.teamproject.www.lee.domain.reply.ReplyLikeDto;

public interface ReplyLikeMapper {
	// 댓글 좋아요 체크
	public int checkLike(ReplyLikeDto dto);
	
	// 댓글 좋아요
	public int replyLike(ReplyLikeDto dto);
	
	// 댓글 좋아요 취소
	public int replyDisLike(ReplyLikeDto dto);
	// 댓글 조회 with boardno
//	public int isLike(int replyno);
	
	// 댓글 삭제
	public int deleteLike(int replyno);
	
	// 댓글 좋아요갯수 가져오기
	public int getCountLikes(int replyno);
}
