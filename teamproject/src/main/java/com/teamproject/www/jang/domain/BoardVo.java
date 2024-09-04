package com.teamproject.www.jang.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVo {
	private Long boardNo;
	private String title;
	private String content;
	private String userId;
	private String nickname;
	private int boardtypeno;
	private Date regdate;
	private Date updatedate;
	private int views;
	private int likes;
	private int replycount;
	
	
	
//	private Long bno;
//	private String title;
//	private String content;
//	private int writer;
//	private Long btype;
//	private Date regdate;
//	private Date updatedate;
//	private int views;
}
