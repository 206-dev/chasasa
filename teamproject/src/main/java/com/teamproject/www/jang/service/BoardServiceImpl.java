package com.teamproject.www.jang.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import com.teamproject.www.jang.domain.AttachVo;
import com.teamproject.www.jang.domain.BoardVo;
import com.teamproject.www.jang.domain.NoticeCriteria;
import com.teamproject.www.jang.domain.NoticeDto;
import com.teamproject.www.jang.mapper.AttachMapper;
import com.teamproject.www.jang.mapper.BoardMapper;

@Service("jangBoardService")
public class BoardServiceImpl implements BoardService{
	@Autowired
	private BoardMapper boardMapper;

	@Autowired
	private AttachMapper attachMapper;
	
	@Override
	public List<NoticeDto> getNoticeList() {
		List<NoticeDto> list = boardMapper.getNoticeList();
		return list;
	}

	@Override
	public NoticeDto getNotice(Long bno) {
		NoticeDto dto = boardMapper.getNotice(bno);
		return dto;
	}

	@Override
	public int getTotal(NoticeCriteria cri) {
		int total = boardMapper.getTotal(cri);
		System.out.println("serviceImpl: " + total);
		System.out.println("serviceImpl: " + cri);
		return total;
	}

	@Override
	public List<NoticeDto> getListWithPaging(NoticeCriteria cri) {
		System.out.println("service: " + cri);
		List<NoticeDto> list = boardMapper.getListWithPaging(cri);
		for(NoticeDto dto : list) {
			dto.calcNewPost();
		}
		return list;
	}

	@Override
	public void viewsUp(Long bno) {
		boardMapper.viewsUp(bno);
	}
	
	@Transactional
	@Override
	public void insertNotice(BoardVo vo) {
		boardMapper.insertNotice(vo);
		Long boardNo = vo.getBoardNo();
		String content = vo.getContent();
		updateSrcs(content, boardNo);
		
	}
	
	@Transactional
	@Override
	public boolean modify(@RequestParam("content") String content, @RequestParam("boradNo") Long boardNo) {
		System.out.println("service; content: " + content);
		int count = boardMapper.updateNotice (content, boardNo);
		attachMapper.deleteUpload(boardNo);
		updateSrcs(content, boardNo);
		
		if(count > 0) {
			return true;
		}
		return false;
	}

	@Override
	public boolean remove(Long boardNo) {
		attachMapper.deleteUpload(boardNo);
		int count = boardMapper.deleteNotice(boardNo);
		if(count > 0) {
			return true;	
		}
		return false;
	}

	
	
	public void updateSrcs(String content, Long boardNo){
		String upload = "D:";
		List<String> list = new ArrayList<>();

		while(true) {
			int index_1 = content.indexOf("<img");
			if(index_1 == -1) {
				break;
			}
			content = content.substring(index_1);
			int index_2 = content.indexOf("src=");
			content = content.substring(index_2 + 5);
			int index_3 = content.indexOf("\" ");
			String content2 = content.substring(0, index_3);
			content = content.substring(index_3);
			list.add(content2);
		}
		
		for(String path : list) {
			String uploadPath = upload + path;
			AttachVo attachVo = new AttachVo();
			attachVo.setBoardNo(boardNo);
			attachVo.setUploadPath(uploadPath);
			attachMapper.insertUpload(attachVo);
		}
		
	}
}
