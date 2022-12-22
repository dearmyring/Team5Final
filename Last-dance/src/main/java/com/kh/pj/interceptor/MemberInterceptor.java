package com.kh.pj.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.pj.constant.SessionConstant;

@Component
public class MemberInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//시나리오
		//1. 접속한 사용자가 로그인 상태인지 검사(request 객체 필요)
		// - HttpSession에 loginId란 값이 있는지 검사
		//2. 상태에 따라 통과/차단 설정
		// (1) 로그인 상태라면 통과(return true)
		// (2) 로그인 상태가 아니라면 로그인 페이지로 리다이렉트 후 차단
		
		//1. 세션이 없을 때는 HttpServletRequest에서 획득 가능
		HttpSession session = request.getSession();
		String member = (String) session.getAttribute(SessionConstant.MEM);
		if(member == null) {//비회원. 2-(2)
			//선택지는 2가지가 있다
			
			//[1] 로그인 페이지로 리다이렉트
			response.sendRedirect("/member/login");
			
			//[2] HTTP 상태 코드 중에서 미인증(401)을 반환
			//- 추가로 상태번호에 따른 처리가 필요하다
			//response.sendError(401);
			
			return false;//차단
		}
		else {//회원. 2-(1)
			return true;//통과
		}
	
	}

}
