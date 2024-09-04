package com.teamproject.www.lee.mapper.lottery;

import org.apache.ibatis.annotations.Param;

public interface LotteryMapper {
	//오늘 로터리 체크
	public int checkLottery(@Param("userid") String userid, @Param("cost") int cost);

	// 구매
	public int buyLottery(@Param("userid") String userid, @Param("cost") int cost);

}	
