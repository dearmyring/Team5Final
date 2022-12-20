package com.kh.pj.service;

import java.util.Date;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.pj.constant.SessionConstant;
import com.kh.pj.vo.MessageVO;
import com.kh.pj.vo.ReceiveVO;
import com.kh.pj.vo.channel.Channel;
import com.kh.pj.vo.channel.Room;
import com.kh.pj.vo.channel.User;

@Service
public class CenterService extends TextWebSocketHandler{
	private Room waitingRoom = new Room();
	
	private Channel channel = new Channel();
	
	//연결 시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//접속 시 대기실로 입장
		Map<String, Object> attr = session.getAttributes();
		User user = User.builder()
							.centerId((String)attr.get(SessionConstant.ID))
							.session(session)
						.build();
		waitingRoom.enter(user);
	}
	
	//연결 종료
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//사용자가 나가면
		//- 대기실에 있을지 채널에 있을지 알 수 없다.
		Map<String, Object> attr = session.getAttributes();
		User user = User.builder()
					.centerId((String)attr.get(SessionConstant.ID))
					.session(session)
				.build();
		waitingRoom.leave(user);//대기실에서 삭제
		channel.exit(user);//채널에서 삭제
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//서버에서는 사용자 정보를 꺼낸 뒤 메세지를 종류별로 구분해서 처리
		Map<String, Object> attr = session.getAttributes();
		User user = User.builder()
					.centerId((String)attr.get(SessionConstant.ID))
					.session(session)
				.build();
		
		//메세지 해석
		ObjectMapper mapper = new ObjectMapper();
		ReceiveVO receiveVO = mapper.readValue(message.getPayload(), ReceiveVO.class);
		
		if(receiveVO.getType() == 1) {
			//사용자가 입장하려고 하는 경우(방이름을 사용자가 보냄)
			//- 해당 이름의 방이 있는지 확인
			//(- 방이 없으면 생성)
			//- 해당 방에 사용자(user)를 입장시킴
			//- 대기실에서 사용자를 제거
			waitingRoom.leave(user);
			channel.join(user, receiveVO.getRoom());
		}
		else if(receiveVO.getType() == 2) {
			//사용자가 채팅을 보내는 경우(채팅내용을 사용자가 보냄)
			//- 해당하는 방의 모든 사용자에게 메세지 전송
			
			MessageVO vo = MessageVO.builder()
									.centerId(user.getCenterId())
									.centerContent(receiveVO.getText())
									.centerTime(new Date())
								.build();
			String json = mapper.writeValueAsString(vo);
			TextMessage msg = new TextMessage(json);
			
			channel.send(user, msg);
		}
	}
}