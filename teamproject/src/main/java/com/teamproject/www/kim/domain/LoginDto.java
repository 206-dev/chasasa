package com.teamproject.www.kim.domain;

import lombok.Data;

@Data
public class LoginDto {
	private String userId;
	private String userPw;
	private Boolean rememberMe;
}
