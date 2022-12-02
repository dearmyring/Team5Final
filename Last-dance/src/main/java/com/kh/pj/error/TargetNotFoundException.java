package com.kh.pj.error;

import lombok.NoArgsConstructor;

@NoArgsConstructor
public class TargetNotFoundException extends RuntimeException{
	public TargetNotFoundException(String msg) {
		super(msg);
	}
}