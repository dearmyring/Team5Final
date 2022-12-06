package com.kh.pj.configuration;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
public class EmailConfiguration {
	@Autowired
	private EmailProperties emailProperties; 
	
	// 등록 메소드
	// 반드시 public이라는 접근제한이 붙어야 한다.
	@Bean
	public JavaMailSender javaMailSender() {
		// 도구 생성 및 정보 설정
		JavaMailSenderImpl sender = new JavaMailSenderImpl();
		sender.setHost(emailProperties.getHost()); // 이메일 전송 대행업체의 HOST
		sender.setPort(emailProperties.getPort()); // 이메일 전송 대행업체의 PORT
		sender.setUsername(emailProperties.getUsername()); // 이메일 전송 대행업체 로그인 ID
		sender.setPassword(emailProperties.getPassword()); // 이메일 전송 대행업체 로그인 PW
		
		// 추가 정보 설정
		Properties props = new Properties(); // Map(String, String) 형태의 저장소
		props.setProperty("mail.smtp.auth", "true"); // 인증 여부를 설정 (필수)
		props.setProperty("mail.smtp.debug", "true"); // 디버깅 사용 여부 설정(선택)
		props.setProperty("mail.smtp.starttls.enable", "true"); // TLS 사용 여부 (필수)
		props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2"); // TLS 버전 설정 (필수)
		props.setProperty("mail.smtp.ssl.trust", "smtp.gmail.com"); // 신뢰할 수 있는 대행업체
		
		sender.setJavaMailProperties(props);
		
		return sender;
	}
}
