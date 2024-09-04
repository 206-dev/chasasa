package com.teamproject.www.lee.domain.report;

import lombok.Data;

@Data
public class ReportRegistDto {
	private String userid;
	private String target;
	private int targetTypeNo;
	private int reasonTypeNo;
	private String content;
	private String targetUrl;
}
