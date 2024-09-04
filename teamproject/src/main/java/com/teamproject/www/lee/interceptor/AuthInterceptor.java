package com.teamproject.www.lee.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;

@Log4j
public class AuthInterceptor extends HandlerInterceptorAdapter{
		@Override
		public boolean preHandle(HttpServletRequest request, HttpServletResponse response,  Object handler)
				throws Exception {
			
			log.info("AuthInterceptor ...............................................");
			HttpSession session = request.getSession();
			Object obj = session.getAttribute("loginSessionDto");
			log.info("obj : " + obj);
			if(obj==null) {
				//로그인 아님
				log.info("로그인이 아닐때");
				String uri = request.getRequestURI();
				String query = request.getQueryString();
				log.info("uri : " + uri);
				log.info("query : " + query);

				if(query==null || query.equals("")) {
					query = "";
				}else {
					query = "?" + query;
				}
				log.info("uri : " + uri);
				uri += query;
				log.info("targetLocation : " + uri);
				session.setAttribute("targetLocation", uri);
				if(uri.equals("/lee/user/profile")) {
					response.sendRedirect("/");
				}else {
					response.sendRedirect("/lee/user/login");
				}
				return false;
			}
			log.info("로그인 중일때");
			return true;
		}
}
