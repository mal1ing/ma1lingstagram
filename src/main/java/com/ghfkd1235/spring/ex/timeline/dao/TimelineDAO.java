package com.ghfkd1235.spring.ex.timeline.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ghfkd1235.spring.ex.timeline.model.Timeline;

@Repository
public interface TimelineDAO {

	
		public int insertTimeline(
				@Param("userId") int userId
				, @Param("content") String content
				, @Param("imagePath") String imagePath);
		
		public List<Timeline> selectTimelineList();
}
