package com.teamproject.www.lee.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.www.lee.domain.item.ItemTypeDto;
import com.teamproject.www.lee.domain.item.ShopItemDto;
import com.teamproject.www.lee.mapper.item.ItemMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ItemMapperTests {
	@Autowired
	private ItemMapper itemMapper;
	
	@Test
	public void instance() {
		log.info("itemMapper: " + itemMapper);
	}
	
	@Test
	public void getItemListTest() {
		List<ShopItemDto> list = itemMapper.getItemList();
		log.info(list);
	}
	
	@Test
	public void getItemTypeTest() {
		List<ItemTypeDto> list = itemMapper.getItemTypeList();
		log.info(list);
	}
	
	@Test
	public void checkMyItemsTest() {
		String userid = "206dev";
		int list =  itemMapper.checkMyItems(userid);
		log.info(list);
	}
}
