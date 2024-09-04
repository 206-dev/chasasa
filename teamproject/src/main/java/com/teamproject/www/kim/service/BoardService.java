package com.teamproject.www.kim.service;

import java.util.List;
import java.util.Map;

import com.teamproject.www.kim.domain.HashtagDto;
import com.teamproject.www.kim.domain.InformationBoardVo;
import com.teamproject.www.kim.domain.InformationCriteria;
import com.teamproject.www.kim.domain.MainPageImageDto;

public interface BoardService {
	
	
	
	//글목록 김세영
	public List<InformationBoardVo> getListKsy(InformationCriteria criteria);
	
	//갯수 김세영
	public int getTotalKsy(InformationCriteria criteria);
	
	// 주간 베스트 게시물 가져오기 김세영
    public List<InformationBoardVo> getWeeklyBest();
    
    // 오늘의 통합 BEST 게시물 리스트 가져오기 김세영
    public List<InformationBoardVo> getTodayBest();
    
    // 상단 공지 2개 가져오기 김세영
    public List<InformationBoardVo> getLatestAnnounce();
    
    // 글등록 김세영
    public Long write(InformationBoardVo vo);
    
    // 글 보기 김세영
  	public InformationBoardVo get(Long boardNo);
  	
  	// 조회수 갱신
  	public boolean modifyReadcnt(Long boardNo);
  	

  	
  	// 글수정 김세영
    public Long modify(InformationBoardVo vo);


    // 글삭제 김세영
	public void delete(Long boardNo);
	
	// 데이터분석 테스트
//	public Map<String, Integer> getMostFrequentWords(String userid);
	
	
	// 해시태그가 포함된 게시글 수 count (비동기 기능)
	public int countPostsByHashtag(String hashtag);
	
	
	//랜덤으로 키워드 두개 선정
    public List<String> getRandomKeywords(String userId);
    //선정된 키워드 두개로 랜덤 게시물 5개 가져오기
    public List<InformationBoardVo> getPostsByKeyword(String userId, String hashtag);
	
    
    //메인페이지 사진
    public List<MainPageImageDto> getRecentBoardImages();

    // 선호도에 따른 게시판 가져오기
    List<InformationBoardVo> getFavoriteBoard(String userId, int rank);

	public int getBoardTypeByRank(String userId, int i);

	public String getBoardTypeName(int boardType1);
    
	 // 이번 주 명예의 전당 게시물 가져오기
    List<InformationBoardVo> getWeeklyBestListFive();
    
    // 오늘의 인기 게시물 가져오기
    List<InformationBoardVo> getTodayBestListFive();
    // 인기 태그 정렬
	public List<HashtagDto> getPopularHashtags();
	// 인기 태그를 눌렀을때
	public Integer getRandomPostBoardNoByTag(String tag);
}
