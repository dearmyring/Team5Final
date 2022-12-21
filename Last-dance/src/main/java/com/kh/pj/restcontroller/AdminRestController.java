package com.kh.pj.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.AdminDto;
import com.kh.pj.repository.AdminDao;
import com.kh.pj.repository.RecipeDao;
import com.kh.pj.vo.ListSearchVO;
import com.kh.pj.vo.ListSearchVO2;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@RequestMapping("/rest")
@RestController
public class AdminRestController {

	@Autowired
	private AdminDao adminDao;
	
	@PostMapping("/admin")
	public String login(
			@RequestBody AdminDto adminDto) {
		AdminDto findDto = adminDao.login(adminDto.getAdminId());
		
		if(findDto == null) {
			return "fail";
		}
		
		if(findDto.getAdminPw().equals(adminDto.getAdminPw())) {
			return findDto.getAdminNick();
		}
		return "fail";
	}
	
	@PostMapping("/admin-count")
	public ListSearchVO adminCount(@RequestBody ListSearchVO vo) {
		vo.setCount(adminDao.adminPostCount(vo));
		vo.setFirstBlock(vo.startBlock());
		vo.setLastBlock(vo.endBlock());
		vo.setHavePrev(vo.hasPrev());
		vo.setHaveNext(vo.hasNext());
		return vo;
	}
	
	@PostMapping("/admin-count2")
	public ListSearchVO2 adminCount2(@RequestBody ListSearchVO2 vo2) {
		vo2.setCount(adminDao.adminBoardCount(vo2));
		vo2.setFirstBlock(vo2.startBlock());
		vo2.setLastBlock(vo2.endBlock());
		vo2.setHavePrev(vo2.hasPrev());
		vo2.setHaveNext(vo2.hasNext());
		return vo2;
	}
}

