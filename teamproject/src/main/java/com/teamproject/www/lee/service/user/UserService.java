package com.teamproject.www.lee.service.user;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.teamproject.www.common.domain.LoginSessionDto;
import com.teamproject.www.common.domain.UserGradeDto;
import com.teamproject.www.lee.domain.user.JoinDto;
import com.teamproject.www.lee.domain.user.LevelDto;
import com.teamproject.www.lee.domain.user.ProfileDto;
import com.teamproject.www.lee.domain.user.UserRankDto;

public interface UserService {
	
	//회원가입
	public boolean signUp(JoinDto dto); 
	
	//회원가입시 아이디체크
	public boolean joinCheckId(String userid);
	
	//회원가입시 닉네임 체크
	public boolean joinCheckNickname(String nickname);
	
	//가입체크
	public boolean CheckUser(Map<String, String> map);
	
	//로그인 DTO 가져오기
	public LoginSessionDto getLoginDto(String u_id);
	
	//아이디 가져오기
	public String getIdByEmail(String u_email);
	
	//비밀번호 업데이트
	public boolean updatePw(Map<String, String> map);
	
	//비밀번호 리셋
	public String resetPw(String u_id);
	
	//이메일 가져오기
	public String getEmailById(String u_id);
	
	//프로필
	//프로필 가져오기
	public ProfileDto getProfile(String u_id);
	//프로필 업데이트
	public boolean updateProfile(Map<String, String> map);
	//닉네임체크
	public boolean checkNick(Map<String, String> map) ;
	//닉네임 업데이트
	public boolean changeNickname(Map<String, String> map);
	//이메일 업데이트
	public boolean updateEmail(Map<String, String> map);
	//포인트 업데이트
	public boolean updatePoint(@Param("userid") String userid, @Param("point") int point);
	//레벨정보가져오기
	public LevelDto getLevelInfo(String userid);
	//포인트 가져오기
	public int getMyPoint(String userid);
	
	//성별체크
	public boolean checkGender(String userid);
	//성별 업데이트
	public boolean updateGender(String userid, String gender);
	//성별 가져오기
	public String getGender (String userid);
	//등급 가져오기
	public int getGradeno(String userid);
	//등급 변경
	public boolean modifyGrade(UserGradeDto dto);
	
	//랭크
	//TOP3랭크 가져오기
	public List<UserRankDto> getTopRankTest();
	//내랭크 가져오기
	public int getMyRank(String userid);
}
