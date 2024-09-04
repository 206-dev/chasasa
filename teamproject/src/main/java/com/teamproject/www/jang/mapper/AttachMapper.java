package com.teamproject.www.jang.mapper;

import com.teamproject.www.jang.domain.AttachVo;

public interface AttachMapper {
	// 업로드 파일 등록
	public void insertUpload(AttachVo attachVo);
	
	// 업로드 파일 제거
	public void deleteUpload(Long boardNo);
}
