package com.teamproject.www.kim.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.teamproject.www.kim.domain.LoginDto;
import com.teamproject.www.kim.domain.UserVo;

public interface UserMapper {
	
	// 로그인 시 사용자를 조회하는 메서드
    public UserVo findByUserIdAndPassword(@Param("userId") String userId, @Param("userPw") String userPw);
	
	public UserVo login(LoginDto dto) throws Exception;

	public UserVo getUserById(String userId);

	public int insertUser(UserVo userVo);
	
	
	
	//데이터 분석 테스트 (전체)
	public List<String> getLikedContentByUser(String userid);
	
	
	
	

	public Integer checkInterestExist(Map<String, Object> params);

	public void updateInterestFrequency(Map<String, Object> params);

	public void insertInterest(Map<String, Object> params);

	
	
	public int getInterestCountByUserId(String userId);

	public String findWordToReplace(String userId);

	public void replaceInterest(Map<String, Object> params);

	public void updateInterestFrequencyLevel(Map<String, Object> params);

	String findUserIdByEmail(@Param("email") String email);

	
	//비번찾기 메일발송
	public UserVo findUserByEmail(@Param("email") String email);

	public void updatePassword(@Param("userId") String userId, @Param("newPassword") String newPassword);

	//회원가입 비동기처리
	
	int checkUserId(@Param("userId") String userId);
    
    int checkNickname(@Param("nickname") String nickname);
    
    int checkEmail(@Param("email") String email);
}
