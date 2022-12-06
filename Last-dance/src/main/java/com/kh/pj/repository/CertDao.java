package com.kh.pj.repository;

import com.kh.pj.entity.CertDto;

public interface CertDao {
	void insert(CertDto certDto);
	boolean check(CertDto certDto);
	boolean delete(String certWho);
	void clear();
}
