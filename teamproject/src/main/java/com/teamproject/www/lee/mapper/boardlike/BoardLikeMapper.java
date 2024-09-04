package com.teamproject.www.lee.mapper.boardlike;

import com.teamproject.www.lee.domain.board.BoardLikeDto;

public interface BoardLikeMapper {
	// 게시글 좋아요 체크
	public int checkLike(BoardLikeDto dto);
	
	// 게시글 좋아요
	public int like(BoardLikeDto dto);
	
	// 좋아요 확인 + 좋아요수 가져오기
	public int getLikes(int boardno);
	// like 체크
//	public int checkLikeWithBoardno(int boardno);
	// 삭제 boardno로
	public int deleteLike(int boardno);
	// 삭제 내것만
	public int deleteMyLike(BoardLikeDto dto);
}	
