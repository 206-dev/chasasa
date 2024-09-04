package com.teamproject.www.kim.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamproject.www.common.domain.LoginSessionDto;
import com.teamproject.www.kim.domain.LoginDto;
import com.teamproject.www.kim.domain.UserVo;
import com.teamproject.www.kim.service.UserService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller("kimUserController")
@RequestMapping("/kim/user/*")
public class UserController {
	@Autowired
	private UserService userService;
	
	@GetMapping("/login")
	public String login(HttpSession session, Model model, @RequestParam(value = "redirectURL", required = false) String redirectURL) {
		// 로그인 페이지에 진입하기 전에 현재 보고 있던 URL을 저장
	    if (redirectURL != null && !redirectURL.isEmpty()) {
	        session.setAttribute("redirectURL", redirectURL);
	    }
	    return "kim/user/login";
	}
	
	@PostMapping("/loginRun")
	public String login(@ModelAttribute LoginDto loginDto, 
	                    HttpSession session, 
	                    RedirectAttributes redirectAttributes, 
	                    HttpServletResponse response) {
	    // 로그인 검증 로직
	    UserVo user = userService.validateUser(loginDto.getUserId(), loginDto.getUserPw());

	    if (user != null) {
	        // 로그인 성공: 세션에 사용자 정보 저장
	        LoginSessionDto loginSessionDto = new LoginSessionDto();
	        loginSessionDto.setUserid(user.getUserid());
	        loginSessionDto.setNickname(user.getNickname());
	        loginSessionDto.setUserlevel(user.getUserLevel());
	        loginSessionDto.setPoint(user.getPoint());
	        loginSessionDto.setGradeno(user.getGradeNo());
	        
//	        uservo
//	        int gradeNo
//
//	        usercon
//	        setPoint(user.getGradeNo());

	        session.setAttribute("loginSessionDto", loginSessionDto);
	        
	        // 아이디 기억 체크박스 처리 (Service로 로직 이동)
	        userService.handleRememberMe(loginDto.getUserId(), loginDto.getRememberMe(), response);
	        
	        // 파일 생성 로직 추가
//	        userService.createLogFileForUser(user.getUserid());
	        
	        // read.jsp 에서 로그인했을때 리다이렉트 URL 처리
	        String redirectURL = (String) session.getAttribute("redirectURL");
	        if (redirectURL != null && !redirectURL.isEmpty()) {
	            session.removeAttribute("redirectURL");
	            
	            // read.jsp 에서 로그인했을때  WEB-INF/views/ 와 .jsp 부분을 제거 올바른 페이지로 이동
	            redirectURL = redirectURL.replace("WEB-INF/views/", "").replace(".jsp", "");
	            return "redirect:" + redirectURL;
	        }
	        
	        return "redirect:/";  // 기본 리다이렉트
	    } else {
	        // 로그인 실패: 에러 메시지 설정
	        redirectAttributes.addFlashAttribute("error", "아이디 또는 비밀번호가 잘못되었습니다.");
	        return "redirect:/kim/user/login";
	    }
	}


	
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        // 세션 무효화
        session.invalidate();
        
        // 홈 페이지로 리다이렉트
        return "redirect:/";
    }

	
	
	@GetMapping("/join")
	public void join() {
		
	}
	
	@PostMapping("/joinRun")
	public String joinRun(@ModelAttribute UserVo userVo, 
	                      RedirectAttributes rttr, 
	                      HttpSession session) {
	    log.info("Received user information for registration: " + userVo);
	    
	    Boolean emailVerified = (Boolean) session.getAttribute("emailVerified");
	    
	    if (emailVerified == null || !emailVerified) {
	        rttr.addFlashAttribute("error", "이메일 인증을 완료해주세요.");
	        return "redirect:/kim/user/join";
	    }

	    try {
	        // 3. 회원가입 처리
	        boolean result = userService.insertUser(userVo);
	        if (result) {
	            rttr.addFlashAttribute("success", "회원가입이 완료되었습니다. 로그인해주세요.");
	            return "redirect:/kim/user/login";
	        } else {
	            rttr.addFlashAttribute("error", "중복 또는 이메일 인증 확인해주세요.");
	            return "redirect:/kim/user/join";
	        }
	    } catch (Exception e) {
	        // 기타 예외 처리
	        log.error("Exception during user registration: ", e);
	        rttr.addFlashAttribute("error", "회원가입에 실패하였습니다. 다시 시도해주세요.");
	        return "redirect:/kim/user/join";
	    }
	}

	
	@PostMapping("/checkUserId")
	@ResponseBody
	public Map<String, String> checkUserId(@RequestParam("userId") String userId) {
	    boolean isAvailable = !userService.isUserIdExist(userId);
	    Map<String, String> response = new HashMap<>();
	    response.put("userIdAvailability", isAvailable ? "available" : "unavailable");
	    return response;
	}

	@PostMapping("/checkNickname")
	@ResponseBody
	public Map<String, String> checkNickname(@RequestParam("nickname") String nickname) {
	    boolean isAvailable = !userService.isNicknameExist(nickname);
	    Map<String, String> response = new HashMap<>();
	    response.put("nicknameAvailability", isAvailable ? "available" : "unavailable");
	    return response;
	}

	@PostMapping("/checkEmail")
	@ResponseBody
	public Map<String, String> checkEmail(@RequestParam("email") String email) {
	    boolean isAvailable = !userService.isEmailExist(email);
	    Map<String, String> response = new HashMap<>();
	    response.put("emailAvailability", isAvailable ? "available" : "unavailable");
	    return response;
	}
	// 아이디찾기
	@GetMapping("/findid")
	public String showFindIdPage() {
	    return "kim/user/findid";
	}
	
	@PostMapping("/findId")
	public String findId(@RequestParam("email") String email, RedirectAttributes rttr) {
	    String userId = userService.findUserIdByEmail(email);
	    if (userId != null) {
	        userService.sendUserIdByEmail(email, userId);
	        rttr.addFlashAttribute("message", "아이디가 이메일로 발송되었습니다.");
	    } else {
	        rttr.addFlashAttribute("error", "해당 이메일로 등록된 아이디가 없습니다.");
	        return "redirect:/kim/user/findid";
	    }
	    return "redirect:/kim/user/login";
	}

	// 비번찾기
	@GetMapping("/findpassword")
	public String findPassword() {
	    return "kim/user/findPassword"; // 비밀번호 찾기 페이지로 이동
	}

	@PostMapping("/sendResetPasswordEmail")
	public String sendResetPasswordEmail(@RequestParam("email") String email, RedirectAttributes rttr) {
	    UserVo user = userService.findUserByEmail(email);
	    if (user != null) {
	        String temporaryPassword = userService.generateTemporaryPassword();
	        userService.updatePassword(user.getUserid(), temporaryPassword);
	        userService.sendTemporaryPasswordEmail(email, temporaryPassword);
	        rttr.addFlashAttribute("message", "임시 비밀번호가 이메일로 전송되었습니다.");
	    } else {
	    	rttr.addFlashAttribute("error", "해당 이메일로 등록된 사용자가 없습니다.");
	    	return "redirect:/kim/user/findpassword";
	    }
	    return "redirect:/kim/user/login";
	}
	//이메일 인증 전송
	@PostMapping("/sendEmailVerification")
	@ResponseBody
	public Map<String, Object> sendEmailVerification(@RequestParam("email") String email, HttpSession session) {
	    Map<String, Object> response = new HashMap<>();
	    
	    try {
	        String verificationCode = userService.generateVerificationCode();
	        session.setAttribute("verificationCode", verificationCode); // 세션에 인증 코드 저장
	        userService.sendVerificationCodeEmail(email, verificationCode);
	        
	        response.put("success", true);
	    } catch (Exception e) {
	        response.put("success", false);
	    }
	    
	    return response;
	}
	//이메일 인증 확인
	@PostMapping("/verifyEmailCode")
	@ResponseBody
	public Map<String, Object> verifyEmailCode(@RequestParam("verificationCode") String inputCode, HttpSession session) {
	    Map<String, Object> response = new HashMap<>();
	    
	    // 세션에서 저장된 인증 코드 가져오기
	    String sessionCode = (String) session.getAttribute("verificationCode");
	    
	    if (sessionCode != null && sessionCode.equals(inputCode)) {
	        response.put("success", true);
	        session.setAttribute("emailVerified", true); // 이메일 인증 완료 플래그 설정
	    } else {
	        response.put("success", false);
	    }
	    
	    return response;
	}



}
	
