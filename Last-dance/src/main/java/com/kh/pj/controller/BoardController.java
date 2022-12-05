package com.kh.pj.controller;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.pj.entity.BoardDto;
import com.kh.pj.entity.RecipeDto;
import com.kh.pj.repository.BoardDao;
import com.kh.pj.vo.BoardListVO;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardDao boardDao;
	
	private final File directory = new File("D:/upload/kh10J");
	
	@GetMapping("/write")
	public String write() {
		return "board/write";
	}
	@PostMapping("/write") 
	public String write(@ModelAttribute BoardDto boardDto ) {
		boardDao.write(boardDto);
		return "redirect:write_success";
	}
	
	@GetMapping("write_success")
	public String writesuccess() {
		return "board/writesuccess";
	}
	
	@RequestMapping("/list")
	public String list(Model model,HttpSession session) {
		String memberNick =(String)session.getAttribute("memberNick");
		model.addAttribute("boardList",boardDao.boardList(memberNick));
		return "board/list";
	}
	
	
	@GetMapping("/edit")
	public String edit(Model model, @RequestParam int boardNo) {
		model.addAttribute("boardDto",boardDao.find(boardNo));
		return "board/edit";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute BoardDto boardDto,
						RedirectAttributes attr) {
		boolean result = boardDao.edit(boardDto);
		if(result) {
			attr.addAttribute("boardNo",boardDto.getBoardNo());
			return "redirect:detail";
		}
		else {
			return "redirect:edit_fail";
		}
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam int boardNo,HttpSession session) {
		boardDao.delete(boardNo);
		return "redirect:list";
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam int boardNo,Model model) {
		boardDao.updateClickCount(boardNo);
		
		BoardListVO boardListVO = boardDao.find(boardNo);
		
		//하이퍼링크로 입력받은 recipeNo로 상세 조회 실행 후 그 결과를 Model에 첨부
		model.addAttribute("boardListVO", boardListVO);
		
		return "board/detail";
	}
	
}
