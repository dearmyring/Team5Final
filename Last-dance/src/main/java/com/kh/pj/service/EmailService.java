package com.kh.pj.service;

import com.kh.pj.entity.CertDto;

public interface EmailService {
	void sendCertMail(String email);
	boolean checkCert(CertDto certDto);
}
