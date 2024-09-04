package com.teamproject.www.lee.service.boardlike;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.www.lee.domain.board.BoardLikeDto;
import com.teamproject.www.lee.mapper.boardlike.BoardLikeMapper;
import com.teamproject.www.lee.mapper.user.UserMapper;

@Service("leeBoardLikeService")
public class BoardLikeServiceImpl implements BoardLikeService{
	@Autowired
	private BoardLikeMapper boardLikeMapper;
	@Autowired
	private UserMapper usermapper;
	
	private final int POINT = 2;

	
	//내가 추천 했는지 조회
	@Override
	public boolean checkLike(BoardLikeDto dto) {
		int result = boardLikeMapper.checkLike(dto);
		if(result>0) {return true;};
		return false;
	}
	
	//추천하기
	@Transactional
	@Override
	public int like(BoardLikeDto dto) {
		int boardno = dto.getBoardno();
		int result = boardLikeMapper.like(dto);
		if(result > 0) {
			String userid = dto.getUserid();
			
			// point
			int resultPoint = usermapper.updatePoint(userid, POINT);
			if(resultPoint>0){
				// 라이크 겟수 가져옴
				return boardLikeMapper.getLikes(boardno);
			}
		}
		return 0;
	}
	
	// 내 좋아요 삭제
	@Transactional
	@Override
	public int deleteMyLike(BoardLikeDto dto) {
		int boardno = dto.getBoardno();
		int result = boardLikeMapper.deleteMyLike(dto);
		if(result > 0) {
			String userid = dto.getUserid();
			//point
			int resultPoint = usermapper.updatePoint(userid, -POINT);
			if(resultPoint>0){
				//삭제 성공시
				return boardLikeMapper.getLikes(boardno);
			}
		}
		return 0;
	}

	// 게시번호에 모든 좋아요 삭제
	@Transactional
	@Override
	public boolean deleteAllLikeWithBoardno(int boardno) {
		int likeCount = boardLikeMapper.getLikes(boardno);
		if(likeCount>0) {
			// 좋아요 존재
			// 게시글 좋아요 삭제
			int result = boardLikeMapper.deleteLike(boardno);
			if(result == 0) {
				System.out.println("게시글 좋아요 삭제 실패");
				return false;
			}
		}
		return true;
	}
	
	
	

	
}
