package com.teamproject.www.jang.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;


import net.coobird.thumbnailator.Thumbnailator;

@RestController("jangUploadController")
@RequestMapping("/jang/upload/*")
public class UploadController {
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		Date today = new Date();
		String folders = sdf.format(today);
		return folders;
	}
	
	@PostMapping("/image")
	public ResponseEntity<Map> uploadImage(@RequestParam("upload") List<MultipartFile> files) throws Exception {
		
		System.out.println("upload/image...");
		if(files.isEmpty()) {
			return ResponseEntity.badRequest().body(null);
		}
		
		String uploadPath = "/uploadFile/" + getFolder();
		
		File folder = new File(uploadPath);
		
		if(!folder.exists()) {
			folder.mkdirs();
		};
		
		Map<String, String> map = new HashMap<String, String>();
		
		for(MultipartFile aFile : files) {
			System.out.println("----------------------");
			System.out.println("fileName: " + aFile.getName()); // upload
			System.out.println("fileOrigianlName: " + aFile.getOriginalFilename()); // 1.PNG
			System.out.println("contentType: " + aFile.getContentType()); // image/png
			System.out.println("size: " + aFile.getSize()); // 35160
			System.out.println("----------------------");
			
			String uuid = UUID.randomUUID().toString();
			String aFileName = aFile.getOriginalFilename();
			String isImage = aFile.getContentType().startsWith("image") ? "I" : "F";
			
			String savedFileName = uuid + "_" + aFileName;
			File file = new File(uploadPath, savedFileName);
			
			
			
			if(isImage.equals("I")) {
				FileOutputStream thumnail = new FileOutputStream(new File(uploadPath, "s_" + savedFileName));
				Thumbnailator.createThumbnail(aFile.getInputStream(), thumnail, 300, 300);
				thumnail.close();
				map.put("url", uploadPath + "/s_" + savedFileName);
				System.out.println(map);
			}
			
			
			
			
			
			// bno를 제외한 AttachBoardDto 객체 생성
			// 나중에 bno 추가 해야 함
			/*
			AttachBoardDto dto = AttachBoardDto.builder()
								.fileName(aFileName)
								.uploadPath(uploadPath)
								.uuid(uuid)
								.image(isImage)
								.build();
			
			List<AttachBoardDto> list = new ArrayList<>();
			list.add(dto);
			*/
		}
			return ResponseEntity.ok(map);
		
	}
}
