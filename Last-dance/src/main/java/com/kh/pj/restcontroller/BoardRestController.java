package com.kh.pj.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.BoardDto;
import com.kh.pj.repository.AdminDao;
import com.kh.pj.repository.BoardDao;
import com.kh.pj.vo.BoardListSearchVO;
import com.kh.pj.vo.BoardListVO;
import com.kh.pj.vo.ListSearchVO2;

@CrossOrigin(origins ="http://127.0.0.1:5500")
@RequestMapping("/rest")
@RestController
public class BoardRestController {

	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private AdminDao adminDao;
	
	@PostMapping("/board")
	public List<BoardListVO> boardList(
			@RequestBody BoardListSearchVO vo){
		return boardDao.boardList(vo);
	}
	
	@PostMapping("/board2")
	public List<BoardDto> adminList(
			@RequestBody ListSearchVO2 vo2) {
		vo2.setTable("recipe");
		vo2.setCount(adminDao.adminBoardCount(vo2));
		vo2.setStartPost(vo2.startRow());
		vo2.setEndPost(vo2.endRow());
		return boardDao.adminList(vo2);		
	}
}
