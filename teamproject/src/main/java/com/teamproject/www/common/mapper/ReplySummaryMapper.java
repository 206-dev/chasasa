package com.teamproject.www.common.mapper;

import java.util.List;

import com.teamproject.www.common.domain.ReplySummaryDto;

public interface ReplySummaryMapper {
	// 카운트 리스트 가져오기
	public List<ReplySummaryDto> getCountList();
}
