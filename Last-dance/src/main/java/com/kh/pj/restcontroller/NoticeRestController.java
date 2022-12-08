package com.kh.pj.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.NoticeDto;
import com.kh.pj.repository.NoticeDao;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@RequestMapping("/rest")
@RestController
public class NoticeRestController {
	
	@Autowired
	private NoticeDao noticeDao;
	
	@DeleteMapping("/notice")
	public List<NoticeDto> noticeDelete(@RequestParam List<String> noticeNo) {
		for(String no : noticeNo) {
			noticeDao.delete(Integer.parseInt(no));
		}
		return noticeDao.list(); 
	}
}
