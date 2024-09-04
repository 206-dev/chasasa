package com.teamproject.www.lee.controller.report;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.teamproject.www.common.domain.LoginSessionDto;
import com.teamproject.www.lee.domain.report.ReportReasonTypeDto;
import com.teamproject.www.lee.domain.report.ReportRegistDto;
import com.teamproject.www.lee.service.report.ReportService;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController("leeReportController")
@RequestMapping("/lee/report/*")
public class ReportController {
	@Autowired
	private ReportService reportService;
	
	@GetMapping("/reasonType")
	public ResponseEntity<List<ReportReasonTypeDto>> reportType() {
		log.info("reportType....");
		List<ReportReasonTypeDto> data = reportService.getReportReasonTypeList();
//		log.info("data : " + data);
		if(data == null) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<>(data, HttpStatus.OK);
	}
	
	@PostMapping("/regist")
	public boolean regist(@RequestBody ReportRegistDto reportDto, HttpSession session) {
		log.info("regist..");
		LoginSessionDto loginDto = (LoginSessionDto)session.getAttribute("loginSessionDto");
		String userid = loginDto.getUserid();
		reportDto.setUserid(userid);
		log.info("reportDto : " + reportDto);
		return reportService.registReport(reportDto);
	}
}
