package com.kh.pj.vo.channel;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.TextMessage;

public class Channel {
	//방들을 이름으로 관리할 수 있는 저장소
	//Map<String, Room> rooms = new HashMap<>();
	Map<String, Room> rooms = Collections.synchronizedMap(new HashMap<>());
	
	//입장
	public void join(User user, String name) {
		if(!rooms.containsKey(name)) {//방이 없으면
			rooms.put(name, new Room());//만드세요
		}
		//입장시키세요
		rooms.get(name).enter(user);
	}
	//검색
	public String find(User user) {
		for(String name : rooms.keySet()) {//모든 방을 반복하며
			Room room = rooms.get(name);//방 하나를 꺼낸다
			if(room.search(user.getCenterId()) != null) {//방에 해당 사용자가 있으면
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