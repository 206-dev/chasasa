package com.teamproject.www.lee.service.lottery;

import org.apache.ibatis.annotations.Param;

public interface LotteryService {
	// 출첵 여부
	public boolean checkLottery(@Param("userid") String userid, @Param("cost") int cost);
	
	// 구매
	public String buyLottery(@Param("userid") String userid, @Param("cost") int cost);
}
