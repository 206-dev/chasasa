package com.teamproject.www.kim.domain;

import lombok.Data;

@Data
public class UserBoardTypePreferenceDto {
	private String userId;
    private Integer boardTypeNo;
    private Integer preferenceCount;
}
