package com.teamproject.www.common.domain;

import lombok.Data;

@Data
public class LoginSessionDto {
	private String userid;
	private String nickname;
	private Integer userlevel;
	private Integer point;
	private String profile;
	private int gradeno;
}
