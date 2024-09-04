package com.teamproject.www.jang.metaverse;

import java.util.Map;

import lombok.Data;

@Data
public class Items {
	private int sizeX;
	private int sizeY;
	private int price;
	private Map<Integer, Integer> location;
}
