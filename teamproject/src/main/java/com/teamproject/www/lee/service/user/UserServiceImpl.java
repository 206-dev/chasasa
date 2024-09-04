package com.teamproject.www.lee.service.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.www.common.domain.LoginSessionDto;
import com.teamproject.www.common.domain.UserGradeDto;
import com.teamproject.www.lee.domain.user.JoinDto;
import com.teamproject.www.lee.domain.user.LevelDto;
import com.teamproject.www.lee.domain.user.ProfileDto;
import com.teamproject.www.lee.domain.user.UserRankDto;
import com.teamproject.www.lee.mapper.user.UserMapper;

import lombok.extern.log4j.Log4j;

@Service("leeUserService")
@Log4j
public class UserServiceImpl implements UserService{
	@Autowired
	private UserMapper userMapper;
	
	private final int START_POINT = 100;
	private final double GROWTH_RATE = 1.1;
	//회원가입
	@Override
	public boolean signUp(JoinDto dto) {
		int count = userMapper.join(dto);
		if(count>0) {
			return true;
		}
		return false;
	}
	
	//회원가입시 체크
	//아이디
	@Override
	public boolean joinCheckId(String userid) {
		int result = userMapper.joinCheckId(userid);
		if(result>0) {
			return true;
		}
		return false;
	}
	//닉네임
	@Override
	public boolean joinCheckNickname(String nickname) {
		int result = userMapper.joinCheckNickname(nickname);
		if(result>0) {
			return true;
		}
		return false;
	}

	//가입 체크
	@Override
	public boolean CheckUser(Map<String, String> map) {
		int result = userMapper.CheckUser(map);
		if(result > 0) {
			//아이디 중복
			return true;
		};
		//중복 아님 
		return false;
	}

	// 로그인 DTO 가져오기
	@Override
	public LoginSessionDto getLoginDto(String u_id) {
		return userMapper.getLoginDto(u_id);
	}

	//아이디 가져오기
	@Override
	public String getIdByEmail(String u_email) {
		System.out.println("service getIdByEmail.................................");
		System.out.println("u_email : " + u_email);
		String userId = userMapper.getIdByEmail(u_email);
		System.out.println("userId : " + userId);
		return userId;
	}
	
	//비밀번호 업데이트
	@Override
	public boolean updatePw(Map<String, String> map) {
		int result = userMapper.updatePw(map);
		if(result > 0) {
			return true;
		}
		return false;
	}
	
	//비밀번호 리셋
	@Override
	public String resetPw(String userid) {
		System.out.println("resetPw......................");
		String uuid = UUID.randomUUID().toString();
		String userpw = uuid.substring(0, uuid.indexOf("-"));
		System.out.println("userpw : " + userpw);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("userpw", userpw);
		int result = userMapper.updatePw(map);
		
		return (result == 1) ? userpw : null;
	}

	//이메일가져오기
	@Override
	public String getEmailById(String u_id) {
		return userMapper.getEmailById(u_id);
	}

	//프로필
	//프로필 가져오기
	@Override
	public ProfileDto getProfile(String u_id) {
		return userMapper.getProfileDto(u_id);
	}
	//프로필 업데이트
	@Override
	public boolean updateProfile(Map<String, String> map) {
		int result = userMapper.updateProfile(map);
		if(result>0) {return true;};
		return false;
	}
	//닉네임 중복 체크
	@Override
	public boolean checkNick(Map<String, String> map) {
		int result = userMapper.checkNickname(map);
		if(result==0) {
			//중복된게 없는경우
			return true;
		}
		return false;
	}
	//닉네임 업데이트
	@Override
	public boolean changeNickname(Map<String, String> map) {
		int result = userMapper.updateNickname(map);
		if(result>0) {return true;};
		return false;
	}

	//이메일 업데이트
	@Override
	public boolean updateEmail(Map<String, String> map) {
		int result = userMapper.updateEmail(map);
		if(result>0) {return true;};
		return false;
	}

	// 포인트 업데이트
	@Transactional
	@Override
	public boolean updatePoint(String userid, int point) {
		log.info("userService, updatePoint......................");
		// 포인트 추가
		int result = userMapper.updatePoint(userid, point);
		if(result ==0) {
			return false;
		}
		//레벨업 계산
		levelManager(userid);
		
		return true;
	}

	private void levelManager(String userid) {
		log.info("userServiece, levelManager.................. ");

		LevelDto dto = userMapper.getLevelPoint(userid);
		int level = dto.getUserlevel();
		int point = dto.getPoint();
		
		log.info("LevelDto : " + dto);
		log.info("level : " + level);
		log.info("point : " + point);
		// 목표 경험치 등 구하기
		Map<String, Integer> map = getNeedPoints(level);
		int nextPoint = map.get("nextPoint");
		int prePoint = map.get("prePoint");
		log.info("map : " + map);
		levelUp(userid, level, point, nextPoint, prePoint);	
	}
	
	private Map<String, Integer> getNeedPoints(int level){
		log.info("UserService, getNextPoint........");
		int prePoint = 0;
		int incresePoint = START_POINT;
		int nextPoint = START_POINT;
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		for(int i=1; i<level; i++){
			incresePoint = (int) Math.floor(incresePoint*GROWTH_RATE);
	 		nextPoint = incresePoint + nextPoint;
	 		prePoint = nextPoint - incresePoint;
		};
		map.put("nextPoint", nextPoint);
		map.put("prePoint", prePoint);
		return map;
	};
	
	private void levelUp(String userid, int level, int point, int nextPoint, int prePoint){
		log.info("levelUp...........................");
		int userlevel = level;
		boolean check = false;
		if(point >= nextPoint){
			log.info("levelUp");
			userlevel++;
			check = true;
		}else if(point < prePoint){
			log.info("levelDown");
			userlevel--;
			check = true;
		}
		log.info("userlevel : " + userlevel);
		
		if(check) {
			userMapper.levelUpdate(userid, userlevel);
		}
		
	}

	//레벨정보 가져오기
	@Override
	public LevelDto getLevelInfo(String userid) {
		return userMapper.getLevelPoint(userid);
	}
	
	//포인트 가져오기
	@Override
	public int getMyPoint(String userid) {
		return userMapper.getMyPoint(userid);
	}
	
	//성별체크
	@Override
	public boolean checkGender(String userid) {
		int result = userMapper.checkGender(userid);
		if(result == 0) {return false;}
		// false면 성별 등록 안함 / true면 성별 등록 되있음
		return true;
	}
	
	//성별 업데이트
	@Override
	public boolean updateGender(String userid, String gender) {
		int result = userMapper.updateGender(userid, gender);
		if(result == 0) {
			return false;
		}
		return true;
	}
	
	//성별 가져오기
	@Override
	public String getGender(String userid) {
		return userMapper.getGender(userid);
	}
	
	//등급가져오기
	@Override
	public int getGradeno(String userid) {
		return userMapper.getGradeno(userid);
	}
	//등급변경
	@Override
	public boolean modifyGrade(UserGradeDto dto) {
		int result = userMapper.updateGrade(dto);
		if(result == 0) {
			return false;
		}
		return true;
	}

	//TOP 3랭크 가져오기
	@Override
	public List<UserRankDto> getTopRankTest() {
		return userMapper.getTopTreeRank();
	}
	//내랭크 가져오기
	@Override
	public int getMyRank(String userid) {
		return userMapper.getMyRank(userid);
	}


}