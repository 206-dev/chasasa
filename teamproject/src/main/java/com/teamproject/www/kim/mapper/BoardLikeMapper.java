package com.teamproject.www.kim.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.teamproject.www.kim.domain.BoardLikeDto;
import com.teamproject.www.kim.domain.UserBoardTypePreferenceDto;

@Mapper
public interface BoardLikeMapper {
    // 추천 추가
    void insertLike(BoardLikeDto boardLikeDto);
    
    // 추천 제거
    void deleteLike(BoardLikeDto boardLikeDto);
    
    // 추천 여부 확인 (추천한 사용자와 게시글 번호로 확인)
    int checkLikeExist(BoardLikeDto boardLikeDto);
    
    // 추천수 조회
    int selectLikeCount(Integer boardNo);
    
    // 좋아요 추가 시 게시글의 좋아요 수 증가
    void incrementBoardLikeCount(Long boardNo);
    
    // 좋아요 제거 시 게시글의 좋아요 수 감소
    void decrementBoardLikeCount(Long boardNo);

	
    String getContentByBoardNo(Long boardNo);
    
    
    
    
    // 관심 게시판 타입에 대한 선호도 업데이트
    void updatePreference(UserBoardTypePreferenceDto dto);

    // 관심 게시판 타입에 대한 선호도 추가
    void insertPreference(UserBoardTypePreferenceDto dto);

    // 유저가 특정 게시판에 대한 선호도를 가지고 있는지 확인
    Integer checkPreferenceExist(UserBoardTypePreferenceDto dto);
    // 유저가 좋아요 눌렀을때 해당 게시물의 boardTypeNo 가져오기
	Integer getBoardTypeNoByBoardNo(Long boardNo);
}
