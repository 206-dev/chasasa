package com.teamproject.www.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.www.common.domain.UserRegSummaryDto;

public interface UserRegSummaryMapper {
	// 카운트 리스트 가져오기
	public List<UserRegSummaryDto> getCountList(@Param("startDate") int startDate, @Param("endDate") int endDate);
}
