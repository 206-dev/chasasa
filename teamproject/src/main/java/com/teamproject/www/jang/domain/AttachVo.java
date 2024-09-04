package com.teamproject.www.jang.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AttachVo {
	private Long fileNo;
	private Long boardNo;
	private String uploadPath;
	private Date uploadDate;
}
