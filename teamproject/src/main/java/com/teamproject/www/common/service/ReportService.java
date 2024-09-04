package com.teamproject.www.common.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.www.common.domain.ReportVo;
import com.teamproject.www.common.domain.UnprocessedReportDto;

public interface ReportService {
	// 리스트 가져오기
	public List<ReportVo> getList();
	
	// 데이터 하나만 가져오기
	public ReportVo getOne(Long reportNo);
	
	// 데이터 등록
	public int add(ReportVo vo);
	
	// 데이터 삭제
	public boolean remove(Long reportNo);
	
	// 데이터 상태 변경
	public boolean modify(@Param("reportNo") Long reportNo, @Param("status")String status);
	
	// 미처리 리스트 가져오기
	public List<UnprocessedReportDto> getUnprocessedList();
}
