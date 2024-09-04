package com.teamproject.www.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.www.common.domain.ReportVo;
import com.teamproject.www.common.domain.UnprocessedReportDto;
import com.teamproject.www.common.mapper.ReportMapper;

@Service("reportService")
public class ReportServiceImpl implements ReportService{
	
	@Autowired
	private ReportMapper reportMapper;
	
	@Override
	public List<ReportVo> getList() {
		List<ReportVo> list = reportMapper.getList();
		return list;
	}

	@Override
	public ReportVo getOne(Long reportNo) {
		ReportVo vo = reportMapper.getOne(reportNo);
		return vo;
	}

	@Override
	public int add(ReportVo vo) {
		int count = reportMapper.insert(vo);
		return 0;
	}

	@Override
	public boolean remove(Long reportNo) {
		boolean result = false;
		int count = reportMapper.delete(reportNo);
		if(count > 0) {
			result = true;
		}
		return result;
	}

	@Override
	public boolean modify(Long reportNo, String status) {
		boolean result = false;
		int count = reportMapper.update(reportNo, status);
		if(count > 0) {
			result = true;
		}
		return result;
	}

	@Override
	public List<UnprocessedReportDto> getUnprocessedList() {
		List<UnprocessedReportDto> list = reportMapper.getUnprocessedList();
		return list;
	}
}
