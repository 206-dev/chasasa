package com.teamproject.www.kim.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.teamproject.www.kim.domain.LoginDto;
import com.teamproject.www.kim.domain.UserVo;
import com.teamproject.www.kim.mapper.UserMapper;

@Service("kimUserService")
public class UserServiceImpl implements UserService{
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
    private JavaMailSender kimMailSender;

	@Override
	public boolean signUp(UserVo vo) {
//		int count = userMapper.join(vo);
//		if(count>0) {
//			return true;
//		}
//		return false;
		return false;
	}

    @Override
    public UserVo validateUser(String userId, String userPw) {
        // 로그인 검증 로직
        UserVo user = userMapper.findByUserIdAndPassword(userId, userPw);
        if (user != null && user.getUserpw().equals(userPw)) {
            return user;
        } else {
            return null;
        }
    }

    @Override
    public UserVo getUserById(String userId) {
        return userMapper.getUserById(userId);
    }
    
    @Override
    public void handleRememberMe(String userId, Boolean rememberMe, HttpServletResponse response) {
        if (rememberMe != null && rememberMe) {
            // /kim/user 경로에 쿠키 저장
            Cookie userCookieForSpecificPath = new Cookie("userid", userId);
            userCookieForSpecificPath.setMaxAge(60 * 60 * 24 * 30); // 쿠키의 유효기간을 30일로 설정
            userCookieForSpecificPath.setPath("/kim/user"); // 쿠키의 경로를 /kim/user로 설정
            response.addCookie(userCookieForSpecificPath);

            // / 경로에 쿠키 저장
            Cookie userCookieForRootPath = new Cookie("userid", userId);
            userCookieForRootPath.setMaxAge(60 * 60 * 24 * 30); // 쿠키의 유효기간을 30일로 설정
            userCookieForRootPath.setPath("/"); // 쿠키의 경로를 루트로 설정
            response.addCookie(userCookieForRootPath);
        } else {
            // /kim/user 경로의 쿠키 삭제
            Cookie userCookieForSpecificPath = new Cookie("userid", null);
            userCookieForSpecificPath.setMaxAge(0); // 쿠키를 삭제
            userCookieForSpecificPath.setPath("/kim/user"); // 쿠키의 경로를 /kim/user로 설정
            response.addCookie(userCookieForSpecificPath);

            // / 경로의 쿠키 삭제
            Cookie userCookieForRootPath = new Cookie("userid", null);
            userCookieForRootPath.setMaxAge(0); // 쿠키를 삭제
            userCookieForRootPath.setPath("/"); // 쿠키의 경로를 루트로 설정
            response.addCookie(userCookieForRootPath);
        }
    }

    @Override
    public boolean insertUser(UserVo userVo) {
        return userMapper.insertUser(userVo) == 1;
    }
    
//    @Override
//    public void createLogFileForUser(String userId) {
//        // 날짜 포맷을 yyMMdd 으로 설정
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
//        String formattedDate = sdf.format(new Date());
//        
//        // 파일 경로 설정 (유저 ID 포함)
//        String filePath = "D:/upload/algo/" + userId + "/";
//        
//        // 파일 이름 설정
//        String fileName = formattedDate + ".txt";
//        
//        // 디렉토리가 존재하지 않으면 생성
//        File directory = new File(filePath);
//        if (!directory.exists()) {
//            directory.mkdirs();
//        }
//        
//        // 파일 생성
//        File file = new File(filePath + fileName);
//        try {
//            if (file.createNewFile()) {
//                System.out.println("파일이 생성되었습니다: " + file.getAbsolutePath());
//            } else {
//            	System.out.println("생성에 사용된 userId : " + userId);
//                System.out.println("파일 생성에 실패했습니다. 이미 생성된 파일로부터 7일이 지나지 않았거나 다른 세션의 userId 로드 과정에 문제가 있을 수 있음");
//            }
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }

    @Override
    public String findUserIdByEmail(String email) {
        return userMapper.findUserIdByEmail(email);
    }

    @Override
    public void sendUserIdByEmail(String email, String userId) {
        String subject = "아이디 찾기 안내";
        String content = "요청하신 아이디는 " + userId + " 입니다.";

        MimeMessage message = kimMailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setFrom("kh2404@gmail.com");
            helper.setTo(email);
            helper.setSubject(subject);
            helper.setText(content, true);
            kimMailSender.send(message);
            System.out.println("이메일이 성공적으로 전송되었습니다.");
        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("이메일 전송에 실패했습니다.");
        }
    }
    
    //비번찾기
    @Override
    public UserVo findUserByEmail(String email) {
        return userMapper.findUserByEmail(email);
    }

    @Override
    public void updatePassword(String userId, String newPassword) {
        userMapper.updatePassword(userId, newPassword);
    }

    @Override
    public void sendTemporaryPasswordEmail(String email, String temporaryPassword) {
        MimeMessage message = kimMailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setFrom("no-reply@yourdomain.com"); // 이메일 계정 설정
            helper.setTo(email);
            helper.setSubject("임시 비밀번호 안내");
            helper.setText("임시 비밀번호는 다음과 같습니다: " + temporaryPassword);
            kimMailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    @Override
    public String generateTemporaryPassword() {
        return UUID.randomUUID().toString().substring(0, 8); // 8자리 임시 비밀번호 생성
    }

    @Override
    public boolean isUserIdExist(String userId) {
        return userMapper.checkUserId(userId) > 0;
    }

    @Override
    public boolean isNicknameExist(String nickname) {
        return userMapper.checkNickname(nickname) > 0;
    }

    @Override
    public boolean isEmailExist(String email) {
        return userMapper.checkEmail(email) > 0;
    }

    public String generateVerificationCode() {
        Random random = new Random();
        return String.format("%06d", random.nextInt(1000000)); // 6자리 인증 코드 생성
    }

    public void sendVerificationCodeEmail(String email, String verificationCode) {
        // 이메일 발송 로직
        MimeMessage mimeMessage = kimMailSender.createMimeMessage();

        try {
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
            helper.setTo(email);
            helper.setSubject("이메일 인증 코드");
            helper.setText("인증 코드: " + verificationCode);

            kimMailSender.send(mimeMessage); // kimMailSender로 이메일 전송
        } catch (MessagingException e) {
            throw new RuntimeException("이메일 전송에 실패했습니다.", e);
        }
    }

}
