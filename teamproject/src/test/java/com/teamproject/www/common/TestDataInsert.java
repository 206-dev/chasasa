package com.teamproject.www.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.www.lee.domain.board.BoardInsertDto;
import com.teamproject.www.lee.domain.reply.ReplyInsertDto;
import com.teamproject.www.lee.domain.user.JoinDto;
import com.teamproject.www.lee.service.board.BoardService;
import com.teamproject.www.lee.service.reply.ReplyService;
import com.teamproject.www.lee.service.user.UserService;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class TestDataInsert {
	@Autowired
	private UserService userService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private ReplyService replyService;
	
	@Test
	public void userInstance() {
		log.info(userService);
	}
	@Test
	public void boardInstance() {
		log.info(boardService);
	}
	@Test
	public void replyInstance() {
		log.info(replyService);
	}
	
	
	//테스트 유저 생성
	@Test
	public void createTestUser() {
		JoinDto dto = new JoinDto();
		int count = 5;
		for(int i=1; i<=count; i++) {
			String userid = "test" + i;
			String email = "test" + i +"@email.com";
			String nickname = "테스트맨" + i;
			dto.setUserid(userid);
			dto.setUserpw("1234");
			dto.setNickname(nickname);
			dto.setEmail(email);
			userService.signUp(dto);
		}
	}

	//게시글 등록
	@Test
	public void createTestboard() {
		List<String> useridList = new ArrayList<String>();
		Map<String, String> nicknameMap = new HashMap<String, String>();
//		List<Map<String, String>> userList = new ArrayList<Map<String,String>>();
		List<Integer> boardnoList = new ArrayList<Integer>();
		int[] boardtypenum = {2,4,6,7,8,9,10,11};
		
		int count = 5;
		for(int i=1; i<=count; i++) {
			String userid = "test" + i;
			String nickname = "테스트맨" + i;
			
			nicknameMap.put(userid, nickname);
			useridList.add(userid);
		}
		log.info("useridList : " + useridList);
		int num = 1;
		for(int i=0; i<boardtypenum.length; i++) {
			int boardtypeno= boardtypenum[i];
			BoardInsertDto dto = new BoardInsertDto();
			for(int k=0; k<4; k++) {
				for(int j=0; j<useridList.size(); j++) {
					String userid = useridList.get(j);
					String nickname = nicknameMap.get(userid);
					String title = "테스트입니다-" + num;
					String content = "<p>"+ "테스트입니다" + "</p>";
					dto.setBoardtypeno(boardtypeno);
					dto.setUserid(userid);
					dto.setNickname(nickname);
					dto.setTitle(title);
					dto.setContent(content);
					int boardno = boardService.registerBoard(dto);
					boardnoList.add(boardno);
					num++;
				}
			}
		}
		
		log.info("boardnoList : " + boardnoList);
		for(int i=0; i<boardnoList.size(); i++) {
			int boardno = boardnoList.get(i);
			for(int j=0; j<useridList.size(); j++) {
				ReplyInsertDto dto = new ReplyInsertDto();
				String userid = useridList.get(j);
				String nickname = nicknameMap.get(userid);
				String comments = "테스트입니다.";
				dto.setBoardno(boardno);
				dto.setUserid(userid);
				dto.setNickname(nickname);
				dto.setComments(comments);
				replyService.registerReply(dto);
			}
		}
	}
}
