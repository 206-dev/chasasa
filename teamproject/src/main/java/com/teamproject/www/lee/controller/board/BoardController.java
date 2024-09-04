package com.teamproject.www.lee.controller.board;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.teamproject.www.lee.Util.MyFileUtil;
import com.teamproject.www.lee.domain.PageDto;
import com.teamproject.www.lee.domain.board.BoardDetailDto;
import com.teamproject.www.lee.domain.board.BoardInsertDto;
import com.teamproject.www.lee.domain.board.BoardListDto;
import com.teamproject.www.lee.domain.board.BoardTypeVo;
import com.teamproject.www.lee.domain.board.BoardUpdateDto;
import com.teamproject.www.lee.domain.board.Criteria;
import com.teamproject.www.lee.service.board.BoardService;
import com.teamproject.www.lee.service.board.BoardTypeService;

import lombok.extern.log4j.Log4j;



@Controller
@RequestMapping("/lee/board/*")
@Log4j
@Qualifier("leeBoardService")
public class BoardController {
	private BoardService boardService;
	private BoardTypeService boardTypeService;
	
	@Autowired
	public BoardController(@Qualifier("leeBoardService") BoardService boardService,
						   @Qualifier("leeBoardTypeService") BoardTypeService boardTypeService) {
		this.boardService = boardService;
		this.boardTypeService = boardTypeService;
	}
	
	//**게시판
	@GetMapping("/list/{bt}")
	public String listBoardType(@PathVariable("bt") String bt, Model model, Criteria criteria,HttpSession session) {
//		log.info("listBoardType................");
//		log.info("criteria : " + criteria);
//		log.info("boardtype : " + boardtype);
		List<BoardListDto> list = boardService.getList(criteria, bt);
		
		// 보드 타입정보 세션 추가
		int boardtypeno = boardTypeService.getBoardTypeNo(bt);
		BoardTypeVo vo = new BoardTypeVo();
		vo.setBoardtypeno(boardtypeno);
		vo.setBoardtype(bt);
//		criteria.setBoardtype(btno);
		session.setAttribute("boardtype", vo);
//		log.info(session.getAttribute("boardtype"));
//		log.info("criteria : " + criteria);
		int allCount = boardService.getAllCount(criteria);
		PageDto pageMaker = new PageDto(criteria, allCount);
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
//		log.info("criteria : " + criteria);
//		log.info("list : " + list);
//		log.info("boardtype : " + vo);
		return "lee/board/list";
	}
	
	//**글쓰기**
	//글쓰기
	@GetMapping("/write")
	public void write() {
	};
	
	
	//글쓰기 처리
	@PostMapping("/writeRun")
	public String writeRun(BoardInsertDto dto) {
//		log.info("writeRun....................................");
//		log.info("dto : " + dto);
		int boardno = boardService.registerBoard(dto);
		return "redirect:/lee/board/detail?boardno="+boardno;
//		return "redirect:/";
	}
	//상세페이지
	@GetMapping("/detail")
	public String detail(Model model, int boardno , Criteria criteria, 
					   HttpServletRequest request, HttpServletResponse response) {
//		log.info("controller, detail...................................");
//		log.info("getDetail 전");
//		log.info("request : " + request);
//		log.info("response : " + response);
		
		//게시글 정보가져오기
		BoardDetailDto dto = boardService.getDetail(boardno);
//		log.info("getDetail 후");
//		log.info("dto : " + dto);
		
		//게시판타입 정보
		BoardTypeVo vo = new BoardTypeVo();
		vo.setBoardtypeno(dto.getBoardtypeno());
		vo.setBoardtype(dto.getBoardtype());
//		log.info("criteria : " + criteria);
		
		//model에 정보 넣기
		model.addAttribute("dto", dto);
		model.addAttribute("criteria", criteria);
		model.addAttribute("boardno", boardno);
		
		//조회수 관리
		boolean checkViews = MyFileUtil.checkViews(request, response, boardno);
		if(checkViews) {
			boardService.plusViews(boardno);
		}
		return "lee/board/detail";
	}
	
	//글삭제
	@PostMapping("/deleteRun")
	public String delete(int boardno, String userid,Criteria criteria, Model model, HttpSession session) {
		BoardTypeVo vo = (BoardTypeVo)session.getAttribute("boardtype");
		String boardtype = vo.getBoardtype();
		model.addAttribute("criteria", criteria);
		boolean result = boardService.delete(boardno, userid);
		System.out.println("del, result : " + result);
		return "redirect:/lee/board/list/" + boardtype;
	}
	//글 수정
	@PostMapping("/updateRun")
	public String delete(BoardUpdateDto dto, Criteria criteria, Model model) {
		model.addAttribute("criteria", criteria);
		boolean result = boardService.update(dto);
		System.out.println("update, result : " + result);
		int boardno = dto.getBoardno();
		return "redirect:/lee/board/detail?boardno="+boardno;
	}
	
}
