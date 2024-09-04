package com.teamproject.www.lee.domain.board;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDetailDto {
	private Integer boardno;
	private String title;
	private String content;
	private String userid;
	private String nickname;
	private Date regdate;
	private Date updatedate;
	private Integer likes;
	private Integer views;
	private Integer boardtypeno;
	private String boardtype;
	private String profile;
}
