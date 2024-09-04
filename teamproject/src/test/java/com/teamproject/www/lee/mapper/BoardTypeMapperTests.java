package com.teamproject.www.lee.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.www.lee.mapper.board.BoardTypeMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardTypeMapperTests {
	@Autowired
	private BoardTypeMapper mapper;
	
	@Test
	public void instance() {
		log.info(mapper);
	}
	
	@Test
	public void getBoardType() {
//		BoardTypeVo vo = mapper.getBoardType(1);
//		log.info("vo : " + vo);
	}
}
