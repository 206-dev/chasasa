package com.teamproject.www.lee.domain;

import java.util.Date;

import lombok.Data;

@Data
public class FreeBoardVo {
	private Integer b_f_no;
	private String b_f_title;
	private String b_f_content;
	private String b_f_writer;
	private Date b_f_regdate;
	private Date b_f_updatedate;
	private Integer b_f_recommended;
	private Integer b_f_views;
}
