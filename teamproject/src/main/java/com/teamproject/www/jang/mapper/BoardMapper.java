package com.teamproject.www.jang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.www.jang.domain.BoardVo;
import com.teamproject.www.jang.domain.NoticeCriteria;
import com.teamproject.www.jang.domain.NoticeDto;

public interface BoardMapper {
	public List<NoticeDto> getNoticeList();
	public int insertNotice(BoardVo boardVo);
	public NoticeDto getNotice(Long boardNo);
	public int getTotal(NoticeCriteria cri);
	public List<NoticeDto> getListWithPaging(NoticeCriteria cri);
	public int viewsUp(Long boardNo);
	public int updateNotice(@Param("content") String content, @Param("boardNo") Long boardNo);
	public int deleteNotice(Long boardNo);
}
