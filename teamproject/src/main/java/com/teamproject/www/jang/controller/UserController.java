package com.teamproject.www.jang.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.teamproject.www.common.domain.LoginSessionDto;
import com.teamproject.www.jang.domain.UserVo;
import com.teamproject.www.jang.service.UserService;

import net.coobird.thumbnailator.Thumbnailator;


@Controller
@RequestMapping("/jang/user")
public class UserController {
	
	@Autowired
	private UserService userService;

	//join
	//회원가입페이지
	@GetMapping("/join")
	public String join() {
		return "jang/index/join";
	}
	
	//프로필 등록
	@ResponseBody
	@PostMapping("/uploadProfile")
	public String uploadProfile(@RequestParam("imageData") List<MultipartFile> files) throws Exception {
		System.out.println("uploadProfile");
		File folder = null;
		String savedFileName = null;
		for(MultipartFile file : files) {
			
			// profile을 관리할 폴더
			folder = new File("/uploadFile/profile");
			if(!folder.exists()) {
				folder.mkdirs();
			}
			
			// UUID생성
			String uuid = UUID.randomUUID().toString();
			savedFileName = uuid + "_" + file.getOriginalFilename();
			
			// 이미지 파일인 경우 thumbnail 파일 생성
			if(file.getContentType().startsWith("image/")) {
				FileOutputStream thumbFile = new FileOutputStream(new File(folder, "s_" + savedFileName));
				Thumbnailator.createThumbnail(file.getInputStream(), thumbFile, 150, 150);
			}
			
			// 원본 파일 생성
			file.transferTo(new File(folder +  "/" + file.getOriginalFilename()));
		}
		
		
		// 저장된 데이터 경로를 반환
		String thumbFilePath = folder + "/s_" + savedFileName;
		return thumbFilePath;
	}
	
	// 중복확인
	@ResponseBody
	@GetMapping("/checkId")
	public boolean checkId(String userId) {
		boolean isIdOk = userService.checkId(userId);
		return isIdOk;
	}
	
	//회원가입처리
	@PostMapping("/join")
	public String joinRun(UserVo vo) {
//		System.out.println(vo);
		boolean result = userService.signUp(vo);
//		System.out.println("joinrun.. result : " + result);
		return "/jang/index/index";
	}
	
	// 로그인폼
	@GetMapping("/login")
	public String loginForm(@RequestParam(name = "currentUrl", required = false) String currentUrl,
							HttpSession session) {
		session.setAttribute("currentUrl", currentUrl);
//		System.out.println(currentUrl);
	
		return "jang/index/login";
	}
	
	
	// 로그인
	@PostMapping("/login")
	public String login(@RequestParam("userId") String userId, @RequestParam("userPw") String userPw,
			 			@RequestParam(name = "saveId", required = false) String saveId,/*
						@RequestParam(name = "currentUrl", required = false) String currentUrl,*/
						HttpSession session, HttpServletResponse response) {
//		System.out.println("userId: " + userId);
//		System.out.println("userPw: " + userPw);
		
		String currentUrl = (String)session.getAttribute("currentUrl");
		String targetLocation = (String)session.getAttribute("targetLocation");
		System.out.println("login, currentUrl : " + currentUrl);
		System.out.println("login, targetLocation : " + targetLocation);
		
		String page = "/jang/index/login";
		
		if (targetLocation != null) {
			currentUrl = targetLocation;
		}
		
		System.out.println("targetLocation: " + targetLocation);
		
//		System.out.println("saveId: " + saveId);
		LoginSessionDto loginSessionDto = userService.login(userId, userPw);
//		System.out.println("loginVo :" + loginSesionDto);
		
		
		if(loginSessionDto != null) {
			System.out.println("로그인 성공");
			System.out.println("loginSessionDto"+ loginSessionDto);
			session.setAttribute("loginSessionDto", loginSessionDto);
			if(saveId!=null) {
				Cookie cookie = new Cookie("saveId", saveId);
				cookie.setMaxAge(60 * 60 * 24 * 30);
				response.addCookie(cookie);
				System.out.println("쿠키 생성됨");
			}
			return "redirect:/" + currentUrl;
		}
		
		System.out.println("로그인 실패");
		 return  page;
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(@RequestParam("currentUrl") String currentUrl, HttpSession session) {
		session.invalidate();
		return "redirect:/" + currentUrl;
	}
}
