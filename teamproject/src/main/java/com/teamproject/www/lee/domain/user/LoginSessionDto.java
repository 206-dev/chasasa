package com.teamproject.www.lee.domain.user;

import lombok.Data;

@Data
public class LoginSessionDto {
	private String userid;
	private String nickname;
	private String userlevel;
	private Integer point;
	private String profile;
}
