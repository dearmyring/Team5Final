package com.kh.pj.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.constant.SessionConstant;
import com.kh.pj.entity.ReplyDto;
import com.kh.pj.repository.ReplyDao;
import com.kh.pj.vo.ReplyListVO;

@CrossOrigin(origins = {"http://127.0.0.1:5500"})
@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {

	@Autowired
	private ReplyDao replyDao;
	
	@PostMapping("/insert")
	public List<ReplyListVO> insert(@ModelAttribute ReplyDto replyDto, HttpSession session) {
		String boardId = (String)session.getAttribute(SessionConstant.ID);
		replyDto.setReplyId(boardId);
		replyDao.insert(replyDto);
		
		return replyDao.selectList(replyDto.getReplyBoardNo());
	}
	
	@PostMapping("/delete")
	public List<ReplyListVO> delete(@ModelAttribute ReplyDto replyDto) {
		replyDao.delete(replyDto.getReplyNo());
		return replyDao.selectList(replyDto.getReplyBoardNo());
	}
	
}
