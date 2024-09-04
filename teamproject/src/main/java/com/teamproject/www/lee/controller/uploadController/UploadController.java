package com.teamproject.www.lee.controller.uploadController;

import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.teamproject.www.lee.Util.MyFileUtil;
import com.teamproject.www.lee.domain.FolderDto;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Log4j
@Controller("leeUploadController")
@RequestMapping("/lee/upload/*")
public class UploadController {
	//이미지 파일 업로드
	@ResponseBody
	@PostMapping("/uploadAction")
	 public Map<String, Object> uploadAction(@RequestParam("upload") MultipartFile uploadFile, HttpSession session) throws Exception {
		  log.info("-----------------------------------uploadAction-----------------------------------");
	        // board-img로 폴더 생성
	        FolderDto folderDto = MyFileUtil.getFolder("board-img");
	        String uploadPath = folderDto.getUploadPath(); // 폴더 경로
	        
	        // response 생성, ck에디터에 넘겨줄것
	        Map<String, Object> response = new HashMap<>();

	        // 이미지가 있을때
	        if (uploadFile != null && !uploadFile.isEmpty()) {
	            // URL 만들기
	            String uuid = UUID.randomUUID().toString();
	            String savedFileName = uuid + "_" + uploadFile.getOriginalFilename();
	            String url = "/lee/upload/display?fileName=/" + uploadPath + "/" + savedFileName;
	            File file = new File(uploadPath, savedFileName);
	            
	            // 이미지 폴더에 저장
	            uploadFile.transferTo(file);
	            
	            // response에 url추가
	            response.put("url", url);
	            response.put("uploaded", true);
	        } else {
	            response.put("uploaded", false);
	        }
	        return response;
    }
	
	@ResponseBody
	@PostMapping("/uploadProfileImg")
	 public String uploadProfileImg(MultipartFile uploadFile, HttpSession session) throws Exception {
		  log.info("-----------------------------------uploadAction-----------------------------------");
	        // board-img로 폴더 생성
	        FolderDto folderDto = MyFileUtil.getFolder("profile-img");
	        String uploadPath = folderDto.getUploadPath(); // 폴더 경로
	        String url = "";
	        // response 생성, ck에디터에 넘겨줄것

	        // 이미지가 있을때
	        if (uploadFile != null && !uploadFile.isEmpty()) {
	            // URL 만들기
	            String uuid = UUID.randomUUID().toString();
	            String savedFileName = uuid + "_" + uploadFile.getOriginalFilename();
	            url = "/lee/upload/display?fileName=/" + uploadPath + "/" + savedFileName;
//	            File file = new File(uploadPath, savedFileName);
	            
	         
				// 원본 파일을 읽어서 -> 썸네일 파일로 출력
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, savedFileName));
				Thumbnailator.createThumbnail(uploadFile.getInputStream(), thumbnail, 110, 110);
				thumbnail.close();
		
//				uploadFile.transferTo(file);
	            
	        }
	        return url;
    }
	
//	//이미지 전송
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> display(String fileName) throws Exception{
		File file = new File(fileName);
		byte[] data = FileCopyUtils.copyToByteArray(file);
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", Files.probeContentType(file.toPath()));
		ResponseEntity<byte[]> entity = new ResponseEntity<byte[]>(data, headers, HttpStatus.OK);
		return entity;
	} 
}
