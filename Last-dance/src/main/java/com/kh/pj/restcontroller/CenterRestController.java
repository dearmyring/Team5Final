package com.kh.pj.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.CenterDto;
import com.kh.pj.repository.CenterDao;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@RestController
@RequestMapping("/rest")
public class CenterRestController {

	@Autowired
	private CenterDao centerDao;
	
	@GetMapping("/center/{centerMemberId}")
	public List<CenterDto> message(
			@PathVariable String centerMemberId) {
		return centerDao.historyList(centerMemberId);
	}
	
	@PostMapping("/center")
	public void center(
			@RequestBody CenterDto centerDto) {
		//일단은 DB랑 웹소켓 서버 시간 약간 다르게 저장
		centerDao.insert(centerDto);
	}
}
