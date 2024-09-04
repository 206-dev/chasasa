package com.teamproject.www.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.www.common.domain.LoginSessionDto;
import com.teamproject.www.jang.service.UserService;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserServiceTests {
	@Autowired
	private UserService userService;

	@Test
	public void testUserServiceInstance() {
		log.info(userService);
	}
	
	//회원가입
	/*
	@Test
	public void testSignUp() {
		int count = 10;
		for(int i=0; i<count; i++) {
			String u_id = "test" + i;
			String upw = "1234";
			String uname = "홍길동" + i;
			String nickname = "test-" + i;
			String email = "test"+ i + "@email.com";
			UserVo vo = new UserVo();
			vo.setU_id(u_id);
			vo.setUpw(upw);
			vo.setUname(uname);
			vo.setNickname(nickname);
			vo.setEmail(email);
			
			Boolean result = userService.signUp(vo);
			log.info(result);
		}
	}
	*/
	// 로그인
	@Test
	public void testLogin() {
		String u_id = "system";
		String upw = "1234";
		
		LoginSessionDto loginSessionDto = userService.login(u_id, upw);
		log.info(loginSessionDto);
	}

}
