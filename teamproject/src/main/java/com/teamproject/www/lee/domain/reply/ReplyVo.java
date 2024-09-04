package com.teamproject.www.lee.domain.reply;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVo {
	private Integer replyno;
	private Integer boardno;
	private String comments;
	private String userid;
	private String nickname;
	private Integer likes;
	private Date replydate;
	private Date updatedate;
}
