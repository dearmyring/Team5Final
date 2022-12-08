package com.kh.pj.restcontroller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.AttachmentDto;
import com.kh.pj.entity.ProfileImageDto;
import com.kh.pj.repository.MypageDao;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@RestController
public class MypageRestController {
	
	@Autowired
	private MypageDao mypageDao;
	
	@PostMapping("/profileImg")
	public void addImage(@RequestParam String attachmentNo, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		
		AttachmentDto confirm = mypageDao.profileImg(loginId);
//		System.err.println(confirm);
		if(confirm == null) {
			mypageDao.addProfileImage(ProfileImageDto.builder()
					.profileId(loginId)
					.ProfileAttachmentNo(Integer.parseInt(attachmentNo))
					.build());
//			System.err.println("등록");
		}
		else {
			mypageDao.editProfileImage(ProfileImageDto.builder()
					.profileId(loginId)
					.ProfileAttachmentNo(Integer.parseInt(attachmentNo))
					.build());
//			System.err.println("수정");
		}
	}

}
