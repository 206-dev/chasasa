package com.teamproject.www.lee.service.boardlike;

import com.teamproject.www.lee.domain.board.BoardLikeDto;

public interface BoardLikeService {
	
	// 추천하기
	public int like(BoardLikeDto dto);
	
	// 추천했는지 조회
	public boolean checkLike(BoardLikeDto dto);
	
	// 삭제하기
	public int deleteMyLike(BoardLikeDto dto);
	
	// 게시번호에 모든 좋아요 삭제
	public boolean deleteAllLikeWithBoardno(int boardno);
}
