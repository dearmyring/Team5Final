package com.kh.pj.vo.channel;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.web.socket.TextMessage;

public class Room {
	//사용자 목록
	private Set<User> users = new CopyOnWriteArraySet<>();
	
	public void enter(User user) {
		users.add(user);
	}
	public void leave(User user) {
		users.remove(user);
	}
	public User search(String memberId) {
		for(User user : users) {
			if(user.is(memberId)) return user;
		}
		return null;
	}
	public void broadcast(TextMessage message) throws IOException {
		for(User user : users) {
			user.send(message);
		}
	}
	public int size() {
		return users.size();
	} 
}