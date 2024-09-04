package com.teamproject.www.lee.service.report;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.www.lee.domain.report.ReportReasonTypeDto;
import com.teamproject.www.lee.domain.report.ReportRegistDto;
import com.teamproject.www.lee.mapper.report.ReportMapper;

import lombok.extern.log4j.Log4j;

@Service("leeReportService")
@Log4j
public class ReportServiceImpl implements ReportService{
	@Autowired
	private ReportMapper reportMapper;

	// 사유 타입 가져오기
	@Override
	public List<ReportReasonTypeDto> getReportReasonTypeList() {
		return reportMapper.getReportReasonTypeList();
	}

	// 신고접수
	@Override
	public boolean registReport(ReportRegistDto dto) {
		int result = reportMapper.insertReport(dto);
		if(result == 0) {
			return false;
		}
		return true;
	}
	
	
}
