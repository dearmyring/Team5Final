package com.kh.pj.restcontroller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.AttachmentDto;
import com.kh.pj.entity.MemberDto;
import com.kh.pj.entity.ProfileImageDto;
import com.kh.pj.repository.MypageDao;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@RestController
@RequestMapping("/rest")
public class MypageRestController {
	
	@Autowired
	private MypageDao mypageDao;
	
	@Autowired
	private PasswordEncoder encoder;
	
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
	
	
	@PostMapping("/pwConfirm")
	public String pwConfirm(@RequestBody MemberDto memberDto, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		//디비에서 가져온 비밀번호
		MemberDto memberPw = mypageDao.pwConfirm(loginId);
		
		boolean judge = encoder.matches(memberDto.getMemberPw(), memberPw.getMemberPw());
		
		
		if(judge) {
			return "Y";
		}
		else {
			return "N";
		}
		
	}

}
