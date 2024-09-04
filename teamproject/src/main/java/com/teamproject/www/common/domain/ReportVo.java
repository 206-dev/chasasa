package com.teamproject.www.common.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReportVo {
	private Long reportNo;
	private String userId;
	private String target;
	private String targetType;
	private String content;
	private Date reportDate;
	private Date processedDate;
	private String status;
	private String reasontype;
	private String targeturl;
}
