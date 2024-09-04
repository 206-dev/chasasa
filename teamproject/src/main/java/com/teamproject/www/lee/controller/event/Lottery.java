package com.teamproject.www.lee.controller.event;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.teamproject.www.common.domain.LoginSessionDto;
import com.teamproject.www.lee.service.lottery.LotteryService;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/lottery")
@Log4j
public class Lottery {
	@Autowired
	private LotteryService lotteryService;
	
	@GetMapping("/check/{cost}")
	public boolean check(@PathVariable("cost") int cost, HttpSession session) {
		log.info("Lottery .................");
		log.info("cost : " + cost);
		LoginSessionDto dto = (LoginSessionDto)session.getAttribute("loginSessionDto");
		String userid = dto.getUserid();
		return lotteryService.checkLottery(userid, cost);
	}
	
	@GetMapping("/buy/{cost}")
	public ResponseEntity<Map<String, String>> buy(@PathVariable("cost") int cost, HttpSession session) {
		LoginSessionDto dto = (LoginSessionDto)session.getAttribute("loginSessionDto");
		String userid = dto.getUserid();
		log.info("userid : " + userid + ", cost : " + cost);
		String resultString = lotteryService.buyLottery(userid, cost);
		log.info("lottery buy, resultString : " + resultString);
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", resultString);
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
}
