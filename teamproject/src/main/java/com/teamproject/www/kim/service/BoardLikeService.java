package com.teamproject.www.kim.service;


import com.teamproject.www.kim.domain.BoardLikeDto;

public interface BoardLikeService {
    // 추천 추가 또는 제거 (이미 추천했을 경우 제거, 아니면 추가)
    int addLike(BoardLikeDto boardLikeDto);
    
//    // 추천 제거 (필요할 경우 사용)
//    boolean removeLike(BoardLikeDto boardLikeDto);
    
    // 추천수 조회
    int countLikes(Integer boardNo);
    
    
    
//	Map<String, Integer> getMostFrequentWords(String userId);
//
//	void appendKeywordsToLatestFile(String userId, Map<String, Integer> wordCountMap);

	void updateInterestsWithKeywords(BoardLikeDto boardLikeDto);
	
	//유저가 좋아하는 boardtypeno 업데이트
	void updateUserPreference(String userId, Integer boardTypeNo);
	
	//좋아요 눌렀을때 해당 게시물의 boardTypeNo 가져오기
	Integer getBoardTypeNoByBoardNo(Long boardNo);
}
