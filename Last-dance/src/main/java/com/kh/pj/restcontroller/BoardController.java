package com.kh.pj.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.BoardDto;
import com.kh.pj.repository.BoardDao;
import com.kh.pj.vo.BoardVO;

import io.swagger.v3.oas.annotations.parameters.RequestBody;

@RestController
@RequestMapping("/rest")
public class BoardController {

	@Autowired
	private BoardDao dao;
	
	@GetMapping("/board")
	public List<BoardVO> list(){
		return dao.list();
	}
	
	@PostMapping("/board")
	public void write(@RequestBody BoardDto dto) {
		dao.write(dto);
	}
	
	//PUT 방식은 POST 처럼 데이터를 Body에 전송할 수 있는 방식
	@PutMapping("/board")
	public boolean edit(@RequestBody BoardDto dto) {
		return dao.edit(dto);
	}
	
	@DeleteMapping("/board/{boardNo}")
	public boolean delete(@PathVariable int no) {
		return dao.delete(no);
	}
}
