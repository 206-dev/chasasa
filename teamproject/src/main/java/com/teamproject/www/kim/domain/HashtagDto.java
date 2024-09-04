package com.teamproject.www.kim.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class HashtagDto {
	private String tag;
    private int frequency;
}
