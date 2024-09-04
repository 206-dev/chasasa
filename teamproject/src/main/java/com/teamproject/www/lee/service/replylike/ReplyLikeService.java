package com.teamproject.www.lee.service.replylike;

import com.teamproject.www.lee.domain.reply.ReplyLikeDto;

public interface ReplyLikeService {
	//댓글 좋아요 체크
	public boolean checkLike(ReplyLikeDto dto);
	
	//댓글 좋아요 갯수 가져오기
//	public void getCountLikes();
//	
	//댓글 좋아요
	public int replyLike(ReplyLikeDto dto) ;
	
	//댓글 좋아요 취소
	public int delete(ReplyLikeDto dto);
}
