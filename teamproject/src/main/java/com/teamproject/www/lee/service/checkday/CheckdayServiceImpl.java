package com.teamproject.www.lee.service.checkday;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.www.lee.mapper.checkday.CheckdayMapper;
import com.teamproject.www.lee.service.user.UserService;


@Service("checkdayService")
public class CheckdayServiceImpl implements CheckdayService{
	@Autowired
	private CheckdayMapper checkdayMapper;
	@Autowired
	private UserService userService;
	
	//출첵조회
	@Override
	public boolean isCheckday(String userid) {
		int result = checkdayMapper.isCheckday(userid);
		if(result > 0) {
			return false;
		}
		return true;
	}

	//출첵
	@Override
	@Transactional
	public boolean registCheckday(String userid) {
		int result = checkdayMapper.insertCheckday(userid);
		if(result == 0) {
			return false;
		}
		return userService.updatePoint(userid, 10);
	}

	//출첵 리스트
	@Override
	public List<Integer> getCheckDayList(String userid) {
		return checkdayMapper.getCheckdayList(userid);
	}

	

	
}
