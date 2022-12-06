package com.kh.pj.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.kh.pj.component.RandomGenerator;
import com.kh.pj.entity.CertDto;
import com.kh.pj.repository.CertDao;

@Service
public class GmailService implements EmailService{
	
	
	@Autowired
	private RandomGenerator randomGenerator;
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	@Override
	public void sendCertMail(String email) {
		// 목표
		// (1) 랜덤 인증 번호 생성 -> 이메일 발송 -> 데이터베이스 등록
		String serial = randomGenerator.generateSerial(6);
		
		// (2) 
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(email);
		message.setSubject("[냉장고를 부탁해] 인증번호입니다.");
		message.setText("인증번호 : " + serial);
		javaMailSender.send(message);
		
		// (3)
		certDao.delete(email);
		CertDto certDto = CertDto.builder().certWho(email).certSerial(serial).build();
		certDao.insert(certDto);
	}
	
	@Override
	public boolean checkCert(CertDto certDto) {
		if(certDao.check(certDto)) {
			certDao.delete(certDto.getCertWho());
			return true;
		}	
			return false;
	}
}
