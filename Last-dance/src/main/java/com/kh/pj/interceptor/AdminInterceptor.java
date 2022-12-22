package com.kh.pj.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.pj.constant.SessionConstant;

@Component
public class AdminInterceptor implements HandlerInterceptor{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		String adm = (String)session.getAttribute(SessionConstant.ADM);
		boolean admin = adm != null ;
		
		if(admin) { //관리자라면
			return true;
		}
		else { //관리자가 아니라면
			response.sendError(403);
			return false; //차단
		}
		
	}	

}
