package com.teamproject.www.jang.service;

import com.teamproject.www.common.domain.LoginSessionDto;
import com.teamproject.www.jang.domain.UserVo;

public interface UserService {
	
	//회원가입
	public boolean signUp(UserVo vo); 
	
	// 로그인
	public LoginSessionDto login(String userId, String userPw);
	
	// 중복확인
	public boolean checkId(String userId);

}
