package com.kh.pj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/view")
public class BoardViewController {

	@RequestMapping("/board")
	public String board() {
		return "board";
	}

}