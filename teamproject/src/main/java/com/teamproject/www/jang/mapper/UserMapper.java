package com.teamproject.www.jang.mapper;

import org.apache.ibatis.annotations.Param;

import com.teamproject.www.common.domain.LoginSessionDto;
import com.teamproject.www.jang.domain.UserVo;

public interface UserMapper {
	//회원가입
	public int join(UserVo vo);
	
	// 로그인
	public LoginSessionDto login(@Param("userId") String userId, @Param("userPw") String userPw);
	
	// 중복확인
	public int checkId(String userId);
}
