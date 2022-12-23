//package com.kh.pj.interceptor;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.stereotype.Component;
//import org.springframework.web.servlet.HandlerInterceptor;
//
//import com.kh.pj.constant.SessionConstant;
//
//@Component
//public class RecipeWriteCheckInterceptor implements HandlerInterceptor {
//	
//	
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception {
//		//회원검사기보다 늦게 실행시킬 예정이므로 이 검사기에는 회원만 들어온다
//		//(목표) 관리자가 아닌 회원이 공지사항을 등록하려고 하면 차단
//		//1. 관리자인지 아닌지 검사 - 관리자면 통과
//		//2. 1번이 아니라면 boardHead라는 파라미터 값이 "공지"이면 차단, 아니면 허용
//		
//		//만약 POST방식이 아니라면 통과
//		if(!request.getMethod().equals("POST")) {
//			return true;
//		}
//		
//		//1
//		HttpSession session = request.getSession();
//		String member = (String)session.getAttribute(SessionConstant.ADM);
//		if(member.equals("관리자1")) {
//			return true;
//		}
//		
//		//2
//		String recipeNick = request.getParameter("recipeNick");
//		if(recipeNick != null) {
//			return true;
//		}
//		
//		//나머지는 다 차단
//		response.sendError(403);
//		return false;
//	}
//
//}
