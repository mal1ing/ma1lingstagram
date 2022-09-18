package com.ghfkd1235.spring.ex.timeline;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ghfkd1235.spring.ex.timeline.bo.TimelineBO;
import com.ghfkd1235.spring.ex.timeline.model.Timeline;

@Controller
@RequestMapping("/timeline")
public class TimelineController {
	
	@Autowired
	private TimelineBO  timelineBO;

	//모든 이들의 사진을 전부 다 띄워야 하니까 아이디로 가져온다
	@GetMapping("/list/view")
	public String timeline(HttpServletRequest request
			, Model model) {
		
		//데이터를 조회하는 과정
		HttpSession session = request.getSession();
		int userId = (Integer)session.getAttribute("userId");
		
		List<Timeline> timelineList = timelineBO.gettimelineList();
		
		model.addAttribute("timelineList", timelineList);
		
		return "timeline/list";
		
		
		
	}
	
	@GetMapping("/create/view")
	public String timelineInput() {
		return "timeline/input";
	}
}
