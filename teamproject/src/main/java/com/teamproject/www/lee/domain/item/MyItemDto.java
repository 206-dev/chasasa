package com.teamproject.www.lee.domain.item;

import lombok.Data;

@Data
public class MyItemDto {
	private Integer itemno;
	private String itemname;
	private String type;
	private Integer price;
	private Integer capacity;
}
