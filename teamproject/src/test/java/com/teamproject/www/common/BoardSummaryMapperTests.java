package com.teamproject.www.common;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.www.common.domain.BoardSummaryDto;
import com.teamproject.www.common.mapper.BoardSummaryMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardSummaryMapperTests {

	@Autowired
	private BoardSummaryMapper boardSummaryMapper;

	@Test
	public void testGetList() {
		List<BoardSummaryDto> list = boardSummaryMapper.getCountList();
		log.info(list);
		System.out.println(list);
	}
}
