package com.kh.pj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.kh.pj.repository.BoardLikeDao;

@Controller
public class BoardLikeController {

	@Autowired
	private BoardLikeDao boardLikeDao;
}
