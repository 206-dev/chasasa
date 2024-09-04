package com.teamproject.www.jang.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.teamproject.www.common.domain.LoginSessionDto;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		LoginSessionDto loginSessionDto = (LoginSessionDto)session.getAttribute("loginSessionDto");
		String targetLocation = request.getRequestURL().toString();
		String currentUrl = (String)request.getParameter("currentUrl");
		System.out.println("인터셉터, currentUrl : " + currentUrl);
		if(loginSessionDto != null) {
			// 원하는 페이지로 보내기
			request.setAttribute("currentUrl", currentUrl);
			return true;
		} else {
			System.out.println("로그인 세션 없음");
			System.out.println("인터셉터, targetLocation: " + targetLocation);
			targetLocation = targetLocation.substring(targetLocation.indexOf("t/") + 2);
			session.setAttribute("targetLocation", targetLocation);
			// 로그인 페이지로 보내기
			response.sendRedirect("/jang/user/login");
			return false;
		}
	}
	
//	@Override
//	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
//			ModelAndView modelAndView) throws Exception {
//		HttpSession session = request.getSession();
//		LoginSessionDto loginSessionDto = (LoginSessionDto)session.getAttribute("loginSessionDto");
//		String targetLocation = (String)session.getAttribute("targetLocation");
//		System.out.println("로그인 세션 없음");
////		session.setAttribute("targetLocation", targetLocation);;
////		System.out.println("getRequestURL: " + request.getRequestURL());
//		if(loginSessionDto != null) {
//			if (targetLocation != null) {
//				modelAndView.setViewName(targetLocation);
//			} 
//		} else {
//			System.out.println("로그인 세션 없음");
//			modelAndView.setViewName("redirect:/jang/user/login");
//		}
//	}
}
