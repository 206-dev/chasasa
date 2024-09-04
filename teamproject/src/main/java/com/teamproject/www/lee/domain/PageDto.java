package com.teamproject.www.lee.domain;

import com.teamproject.www.lee.domain.board.Criteria;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDto {
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	private int total;
	private Criteria cri;
	
	public PageDto(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		// 1 ~ 10, 10 ~ 20,
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10;
		this.startPage = endPage - 9;
		
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()));
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
	
}
