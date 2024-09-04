package com.teamproject.www.jang.domain;

import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeCriteria {
	private int pageNum;
	private int amount;
	private String type;
	private String keyword;
	private String sort;
	private String order;
	
	public NoticeCriteria() {
		this(1, 10, "boardNo", "desc");
	}
	
	public NoticeCriteria(int pageNum, int amount, String sort, String order) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.sort = sort;
		this.order = order;
		System.out.println("pageNum: " + pageNum);
	}
	
	// 필요한가?
	public String[] getTypeArr() {
		if (type != null) {
			String[] strs = type.split("");
			return strs;
		}
		return null;
	}
}
