package com.teamproject.www.kim.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.www.kim.domain.AttachBoardDto;
import com.teamproject.www.kim.domain.HashtagDto;
import com.teamproject.www.kim.domain.InformationBoardVo;
import com.teamproject.www.kim.domain.InformationCriteria;
import com.teamproject.www.kim.domain.MainPageImageDto;
import com.teamproject.www.kim.mapper.AttachMapper;
import com.teamproject.www.kim.mapper.BoardMapper;
import com.teamproject.www.kim.mapper.UserMapper;

@Service("kimBoardService")
public class BoardServiceImpl implements BoardService{
	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Autowired
    private UserMapper userMapper;

	// getlistksy
	@Override
    public List<InformationBoardVo> getListKsy(InformationCriteria criteria) {
		System.out.println("getInfoList...");
		List<InformationBoardVo> list = boardMapper.getListWithPagingKsy(criteria);
		
		
        return list;
	}
	
	// gettotalksy
    @Override
    public int getTotalKsy(InformationCriteria criteria) {
    	int count = boardMapper.getTotalCountKsy(criteria);
        return count;
    }
    
    // 정보게시판 주간 베스트 게시물 가져오기 김세영
    @Override
    public List<InformationBoardVo> getWeeklyBest() {
        return boardMapper.getWeeklyBest();
    }
    
    // 오늘의 통합 best 게시물 가져오기 김세영
    @Override
    public List<InformationBoardVo> getTodayBest() {
        return boardMapper.getTodayBest();
    }
    
    //상단 공지 2개  가져오기 김세영
    @Override
    public List<InformationBoardVo> getLatestAnnounce() {
        return boardMapper.getLatestAnnounce();
    }
    
    // 김세영 글등록
	@Override
	public Long write(InformationBoardVo vo) {
		System.out.println("글등록 김세영");
		
		System.out.println("Content: " + vo.getContent());  // Content 필드 확인용 로그
	    
	    if (vo.getContent() == null || vo.getContent().trim().isEmpty()) {
	        throw new IllegalArgumentException("Content cannot be null or empty");
	    }
	    
		int count = boardMapper.insertSelectKeyKsy(vo);
		
		// 첨부파일 insert
		List<AttachBoardDto> list = vo.getAttachList();
		if (list != null && list.size() > 0) {
			list.forEach(dto -> {
				dto.setBoardNo(vo.getBoardNo());
				attachMapper.insertKsy(dto);
			});
		}
		
		
		if (count > 0) {
			return vo.getBoardNo();
		}
		return 0L;
	}
	// 김세영 글보기
	@Override
	public InformationBoardVo get(Long bno) {
	    System.out.println("get...");
	    InformationBoardVo vo = boardMapper.selectByBnoKsy(bno);
	    
	    
	    return vo;
	}

	@Override
	public Long modify(InformationBoardVo vo) {
	    System.out.println("글수정 김세영");
	    int count = boardMapper.modifySelectKeyKsy(vo);
	    // 첨부파일 처리
	    List<AttachBoardDto> attachList = vo.getAttachList();
	    if (attachList != null && attachList.size() > 0) {
	        attachList.forEach(dto -> {
	            dto.setBoardNo(vo.getBoardNo());
	            attachMapper.insertKsy(dto);
	        });
	    }
	    
	    if (count > 0) {
	        return vo.getBoardNo();
	    }
	    return 0L;
	}

	
	@Override
	public void delete(Long boardNo) {
	    boardMapper.deleteRepliesByBoardNo(boardNo); // 댓글 삭제
	    boardMapper.deleteAttachByBoardNo(boardNo);  // 첨부파일 삭제
	    boardMapper.deleteBoardLikesByBoardNo(boardNo); // 게시글의 좋아요 삭제
	    boardMapper.deleteBoardByBoardNo(boardNo);   // 게시글 삭제
	}
	
	@Override
	public boolean modifyReadcnt(Long boardNo) {
		int count = boardMapper.updateCnt(boardNo);
		return (count == 1) ? true : false;
	}
//	// 데이터 분석 테스트
//	// http://localhost/kim/board/likedWordFrequency?userid=rabbit
//	@Override
//	public Map<String, Integer> getMostFrequentWords(String userId) {
//	    List<String> contents = userMapper.getLikedContentByUser(userId);
//	    String allContent = String.join(" ", contents); // 모든 content를 하나의 문자열로 결합
//
//	    // 불용어를 로드 (ClassPathResource 사용)
//	    Set<String> stopWords = loadStopWords("kim/stopwords.txt");
//	    // 단어별 빈도수를 계산하기 위한 Map
//	    Map<String, Integer> wordCountMap = new HashMap<>();
//	    
//	    // 단어별로 분리
//	    String[] words = allContent.split("\\s+");
//	    for (String word : words) {
//	    	word = word.replaceAll("[^\\p{IsHangul}]", ""); // 한글 외의 모든 문자는 제거
//	        if (word.isEmpty() || stopWords.contains(word)) continue;
//	        wordCountMap.put(word, wordCountMap.getOrDefault(word, 0) + 1);
//	    }
//	    
//	    return wordCountMap;
//	}
//
//	// 불용어 파일을 읽어오는 메서드 (ClassPathResource 사용)
//	private Set<String> loadStopWords(String resourcePath) {
//	    Set<String> stopWords = new HashSet<>();
//	    int lineCount = 0; // 불용어 정상 로드 확인용
//	    try {
//	        // ClassPathResource를 통해 클래스패스에서 리소스를 로드
//	        Resource resource = new ClassPathResource(resourcePath);
//	        try (BufferedReader reader = new BufferedReader(new InputStreamReader(resource.getInputStream(), "UTF-8"))) {
//	            String line;
//	            while ((line = reader.readLine()) != null) {
//	                stopWords.add(line.trim());
//	                lineCount++; // 불용어 정상 로드 확인용
//	            }
//	            System.out.println("불용어가 정상적으로 로드됨: " + lineCount + "개");
//	        }
//	    } catch (IOException e) {
//	        e.printStackTrace();
//	    }
//	    return stopWords;
//	}

	@Override
	public int countPostsByHashtag(String hashtag) {
		return boardMapper.countPostsByHashtag(hashtag);
	}
	
	@Override
    public List<String> getRandomKeywords(String userId) {
        // Frequencylevel 선택 확률을 반영한 레벨 목록
        List<Integer> weightedLevels = new ArrayList<>();
        for (int i = 0; i < 35; i++) weightedLevels.add(1);
        for (int i = 0; i < 20; i++) weightedLevels.add(2);
        for (int i = 0; i < 20; i++) weightedLevels.add(3);
        for (int i = 0; i < 25; i++) weightedLevels.add(4);
        
        // 첫 번째 레벨 선택
        Collections.shuffle(weightedLevels);
        Integer level1 = weightedLevels.get(new Random().nextInt(weightedLevels.size()));

        // 두 번째 레벨 선택 (중복되지 않도록)
        Integer level2;
        do {
            level2 = weightedLevels.get(new Random().nextInt(weightedLevels.size()));
        } while (level1.equals(level2));
        
        // 두 개의 레벨을 비교하여 높은 레벨과 낮은 레벨을 구분
        Integer higherLevel = Math.max(level1, level2);
        Integer lowerLevel = Math.min(level1, level2);
        
        // 선택된 레벨에서 각각의 키워드를 랜덤으로 선택
        List<String> higherKeywords = boardMapper.getKeywordsByFrequencyLevel(userId, higherLevel);
        List<String> lowerKeywords = boardMapper.getKeywordsByFrequencyLevel(userId, lowerLevel);
        
//        String higherKeyword = higherKeywords.get(new Random().nextInt(higherKeywords.size()));
//        String lowerKeyword = lowerKeywords.get(new Random().nextInt(lowerKeywords.size()));
        
        // 예외 처리: 키워드 리스트가 비어 있을 경우 해당 레벨을 낮은 레벨로 대체
        if (higherKeywords.isEmpty()) {
            higherKeywords = boardMapper.getKeywordsByFrequencyLevel(userId, 2); // 기본 레벨로 대체
        }
        if (lowerKeywords.isEmpty()) {
            lowerKeywords = boardMapper.getKeywordsByFrequencyLevel(userId, 1); // 기본 레벨로 대체
        }
        
        // 최종적으로 리스트가 비어 있으면 기본 키워드 반환
        if (higherKeywords.isEmpty() || lowerKeywords.isEmpty()) {
            return Arrays.asList("마운틴", "모닥불"); // 기본 키워드를 제공
        }
        
        // 비어있지 않은 경우에만 랜덤 키워드 선택
        String higherKeyword = !higherKeywords.isEmpty() ? higherKeywords.get(new Random().nextInt(higherKeywords.size())) : "마운틴";
        String lowerKeyword = !lowerKeywords.isEmpty() ? lowerKeywords.get(new Random().nextInt(lowerKeywords.size())) : "모닥불";
        
        // 높은 레벨의 키워드를 왼쪽, 낮은 레벨의 키워드를 오른쪽으로 반환
        return Arrays.asList(higherKeyword, lowerKeyword);
    }

    @Override
    public List<InformationBoardVo> getPostsByKeyword(String userId, String hashtag) {
        return boardMapper.getPostsByKeyword(userId, hashtag);
    }

	@Override
	public List<MainPageImageDto> getRecentBoardImages() {
		return boardMapper.getRecentBoardImages();
	}
	
	@Override
    public List<InformationBoardVo> getFavoriteBoard(String userId, int rank) {
		Integer boardTypeNo;
	    if ("guest".equals(userId)) {
	        // guest일 경우 가장 인기 있는 boardTypeNo를 가져옴
	        boardTypeNo = boardMapper.getPopularBoardTypeByRank(rank);
	    } else {
	        // 일반 유저일 경우 유저 선호도에 따른 boardTypeNo를 가져옴
	        boardTypeNo = boardMapper.getBoardTypeByRank(userId, rank);
	    }

	    if (boardTypeNo != null) {
	        return boardMapper.getTodayBestByBoardType(boardTypeNo);
	    }
	    return Collections.emptyList();
    }
	// 선호도에 따라 정렬된 게시판 1, 2, 3 의 head 를 위한 메서드
	// 선호도에 따라 정렬된 게시판 1, 2, 3 의 head 를 위한 메서드
	private static final Map<Integer, String> BOARD_TYPE_MAP = new HashMap<>();
    
    static {
        BOARD_TYPE_MAP.put(1, "공지사항");
        BOARD_TYPE_MAP.put(4, "자유");
        BOARD_TYPE_MAP.put(5, "정보공유");
        BOARD_TYPE_MAP.put(6, "리뷰");
        BOARD_TYPE_MAP.put(7, "질문");
        BOARD_TYPE_MAP.put(8, "벙캠/동행");
        BOARD_TYPE_MAP.put(9, "모임후기");
        BOARD_TYPE_MAP.put(10, "삽니다");
        BOARD_TYPE_MAP.put(11, "팝니다");
    }

    @Override
    public String getBoardTypeName(int boardtypeno) {
        return BOARD_TYPE_MAP.getOrDefault(boardtypeno, "알 수 없음");
    }

    @Override
    public int getBoardTypeByRank(String userId, int rank) {
    	Integer boardTypeNo;
        if ("guest".equals(userId)) {
            // guest일 경우 가장 인기 있는 boardTypeNo를 가져옴
            boardTypeNo = boardMapper.getPopularBoardTypeByRank(rank);
        } else {
            // 일반 유저일 경우 유저 선호도에 따른 boardTypeNo를 가져옴
            boardTypeNo = boardMapper.getBoardTypeByRank(userId, rank);
        }

        if (boardTypeNo != null) {
            return boardTypeNo;
        } else {
            return getDefaultBoardTypeByRank(rank);
        }
    }

    // 순위에 따른 기본 게시판 타입 설정 메서드
    private int getDefaultBoardTypeByRank(int rank) {
        switch(rank) {
            case 1:
                return 5; // 1순위 - 정보공유
            case 2:
                return 4; // 2순위 - 자유
            case 3:
                return 1; // 3순위 - 공지사항
            default:
                return 1; // 그 외 순위는 공지사항으로 기본 설정
        }
    }
	 // 선호도에 따라 정렬된 게시판 1, 2, 3 의 head 를 위한 메서드
	 // 선호도에 따라 정렬된 게시판 1, 2, 3 의 head 를 위한 메서드

    @Override
    public List<InformationBoardVo> getWeeklyBestListFive() {
        return boardMapper.getWeeklyBestListFive();
    }

    @Override
    public List<InformationBoardVo> getTodayBestListFive() {
        return boardMapper.getTodayBestListFive();
    }
    @Override
    public List<HashtagDto> getPopularHashtags() {
        // 지난 4일 동안의 모든 게시물 내용 가져오기
        List<String> contents = boardMapper.getAllContents();

        // 해시태그 추출 및 빈도 계산 로직 구현
        Map<String, Integer> hashtagFrequency = new HashMap<>();
        
        for (String content : contents) {
            // 해시태그를 추출하여 빈도수를 계산하는 로직 구현
            List<String> hashtags = extractHashtags(content);
            for (String hashtag : hashtags) {
                hashtagFrequency.put(hashtag, hashtagFrequency.getOrDefault(hashtag, 0) + 1);
            }
        }

        // 빈도수가 높은 상위 20개 해시태그를 리스트로 변환하여 반환
        List<HashtagDto> popularHashtags = hashtagFrequency.entrySet().stream()
                .sorted((e1, e2) -> e2.getValue().compareTo(e1.getValue()))
                .limit(20)
                .map(e -> new HashtagDto(e.getKey(), e.getValue()))
                .collect(Collectors.toList());

        // 해시태그와 빈도수를 콘솔에 출력
        for (HashtagDto hashtagDto : popularHashtags) {
//            System.out.println("해시태그: #" + hashtagDto.getTag() + " -> 빈도수: " + hashtagDto.getFrequency());
        }

        return popularHashtags;
    }

    private List<String> extractHashtags(String content) {
        // content가 null인지 확인
        if (content == null) {
            return new ArrayList<>();
        }

        List<String> hashtags = new ArrayList<>();
        Pattern pattern = Pattern.compile("<button class=\"hashtag-button\">(.*?)</button>");
        Matcher matcher = pattern.matcher(content);

        // 일치하는 모든 해시태그를 추출
        while (matcher.find()) {
        	String hashtag = matcher.group(1);
            // 앞의 '-#'와 뒤의 '-'를 제거
            hashtag = hashtag.substring(2, hashtag.length() - 1);
            hashtags.add(hashtag); // 처리된 해시태그를 리스트에 추가
        }

        return hashtags;
    }
    @Override
    public Integer getRandomPostBoardNoByTag(String tag) {
        List<Integer> boardNos = boardMapper.getBoardNosByTag(tag);

        if (boardNos == null || boardNos.isEmpty()) {
            // 리스트가 비어있거나 null인 경우 처리
            return null;
        }

        // 랜덤으로 게시물 번호 선택
        Random random = new Random();
        int randomIndex = random.nextInt(boardNos.size());
        return boardNos.get(randomIndex);
    }


	

}
