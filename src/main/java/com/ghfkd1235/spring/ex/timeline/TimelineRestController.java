package com.ghfkd1235.spring.ex.timeline;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ghfkd1235.spring.ex.timeline.bo.TimelineBO;

@RestController
@RequestMapping("/timeline")
public class TimelineRestController {
	
	@Autowired
	private TimelineBO	timelineBO;
	
	
	//타임라인 생성 기능
	@PostMapping("/create")
		public Map<String, String> create(
				 @RequestParam("content") String content
				, @RequestParam(value="file", required=false) MultipartFile file
				, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		int userId = (Integer)session.getAttribute("userId");
		
		int count = timelineBO.addTimeline(userId, content, file);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
		
	}
}
