package com.kh.pj.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.CenterDto;
import com.kh.pj.repository.CenterDao;

@RestController
@RequestMapping("/rest")
public class CenterRestController {

	@Autowired
	private CenterDao centerDao;
	
//	@GetMapping("/center/{centerMemberId}")
//	public String message(
//			@PathVariable String centerMemberId,
//			Model model) {
//		model.addAttribute("centerHistoryList", centerDao.historyList(centerMemberId));
//		return "websocket-center";
//	}
	
	@PostMapping("/center")
	public void center(
			@RequestBody CenterDto centerDto) {
		centerDao.insert(centerDto);
	}
}
