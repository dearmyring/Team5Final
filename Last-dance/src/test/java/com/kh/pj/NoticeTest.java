package com.kh.pj;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kh.pj.entity.NoticeDto;
import com.kh.pj.repository.NoticeDao;

@SpringBootTest
public class NoticeTest {

	@Autowired
	private NoticeDao noticeDao;
	
	@Test
	public void insert() {
		for(int i=0; i<15; i++) {
			noticeDao.insert(NoticeDto.builder()
					.noticeNo(noticeDao.sequence())
					.noticeTitle("테스트 "+i+"번 째")
					.noticeContent("테스트 "+i+"번 째 글")
					.noticeNick("관리자1")
				.build());
		}
	}
}
