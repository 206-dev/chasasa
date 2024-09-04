package com.teamproject.www.common.domain;

import java.util.Date;

import lombok.Data;

@Data
public class UnprocessedReportDto {
	private Long reportNo;
	private String target;
	private String targetType;
	private String content;
	private Date reportDate;
	private String reasonType;
	private String targetURL;
}
