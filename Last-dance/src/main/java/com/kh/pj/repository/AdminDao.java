package com.kh.pj.repository;

import com.kh.pj.entity.AdminDto;

public interface AdminDao {
	AdminDto login(String adminId);
}
