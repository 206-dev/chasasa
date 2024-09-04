package com.teamproject.www.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.www.common.domain.BoardSummaryDto;
import com.teamproject.www.common.domain.ReplySummaryDto;
import com.teamproject.www.common.domain.UserRegSummaryDto;
import com.teamproject.www.common.mapper.BoardSummaryMapper;
import com.teamproject.www.common.mapper.ReplySummaryMapper;
import com.teamproject.www.common.mapper.UserRegSummaryMapper;

@Service("summaryActionsService")
public class SummaryServiceImpl implements SummaryService{

	@Autowired
	private BoardSummaryMapper boardSummaryMapper;

	@Autowired
	private ReplySummaryMapper replySummaryMapper;
	
	@Autowired
	private UserRegSummaryMapper userRegSummaryMapper;

	@Override
	public List<BoardSummaryDto> getBoardCountList() {
		List<BoardSummaryDto>list = boardSummaryMapper.getCountList();
		int count = 0;
		for(BoardSummaryDto dto : list) {
			count += dto.getCount();
		}
		for(BoardSummaryDto dto : list) {
			Double percentage = (double)dto.getCount()/count; 
			dto.setPercentage(percentage);
		}
		return list;
	}

	@Override
	public List<UserRegSummaryDto> getUserRegCountList(int startDate, int endDate) {
		List<UserRegSummaryDto> list = userRegSummaryMapper.getCountList(startDate, endDate);
		int count = 0;
		for(UserRegSummaryDto dto : list) {
			count += dto.getCount();
		}
		for(UserRegSummaryDto dto : list) {
			Double percentage = (double)dto.getCount()/count; 
			dto.setPercentage(percentage);
		}
		return list;
	}

	@Override
	public List<ReplySummaryDto> getReplyCountList() {
		List<ReplySummaryDto>list = replySummaryMapper.getCountList();
		int count = 0;
		for(ReplySummaryDto dto : list) {
			count += dto.getCount();
		}
		for(ReplySummaryDto dto : list) {
			Double percentage = (double)dto.getCount()/count; 
			dto.setPercentage(percentage);
		}
		return list;
	}

	
}
