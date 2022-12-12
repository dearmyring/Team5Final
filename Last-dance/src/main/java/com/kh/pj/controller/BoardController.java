package com.kh.pj.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.pj.constant.SessionConstant;
import com.kh.pj.entity.BoardDto;
import com.kh.pj.entity.BoardImgDto;
import com.kh.pj.entity.BoardLikeDto;
import com.kh.pj.entity.ReplyDto;
import com.kh.pj.repository.AttachmentDao;
import com.kh.pj.repository.BoardDao;
import com.kh.pj.repository.BoardImgDao;
import com.kh.pj.repository.BoardLikeDao;
import com.kh.pj.repository.ReplyDao;
import com.kh.pj.service.BoardService;
import com.kh.pj.vo.BoardListSearchVO;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardDao boardDao;
	@Autowired
	private BoardService boardService;
	@Autowired
	private BoardLikeDao boardLikeDao;
	@Autowired
	private AttachmentDao attachmentDao;
	@Autowired
	private BoardImgDao boardImgDao;
	@Autowired
	private ReplyDao replyDao;
	
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
						@RequestParam List<Integer> boardAttachmentNo,
//						@RequestParam List<MultipartFile> attachment,
						HttpSession session, RedirectAttributes attr) throws IllegalStateException, IOException {
//		session에 있는 회원 아이디를 작성자로 추가한 뒤 등록해야함
		String boardId = (String)session.getAttribute(SessionConstant.ID);
		boardDto.setBoardId(boardId);
		int boardNo = boardDao.sequence();
		boardDto.setBoardNo(boardNo);
		boardDao.write(boardDto);
		
		
		
		for(int attachmentNo : boardAttachmentNo) {
			BoardImgDto imgDto = BoardImgDto.builder()
				.boardAttachmentNo(attachmentNo)
				.boardNo(boardNo)
			.build();
			boardImgDao.insert(imgDto);
		}
		
//		int boardNo = boardService.write(boardDto, attachment);
		attr.addAttribute("boardNo", boardNo);
		return "redirect:detail";
	}
	
	@GetMapping("write_success")
	public String writesuccess() {
		return "board/writesuccess";
	}
	
	@RequestMapping("/list")
	public String list(Model model,HttpSession session,
						@ModelAttribute(name="boardListSearchVo")BoardListSearchVO vo) {
		model.addAttribute("boardList",boardDao.boardList(vo));
		return "board/list";
	}
	
	
	@GetMapping("/edit")
	public String edit(Model model, @RequestParam int boardNo) {
		model.addAttribute("boardDto",boardDao.selectOne(boardNo));
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
	public String detail(@RequestParam int boardNo,Model model,HttpSession session) {	
		model.addAttribute("boardImgDto", boardImgDao.find(boardNo));
		@SuppressWarnings("unchecked")
		Set<Integer> history = (Set<Integer>)session.getAttribute("history");
		if(history == null) {//history 가 없다면 신규 생성
			history = new HashSet<>();
		}
		
//		(3) 현재 글 번호를 읽은 적이 있는지 검사
		if(history.add(boardNo)) { //추가된 경우
			model.addAttribute("boardDto", boardDao.click(boardNo)); 
		}
		
		else {//추가가 안 된 경우 - 읽은 적이 있는 번호면
			model.addAttribute("boardDto", boardDao.selectOne(boardNo)); //불러와
		}
		
		
//	(4) 갱신된 저장소를 세션에 다시 저장
	session.setAttribute("history", history);
	
//	(+ 추가) 댓글 목록을 조회하여 첨부
		model.addAttribute("replyList",replyDao.selectList(boardNo));
		model.addAttribute("filesList", attachmentDao.selectBoardFileList(boardNo));
		
		String boardId = (String) session.getAttribute(SessionConstant.ID);
		if(boardId != null) {
			BoardLikeDto likeDto = new BoardLikeDto();
			likeDto.setBoardLikeId(boardId);
			likeDto.setBoardLikeNo(boardNo);
			model.addAttribute("isLike",boardLikeDao.check(likeDto));
		}
		return "board/detail";
	}
		
	
//	좋아요
	@GetMapping("/like")
	public String boardLike(
				@RequestParam int boardNo,
				HttpSession session, RedirectAttributes attr,BoardDto boardDto
			) {
		String boardId = (String)session.getAttribute(SessionConstant.ID);
		BoardLikeDto dto = new BoardLikeDto();
		dto.setBoardLikeId(boardId);
		dto.setBoardLikeNo(boardNo);
		
		if(boardLikeDao.check(dto)) {//좋아요를 한 상태면
			boardLikeDao.delete(dto);//지우세요
		}
		else {//좋아요를 한 적이 없는 상태면
			boardLikeDao.insert(dto);//추가하세요
		}
		
		boardLikeDao.refresh(boardNo);//조회수 갱신
		
		attr.addAttribute("boardNo", boardNo);
		return "redirect:/board/detail";
	}
	
	@PostMapping("/reply/write")
	public String replyWrite(@ModelAttribute ReplyDto replyDto,
								RedirectAttributes attr, HttpSession session) {
		String boardId = (String)session.getAttribute(SessionConstant.ID);
		replyDto.setReplyId(boardId);
		replyDao.insert(replyDto);
		attr.addAttribute("boardNo",replyDto.getReplyBoardNo());
		return "redirect:/board/detail";
	}
	
	@GetMapping("/reply/delete")
	public String replyDelete(
			@RequestParam int replyNo,
			@RequestParam int replyBoardNo,
			RedirectAttributes attr) {
		replyDao.delete(replyNo);
		attr.addAttribute("boardNo", replyBoardNo);
		return "redirect:/board/detail";
	}
	
	@PostMapping("/reply/edit")
	public String replyEdit(
			@ModelAttribute ReplyDto replyDto,
			RedirectAttributes attr) {
		replyDao.update(replyDto);
		attr.addAttribute("boardNo", replyDto.getReplyBoardNo());
		return "redirect:/board/detail";
	}
	
	@GetMapping("/reply/blind")
	public String replyBlind(
			@RequestParam int replyNo,
			@RequestParam int replyBoardNo,
			RedirectAttributes attr) {
		ReplyDto replyDto = replyDao.selectOne(replyNo);
		replyDao.updateBlind(replyNo, !replyDto.isReplyBlind());
		
		attr.addAttribute("boardNo", replyBoardNo);
		return "redirect:/board/detail";
	}
}

