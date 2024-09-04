package com.teamproject.www.lee.service.report;

import java.util.List;

import com.teamproject.www.lee.domain.report.ReportReasonTypeDto;
import com.teamproject.www.lee.domain.report.ReportRegistDto;

public interface ReportService {
	// 사유 타입 가져오기
	public List<ReportReasonTypeDto> getReportReasonTypeList();
	// 신고 접수
	public boolean registReport(ReportRegistDto dto);
}
