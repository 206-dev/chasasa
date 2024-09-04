package com.teamproject.www.lee.service.board;

import java.util.List;

import com.teamproject.www.lee.domain.board.BoardDetailDto;
import com.teamproject.www.lee.domain.board.BoardInsertDto;
import com.teamproject.www.lee.domain.board.BoardListDto;
import com.teamproject.www.lee.domain.board.BoardUpdateDto;
import com.teamproject.www.lee.domain.board.Criteria;

public interface BoardService {
	// 자유게시판 글등록
	public int registerBoard(BoardInsertDto dto);
	
	// 자유게시판 리스트 가져오기
	public List<BoardListDto> getList(Criteria criteria, String boardType);
	
	// 자게 디테일 가져오기
	public BoardDetailDto getDetail(int boardno);
	
	// 총개수
	public int getAllCount(Criteria criteria);
	
	// 자게 글 삭제
	public boolean delete(int boardno, String userid);
	
	// 글 수정
	public boolean update(BoardUpdateDto dto);
	
	// 조회수 증가
	public boolean plusViews(int b_f_no);
	
	
}
