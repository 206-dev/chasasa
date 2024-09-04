package com.teamproject.www.jang.metaverse;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lombok.Data;
import lombok.ToString;

@ToString
@Data
public class Background {
	private int rows;
	private int columns;
	private List<List<Map<String, Integer>>> array;
	private List<Items> items;

	public Background() {
		this.rows = 6;
		this.columns = 6;
		this.array = setArray(initialArray());
		this.items = null;
	}

	public List<Map<String, Integer>> initialArray() {
		List<Map<String, Integer>> array =Arrays.asList(new HashMap<String, Integer>() {
			{
				put("x", 303);
				put("y", 104);
			}
		}, new HashMap<String, Integer>() {
			{
				put("x", 589);
				put("y", 292);
			}
		}, new HashMap<String, Integer>() {
			{
				put("x", 283);
				put("y", 503);
			}
		}, new HashMap<String, Integer>() {
			{
				put("x", 0);
				put("y", 314);
			}
		});
		
		return array;
	}

	public List<List<Map<String, Integer>>> setArray(List<Map<String, Integer>> polygon) {
		List<List<Map<String, Integer>>> coordinates = new ArrayList<>();

		// 4개의 점을 가져옴
		Map<String, Integer> point1 = polygon.get(0);
		Map<String, Integer> point2 = polygon.get(1);
		Map<String, Integer> point3 = polygon.get(2); // 3번째 점은 index 2
		Map<String, Integer> point4 = polygon.get(3); // 4번째 점은 index 3

		double portionRows = 1.0 / rows;
		double portionColumns = 1.0 / columns;

		for (int i = 0; i <= rows; i++) { // 0부터 rows까지 포함
			List<Map<String, Integer>> tempArray = new ArrayList<>();

			// calPoint1 계산
			Map<String, Integer> calPoint1 = new HashMap<>();
			calPoint1.put("x", (int) (point1.get("x") + (point4.get("x") - point1.get("x")) * portionColumns * i));
			calPoint1.put("y", (int) (point1.get("y") + (point4.get("y") - point1.get("y")) * portionColumns * i));
			
			// calPoint2 계산
			Map<String, Integer> calPoint2 = new HashMap<>();
			calPoint2.put("x", (int) (point2.get("x") + (point3.get("x") - point2.get("x")) * portionColumns * i));
			calPoint2.put("y", (int) (point2.get("y") + (point3.get("y") - point2.get("y")) * portionColumns * i));
			
			for (int j = 0; j <= columns; j++) { // 0부터 columns까지 포함
				Map<String, Integer> point = new HashMap<String, Integer>();
				point.put("x", (int) (calPoint1.get("x") + (calPoint2.get("x") - calPoint1.get("x")) * portionColumns * j));
				point.put("y", (int) (calPoint1.get("y") + (calPoint2.get("y") - calPoint1.get("y")) * portionColumns * j));
				tempArray.add(point);
			}

			coordinates.add(tempArray); // coordinates에 tempArray 추가
		}
//		System.out.println(coordinates);
		return coordinates;
	}
}
