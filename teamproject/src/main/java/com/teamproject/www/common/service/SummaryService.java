package com.teamproject.www.common.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.www.common.domain.BoardSummaryDto;
import com.teamproject.www.common.domain.ReplySummaryDto;
import com.teamproject.www.common.domain.UserRegSummaryDto;

public interface SummaryService {
	// 게시판 카운트 리스트 가져오기
	public List<BoardSummaryDto> getBoardCountList();
	
	// 댓글 카운트 리스트 가져오기
	public List<ReplySummaryDto> getReplyCountList();
	
	// 가입 유저 카운트 리스트 가져오기
	public List<UserRegSummaryDto> getUserRegCountList(@Param("startDate") int startDate, @Param("endDate") int endDate);
}
