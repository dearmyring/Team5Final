package com.kh.pj.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.pj.entity.AttachmentDto;
import com.kh.pj.entity.BoardDto;
import com.kh.pj.repository.AttachmentDao;
import com.kh.pj.repository.BoardDao;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private AttachmentDao attachmentDao;
	
	private final File directory = new File("D:/upload/kh10J");

	@Override
	public int write(BoardDto boardDto, List<MultipartFile> attachment) throws IllegalStateException, IOException {
		//문제점 : 등록은 되는데 몇 번인지 알 수 없다
		//해결책 : 번호를 미리 생성하고 등록하도록 메소드 변경
		int boardNo = boardDao.insert2(boardDto);
		
		//(+ 추가) 게시글이 등록된 다음 파일이 있다면 해당 파일을 등록 및 연결
				//- 첨부파일이 없어도 리스트에는 1개의 객체가 들어있다
		for(MultipartFile file : attachment) {
			
			int attachmentNo = attachmentDao.sequence();
			attachmentDao.insert(AttachmentDto.builder()
					.attachmentNo(attachmentNo)
					.attachmentName(file.getOriginalFilename())
					.attachmentType(file.getContentType())
					.attachmentSize(file.getSize())
					.build());
			//파일저장
			File target = new File(directory,String.valueOf(attachmentNo));
			file.transferTo(target);
			
			//+ 연결 테이블에 연결 정보를 저장 (게시글 번호, 첨부파일 번호)
			boardDao.connectAttachment(boardNo, attachmentNo);
	}
			return boardNo;
}

	@Override
	public boolean remove(int boardNo) {
		//삭제가 이루어지기 전에 삭제될 게시글의 첨부파일 정보를 조회
		List<AttachmentDto> filesList = 
				attachmentDao.selectBoardFileList(boardNo);
		
		//삭제 - 자동으로 보드이미지 데이터 연쇄 삭제됨
		boolean result = boardDao.delete(boardNo);
		
		if(result) {
	    	  for(AttachmentDto attachmentDto : filesList) {
	    		  //첨부파일(files) 테이블 삭제
	    		  attachmentDao.delete(attachmentDto.getAttachmentNo());
	    		  //실제 파일 삭제
	    		  String attachmentName = String.valueOf(attachmentDto.getAttachmentNo());
	    		  File target = new File(directory, attachmentName);
	    		  target.delete();
	    	  }
		}	
return result;
}

	
}
