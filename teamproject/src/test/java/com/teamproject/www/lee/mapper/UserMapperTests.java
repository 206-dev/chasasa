package com.teamproject.www.lee.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.www.lee.domain.user.UserRankDto;
import com.teamproject.www.lee.mapper.user.UserMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserMapperTests {
	@Autowired
	private UserMapper userMapper;
	
	@Test
	public void instance() {
		log.info(userMapper);
	}
	
	@Test
	public void joinCheckId() {
		String userid = "asraisin";
		int result = userMapper.joinCheckId(userid);
		log.info("result : " + result);
	}
	
	@Test
	public void joinCheckNickname() {
		String nickname = "아스라이신";
		int result = userMapper.joinCheckNickname(nickname);
		log.info("result : " + result);
	}
	
	@Test
	public void checkGenderTest() {
		String userid = "206dev";
		int gender = userMapper.checkGender(userid);
		
		log.info("gender : " + gender);
	}
	
	@Test
	public void updateGenderTest() {
		String userid = "206dev";
		String gender = "M";
		int result = userMapper.updateGender(userid, gender);
		log.info("result : " + result);
		
	}
	
	@Test
	public void getTopRankTest() {
		List<UserRankDto> list  = userMapper.getTopTreeRank();
		log.info(list);
	}
	
	@Test
	public void getMyRankTest() {
		int myRank = userMapper.getMyRank("asraisin");
		log.info(myRank);
	}
	
	@Test
	public void getGenderTest() {
		String gender = userMapper.getGender("206dev");
		log.info(gender);
	}
	
	@Test
	public void getGradenoTest() {
		int gradeno = userMapper.getGradeno("206jeju");
		log.info("gradeno : " + gradeno);
	}
}
