package com.teamproject.www.common.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.www.common.domain.ReportVo;
import com.teamproject.www.common.domain.UserActionDto;
import com.teamproject.www.common.mapper.ReportMapper;
import com.teamproject.www.common.mapper.UserActionMapper;

@Service("userActionsService")
public class UserActionServiceImpl implements UserActionService{

	@Autowired
	private UserActionMapper userActionsMapper;

	@Autowired
	private ReportMapper reportMapper;
	
	@Override
	public List<UserActionDto> getList() {
		List<UserActionDto> list = userActionsMapper.getList();
		return list;
	}

	@Override
	public List<UserActionDto> getUserActionList(@Param("target") String target, @Param("targetType") String targetType) {
//		System.out.println("target: " + target);
		System.out.println("targetType: " + targetType);
		String userId = reportMapper.getUserId(target, targetType);
		System.out.println("userId: " + userId);
		List<UserActionDto> list = userActionsMapper.getListByUserId(userId);
//		System.out.println("list: " + list);
		return list;
	}

	@Override
	public boolean insert(@Param("dto") UserActionDto dto,
			@Param("period")  String period, @Param("vo") ReportVo vo) {
//		System.out.println("ser/dto : " + dto);
//		System.out.println("ser/vo : " + vo);
		String userId = reportMapper.getUserId(vo.getTarget(), vo.getTargetType());
		dto.setUserId(userId);
		int numPeriod = Integer.valueOf(period);
		boolean result = false;
		int count = userActionsMapper.insert(dto, numPeriod);
		count += reportMapper.update(vo.getReportNo(), "completed");
		if(count > 1) {
			result = true;
		}
		return result;
	}

	@Override
	public int update(String status, String userId) {
		int count = userActionsMapper.update(status, userId);
		return 0;
	}
	
}
