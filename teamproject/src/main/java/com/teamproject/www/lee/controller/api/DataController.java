package com.teamproject.www.lee.controller.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.teamproject.www.common.domain.LoginSessionDto;
import com.teamproject.www.lee.domain.api.EventResponseDto;
import com.teamproject.www.lee.domain.item.ItemBuyDto;
import com.teamproject.www.lee.domain.item.MyItemDto;

import com.teamproject.www.lee.service.item.ItemService;
import com.teamproject.www.lee.service.user.UserService;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/api")
@Log4j
@Qualifier("leeItemService")
@SuppressWarnings("unused")
public class DataController {
	@Autowired
	private ItemService itemService;
	@Autowired
	private UserService userService;
	
	// 내아이템 목록 가져오기
	@GetMapping("/items")
	public ResponseEntity<List<MyItemDto>> getData(HttpSession session) {
		log.info("getData....");
		LoginSessionDto dto = (LoginSessionDto)session.getAttribute("loginSessionDto");
		log.info("dto : " + dto);
		String userid = dto.getUserid();
		log.info("userid : " + userid);
		List<MyItemDto> data = itemService.getMyItemList(userid);
		log.info("List<MyItemDto> : " + data);
		if(dto == null) {
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		}
		return new ResponseEntity<>(data, HttpStatus.OK);
	}
	
	
	//유저 정보 가져오기
	@GetMapping("/userInfo")
	public ResponseEntity<Map<String, String>> getUserInfo(HttpSession session) {
		log.info("getNickname....");
		LoginSessionDto dto = (LoginSessionDto)session.getAttribute("loginSessionDto");
		log.info("dto : " + dto);
		if(dto == null) {
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		}
		String userId = dto.getUserid();
		String nickname = dto.getNickname();
		String gender = userService.getGender(userId);
		Map<String, String> data = new HashMap<String, String>();
		data.put("userId", userId);
		data.put("nickname", nickname);
		data.put("gender", gender);
		log.info("data : " + data);
		return new ResponseEntity<Map<String,String>>(data, HttpStatus.OK);
	}
	
	//아이템구입
	@PostMapping("/buyItem")
	public boolean buyItem(@RequestBody ItemBuyDto dto) {
		log.info("buyItem..");
		log.info("dto : " + dto);
		return itemService.buyItem(dto);
	}
	
	@SuppressWarnings("unchecked")
	@PostMapping("/eventSmallTent")
	public ResponseEntity<EventResponseDto> eventSmallTent(@RequestBody String requestBody) {
		log.info("eventSmallTent......");
//		log.info("requestBody : " + requestBody);
		ObjectMapper objectMapper = new ObjectMapper();
		Boolean eventResult = false; 
		try {
			Map<String, String> map = objectMapper.readValue(requestBody, Map.class);
			String userid = map.get("userid");
			log.info("userid : " + userid);
			eventResult = itemService.eventSmallTent(userid);
			if(!eventResult) {
				return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		EventResponseDto dto = new EventResponseDto();
		dto.setResult(eventResult);
		dto.setUrl("http://192.168.1.103/lee/chataverse/itemshop");

		return new ResponseEntity<EventResponseDto>(dto, HttpStatus.OK);
	}
	
	@SuppressWarnings("unchecked")
	@PostMapping("/checkUserid")
	public ResponseEntity<Map<String, Boolean>> checkUserid(@RequestBody String requestBody) {
		log.info("checkUserid......");
//		log.info("requestBody : " + requestBody);
		ObjectMapper objectMapper = new ObjectMapper();
		boolean result = false;
		try {
			Map<String, String> map = objectMapper.readValue(requestBody, Map.class);
			String userid = map.get("userid");
			log.info("userid : " + userid);
			result = userService.joinCheckId(userid);
			if(!result) {
				return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("userIdCheckResult", result);
		return new ResponseEntity<Map<String,Boolean>>(map, HttpStatus.OK);
	}
}
