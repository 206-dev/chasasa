package com.teamproject.www.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.www.common.domain.ReportVo;
import com.teamproject.www.common.domain.UnprocessedReportDto;

public interface ReportMapper {
	// 리스트 가져오기
	public List<ReportVo> getList();
	
	// 유저 아이디 가져오기
	public String getUserId(@Param("target") String target, @Param("targetType") String targetType);
	
	// 데이터 하나만 가져오기
	public ReportVo getOne(Long reportNo);
	
	// 데이터 등록
	public int insert(ReportVo vo);
	
	// 데이터 삭제
	public int delete(Long reportNo);
	
	// 데이터 상태 변경
	public int update(@Param("reportNo") Long reportNo, @Param("status")String status);
	
	// 미처리 리스트 가져오기
	public List<UnprocessedReportDto> getUnprocessedList();
}
