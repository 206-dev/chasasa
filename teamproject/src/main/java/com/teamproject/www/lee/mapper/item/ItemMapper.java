package com.teamproject.www.lee.mapper.item;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.www.lee.domain.item.ItemTypeDto;
import com.teamproject.www.lee.domain.item.MyItemDto;
import com.teamproject.www.lee.domain.item.ShopItemDto;

public interface ItemMapper {
	// 기본 아이템 체크 
	public int checkMyItems(String userid);
	
	// 아이템 리스트 가져오기
	public List<ShopItemDto> getItemList();
	
	// 아이템 타입 리스트 가져오기
	public List<ItemTypeDto> getItemTypeList();
	
	// 보유 아이템 가져오기
	public List<MyItemDto> getMyItemList(String userid);
	
	// 아이템 구입 insert tbl_user_items
	public int insertMyItem(@Param("userid") String userid,@Param("itemno") int itemno);
	
	//제휴사 소형텐트 이벤트
	public int insertSmallTent(String userid);
}	
