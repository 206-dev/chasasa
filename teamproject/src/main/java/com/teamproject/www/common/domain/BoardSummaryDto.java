package com.teamproject.www.common.domain;

import lombok.Data;

@Data
public class BoardSummaryDto {
	private String boardType;
	private int count;
	private Double percentage;
}
