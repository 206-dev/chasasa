package com.teamproject.www.lee.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.www.lee.service.user.UserService;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserServiceTests {
	@Autowired
	private UserService userService;
	
	@Test
	public void instance() {
		log.info(userService);
	}
	
	// 포인트관리 + 레벨링 테스트
	@Test
	public void pointLevelTests() {
		log.info("pointLevelTests.......................");
		String userid = "test00";
		int point = 64;
		boolean result = false;
		for(int i = 0; i<1; i++) {
			result = userService.updatePoint(userid, point);			
		}
		log.info("result : " + result);
	}
}
