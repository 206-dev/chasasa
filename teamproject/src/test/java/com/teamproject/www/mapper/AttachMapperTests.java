package com.teamproject.www.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.www.jang.domain.AttachVo;
import com.teamproject.www.jang.mapper.AttachMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class AttachMapperTests {
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Test
	public void testInstance() {
		log.info(attachMapper);
	}
	
	@Test
	public void testInsertUpload() {
		Long boardNo = 2041L;
		String uploadPath = "D://";
		
		AttachVo attachVo = new AttachVo();
		attachVo.setBoardNo(boardNo);
		attachVo.setUploadPath(uploadPath);
		
		attachMapper.insertUpload(attachVo);
		
	}
	
}
