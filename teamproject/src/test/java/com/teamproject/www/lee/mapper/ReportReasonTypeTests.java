package com.teamproject.www.lee.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.www.lee.domain.report.ReportReasonTypeDto;
import com.teamproject.www.lee.mapper.report.ReportMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReportReasonTypeTests {
	@Autowired
	private ReportMapper reportMapper;
	
	@Test
	public void instance() {
		log.info(reportMapper);
	}
	
	@Test
	public void ReportReasonTypeTest() {
		List<ReportReasonTypeDto> list = reportMapper.getReportReasonTypeList();
		log.info(list);
	}
}
