package com.teamproject.www.kim.domain;


import java.util.Date;

import lombok.Data;

@Data
public class UserVo {
	private String userid;
	private String userpw;
	private String nickname;
	private String email;
	private String profile;
	private Integer userLevel;
	private Integer point;
	private Date regdate;
	private int gradeNo;
}
