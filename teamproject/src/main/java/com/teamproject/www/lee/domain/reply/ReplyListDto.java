package com.teamproject.www.lee.domain.reply;



import java.util.Date;

import lombok.Data;

@Data
public class ReplyListDto {
	private Integer boardno;
	private Integer replyno;
	private String comments;
	private String userid;
	private String nickname;
	private Integer likes;
	private Date replydate;
	private Date updatedate;
	private Integer parentreplyno;
	private Integer reply_level;
	private String profile;
}
