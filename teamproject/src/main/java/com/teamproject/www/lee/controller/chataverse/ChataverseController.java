package com.teamproject.www.lee.controller.chataverse;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamproject.www.common.domain.LoginSessionDto;
import com.teamproject.www.lee.domain.item.ItemTypeDto;
import com.teamproject.www.lee.domain.item.MyItemDto;
import com.teamproject.www.lee.domain.item.ShopItemDto;
import com.teamproject.www.lee.service.item.ItemService;
import com.teamproject.www.lee.service.user.UserService;


import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/lee/chataverse/*")
@Log4j
//@Qualifier("leeReplyService")
public class ChataverseController {
	@Autowired
	private ItemService itemService;
	@Autowired
	private UserService userService;
	
	@GetMapping("/loading")
	public void loading() {}
	
	@GetMapping("/checkUser")
	public String checkUser(HttpSession session){
		log.info("checkUser...");
		LoginSessionDto dto = (LoginSessionDto)session.getAttribute("loginSessionDto");
		String userid = dto.getUserid();
		log.info("userid : " + userid);
		//가입이 되있는 체크하고 신규인지 가입자인지에 따라
		//성별 선택 or 캐릭 선택 창으로
		boolean resultCheckGender = userService.checkGender(userid);
		itemService.checkMyBasicItem(userid);
		log.info("resultCheckGender : " + resultCheckGender);
		if(resultCheckGender) {
			return "redirect:/lee/chataverse/choiceRegion";
		}else {
			//성별 선택
			return "redirect:/lee/chataverse/selectGender";
		}
	}
	
	@GetMapping("/selectGender")
	public void selectGender() {
		
	}
	
	
	@GetMapping("/choiceGenderRun/{gender}")
	public String choiceCharacter(@PathVariable("gender") String gender, HttpSession session) {
		log.info("choiceCharacter.......");
		log.info("gender : " + gender);
		//성별 등록
		LoginSessionDto dto = (LoginSessionDto)session.getAttribute("loginSessionDto");
		String userid = dto.getUserid();
		boolean resultUpdateGender = userService.updateGender(userid, gender);
		if(resultUpdateGender) {
			return "redirect:/lee/chataverse/checkUser";			
		}
		return "/";
	}
	
	@GetMapping("/choiceRegion")
	public void choiceRegion(){
		
	}
	
	//로딩 플레이
	@GetMapping("/loadingPlay/{region}")
	public String loadingPlay(@PathVariable("region") String region, RedirectAttributes rttr) {
		rttr.addFlashAttribute("region", region);
		return "lee/chataverse/loadingPlay";
	}
	//플레이
	@GetMapping("/play/{region}")
	public String play(@PathVariable("region") String region, HttpServletResponse response) {
		log.info("play......................");
		log.info("region : " + region);
		
		// Cashe-Controll 헤더 설정
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
		return "lee/chataverse/play";
	}
	
	//아이템샵
	@GetMapping("/itemshop")
	public void itemshop(HttpSession session) {
		LoginSessionDto loginSessionDto = (LoginSessionDto)session.getAttribute("loginSessionDto");
		if(loginSessionDto!=null) {
			String userid = loginSessionDto.getUserid();
			List<MyItemDto> myItemList = itemService.getMyItemList(userid);
			session.setAttribute("myItemList", myItemList);
			log.info("myItemList : " + myItemList);
		}
		List<ItemTypeDto> itemTypeList = itemService.getItemTypeList();
		List<ShopItemDto> itemList = itemService.getItemList();
		log.info("itemTypeList : " + itemTypeList);
		log.info("itemList : " + itemList);
		
		session.setAttribute("itemTypeList", itemTypeList);
		session.setAttribute("itemList", itemList);
	};
	
	
}
