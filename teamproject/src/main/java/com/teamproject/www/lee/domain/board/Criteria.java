package com.teamproject.www.lee.domain.board;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private Integer pageNum;
	private Integer amount;
	private String keyword;
	private String type;
	private Integer boardtypeno;
	public Criteria() {
		this(1, 20);
	}
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		if (type != null) {
			String[] strs = type.split("");
			return strs;
		}
		return null;
	}
}
