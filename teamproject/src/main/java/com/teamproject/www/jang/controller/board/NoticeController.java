package com.teamproject.www.jang.controller.board;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamproject.www.jang.domain.BoardVo;
import com.teamproject.www.jang.domain.NoticeCriteria;
import com.teamproject.www.jang.domain.NoticeDto;
import com.teamproject.www.jang.domain.NoticePageDto;
import com.teamproject.www.jang.service.BoardService;

@Controller
@RequestMapping("/jang/board/notice/*")
@Qualifier("jangBoardService")
public class NoticeController {
	// 허용된 정렬 조건
	private static final List<String> SORT_LIST = Arrays.asList("boardNo", "title", "content", "writer", "regdate", "views");
	private static final List<String> ORDER_LIST = Arrays.asList("desc", "asc");
	
	@Autowired
	private BoardService boardService;
	
	@GetMapping("/list")
	public List<NoticeDto> notice(NoticeCriteria cri,
					   @RequestParam(value = "sort", required = false) String sort ,
					   @RequestParam(value = "order", required = false) String order,
					   Model model) {
		
		// 정렬 값 세팅(기본값 - sort : boardNo, order - desc)
		// sort 와 order를 직접 받아와서 cri에 적용(NoticeCriteria의 field를 public으로 하지 않음)
		if(sort != null && SORT_LIST.contains(sort)) {
			cri.setSort(sort);
		}
		
		if(order != null && ORDER_LIST.contains(order)) {
			cri.setOrder(order);
		}
		
		// System.out.println("cri: " +cri);
		
		// 조건에 맞는 게시글의 총 갯수를 가져옴
		int total = boardService.getTotal(cri);
		System.out.println(total);
		
		// 조건에 맞는 게시글을 페이징하는 객체 생성
		NoticePageDto pageMaker = new NoticePageDto(cri, total);
		System.out.println("pageMaker:" + pageMaker);
		
		// 조건에 맞는 게시글 리스트를 가져옴
		List<NoticeDto> list = boardService.getListWithPaging(cri);
		 System.out.println(list);
		
		// 리스트와 페이징 객체를 jsp로 전송
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
		
		// System.out.println("type: " + cri.getType());
		// System.out.println("keyword: " + cri.getKeyword());
		return list;
	}
	
	// 비동기 get 요청에 대한 응답
	@ResponseBody
	@GetMapping("/list-data")
	public Map<String, Object> getNoticeData(NoticeCriteria cri,
					   @RequestParam(value = "sort", required = false) String sort ,
					   @RequestParam(value = "order", required = false) String order,
					   Model model) {
		
		// System.out.println("list-data...");
		// 정렬 값 세팅(기본값 - sort : boardNo, order - desc)
		// sort 와 order를 직접 받아와서 cri에 적용(NoticeCriteria의 field를 public으로 하지 않음)
		if(sort != null && SORT_LIST.contains(sort)) {
			cri.setSort(sort);
		}
		
		if(order != null && ORDER_LIST.contains(order)) {
			cri.setOrder(order);
		}
		
		// System.out.println("cri: " +cri);
		
		// 조건에 맞는 게시글의 총 갯수를 가져옴
		int total = boardService.getTotal(cri);
		
		// 조건에 맞는 게시글을 페이징하는 객체 생성
		NoticePageDto pageMaker = new NoticePageDto(cri, total);
		
		
		// 조건에 맞는 게시글 리스트를 가져옴
		List<NoticeDto> list = boardService.getListWithPaging(cri);
		// System.out.println(list);
		
		// 리스트와 페이징 객체를 jsp로 전송
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
		
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("list", list);
		data.put("pageMaker", pageMaker);
		
		return data;
	}
	
	@GetMapping("/detail")
	public String noticeDetail(@RequestParam("boardNo") Long boardNo, NoticeCriteria cri, Model model) {
		// System.out.println("cri: " + cri);
		NoticeDto noticeDto = boardService.getNotice(boardNo);

		// cri만 보내도 되지만 action_form에 셋팅된 기본 값(pageMaker.cri.xxx)을 사용하기 위해
		NoticePageDto pageMaker = new NoticePageDto(cri, 0);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("noticeDto", noticeDto);
		boardService.viewsUp(boardNo);
        return "forward:/WEB-INF/views/jang/board/notice/noticeDetail.jsp";
	}
	
	@GetMapping("/postForm")
	public String postForm() {
		return "/jang/board/notice/post";
	}
	
	@PostMapping("/post")
	public String post(BoardVo vo) {
		// System.out.println("post...");
		// System.out.println("vo : " + vo);
		boardService.insertNotice(vo);
		return "redirect:/jang/board/notice/list";
	}
	
	@ResponseBody
	@PostMapping("/modify")
	public ResponseEntity<Map> modify(String content, Long boardNo) {
//		System.out.println("content: " + content);
//		System.out.println("boardNo: " + boardNo);
		ResponseEntity<Map> response = null;
		String resultContent = "";
		
		boolean result = boardService.modify(content, boardNo);
		
		if(result) {
			Map<String, String> map = new HashMap<String, String>();
			resultContent = content;
			
			map.put("contentType", "text/plain;charset=utf-8");
			map.put("data", resultContent);
			response = new ResponseEntity<Map>(map, HttpStatus.OK);
			// System.out.println("결과: content -" + resultContent);
		}
		return response;
	}
	
	@PostMapping("/remove/{boardNo}")
	public String remove(@PathVariable("boardNo") Long boardNo, NoticeCriteria criteria) {
		boolean result = boardService.remove(boardNo);
		
		String url = String.format("?pageNum=%d&amount=%d&type=%s&keyword=%s&sort=%s&order=%s"
				,criteria.getPageNum(), criteria.getAmount(), criteria.getType(), criteria.getKeyword(), criteria.getSort(), criteria.getOrder()); 
		// System.out.println("url:" + url);
		// System.out.println(result);
		return "redirect:/jang/board/notice/list?" + url;
	}
}
