package com.teamproject.www.jang.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.teamproject.www.jang.metaverse.Background;
import com.teamproject.www.jang.metaverse.Items;

@Controller("jangMetaverseController")
@RequestMapping("/jang/metaverse/*")
public class MetaverseController {
	
	@GetMapping("/main")
	public String main(HttpSession session) {
		System.out.println(session.getAttribute("loginSessionDto"));
		Background background = new Background();
//		List<Items> list = new ArrayList<Items>();
//		Items items = new Items();
//		Map<Integer, Integer> map = new HashMap<>();
//		map.put(1, 1);
//		items.setLocation(map);
//		items.setPrice(1);
//		items.setSizeX(1);
//		items.setSizeY(1);
//		list.add(items);
//		background.setItems(list);
//		ObjectMapper objectMapper = new ObjectMapper();
//		try {
//			JsonParser jsonparser = (JsonParser)objectMapper.createParser(background.toString());
////			jsonparser.
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		session.setAttribute("background", background);
		System.out.println(background);
		
		return "jang/board/metaverse/main";
	}
	
//	\
}
