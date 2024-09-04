package com.teamproject.www.lee.service.item;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.www.lee.domain.item.ItemBuyDto;
import com.teamproject.www.lee.domain.item.ItemTypeDto;
import com.teamproject.www.lee.domain.item.MyItemDto;
import com.teamproject.www.lee.domain.item.ShopItemDto;
import com.teamproject.www.lee.mapper.item.ItemMapper;
import com.teamproject.www.lee.service.user.UserService;

import lombok.extern.log4j.Log4j;

@Service("leeItemService")
@Log4j
public class ItemServiceImpl implements ItemService{
	@Autowired
	private ItemMapper itemMapper;
	@Autowired
	private UserService userService;
	
	//기본 아이템 체크 후 처리
	@Override
	@Transactional
	public void checkMyBasicItem(String userid) {
		int checkResult = itemMapper.checkMyItems(userid);
		// 0 이상이면 아이템 있는거니 처리할 내용x
		// 0 이면 기본 아이템이 없으니 추가
		if(checkResult == 0) {
			itemMapper.insertMyItem(userid, 1);
			itemMapper.insertMyItem(userid, 2);
		}
	}
	
	@Override
	public List<MyItemDto> getMyItemList(String userId) {
		return itemMapper.getMyItemList(userId);
	}

	@Override
	public List<ItemTypeDto> getItemTypeList() {
		return itemMapper.getItemTypeList();
	}

	@Override
	public List<ShopItemDto> getItemList() {
		return itemMapper.getItemList();
	}
	
	//아이템 구입
	@Transactional
	@Override
	public boolean buyItem(ItemBuyDto dto) {
		log.info("itemService, buyItem().....");
		log.info("dto : " + dto);
		String userid = dto.getUserid();
		int itemno = dto.getItemno();
		int price = dto.getPrice();
		
		log.info("userid : " + userid);
		log.info("itemno : " + itemno);
		log.info("price : " + price);
		//포인트 차감
		boolean pointUpdateResult = userService.updatePoint(userid, -price);
		if(pointUpdateResult == false) {
			log.info("포인트 차감 실패");	
			return false;
		}
		//아이템 등록
		int insertItemResult = itemMapper.insertMyItem(userid, itemno);
		if(insertItemResult == 0) {
			log.info("아이템 등록 실패");
			return false;
		}
		return true;
	}

	//스몰텐트 이벤트
	@Override
	public boolean eventSmallTent(String userid) {
		int result = itemMapper.insertSmallTent(userid);
		if(result > 0) {
			return true;
		}
		return false; 
	}

	
}
