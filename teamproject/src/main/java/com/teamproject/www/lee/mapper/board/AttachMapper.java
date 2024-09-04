package com.teamproject.www.lee.mapper.board;

import java.util.List;

import com.teamproject.www.lee.domain.AttachFileDto;

public interface AttachMapper {
	// insertAttach
	public int insertAttach(AttachFileDto dto);
	
	// getYesterdayPathList
	public List<String> getYesterdayUploadpath();
	
	// getPathListByBoardNo
	public List<String> getPathListByBoardNo(int boardno);
	
	// deleteByBoardNo
	public int deleteByBoardNo(int boardno);
	
	//getCountByBoardno
	public int getCountByBoardno(int boardno);
	// deleteByUpdate
	public int deleteByUpdate(List<String> updatePaths);
}
