package com.teamproject.www.kim.domain;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString	
@Builder
public class AttachBoardDto {
	private String fileName;	// 1.png
	private String uploadPath;  // yyyy/MM/dd
	private String uuid;        // Random String
	private String image;		// 이미지인지 여부 ("I", "F")
	private Long boardNo;			// 어느 게시글의 첨부파일인지
}
