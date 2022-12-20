package com.kh.pj.vo.channel;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.TextMessage;

public class Channel {
	Map<String, Room> rooms = Collections.synchronizedMap(new HashMap<>());
	
	public void join(User user, String name) {//name은 방 이름
		if(!rooms.containsKey(name)) {
			rooms.put(name, new Room());
		}
		
		rooms.get(name).enter(user);
	}
	//검색
	public String find(User user) {
		for(String name : rooms.keySet()) {
			Room room = rooms.get(name);
			if(room.search(user.getCenterId()) != null) {
				return name;
			}
		}
		return null;
	}
	//퇴장
	public void exit(User user) {
		String name = this.find(user);
		if(name == null) return;
		rooms.get(name).leave(user);
		//방이 비었으면 삭제
		if(rooms.get(name).size() == 0) {
			rooms.remove(name);
		}
	}
	//방에 메세지를 전송하는 기능
	//- (방 또는 사용자) 와 메세지를 알아야 한다
	public void send(User user, TextMessage message) throws IOException {
		String name = this.find(user);
		if(name != null) {
			rooms.get(name).broadcast(message);
		}
	}
}