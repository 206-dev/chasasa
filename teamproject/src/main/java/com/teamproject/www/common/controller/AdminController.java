package com.teamproject.www.common.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.teamproject.www.common.domain.BoardSummaryDto;
import com.teamproject.www.common.domain.ReplySummaryDto;
import com.teamproject.www.common.domain.ReportVo;
import com.teamproject.www.common.domain.UnprocessedReportDto;
import com.teamproject.www.common.domain.UserActionDto;
import com.teamproject.www.common.domain.UserGradeDto;
import com.teamproject.www.common.domain.UserRegSummaryDto;
import com.teamproject.www.common.service.ReportService;
import com.teamproject.www.common.service.SummaryService;
import com.teamproject.www.common.service.UserActionService;
import com.teamproject.www.jang.service.BoardService;
import com.teamproject.www.lee.service.user.UserService;

import lombok.extern.log4j.Log4j;


@Controller
@RequestMapping("/admin/*")
@Qualifier("reportService")
@Log4j
public class AdminController {
	
	@Autowired
	private ReportService reportService;
	
	@Qualifier("jangBoardService")
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private UserActionService userActionService;
	
	@Autowired
	private SummaryService summaryService;
	
	@Qualifier("leeUserService")
	@Autowired
	private UserService userService;
	
	@GetMapping("/main")
	public String main() {
		return "/common/administor/main";
	}
	
	@GetMapping("/index")
	public String index() {
		return "/common/administor/index";
	}
	
	@GetMapping("/report")
	public String complaints(Model model) {
		List<UnprocessedReportDto> list = reportService.getUnprocessedList();
		model.addAttribute("reportList", list);
		return "/common/administor/report";
	}
	
	
	@GetMapping("/user")
	public String user() {
		return "/common/administor/user";
	}
	
	@ResponseBody
	@GetMapping("/user/action-history")
	public List<UserActionDto> getUserActions(@RequestParam("target") String target, @RequestParam("targetType") String targetType) {
		// System.out.println("target :" + target);
		// System.out.println("targetType :" + targetType);
		List<UserActionDto> list = userActionService.getUserActionList(target, targetType);
		// System.out.println(list);
		return list;
	}
	
	@PostMapping("/user/restriction")
	public String restriction(UserActionDto dto, @RequestParam("period") String period,
			@RequestParam("target") String target, @RequestParam("targetType") String targetType, @RequestParam("reportNo") Long reportNo) {
		ReportVo vo = new ReportVo();
		vo.setReportNo(reportNo);
		vo.setTarget(target);
		vo.setTargetType(targetType);
		// System.out.println("ctr/dto: " + dto);
		// System.out.println("ctr/vo: " + vo);
		boolean result= userActionService.insert(dto, period, vo);
		return "redirect:/admin/report";
	}
	
	@GetMapping("/summary")
	public String summary(HttpSession session) throws JsonProcessingException {
		List<BoardSummaryDto> boardList = summaryService.getBoardCountList();
		List<ReplySummaryDto> replyList = summaryService.getReplyCountList();
		List<UserRegSummaryDto>	regUserList = summaryService.getUserRegCountList(7, 0);
		
		ObjectMapper mapper = new ObjectMapper();
        String jsonBoardList = mapper.writeValueAsString(boardList);
        String jsonReplyList = mapper.writeValueAsString(replyList);
        String jsonUserRegList = mapper.writeValueAsString(regUserList);
        session.setAttribute("boardSummaryList", jsonBoardList);
        session.setAttribute("replySummaryList", jsonReplyList);
        session.setAttribute("userRegSummaryList", jsonUserRegList);
        
        System.out.println(regUserList);
        
		return "/common/administor/summary";
	}
	
	
	//등급 조회
	@ResponseBody
	@GetMapping("/getGarde/{userid}")
	public int getGrade(@PathVariable("userid") String userid) {
		log.info("userid : "+ userid);
		
		return userService.getGradeno(userid);
	}
	
	//등급 변경
	@ResponseBody
	@PostMapping("/modifyGrade")
	public boolean modifyGrade(@RequestBody UserGradeDto dto) {
		return userService.modifyGrade(dto);
	}
	
}
