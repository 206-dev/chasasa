package com.teamproject.www.lee.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;

@Log4j
public class UnAuthInterceptor extends HandlerInterceptorAdapter{
	@Override
		public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
				throws Exception {
			log.info("UnAuthInterceptor................................");
 			HttpSession session = request.getSession();
 			Object obj = session.getAttribute("loginSessionDto");
 			log.info(obj);
 			if(obj!=null) {
 				//로그인 성공시
 				//접근 불가 지정
 				response.sendRedirect("/");
 			}
 			//로그인 아닐때
			return true;
		}
}
