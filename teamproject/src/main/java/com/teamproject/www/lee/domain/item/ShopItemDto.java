package com.teamproject.www.lee.domain.item;

import lombok.Data;

@Data
public class ShopItemDto {
	private Integer itemno;
	private Integer typeno;
	private String itemnamekr;
	private Integer price;
	private Integer capacity;
	private String itempath;
}
