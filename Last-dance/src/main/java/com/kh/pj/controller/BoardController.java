package com.kh.pj.controller;

import java.io.File;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.pj.constant.SessionConstant;
import com.kh.pj.entity.BoardDto;
import com.kh.pj.entity.BoardImgDto;
import com.kh.pj.entity.BoardLikeDto;
import com.kh.pj.entity.MemberDto;
import com.kh.pj.entity.NoticeDto;
import com.kh.pj.entity.RecipeLikeDto;
import com.kh.pj.entity.ReplyDto;
import com.kh.pj.repository.AttachmentDao;
import com.kh.pj.repository.BoardDao;
import com.kh.pj.repository.BoardImgDao;
import com.kh.pj.repository.NoticeDao;
import com.kh.pj.repository.ReplyDao;
import com.kh.pj.service.BoardService;
import com.kh.pj.vo.BoardListSearchVO;
import com.kh.pj.vo.BoardListVO;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardDao boardDao;
	@Autowired
	private BoardService boardService;
	@Autowired
	private AttachmentDao attachmentDao;
	@Autowired
	private BoardImgDao boardImgDao;
	@Autowired
	private ReplyDao replyDao;
	@Autowired
	private NoticeDao noticeDao;
	
	
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
	public String write(@ModelAttribute BoardDto boardDto, MemberDto memberDto,
						@RequestParam int boardAttachmentNo,
						HttpSession session, RedirectAttributes attr) throws Exception {
//		session에 있는 회원 아이디를 작성자로 추가한 뒤 등록해야함
		String boardId = (String)session.getAttribute(SessionConstant.ID);
		boardDto.setBoardId(boardId);
		int boardNo = boardDao.sequence();
		boardDto.setBoardNo(boardNo);
		boardDao.write(boardDto);
		
		
			BoardImgDto imgDto = BoardImgDto.builder()
				.boardAttachmentNo(boardAttachmentNo)
				.boardNo(boardNo)
			.build();
			boardImgDao.insert(imgDto);
			
		memberDto.setMemberId(boardId);
		if(boardDao.boardCNT(memberDto)<=3) {
			memberDto.setMemberPoint(5);
			boardDao.updatePoint(memberDto);			
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
						@ModelAttribute(name="boardListSearchVo")BoardListSearchVO vo,
						@ModelAttribute NoticeDto noticeDto) {
						
		model.addAttribute("boardList",boardDao.boardList(vo));
		model.addAttribute("noticeList",boardDao.noticeList(noticeDto));
		return "board/list";
	}
	
	
	@GetMapping("/edit")
	public String edit(Model model, @RequestParam int boardNo) {
		
		model.addAttribute("boardDto",boardDao.selectOne(boardNo));
		model.addAttribute("boardImgDto", boardImgDao.find(boardNo));
		return "board/edit";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute BoardDto boardDto,
						@RequestParam int boardAttachmentNo,
						RedirectAttributes attr) {
		
		
		if(boardImgDao.find(boardDto.getBoardNo()) ==  null){
			BoardImgDto imgDto = BoardImgDto.builder()
					.boardAttachmentNo(boardAttachmentNo)
					.boardNo(boardDto.getBoardNo())
				.build();
			boardImgDao.insert(imgDto);	
		}
		else {
			BoardImgDto imgDto = BoardImgDto.builder()
					.boardAttachmentNo(boardAttachmentNo)
					.boardNo(boardDto.getBoardNo())
				.build();
			boardImgDao.editThumbnail(imgDto);	
		}
		
		attr.addAttribute("boardNo",boardDto.getBoardNo());	
		boardDao.edit(boardDto);
		
		return "redirect:detail";
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam int boardNo,HttpSession session) {
		boardDao.delete(boardNo);
		return "redirect:list";
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam int boardNo,Model model,HttpSession session
						) {	
		model.addAttribute("boardImgDto", boardImgDao.find(boardNo));
		
		System.out.println(boardImgDao.find(boardNo));
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
		
		//좋아요 한적이 있는지 확인
		BoardLikeDto boardLikeDto = BoardLikeDto.builder()
								.boardLikeNo(boardNo)
								.boardLikeId((String) session.getAttribute("loginId"))
								.build();
		
		boardDao.boardLikeOne(boardLikeDto);
		
		model.addAttribute("like", boardDao.boardLikeOne(boardLikeDto));
		
		return "board/detail";
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

