package com.teamproject.www.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.www.common.domain.LoginSessionDto;
import com.teamproject.www.jang.domain.UserVo;
import com.teamproject.www.jang.mapper.UserMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserMapperTests {
	
	@Autowired
	private UserMapper userMapper;
	
	//instance
	@Test
	public void testInstance() {
		log.info(userMapper);
	}
	
	@Test
	public void testJoin() {
	
		int count = 20;
		for(int i=10; i<count; i++) {
			String userid = "user" + i;
			String userpw = "1234";
			String nickname = "유저" + i;
			String email = "test"+ i + "@email.com";
			String gender = "W";
			String profile = "testProfilePath" + i;
			
			UserVo vo = new UserVo();
			vo.setUserId(userid);
			vo.setUserPw(userpw);
			vo.setNickname(nickname);
			vo.setEmail(email);
			vo.setProfile(profile);
			vo.setGender(gender);
			
			System.out.println(vo);
			int result = userMapper.join(vo);
			log.info(result);
		}
	}
	
	
	@Test
	public void testLogin() {
		String userId = "system";
		String userPw = "1234";
		
		LoginSessionDto dto = userMapper.login(userId, userPw);
		log.info(dto);
	}
}
