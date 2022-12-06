package com.kh.pj.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;


import lombok.Data;

@Data
@Component
@ConfigurationProperties(prefix = "custom.email")
public class EmailProperties {
	private String host, username, password;
	private int port;
}
