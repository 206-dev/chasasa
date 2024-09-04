package com.teamproject.www.jang.controller.board;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/jang/board/market/*")
@Qualifier("jangMarketService")
public class MarketController {
	
	@GetMapping("/list")
	public String list() {
		return "jang/board/market/total";
	}
}
