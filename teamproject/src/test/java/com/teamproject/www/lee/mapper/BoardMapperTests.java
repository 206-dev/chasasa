package com.teamproject.www.lee.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.www.lee.domain.board.BoardDetailDto;
import com.teamproject.www.lee.domain.board.BoardListDto;
import com.teamproject.www.lee.domain.board.Criteria;
import com.teamproject.www.lee.mapper.board.BoardMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	@Autowired
	private BoardMapper mapper;
	
	@Test
	public void instance() {
		log.info(mapper);
	}
	
	@Test
	public void getDetailTest() {
		BoardDetailDto dto = mapper.getDetail(10);
		log.info("dto : " + dto);
	}
	
	@Test
	public void getListWithPaging() {
		Criteria cri = new Criteria();
		log.info("cri : " + cri);
		cri.setBoardtypeno(1);
		List<BoardListDto> list = mapper.getListWithPaging(cri);
		log.info("list : " + list);
	}
}
