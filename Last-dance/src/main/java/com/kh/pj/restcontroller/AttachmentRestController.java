package com.kh.pj.restcontroller;


import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.kh.pj.entity.AttachmentDto;
import com.kh.pj.entity.RecipeContentDto;
import com.kh.pj.repository.AttachmentDao;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@RestController
@RequestMapping("/rest")
public class AttachmentRestController {
		
	@Autowired
	private AttachmentDao attachmentDao;
	
	//기준 경로
	private File dir = new File(System.getProperty("user.home"), "/upload/kh10j");
//	맥북용
//	private final File directory = new File(System.getProperty("user.home")+"/upload/kh10j");
	
	//업로드
	@PostMapping("/upload")
	public String upload(
			@RequestParam MultipartFile attach,
			@RequestBody RecipeContentDto content) throws IllegalStateException, IOException {
		//DB저장
		int attachmentNo = attachmentDao.sequence();
		attachmentDao.insert(AttachmentDto.builder()
					.attachmentNo(attachmentNo)
					.attachmentName(attach.getOriginalFilename())
					.attachmentType(attach.getContentType())
					.attachmentSize(attach.getSize())
				.build());
		
		//파일저장
		dir.mkdirs();//폴더 생성
		
		File target = new File(dir, String.valueOf(attachmentNo));
		attach.transferTo(target);
		
		return ServletUriComponentsBuilder.fromCurrentContextPath()
						.path("/download/").path(String.valueOf(attachmentNo))
						.toUriString();
	}
	
	//다운로드 - 기존 방식과 동일
	@GetMapping("/download/{attachmentNo}")
	public ResponseEntity<ByteArrayResource> download(
			@PathVariable int attachmentNo) throws IOException{
		AttachmentDto attachmentDto = attachmentDao.find(attachmentNo);
		if(attachmentDto == null) {
			throw new IllegalArgumentException();//잘못된 인자가 들어왔다는 예외
		}
		
		File target = new File(dir, String.valueOf(attachmentDto.getAttachmentNo()));
		if(!target.exists()) {
			throw new IllegalArgumentException();
		}
		
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		return ResponseEntity.ok()
					.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
					.header(HttpHeaders.CONTENT_TYPE, attachmentDto.getAttachmentType())
					.header(HttpHeaders.CONTENT_DISPOSITION, 
							ContentDisposition.attachment().filename(
									attachmentDto.getAttachmentName(), 
									StandardCharsets.UTF_8)
							.build().toString())
					.contentLength(attachmentDto.getAttachmentSize())
				.body(resource);
	}
	
}
