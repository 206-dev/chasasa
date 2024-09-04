package com.teamproject.www.kim.domain;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class AttachFileDto {

	private String fileName;	// 1.png
	private String uploadPath;  // yyyy/MM/dd
	private String uuid;        // Random String
	private boolean image;		// 이미지인지 여부
}