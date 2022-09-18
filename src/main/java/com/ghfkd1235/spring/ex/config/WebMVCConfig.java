package com.ghfkd1235.spring.ex.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.ghfkd1235.spring.ex.common.FileManagerService;

@Configuration
public class WebMVCConfig implements WebMvcConfigurer {
	
	
	// 서버의 특정 경로의 파일을
	// 설정한 경로로 외부에서 접근 가능하도록 설정한다.
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/images/**")
		// 맥은 / 윈도우는 //
		.addResourceLocations("file://" + FileManagerService.FILE_UPLOAD_PATH + "/");
	}

}
