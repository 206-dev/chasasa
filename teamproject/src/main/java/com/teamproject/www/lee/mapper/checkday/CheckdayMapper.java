package com.teamproject.www.lee.mapper.checkday;

import java.util.List;

public interface CheckdayMapper {
	//오늘 출첵 여부 확인
	public int isCheckday(String userid);
	
	//출쳌 추가
	public int insertCheckday(String userid);
	
	//이번달 출석 여부 가져오기
	public List<Integer> getCheckdayList(String userid);
}	
