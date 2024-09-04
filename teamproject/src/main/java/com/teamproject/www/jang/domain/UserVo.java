package com.teamproject.www.jang.domain;

import lombok.Data;

@Data
public class UserVo {
	private String userId;
	private String userPw;
	private String nickname;
	private String email;
	private String profile;
	private String regdate;
	private String gender;
}
