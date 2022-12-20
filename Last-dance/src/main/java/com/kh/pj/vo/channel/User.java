package com.kh.pj.vo.channel;

import java.io.IOException;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class User {
	private String centerId;
	private WebSocketSession session;

	public boolean is(String centerId) {
		if(centerId == null) return false;
		if(this.centerId == null) return false;
		return this.centerId.equals(centerId);
	}

	public void send(TextMessage message) throws IOException {
		session.sendMessage(message);
	}
}
