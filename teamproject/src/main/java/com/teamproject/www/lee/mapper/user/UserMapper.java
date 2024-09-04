package com.teamproject.www.lee.mapper.user;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.teamproject.www.common.domain.LoginSessionDto;
import com.teamproject.www.common.domain.UserGradeDto;
import com.teamproject.www.lee.domain.user.JoinDto;
import com.teamproject.www.lee.domain.user.LevelDto;
import com.teamproject.www.lee.domain.user.ProfileDto;
import com.teamproject.www.lee.domain.user.UserRankDto;

public interface UserMapper {
	//회원가입
	public int join(JoinDto dto);
	
	//아이디 중복체크
	public int joinCheckId(String userid);
	//닉네임 중복체크
	public int joinCheckNickname(String nickname);
	
	//가입 체크
	public int CheckUser(Map<String, String> map);

	//로그인 Dto 가져오기
	public LoginSessionDto getLoginDto(String userid);
	
	//아이디 이메일로 가져오기
	public String getIdByEmail(String email);
	
	//이메일 가져오기
	public String getEmailById(String userid);
	
	//프로필 사진 가져오기
	public String getProfileImg(String userid);
	
	//프로필**********************************************
	//프로필 업데이트
	public int updateProfile(Map<String, String> map);
	//프로필 정보 가져오기
	public ProfileDto getProfileDto(String userid);
	//닉네임 중복 조회
	public int checkNickname(Map<String, String> map);
	
	//닉네임 업데이트
	public int updateNickname(Map<String, String> map);
	//이메일 업데이트
	public int updateEmail(Map<String, String> map);
	//비밀번호 업데이트
	public int updatePw(Map<String, String> map);
	//포인트 업데이트
	public int updatePoint(@Param("userid") String userid, @Param("point") int point);
	//레벨 포인트 가져오기
	public LevelDto getLevelPoint(String userid);
	// 포인트 가져오기
	public int getMyPoint(String userid);
	//레벨 업데이트	
	public int levelUpdate(@Param("userid") String userid, @Param("userlevel") int userlevel);
	
	//성별 null 체크
	public int checkGender(@Param("userid") String userid);
	//성별 등록
	public int updateGender(@Param("userid") String userid, @Param("gender") String gender);
	//성별 가져오기
	public String getGender(@Param("userid") String userid);
	//등급 가져오기
	public int getGradeno(@Param("userid") String userid);
	//등급 업데이트
	public int updateGrade(UserGradeDto dto);
	
	//랭크
	//top  1, 2, 3
	public List<UserRankDto> getTopTreeRank();
	//내 랭크
	public int getMyRank(String userid);
}

