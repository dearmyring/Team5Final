package com.kh.pj.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.kh.pj.service.CenterService;

@Configuration
@EnableWebSocket
public class CenterServerConfiguration implements WebSocketConfigurer{

	@Autowired
	private CenterService centerService;
	
	@Override
	public void registerWebSocketHandlers(
							WebSocketHandlerRegistry registry) {

		registry.addHandler(centerService, "/ws/center")
						.addInterceptors(new HttpSessionHandshakeInterceptor())
						.withSockJS();
	}
	
}
