package com.kh.pj.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.pj.constant.SessionConstant;
import com.kh.pj.entity.BoardDto;
import com.kh.pj.entity.BoardLikeDto;
import com.kh.pj.repository.BoardDao;
import com.kh.pj.repository.BoardLikeDao;
import com.kh.pj.service.BoardService;
import com.kh.pj.vo.BoardListVO;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardDao boardDao;
	@Autowired
	private BoardService boardService;
	@Autowired
	private BoardLikeDao boardLikeDao;
	
	private final File directory = new File("D:/upload/kh10J");
	@PostConstruct
	public void prepare() {
		directory.mkdirs();
	}
	
	
	@GetMapping("/write")
	public String write() {
		return "board/write";
	}
	@PostMapping("/write") 
	public String write(@ModelAttribute BoardDto boardDto,
						@RequestParam List<MultipartFile> attachment,
						HttpSession session, RedirectAttributes attr) throws IllegalStateException, IOException {
//		session에 있는 회원 아이디를 작성자로 추가한 뒤 등록해야함
		String boardId = (String)session.getAttribute(SessionConstant.ID);
		boardDto.setBoardId(boardId);
		int boardNo = boardService.write(boardDto, attachment);
		attr.addAttribute("boardNo", boardNo);
		return "redirect:detail";
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
			return "redirect:list";
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
	
//	좋아요
	@GetMapping("/like")
	public String boardLike(
				@RequestParam int boardLikeNo,
				HttpSession session, RedirectAttributes attr
			) {
		String boardLikeId = (String)session.getAttribute(SessionConstant.ID);
		BoardLikeDto dto = new BoardLikeDto();
		dto.setBoardLikeId(boardLikeId);
		dto.setBoardLikeNo(boardLikeNo);
		
		if(boardLikeDao.check(dto)) {//좋아요를 한 상태면
			boardLikeDao.delete(dto);//지우세요
		}
		else {//좋아요를 한 적이 없는 상태면
			boardLikeDao.insert(dto);//추가하세요
		}
		
		boardLikeDao.refresh(boardLikeNo);//조회수 갱신
		
		attr.addAttribute("boardLikeNo", boardLikeNo);
		return "redirect:/board/detail";
	}
	
}

