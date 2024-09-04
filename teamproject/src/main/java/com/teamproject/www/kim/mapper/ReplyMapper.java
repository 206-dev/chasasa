package com.teamproject.www.kim.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.www.kim.domain.InformationReplyVo;




public interface ReplyMapper {
	// 김세영 댓글달기
	public int insert(InformationReplyVo vo);
	
	public InformationReplyVo read(Long replyNo);
	
	public int delete(Long replyNo);
	
	public int update(InformationReplyVo vo);
//	김세영 댓글 불러오기
	public List<InformationReplyVo> getList(Long boardNo);
	
}