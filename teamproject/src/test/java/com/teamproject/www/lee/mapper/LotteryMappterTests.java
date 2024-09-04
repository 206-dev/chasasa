package com.teamproject.www.lee.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.www.lee.mapper.lottery.LotteryMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class LotteryMappterTests {
	@Autowired
	private LotteryMapper mapper;
	
	@Test
	public void instance() {
		log.info(mapper);
	}
	
	@Test
	public void checkLotteryTest() {
		int result = mapper.checkLottery("206dev", 500);
		log.info("result : " + result);
	}
	
}
