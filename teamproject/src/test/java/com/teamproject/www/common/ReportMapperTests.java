package com.teamproject.www.common;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.www.common.domain.ReportVo;
import com.teamproject.www.common.domain.UnprocessedReportDto;
import com.teamproject.www.common.mapper.ReportMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReportMapperTests {

	@Autowired
	private ReportMapper reportMapper;

	@Test
	public void testGetList() {
		List<ReportVo> list = reportMapper.getList();
		log.info(list);
		System.out.println(list);
	}

	// 데이터 하나만 가져오기
	@Test
	public void testGetOne() {
		ReportVo vo = reportMapper.getOne(7L);
		log.info(vo);
	};

	// 데이터 등록
	@Test
	public void testInsert() {
		boolean result = false;
		ReportVo vo = new ReportVo();
		vo.setUserId("user01");
		vo.setTarget("11");
//		vo.setTargetType(1);
		vo.setContent("테스트 내용");
		int count = reportMapper.insert(vo);
		if(count > 0) {
			result = true;
		}
		log.info(result);
	};

	// 데이터 삭제
	@Test
	public void testDelete() {
		int count = reportMapper.delete(26L);
		log.info(count);
	};

	// 데이터 상태 변경
	@Test
	public void testUpdate() {
		String status = "completed";
		Long reportNo = 24L;
		int count = reportMapper.update(reportNo, status);
		log.info(count);
	};
	
	// 미처리 리스트 가져오기
	@Test
	public void testGetUnprocessedList() {
		List<UnprocessedReportDto> list = reportMapper.getUnprocessedList();
		log.info(list);
		System.out.println(list);
	}
	
	// 유저 아이디 가져오기
	@Test
	public void testGetUserId() {
		String target = "303";
		String targetType = "유저";
		String userId = reportMapper.getUserId(target, targetType);
		log.info(userId);
	}
}
