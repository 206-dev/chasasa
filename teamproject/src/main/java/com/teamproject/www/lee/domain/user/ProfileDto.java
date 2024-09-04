package com.teamproject.www.lee.domain.user;

import lombok.Data;

@Data
public class ProfileDto {
	private String userid;
	private String nickname;
	private String email;
	private String userlevel;
	private Integer point;
	private String profile;
}
