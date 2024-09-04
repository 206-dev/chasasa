package com.teamproject.www.kim.service;

import java.util.List;

import com.teamproject.www.kim.domain.InformationReplyVo;



public interface ReplyService {
	// 김세영 정보공유 댓글등록
	public boolean register(InformationReplyVo vo);
	
	public InformationReplyVo get(Long replyNo);
	
	public boolean remove(Long replyNo, Long boardNo);
	
	public boolean modify(InformationReplyVo vo);
	
	public List<InformationReplyVo> getList(Long boardNo);
}