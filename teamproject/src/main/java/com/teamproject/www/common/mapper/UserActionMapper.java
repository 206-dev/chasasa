package com.teamproject.www.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.www.common.domain.ReportVo;
import com.teamproject.www.common.domain.UserActionDto;

public interface UserActionMapper {
	// 리스트 가져오기
	public List<UserActionDto> getList();
	
	// 데이터 하나만 가져오기
	public List<UserActionDto> getListByUserId(String userId);
	
	// 데이터 등록
	public int insert(@Param("dto") UserActionDto dto, @Param("period")  int period);
	
	// 데이터 상태 변경
	public int update(@Param("status") String status, @Param("userId")String userId);
}
