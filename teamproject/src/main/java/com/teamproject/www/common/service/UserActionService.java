package com.teamproject.www.common.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.www.common.domain.ReportVo;
import com.teamproject.www.common.domain.UnprocessedReportDto;
import com.teamproject.www.common.domain.UserActionDto;

public interface UserActionService {
	// 리스트 가져오기
	public List<UserActionDto> getList();

	// 한 유저의 데이터만 가져오기
	public List<UserActionDto> getUserActionList(@Param("target") String target, @Param("targetType") String targetType);

	// 데이터 등록
	public boolean insert(@Param("dto") UserActionDto dto, @Param("period")  String period, @Param("vo") ReportVo vo);

	// 데이터 상태 변경
	public int update(@Param("status") String status, @Param("userId") String userId);
}
