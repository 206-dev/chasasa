package com.teamproject.www.lee.service.item;

import java.util.List;

import com.teamproject.www.lee.domain.item.ItemBuyDto;
import com.teamproject.www.lee.domain.item.ItemTypeDto;
import com.teamproject.www.lee.domain.item.MyItemDto;
import com.teamproject.www.lee.domain.item.ShopItemDto;

public interface ItemService {
	// 기본 아이템 체크후 없으면 추가
	public void checkMyBasicItem(String userid);
	
	// 내 아이템 리스트 가져오기
	public List<MyItemDto> getMyItemList(String userId);
	
	// 아이템 타입 리스트 가져오기
	public List<ItemTypeDto> getItemTypeList();
	
	// 아이템 리스트 가져오기
	public List<ShopItemDto> getItemList();
	
	// 아이템 구입
	public boolean buyItem(ItemBuyDto dot);
	
	// 스몰텐트 이벤트
	public boolean eventSmallTent(String userid);
}
