package com.teamproject.www.lee.task;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.teamproject.www.lee.Util.MyFileUtil;
import com.teamproject.www.lee.mapper.board.AttachMapper;

import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class CleanImagesTask {
	@Autowired
	private AttachMapper attachMapper;
	
	@Scheduled(cron = "0 0 1 * * *")
	public void cleanImgs() {
		//어제 날짜 컨텐츠 가져오기
		log.info("************************* cleanImgs *************************");
		//DB 어제날자 이미지들
		log.info(attachMapper);
		List<String>yesterdayPaths = attachMapper.getYesterdayUploadpath();
		
		MyFileUtil.cleanImgTask(yesterdayPaths);
		log.info("yesterDayPahts : " + yesterdayPaths);
	}
}
