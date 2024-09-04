package com.teamproject.www.kim.mapper;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.www.kim.domain.InformationBoardVo;
import com.teamproject.www.kim.domain.InformationCriteria;
import com.teamproject.www.kim.mapper.BoardMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
    @Autowired
    private BoardMapper boardMapper;
    
    // 공지사항 2개 가져오기 테스트
    @Test
    public void testGetLatestAnnounce() {
        List<InformationBoardVo> result = boardMapper.getLatestAnnounce();
        assertNotNull(result);
        assertTrue(result.size() <= 2);  // 최근 2개의 공지글만 가져와야 함
        for (InformationBoardVo vo : result) {
            System.out.println(vo);
        }
    }
    // 게시판 게시글 가져오기 정렬 및 페이징
    @Test
    public void testGetListWithPagingKsy() {
        // Criteria 설정
        InformationCriteria criteria = new InformationCriteria();
        criteria.setType("C");
        criteria.setKeyword("용-3");
        criteria.setSort("views");
        criteria.setPageNum(1);  // 페이지 번호 설정
        criteria.setAmount(10);  // 한 페이지에 표시할 게시물 수 설정
        
        // 쿼리 실행
        List<InformationBoardVo> result = boardMapper.getListWithPagingKsy(criteria);
        System.out.println("---------------" + result.get(0).getContent());
        // 결과 검증
        assertNotNull(result);  // 결과가 null이 아닌지 확인
        assertFalse(result.isEmpty());  // 결과가 비어있지 않은지 확인
        
        // 결과 출력 및 검증
//        for (InformationBoardVo vo : result) {
//            log.info(vo.toString());
//            assertTrue(vo.getContent().contains("용-3"));
//        }
    }
}
