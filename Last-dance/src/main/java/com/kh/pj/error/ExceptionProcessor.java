package com.kh.pj.error;


import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestControllerAdvice(annotations = RestController.class)
public class ExceptionProcessor {
	
	@ExceptionHandler(Exception.class)
	public ResponseEntity<String> error(Exception ex){
		log.error("ERROR", ex);
		return ResponseEntity.internalServerError().build();
	}
	
	@ExceptionHandler(TargetNotFoundException.class)
	public ResponseEntity<String> notFound(TargetNotFoundException ex){
		log.warn("not found", ex);
		return ResponseEntity.notFound().build();
	}
	
}
