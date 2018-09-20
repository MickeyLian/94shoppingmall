package com.ljn.mall.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.ljn.mall.domain.User;

public class LoginIntercepter implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//获取请求的URI，也就是去除http:localhost:8080这部分剩下的
		String uri=request.getRequestURI();
		if (uri.indexOf("login")>=0) {
			return true;
		}
		HttpSession session=request.getSession();
		User user=(User) session.getAttribute("loginUser");
		if (user!=null) {
			//登录成功
			return true;
		}else{
			//没有登录，转向到登录页面
			request.setAttribute("msg", "亲，您还没有登录，请先登录！");
			request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
			return false;
			
		}
		
		
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
	}
}
