package com.teamproject.www.common.domain;

import java.util.Date;

import lombok.Data;

@Data
public class UserActionDto {
	private String userId;
	private String actionType;
	private String reasonType;
	private Date startTime;
	private Date endTime;
	private String issuedBy;
	private String status;
}
