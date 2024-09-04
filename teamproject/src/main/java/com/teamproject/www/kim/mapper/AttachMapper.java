package com.teamproject.www.kim.mapper;

import java.util.List;

import com.teamproject.www.kim.domain.AttachBoardDto;

public interface AttachMapper {

	public int insertKsy(AttachBoardDto dto);
	
	public List<AttachBoardDto> getAttachListKsy(Long boardNo);
	
	public int deleteKsy(Long boardNo);

	public List<AttachBoardDto> getOldAttachListKsy();
	
}