package com.teamproject.www.lee.service.checkday;

import java.util.List;

public interface CheckdayService {
	
	// 출첵 여부
	public boolean isCheckday(String userid);
	
	// 출쳌
	public boolean registCheckday(String userid);

	// 이번달 출첵 리스트
	public List<Integer> getCheckDayList(String userid);
}
