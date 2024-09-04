package com.teamproject.www.lee.mapper.report;

import java.util.List;

import com.teamproject.www.lee.domain.report.ReportReasonTypeDto;
import com.teamproject.www.lee.domain.report.ReportRegistDto;

public interface ReportMapper {
	// 신고 사유 타입 가져오기
	public List<ReportReasonTypeDto> getReportReasonTypeList();
	
	// 신고 등록
	public int insertReport(ReportRegistDto dto);
}
