package com.teamproject.www.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.teamproject.www.common.domain.LoginSessionDto;

public class AdminInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		LoginSessionDto loginSessionDto = (LoginSessionDto)session.getAttribute("loginSessionDto");
		int gradeNo = loginSessionDto.getGradeno();
		System.out.println("grade: " + gradeNo);
		if(gradeNo > 1) {
			// 원하는 페이지로 보내기
			return true;
		} else {
			System.out.println("권한 없음");
			// 메인 페이지로 보내기
			response.sendRedirect("/");
			return false;
		}
	}
	
}
