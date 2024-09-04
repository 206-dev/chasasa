package com.teamproject.www.kim.service;

import javax.servlet.http.HttpServletResponse;

import com.teamproject.www.kim.domain.UserVo;

public interface UserService {
	
	public boolean signUp(UserVo vo); 

	public UserVo validateUser(String userId, String userPw);

	public UserVo getUserById(String userid);

	public void handleRememberMe(String userId, Boolean rememberMe, HttpServletResponse response);

	public boolean insertUser(UserVo userVo);
	
	// 유저 선호도 txt 파일 생성
//	void createLogFileForUser(String userId);
	
	
	// 아이디찾기
	public String findUserIdByEmail(String email);
	public void sendUserIdByEmail(String email, String userId);

	
	
	//비번찾기
	public UserVo findUserByEmail(String email);
	public String generateTemporaryPassword();
	public void updatePassword(String userid, String temporaryPassword);
	public void sendTemporaryPasswordEmail(String email, String temporaryPassword);
	
	//회원가입 비동기처리
	public boolean isUserIdExist(String userid);

	public boolean isNicknameExist(String nickname);

	public boolean isEmailExist(String email);
	
	
	// 회원가입 이메일 인증
	public String generateVerificationCode();

	public void sendVerificationCodeEmail(String email, String verificationCode);
	
	
	
}