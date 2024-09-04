package com.teamproject.www.kim.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.www.kim.domain.InformationReplyVo;
import com.teamproject.www.kim.mapper.BoardMapper;
import com.teamproject.www.kim.mapper.ReplyMapper;

@Service("kimReplyService")
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	private ReplyMapper replyMapper;
	
	@Autowired
	private BoardMapper boardMapper;

	@Transactional
	@Override
	public boolean register(InformationReplyVo vo) {
		int count = replyMapper.insert(vo);
		count += boardMapper.updateReplyCntKsy(vo.getBoardNo(), 1);
		return (count == 2) ? true : false;
	}

	@Override
	public InformationReplyVo get(Long replyNo) {
		InformationReplyVo vo = replyMapper.read(replyNo);
		return vo;
	}
	
	@Transactional
	@Override
	public boolean remove(Long replyNo, Long boardNo) {
		int count = replyMapper.delete(replyNo);
		count += boardMapper.updateReplyCntKsy(boardNo, -1);
		return (count == 2) ? true : false;
	}

	@Override
	public boolean modify(InformationReplyVo vo) {

	    // 수정된 객체를 출력
	    System.out.println("Modifying reply: " + vo);

	    // 업데이트 쿼리 실행
	    int count = replyMapper.update(vo);

	    // 업데이트 결과 출력
	    System.out.println("Update count: " + count);

	    // 업데이트 성공 여부 반환
	    return (count > 0);
	}

	@Override
	public List<InformationReplyVo> getList(Long boardNo) {
		List<InformationReplyVo> list = replyMapper.getList(boardNo);
		return list;
	}
}
