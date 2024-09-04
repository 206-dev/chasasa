package com.teamproject.www.lee.domain.user;

import java.util.Date;

import lombok.Data;

@Data
public class UserVo {
	private Integer userno;
	private String userid;
	private String userpw;
	private String nickname;
	private String email;
	private Integer lv;
	private Integer point;
	private Date regdate;
	private String thumbnail;
}
