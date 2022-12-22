//package com.kh.pj.interceptor;
//
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
//import org.springframework.web.servlet.HandlerInterceptor;
//
//import com.kh.pj.constant.SessionConstant;
//import com.kh.pj.entity.BoardDto;
//import com.kh.pj.repository.BoardDao;
//import com.kh.pj.vo.BoardListVO;
//
//@Component
//public class MemberBoardOwnerCheckInterceptor implements HandlerInterceptor{
//	
//	@Autowired
//	private BoardDao boardDao;
//	
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception {
//		
//		//통과하는 경우
//		//(1) 현재 사용자가 작성자
//		//(2) 관리자가 삭제
//		
//		//(1)
//		HttpSession session = request.getSession();
//		
//		String memberId = (String)session.getAttribute(SessionConstant.ID);
//		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
//		BoardListVO boardListVO = boardDao.selectOne(boardNo);
//		boolean isOwner = memberId.equals(boardListVO.getBoardId());
//	
//		
//		if(isOwner) { //소유자라면
//			return true;
//		}
//		
//		//(2)
//		//String memberGrade = (String)session.getAttribute("mg");
//		String adm = (String)session.getAttribute(SessionConstant.ADM);
//		boolean admin = adm != null && adm.equals("관리자1");
//		boolean isDelete = request.getRequestURI().equals("/board/delete");
//		if(admin && isDelete) {//관리자가 삭제할 경우
//			return true;
//		}
//		
//		
//		//기본적으로 차단
//		response.sendError(403);
//		return false;
//		
//		
//
//	}
//	
//	
//	
//	
//	
//	
//	
//
//}
