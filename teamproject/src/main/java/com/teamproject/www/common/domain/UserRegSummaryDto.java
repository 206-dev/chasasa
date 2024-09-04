package com.teamproject.www.common.domain;

import java.util.Date;

import lombok.Data;

@Data
public class UserRegSummaryDto {
	private int count;
	private Date regDate;
	private Double percentage;
}
