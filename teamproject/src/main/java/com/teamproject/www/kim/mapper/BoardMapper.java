package com.teamproject.www.kim.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.www.kim.domain.InformationBoardVo;
import com.teamproject.www.kim.domain.InformationCriteria;
import com.teamproject.www.kim.domain.MainPageImageDto;

public interface BoardMapper {
	
	// 주간 게시글 list 가져오기 김세영
	public List<InformationBoardVo> getWeeklyBest();
	
	// 게시글list 가져오기 김세영
	public List<InformationBoardVo> getListWithPagingKsy(InformationCriteria criteria);
	
	// 게시글 갯수 김세영
	public int getTotalCountKsy(InformationCriteria criteria);
	
	// 오늘의 BEST 게시물 리스트 가져오기 김세영
    public List<InformationBoardVo> getTodayBest();
    
    // 상단 공지2개 가져오기 김세영
    public List<InformationBoardVo> getLatestAnnounce();
    
    // 글쓰기 김세영
 	public int insertKsy(InformationBoardVo vo);
    
    // 김세영 글쓰기 - 키
	public int insertSelectKeyKsy(InformationBoardVo vo);
	
	// 김세영 글보기
	public InformationBoardVo selectByBnoKsy(Long boardNo);
	
	// 김세영 댓글 갯수 갱신(댓글 등록/삭제)
	public int updateReplyCntKsy(@Param("boardNo") Long boardNo, 
								  @Param("amount") int amount);
	
	// 김세영 게시글 수정
	public int modifySelectKeyKsy(InformationBoardVo vo);
	

    // 게시물 첨부파일 삭제
    public void deleteAttachByBoardNo(Long boardNo);

    // 게시글에 달린 댓글 삭제
    public void deleteRepliesByBoardNo(Long boardNo);

    // 게시글에 달린 좋아요 삭제
    public void deleteBoardLikesByBoardNo(Long boardNo);

    // 게시글 삭제
    public void deleteBoardByBoardNo(Long boardNo);
    
    // 조회수 갱신
 	public int updateCnt(@Param("boardNo") Long boardNo);
 	// 해시태그 검색
	public int countPostsByHashtag(@Param("hashtag") String hashtag);
	
	// 키워드 두개 선정
	List<String> getKeywordsByFrequencyLevel(@Param("userId") String userId, @Param("level") int level);
	// 키워드 두개에 의한 게시물
    List<InformationBoardVo> getPostsByKeyword(@Param("userId") String userId, @Param("hashtag") String hashtag);
    
    // main 페이지 사진
    public List<MainPageImageDto> getRecentBoardImages();

    // 선호도에 따른 게시판 타입 가져오기
    Integer getBoardTypeByRank(@Param("userId") String userId, @Param("rank") int rank);

    // 게시판 타입별 오늘의 BEST 게시물 가져오기
    List<InformationBoardVo> getTodayBestByBoardType(@Param("boardTypeNo") Integer boardTypeNo);
    
    // 이번 주 명예의 전당 게시물 가져오기
    List<InformationBoardVo> getWeeklyBestListFive();

    // 오늘의 인기 게시물 가져오기
    List<InformationBoardVo> getTodayBestListFive();
    // 인기 태그 정렬
	public List<String> getAllContents();
	// 인기 태그를 눌렀을때
	public List<Integer> getBoardNosByTag(@Param("tag") String tag);

	public Integer getPopularBoardTypeByRank(int rank);



 	

}
