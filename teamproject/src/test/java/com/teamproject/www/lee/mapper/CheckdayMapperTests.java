package com.teamproject.www.lee.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.www.lee.mapper.checkday.CheckdayMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CheckdayMapperTests {
	@Autowired
	private CheckdayMapper checkdayMapper;
	
	@Test
	public void instacne () {
		log.info(checkdayMapper);
	}
	
	@Test
	public void isCheckday() {
		int result = checkdayMapper.isCheckday("206dev");
		log.info(result);
	}
	
	@Test
	public void insert() {
		int result = checkdayMapper.insertCheckday("206dev");
		log.info(result);
	}
	
	@Test
	public void getCheckDayList() {
		List<Integer> list = checkdayMapper.getCheckdayList("206dev");
		log.info(list);
	}
}
