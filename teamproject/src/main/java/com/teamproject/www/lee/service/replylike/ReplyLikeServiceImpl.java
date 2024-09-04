package com.teamproject.www.lee.service.replylike;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.www.lee.domain.reply.ReplyLikeDto;
import com.teamproject.www.lee.mapper.reply.ReplyMapper;
import com.teamproject.www.lee.mapper.replylike.ReplyLikeMapper;
import com.teamproject.www.lee.service.user.UserService;

import lombok.extern.log4j.Log4j;

@Service("leeReplyLikeService")
@Log4j
public class ReplyLikeServiceImpl implements ReplyLikeService{
	@Autowired
	private ReplyLikeMapper replyLikeMapper;
	@Autowired 
	private ReplyMapper replyMapper;
	@Autowired
	private UserService userService;

	private final int POINT = 1;
	// 댓글 좋아요 체크
	@Override
	public boolean checkLike(ReplyLikeDto dto) {
		int result = replyLikeMapper.checkLike(dto);
		if(result>0) {
			// 좋아요 이미 했기때문에 false
			return false;
		}
		return true;
	}
	
	// 댓글 좋아요
	@Override
	@Transactional
	public int replyLike(ReplyLikeDto dto) {
		log.info("replyLikeService, replyLike........................");
		log.info("dto : " + dto);
		int result = replyLikeMapper.replyLike(dto);
		log.info("result : " + result);
		if(result > 0) {
			log.info("댓글 좋아요 성공");
			int replyno = dto.getReplyno();
			String userid = dto.getReplyer();
			// 댓글 게시판에 likes 추가
			int resultLike = replyMapper.like(replyno);
			if(resultLike > 0) {
				// 포인트 추가
				userService.updatePoint(userid, POINT);
				// 좋아요 갯수 리턴
				return replyLikeMapper.getCountLikes(replyno);
			}
			log.info("댓글 게시판에 좋아요 추가 실패");
		}
		log.info("댓글 좋아요 실패");
		return 0;
	}

	
	// 댓글 취소
	@Override
	public int delete(ReplyLikeDto dto) {
		log.info("replyLikeService, replyLike........................");
		log.info("dto : " + dto);
		
		int result = replyLikeMapper.replyDisLike(dto);
		log.info("result : " + result);
		if(result > 0) {
			log.info("댓글 좋아요 취소 성공");
			int replyno = dto.getReplyno();
			String userid = dto.getReplyer();
			// 댓글 게시판에 likes 추가
			int resultLike = replyMapper.disLike(replyno);
			if(resultLike > 0) {
				// 댓글러 유저 포인트 차감
				userService.updatePoint(userid, -POINT);
				return replyLikeMapper.getCountLikes(replyno);
			}
			log.info("댓글 게시판에 좋아요 추가 실패");
		}
		log.info("댓글 좋아요 실패");
		
//		disLike
		return 0;
	}
	
	
}
