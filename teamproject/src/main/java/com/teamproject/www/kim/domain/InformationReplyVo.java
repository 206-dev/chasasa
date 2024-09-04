package com.teamproject.www.kim.domain;




import java.util.Date;

import lombok.Data;

@Data
public class InformationReplyVo {
	private Long replyNo;
    private Long boardNo;
    private String comments;
    private Long parentReplyNo;
    private String userId;
    private String nickname;
    private Long likes;
    private Date updatedate;
	
	
	//private Date replyDate;
}