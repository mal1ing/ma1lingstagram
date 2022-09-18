package com.ghfkd1235.spring.ex.timeline.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ghfkd1235.spring.ex.common.FileManagerService;
import com.ghfkd1235.spring.ex.timeline.dao.TimelineDAO;
import com.ghfkd1235.spring.ex.timeline.model.Timeline;

@Service
public class TimelineBO {

	@Autowired
	private TimelineDAO timelineDAO;
	
	public int addTimeline(int userId, String content, MultipartFile file) {
		String imagePath = null;
		//파일을 서버에 특정 위치에 저장
		//해당 파일을 접근할 수 있는 주소 경로로 dao로 전달한다.
		if(file != null) {
			imagePath = FileManagerService.saveFile(userId, file);
			
			if(imagePath == null) {
				return 0;
			}
		}
		
		return timelineDAO.insertTimeline(userId, content, imagePath);
	}
	
	
	// 사용자들의 사진들을 가져오는 기능
	
	public List<Timeline> gettimelineList(){
		
		return timelineDAO.selectTimelineList();
	}
}
