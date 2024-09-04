package com.teamproject.www.jang.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.www.common.domain.LoginSessionDto;
import com.teamproject.www.jang.domain.UserVo;
import com.teamproject.www.jang.mapper.UserMapper;

@Service("jangUserService")
public class UserServiceImpl implements UserService{
	@Autowired
	private UserMapper userMapper;
	
	@Override
	public boolean signUp(UserVo vo) {
		int count = userMapper.join(vo);
		if(count>0) {
			return true;
		}
		return false;
	}

	@Override
	public LoginSessionDto login(String userId, String userPw) {
		LoginSessionDto loginSessionDto = userMapper.login(userId, userPw);
		System.out.println("userServiceImpl/loginSessionDto : " + loginSessionDto);
		return loginSessionDto;
	}

	@Override
	public boolean checkId(String userId) {
		int result = userMapper.checkId(userId);
		if(result > 0 ) {
			return false;
		}
		return true;
	}

}
