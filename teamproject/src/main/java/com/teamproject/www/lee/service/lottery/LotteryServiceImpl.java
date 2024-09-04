package com.teamproject.www.lee.service.lottery;


import java.util.Random;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.www.lee.mapper.lottery.LotteryMapper;
import com.teamproject.www.lee.service.user.UserService;

import lombok.extern.log4j.Log4j;



@Service("lotteryService")
@Log4j
public class LotteryServiceImpl implements LotteryService{
	@Autowired
	private LotteryMapper lotteryMapper;
	@Autowired
	private UserService userService;
	
	private final int FIRST_WIN_MULTIPLE = 100;
	private final int SECOND_WIN_MULTIPLE = 10;
	private final int THIRD_WIN_MULTIPLE = 5;
	private final int FOURTH_WIN_MULTIPLE = 2;
	private final int BOOM = 0;
	
	@Override
	public boolean checkLottery(String userid, int cost) {
		int result = lotteryMapper.checkLottery(userid, cost);
		if(result == 0) {
			return true;
		}
		return false;
	}

	@Transactional
	@Override
	public String buyLottery(@Param("userid") String userid, @Param("cost") int cost) {
		int buyResult = lotteryMapper.buyLottery(userid, cost);
		if(buyResult == 0) {
			log.info("buyResult : " + buyResult);
		}
		
		boolean updatePointResult = userService.updatePoint(userid, -cost);
		if(!updatePointResult) {
			log.info("updatePointResult : " + updatePointResult);
		}
		
		int resultLottery = lottery();
		if(resultLottery != BOOM) {
			boolean updateLotteryPointResult = false;
			switch(cost) {
				case 50:
				case 100:
					for(int i=0; i<resultLottery; i++) {
						updateLotteryPointResult = userService.updatePoint(userid, cost);
					}
					break;
				case 500:
					for(int i=0; i<resultLottery*5; i++) {
						updateLotteryPointResult = userService.updatePoint(userid, 100);
					}
					break;
			}
			if(!updateLotteryPointResult) {
				log.info("updateLotteryPointResult : " + updateLotteryPointResult);
			}
		}
		
		String lotteryResultString = "";
		switch(resultLottery) {
			case FIRST_WIN_MULTIPLE :
				lotteryResultString = "1등 당첨!";
				break;
			case SECOND_WIN_MULTIPLE :
				lotteryResultString = "2등 당첨!";
				break;
			case THIRD_WIN_MULTIPLE :
				lotteryResultString = "3등 당첨!";
				break;
			case FOURTH_WIN_MULTIPLE :
				lotteryResultString = "4등 당첨!";
				break;
			case BOOM :
				lotteryResultString = "꽝!";
				break;
		}
			
		return lotteryResultString;
	}

	public int lottery() {
		Random random = new Random();
		
        // 1등: 0.1% 확률
        if (random.nextInt(1000) + 1 == 1) {
            return FIRST_WIN_MULTIPLE;
        }

        // 2등: 2% 확률
        if (random.nextInt(100) + 1 <= 2) {
            return SECOND_WIN_MULTIPLE;
        }

        // 3등: 10% 확률
        if (random.nextInt(10) + 1 == 1) {
            return THIRD_WIN_MULTIPLE;
        }

        // 4등: 30% 확률
        if (random.nextInt(10) + 1 <= 3) {
            return FOURTH_WIN_MULTIPLE;
        }

        // 당첨되지 않음
        return BOOM;
		
	}
}
