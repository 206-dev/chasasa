package com.teamproject.www.lee.mapper.board;

import java.util.List;

import com.teamproject.www.lee.domain.ClobVo;
import com.teamproject.www.lee.domain.board.BoardDetailDto;
import com.teamproject.www.lee.domain.board.BoardInsertDto;
import com.teamproject.www.lee.domain.board.BoardListDto;
import com.teamproject.www.lee.domain.board.BoardUpdateDto;
import com.teamproject.www.lee.domain.board.Criteria;

public interface BoardMapper {
	// 게시판 등록
	// 자유게시판
	public int insertFreeBoard(BoardInsertDto Dto);
	
	public int insertGetKey(BoardInsertDto Dto);
	
	// 게시글 List 가져오기
	public List<BoardListDto> getList(Criteria criteria, int boardtypeno);
	
	// 게시글 List 가져오기 with Paging
	public List<BoardListDto> getListWithPaging(Criteria criteria);
	
	// 게시글 상세정보 가져오기 with b_f_no
	public BoardDetailDto getDetail(int boardno);
	
	// 총갯수 가져오기
	public int getAllCount(Criteria criteria);
	
	// 컨텐츠 가져오기 by b_f_no
	public String getContentByBoardno(int boardno);
	
	// 자게 글 삭제
	public int delete(int boardno);
	
	// 자게 글 수정
	public int update(BoardUpdateDto dto);
	
	// 조회수 증가
	public int pluseViews(int boardno);
	
	// 추천하기
	public int like(int boardno);
	// 추천수 가져오기
	public int checkLike(int boardno);
	
	// 댓글수 업데이트
	public int updateReplyCount(int boardno);
	
	// 어제 날짜 게시글 컨텐츠들 가져오기
	public List<ClobVo> getYesterdayContents();
}
