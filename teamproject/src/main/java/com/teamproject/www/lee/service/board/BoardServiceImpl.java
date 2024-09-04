package com.teamproject.www.lee.service.board;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.www.lee.Util.MyFileUtil;
import com.teamproject.www.lee.domain.AttachFileDto;
import com.teamproject.www.lee.domain.board.BoardDetailDto;
import com.teamproject.www.lee.domain.board.BoardInsertDto;
import com.teamproject.www.lee.domain.board.BoardListDto;
import com.teamproject.www.lee.domain.board.BoardUpdateDto;
import com.teamproject.www.lee.domain.board.Criteria;
import com.teamproject.www.lee.mapper.board.AttachMapper;
import com.teamproject.www.lee.mapper.board.BoardMapper;
import com.teamproject.www.lee.mapper.board.BoardTypeMapper;
import com.teamproject.www.lee.mapper.reply.ReplyMapper;
import com.teamproject.www.lee.mapper.replylike.ReplyLikeMapper;
import com.teamproject.www.lee.mapper.user.UserMapper;
import com.teamproject.www.lee.service.boardlike.BoardLikeService;
import com.teamproject.www.lee.service.reply.ReplyService;
import com.teamproject.www.lee.service.user.UserService;

@Service("leeBoardService")
public class BoardServiceImpl implements BoardService{
	@Autowired
	private BoardMapper boardMapper;
	@Autowired
	private ReplyMapper replyMapper;
	@Autowired
	private ReplyService replyService;
	@Autowired
	private ReplyLikeMapper replyLikeMapper;
	@Autowired
	private BoardLikeService boardLikeService;
	@Autowired
	private AttachMapper attachMapper;
	@Autowired
	private BoardTypeMapper boardTypeMapper;
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private UserService userServcie;
	
	private final int POINT = 10;
	
	//*** 자유게시판 ***--------------------------------------------------------
	// 자유게시판 글등록
	@Transactional
	@Override
	public int registerBoard(BoardInsertDto dto) {
//		System.out.println("boardservice......................");
//		System.out.println("boardSerice dto : " + dto);
		boardMapper.insertGetKey(dto);
		int boardno = dto.getBoardno();
		System.out.println("boardno : " + boardno);
		List<AttachFileDto> PathList = dto.getPathList();
		if(PathList != null && PathList.size() > 0) {
			PathList.forEach(getDto ->{
				getDto.setBoardno(boardno);
				attachMapper.insertAttach(getDto);
			});
			
		}
		
		//포인트
		String userid = dto.getUserid();
		boolean resultUpdatePoint = userServcie.updatePoint(userid, POINT);
		if(resultUpdatePoint == false) {
			System.out.println("resultUpdatePoint 실패");
		}
		
		return boardno;
	}

	// 자유게시판 리스트 가져오기
	@Override
	public List<BoardListDto> getList(Criteria criteria, String boardtype) {
//		System.out.println("getlist....................................");
//		System.out.println("boardtype : " + boardtype);
//		System.out.println("criteria : " + criteria);
		int boardtypeno = 0 ;
		boardtypeno = boardTypeMapper.getBoardTypeNo(boardtype);
		criteria.setBoardtypeno(boardtypeno);
		List<BoardListDto> list = boardMapper.getListWithPaging(criteria);
//		System.out.println("list : " + list);
		return list;
	}

	// 디테일 가져오기
	@Transactional
	@Override
	public BoardDetailDto getDetail(int boardno) {
		BoardDetailDto dto = boardMapper.getDetail(boardno);
		String userid = dto.getUserid();
		String profile = userMapper.getProfileImg(userid);
		dto.setProfile(profile);
		return dto;
	}

	// 총갯수
	@Override
	public int getAllCount(Criteria criteria) {
		return boardMapper.getAllCount(criteria);
	}

	// 글 삭제
	@Transactional
	@Override
	public boolean delete(int boardno, String userid) {
		// 게시글삭제
		// 댓글삭제
//		System.out.println("boardServiceImpl..........................................");
//		System.out.println("delete..........................................");
//		System.out.println("boardno : " + boardno);
		List<Integer> replynoList = replyMapper.getListReplyno(boardno);
//		System.out.println("replynoList : " + replynoList);
		if(replynoList!=null && replynoList.size() != 0) {
			System.out.println("replynoList not null");
			//댓글이 존재하면 좋아요 확인후 삭제
			//좋아요 먼저 삭제
			for(int replyno : replynoList) {
//				System.out.println("replynoList for...");
				int result = replyLikeMapper.deleteLike(replyno);
//				System.out.println("deleteLike result : " + result);
				if(result == 0) {
//					System.out.println("댓글 좋아요 삭제 실패");
					//좋아요 삭제 실패
					return false;
				}
			}
			
			//댓글삭제
			System.out.println("replyMapper.deleteByBoardNo..........................................");
			boolean replyResult = replyService.deleteByBoardNo(boardno, userid);
			if(replyResult==false) {
				//댓글 삭제실패
//				System.out.println("댓글 삭제 실패");
				return false;
			}
		}
		// 이미지보드 삭제
//		System.out.println("attachMapper.getCountByBoardno..........................................");
		int attachCount = attachMapper.getCountByBoardno(boardno);
		if(attachCount>0) {
			//이미지존재
			//이미지 삭제
			System.out.println("attachMapper.getPathListByBoardNo..........................................");
			List<String> imgPathList = attachMapper.getPathListByBoardNo(boardno);
			boolean isDelImg = MyFileUtil.deleImg(imgPathList);
			if(!isDelImg) {
				System.out.println("이미지 삭제 실패");
				return false;
			}
			//이미지 테이블 삭제
			System.out.println("attachMapper.getPathListByBoardNo..........................................");
			int AttachResult = attachMapper.deleteByBoardNo(boardno);
			if(AttachResult==0) {
				System.out.println("이미지 보드 삭제실패");
				return false;
			}
		}
		// 좋아요 삭제 with boardno
		boolean deleteResult = boardLikeService.deleteAllLikeWithBoardno(boardno);
		if(deleteResult==false) {
			System.out.println("좋아요 삭제 실패");
			return false;
		};
		//포인트 감소
		boolean updatePointResult = userServcie.updatePoint(userid, -POINT);
		if(updatePointResult == false) {
			System.out.println("포인트 감소 실패");
			return false;
		}
		int resultBoardDel =  boardMapper.delete(boardno);
		if(resultBoardDel == 0) {
			System.out.println("게시글 삭제실패");
			return false;
		}
		return true;
	
	}

	// 글 수정
	@Transactional
	@Override
	public boolean update(BoardUpdateDto dto) {
//		System.out.println("board service........................");
//		System.out.println("dto : " + dto);
		int boardno = dto.getBoardno();
		List<AttachFileDto> getPathList = dto.getPathList();
		List<String> pathList = new ArrayList<String>();
		if(getPathList != null && getPathList.size()  > 0) {
			for(AttachFileDto pathDto : getPathList) {
				pathList.add(pathDto.getUploadpath());
			}
			for(String path : pathList) {
				AttachFileDto attachDto = new AttachFileDto();
				attachDto.setBoardno(boardno); 
				attachDto.setUploadpath(path);
				attachMapper.insertAttach(attachDto);
			}
		}else {
			
		}
		// attach 수정
		// 삭제
		attachMapper.deleteByBoardNo(boardno);
		//수정
		int result = boardMapper.update(dto);
		if(result > 0) {return true;}
		return false;
	}

	// 조회수 증가
	@Override
	public boolean plusViews(int board) {
		int result = boardMapper.pluseViews(board);
		if(result>0) {return true;};
		return false;
	}
}
