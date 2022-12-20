package com.kh.pj.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.BoardLikeDto;
import com.kh.pj.repository.BoardDao;
import com.kh.pj.vo.BoardListSearchVO;
import com.kh.pj.vo.BoardListVO;

@CrossOrigin(origins ="http://127.0.0.1:5500")
@RequestMapping("/rest")
@RestController
public class BoardRestController {

	@Autowired
	private BoardDao boardDao;
	
	@PostMapping("/board")
	public List<BoardListVO> boardList(
			@RequestBody BoardListSearchVO vo){
		return boardDao.boardList(vo);
	}
	
	//레시피 좋아요
		@GetMapping("/board_like/{boardNo}")
		public int likeUpdate(@PathVariable int boardNo, HttpSession session) {
			BoardLikeDto boardLikeDto = BoardLikeDto.builder()
															.boardLikeNo(boardNo)
															.boardLikeId((String) session.getAttribute("loginId"))
															.build();
			if(boardDao.boardLikeOne(boardLikeDto) == null) {
				boardDao.likeUp(boardNo);
				boardDao.addLike(boardLikeDto);
			}
			else {
				boardDao.likeDown(boardNo);
				boardDao.removeLike(boardLikeDto);
			}//if~else end
			
			return boardDao.countLike(boardNo);
			
		}//likeUpdate() end
	
}
