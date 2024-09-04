package com.teamproject.www.kim.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import com.teamproject.www.kim.domain.BoardLikeDto;
import com.teamproject.www.kim.domain.UserBoardTypePreferenceDto;
import com.teamproject.www.kim.mapper.BoardLikeMapper;
import com.teamproject.www.kim.mapper.UserMapper;

@Service
public class BoardLikeServiceImpl implements BoardLikeService {

	 	@Autowired
	    private BoardLikeMapper boardLikeMapper;
	 	
	 	@Autowired
	 	private UserMapper userMapper;
	 	

	    @Override
	    public int addLike(BoardLikeDto boardLikeDto) {
	        int likeExists = boardLikeMapper.checkLikeExist(boardLikeDto);

	        if (likeExists > 0) {
	            // 이미 추천한 경우 -> 추천 제거
	            boardLikeMapper.deleteLike(boardLikeDto);
	            boardLikeMapper.decrementBoardLikeCount(boardLikeDto.getBoardNo());
	            return 0; // 추천 제거
	        } else {
	            // 추천 추가
	            boardLikeMapper.insertLike(boardLikeDto);
	            boardLikeMapper.incrementBoardLikeCount(boardLikeDto.getBoardNo());
	            return 1; // 추천 추가
	        }
	    }

//	    @Override
//	    public boolean removeLike(BoardLikeDto boardLikeDto) {
//	        try {
//	            boardLikeMapper.deleteLike(boardLikeDto);
//	            boardLikeMapper.decrementBoardLikeCount(boardLikeDto.getBoardNo());
//	            return true;
//	        } catch (Exception e) {
//	            e.printStackTrace();
//	            return false;
//	        }
//	    }

	    @Override
	    public int countLikes(Integer boardNo) {
	        return boardLikeMapper.selectLikeCount(boardNo);
	    }
	    
	    
	    
//	    @Override
//	    public void appendKeywordsToLatestFile(String userId, Map<String, Integer> wordCountMap) {
//	        // 오늘 날짜를 yyyy/MM/dd 형식으로 변환
////	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
////	        String today = dateFormat.format(new Date());
//
//	        // 오늘 날짜를 포함한 파일 경로 설정
//	        String directoryPath = "D:/upload/algo/" + userId + "/";
//	        File directory = new File(directoryPath);
//
//	        if (!directory.exists()) {
//	            System.out.println("사용자 디렉토리가 존재하지 않습니다: " + directoryPath);
//	            return;
//	        }
//
//	        // 파일명을 기준으로 최신 파일 찾기
//	        File[] files = directory.listFiles((dir, name) -> name.endsWith(".txt"));
//	        if (files == null || files.length == 0) {
//	            System.out.println("txt 파일이 없습니다.");
//	            return;
//	        }
//
//	        // 파일명을 기준으로 정렬하여 최신 파일 찾기
//	        File latestFile = Arrays.stream(files)
//	                .max(Comparator.comparing(File::getName))
//	                .orElse(null);
//
//	        if (latestFile != null) {
//	            try (BufferedWriter writer = new BufferedWriter(new FileWriter(latestFile, true))) {
//	                // 키워드: 횟수 형식으로 기록
//	                for (Map.Entry<String, Integer> entry : wordCountMap.entrySet()) {
//	                    writer.write(entry.getKey() + " : " + entry.getValue());
//	                    writer.newLine();
//	                }
//	                writer.flush();
//	                System.out.println("키워드가 파일에 기록되었습니다: " + latestFile.getAbsolutePath());
//	            } catch (IOException e) {
//	                e.printStackTrace();
//	            }
//	        } else {
//	            System.out.println("최신 파일을 찾을 수 없습니다.");
//	        }
//	    }
//
//
//	    @Override
//		public Map<String, Integer> getMostFrequentWords(String userId) {
//		    List<String> contents = userMapper.getLikedContentByUser(userId);
//		    String allContent = String.join(" ", contents); // 모든 content를 하나의 문자열로 결합
//
//		    // 불용어를 로드 (ClassPathResource 사용)
//		    Set<String> stopWords = loadStopWords("kim/stopwords.txt");
//		    // 단어별 빈도수를 계산하기 위한 Map
//		    Map<String, Integer> wordCountMap = new HashMap<>();
//		    
//		    // 단어별로 분리
//		    String[] words = allContent.split("\\s+");
//		    for (String word : words) {
//		    	word = word.replaceAll("[^\\p{IsHangul}]", ""); // 한글 외의 모든 문자는 제거
//		        if (word.isEmpty() || stopWords.contains(word)) continue;
//		        wordCountMap.put(word, wordCountMap.getOrDefault(word, 0) + 1);
//		    }
//		    
//		    return wordCountMap;
//		}
//	    
//	 // 불용어 파일을 읽어오는 메서드 (ClassPathResource 사용)
//		private Set<String> loadStopWords(String resourcePath) {
//		    Set<String> stopWords = new HashSet<>();
//		    int lineCount = 0; // 불용어 정상 로드 확인용
//		    try {
//		        // ClassPathResource를 통해 클래스패스에서 리소스를 로드
//		        Resource resource = new ClassPathResource(resourcePath);
//		        try (BufferedReader reader = new BufferedReader(new InputStreamReader(resource.getInputStream(), "UTF-8"))) {
//		            String line;
//		            while ((line = reader.readLine()) != null) {
//		                stopWords.add(line.trim());
//		                lineCount++; // 불용어 정상 로드 확인용
//		            }
//		            System.out.println("불용어가 정상적으로 로드됨: " + lineCount + "개");
//		        }
//		    } catch (IOException e) {
//		        e.printStackTrace();
//		    }
//		    return stopWords;
//		}

		@Override
		public void updateInterestsWithKeywords(BoardLikeDto boardLikeDto) {
		    // 게시물의 내용을 가져옴
		    String content = boardLikeMapper.getContentByBoardNo(boardLikeDto.getBoardNo());

		    // 내용에서 해시태그 추출 및 빈도 계산
		    Map<String, Integer> hashtagFrequencyMap = calculateHashtagFrequencies(content);

		    // 중복된 빈도수의 해시태그끼리 이미 등록된 단어를 우선으로 정렬
		    List<String> sortedHashtags = sortHashtagsByPriority(boardLikeDto.getUserId(), hashtagFrequencyMap);

		    // 상위 20개 해시태그를 관심사에 업데이트 또는 추가
		    for (String hashtag : sortedHashtags.subList(0, Math.min(20, sortedHashtags.size()))) {
		        updateOrInsertInterest(boardLikeDto.getUserId(), hashtag);
		    }
		}

		private Map<String, Integer> calculateHashtagFrequencies(String content) {
		    Map<String, Integer> frequencyMap = new HashMap<>();
		    Pattern pattern = Pattern.compile("­#([^­]+)­"); // 해시태그 패턴 정의
		    Matcher matcher = pattern.matcher(content);

		    while (matcher.find()) {
		        String hashtag = matcher.group(0).replace("\u00AD", "").replace("#", ""); // 소프트 하이픈, # 제거
		        frequencyMap.put(hashtag, frequencyMap.getOrDefault(hashtag, 0) + 1);
		    }
		    
		    return frequencyMap;
		}

		private List<String> sortHashtagsByPriority(String userId, Map<String, Integer> frequencyMap) {
		    return frequencyMap.entrySet().stream()
		        .sorted((entry1, entry2) -> {
		            int freqComparison = entry2.getValue().compareTo(entry1.getValue()); // 빈도수 내림차순 정렬
		            if (freqComparison == 0) {
		                // 빈도수가 같은 경우, 이미 등록된 단어를 우선으로 정렬
		                boolean isEntry1Registered = isWordRegistered(userId, entry1.getKey());
		                boolean isEntry2Registered = isWordRegistered(userId, entry2.getKey());
		                return Boolean.compare(isEntry2Registered, isEntry1Registered); // true가 더 높은 우선순위
		            }
		            return freqComparison;
		        })
		        .map(Map.Entry::getKey)
		        .collect(Collectors.toList());
		}

		private boolean isWordRegistered(String userId, String word) {
		    Map<String, Object> params = new HashMap<>();
		    params.put("userId", userId);
		    params.put("word", word);
		    Integer existingFrequency = userMapper.checkInterestExist(params);
		    return existingFrequency != null;
		}

		private void updateOrInsertInterest(String userId, String hashtag) {
		    Map<String, Object> params = new HashMap<>();
		    params.put("userId", userId);
		    params.put("word", hashtag);

		    // 관심사에 이미 존재하는지 체크
		    Integer existingFrequency = userMapper.checkInterestExist(params);
		    System.out.println("관심사에 이미 존재하는지 체크 Checking if " + hashtag + " already exists for user " + userId);

		    int newFrequency;
		    if (existingFrequency != null) {
		        // 이미 존재하는 경우 frequency 증가
		        System.out.println("// 이미 존재하는 경우 frequency 증가" + hashtag + " exists with frequency: " + existingFrequency);
		        newFrequency = existingFrequency + 1;
		        params.put("frequency", newFrequency);
		        userMapper.updateInterestFrequency(params);
		        System.out.println("Updated frequency of " + hashtag + " to " + newFrequency);
		    } else {
		        // 새로운 키워드를 추가할 때, 유저의 관심 키워드가 20개를 초과하는지 확인
		        int count = userMapper.getInterestCountByUserId(userId);
		        System.out.println("// 새로운 키워드를 추가할 때, 유저의 관심 키워드가 20개를 초과하는지 확인 User " + userId + " has " + count + " interests.");

		        if (count >= 20) {
		            // 대체할 키워드를 선택: frequency가 1 이하이고 updatedate가 가장 오래된 것
		            String wordToReplace = userMapper.findWordToReplace(userId);
		            System.out.println("대체할 키워드를 선택: frequency가 1 이하이고 updatedate가 가장 오래된 것 Word to replace: " + wordToReplace);

		            if (wordToReplace != null) {
		                // 해당 키워드를 새로운 키워드로 대체
		                params.put("oldWord", wordToReplace);
		                newFrequency = 1;
		                params.put("frequency", newFrequency);
		                userMapper.replaceInterest(params);
		                System.out.println("해당 키워드를 새로운 키워드로 대체 Replaced " + wordToReplace + " with " + hashtag);
		            } else {
		                // 자리가 확보되지 않으면 이 키워드는 무시
		                System.out.println("자리가 부족하여 키워드를 추가할 수 없습니다.");
		                System.out.println("No available slot to insert " + hashtag);
		                return; // 해당 키워드를 추가하지 않음
		            }
		        } else {
		            // 새로운 키워드로 추가
		            newFrequency = 1;
		            params.put("frequency", newFrequency);
		            userMapper.insertInterest(params);
		            System.out.println("새로운 키워드로 추가 Inserted new keyword " + hashtag + " for user " + userId);
		        }
		    }

		    // frequency에 따른 frequencylevel 계산 및 업데이트
		    int frequencyLevel = calculateFrequencyLevel(newFrequency);
		    params.put("frequencylevel", frequencyLevel);
		    userMapper.updateInterestFrequencyLevel(params);
		    System.out.println("Updated frequencylevel of " + hashtag + " to " + frequencyLevel);
		}

		private int calculateFrequencyLevel(int frequency) {
		    if (frequency >= 12) {
		        return 4;
		    } else if (frequency >= 7) {
		        return 3;
		    } else if (frequency >= 3) {
		        return 2;
		    } else {
		        return 1;
		    }
		}
		
		// 유저가 좋아하는 boardtypeno 업데이트
		@Override
	    public void updateUserPreference(String userId, Integer boardTypeNo) {
	        UserBoardTypePreferenceDto dto = new UserBoardTypePreferenceDto();
	        dto.setUserId(userId);
	        dto.setBoardTypeNo(boardTypeNo);

	        Integer preferenceExists = boardLikeMapper.checkPreferenceExist(dto);
	        if (preferenceExists != null && preferenceExists > 0) {
	            // 이미 존재하면 업데이트
	        	boardLikeMapper.updatePreference(dto);
	        } else {
	            // 존재하지 않으면 새로 추가
	        	boardLikeMapper.insertPreference(dto);
	        }
	    }

		@Override
		public Integer getBoardTypeNoByBoardNo(Long boardNo) {
			return boardLikeMapper.getBoardTypeNoByBoardNo(boardNo);
		}
		
		
		
		
		
		





}
