package com.teamproject.www.lee.controller.event;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.teamproject.www.common.domain.LoginSessionDto;
import com.teamproject.www.lee.service.checkday.CheckdayService;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/checkDay")
@Log4j
public class CheckDay {
	@Autowired
	private CheckdayService checkdayService;
	
	@GetMapping("/today")
	public boolean today(HttpSession session) {
		LoginSessionDto dto = (LoginSessionDto)session.getAttribute("loginSessionDto");
		String userid = dto.getUserid();
//		log.info("userid : " + userid);
		
		return checkdayService.isCheckday(userid);
	}
	
	@GetMapping("/regist")
	public boolean regist(HttpSession session) {
		LoginSessionDto dto = (LoginSessionDto)session.getAttribute("loginSessionDto");
		String userid = dto.getUserid();
//		log.info("userid : " + userid);
		
		return checkdayService.registCheckday(userid);
	}
	
	@GetMapping("/getList")
	public List<Integer> getList(HttpSession session){
		LoginSessionDto dto = (LoginSessionDto)session.getAttribute("loginSessionDto");
		String userid = dto.getUserid();
		
		return checkdayService.getCheckDayList(userid);
	}
}
