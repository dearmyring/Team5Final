package com.kh.pj.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.pj.constant.SessionConstant;
import com.kh.pj.entity.ReplyDto;
import com.kh.pj.repository.ReplyDao;

@Component
public class MemberReplyOwnerCheckInterceptor implements HandlerInterceptor {
	
	@Autowired
	private ReplyDao replyDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//검사할 항목
		//1. 해당 댓글의 작성자가 현재 사용자일 경우 통과
		//2. 1번 검사에 detail페이지에서 온 경우인지 추가로 검사 후 통과
		//준비물 : HttpSession의 사용자 ID, replyNo 파라미터, referer 헤더
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute(SessionConstant.MEM);
		int replyNo = Integer.parseInt(request.getParameter("replyNo"));
		String referer = request.getHeader("Referer");
		ReplyDto replyDto = replyDao.selectOne(replyNo);
		
		if(memberId.equals(replyDto.getReplyId())) {//1
			if(referer != null && referer.contains("/board/detail")) {
				return true;
			}
		}
		
		response.sendError(403);
		return false;
		
		

	}

}
