package com.teamproject.www.common;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.www.common.domain.UserRegSummaryDto;
import com.teamproject.www.common.mapper.UserRegSummaryMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserRegSummaryTests {

	@Autowired
	private UserRegSummaryMapper userRegSummaryMapper;
	
	@Test
	public void testGetList() {
	    List<UserRegSummaryDto> list = userRegSummaryMapper.getCountList(0, 0);
	    log.info(list);
	}
}
