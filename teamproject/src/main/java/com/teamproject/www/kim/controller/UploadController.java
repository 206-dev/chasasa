package com.teamproject.www.kim.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.teamproject.www.kim.domain.AttachBoardDto;
import com.teamproject.www.kim.domain.AttachFileDto;
import com.teamproject.www.kim.mapper.AttachMapper;
import com.teamproject.www.kim.service.BoardService;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
@RequestMapping("/kim/upload/*")
public class UploadController {
	@Autowired
    private AttachMapper attachMapper;
	@Autowired
    private BoardService boardService;

    @GetMapping("/uploadForm")
    public void uploadForm() {
    }
    
    
    
    private String getFolder() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        Date today = new Date();
        String folders = sdf.format(today);
        return folders;
    }
    
    
    // 이미지 파일인지 체크
    private boolean checkimageType(File file) {
        try {
            String contentType = Files.probeContentType(file.toPath());
            log.info("contentType:" + contentType);
            if (contentType == null) {
                contentType = MediaType.APPLICATION_OCTET_STREAM_VALUE;
            }
            return contentType.startsWith("image");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @ResponseBody
    @PostMapping("/uploadFormAction")
    public List<Map<String, Object>> uploadFormAction(MultipartFile[] uploadFile) throws Exception {
        log.info("uploadFormAction...");
        String baseUploadPath = "D:/upload"; // 기본 업로드 경로
        String todayFolderPath = baseUploadPath + "/" + getFolder(); // 오늘 날짜 경로 생성
        List<Map<String, Object>> list = new ArrayList<>();

        for (MultipartFile multi : uploadFile) {
            log.info("-------------------------");
            log.info(multi.getOriginalFilename());
            log.info(multi.getSize());

            AttachFileDto attachDto = uploadFileAndGetDto(multi, baseUploadPath, true);
            if (attachDto != null) {
                // uploadPath에 파일 이름 추가
                String fullPath = attachDto.getUploadPath() + "/" + attachDto.getUuid() + "_" + attachDto.getFileName();
                attachDto.setUploadPath(fullPath);

                // JSON 형태로 반환할 데이터를 Map에 저장
                Map<String, Object> responseData = new HashMap<>();
                responseData.put("uploadPath", attachDto.getUploadPath());
                responseData.put("fileName", attachDto.getFileName());
                responseData.put("uuid", attachDto.getUuid());
                responseData.put("image", attachDto.isImage());
                responseData.put("todayFolderPath", todayFolderPath); // 추가된 경로 정보

                log.info("드래그 앤 드롭 파일 fullpath = " + attachDto.getUploadPath());
                list.add(responseData); // 리스트에 추가
            }
        }
        return list; // JSON 형식으로 반환
    }

    
    @GetMapping("/uploadAjax")
    public void uploadAjax() {
    }
    
    // <img src="/display?fileName="/>
    @ResponseBody
    @GetMapping("/display")
    public ResponseEntity<byte[]> getFile(String fileName) throws Exception {
    	File f = new File(fileName); // 전체 경로로 파일을 찾음
        // binary data
        byte[] data = FileCopyUtils.copyToByteArray(f);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", Files.probeContentType(f.toPath())); // image/png
        ResponseEntity<byte[]> entity =
                new ResponseEntity<byte[]>(data, headers, HttpStatus.OK);
        return entity;
    }
    
    @GetMapping(value = "/download",
                produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    @ResponseBody
    // org.springframework.core.io.Resource
    public ResponseEntity<Resource> downloadFile(String fileName) throws Exception {
        // 2024/07/25/69a437d2-f608-4259-be4d-9b474deff251_test.txt
        log.info("downlad file:" + fileName);
        Resource resource = new FileSystemResource(fileName); // 변경된 부분
        log.info("resource:" + resource);
        String resourceName = resource.getFilename();
        log.info("resourceName:" + resourceName);
        int userScoreIndex = resourceName.indexOf("_");
        String attachName = resourceName.substring(userScoreIndex + 1);
        log.info("attachName:" + attachName);
        // org.springframework.http.HttpHeaders
        HttpHeaders headers = new HttpHeaders();
        String isoString = new String(attachName.getBytes("utf-8"), "iso-8859-1");
        log.info("isoString:" + isoString);
        headers.add("Content-Disposition", "attachment; filename=" 
                + isoString);
        ResponseEntity<Resource> entity = new ResponseEntity<Resource>(
                resource, headers, HttpStatus.OK);
        return entity;
    }
    
    // server.xml 
    // - <Connect port="80" parseBodyMethods="POST,PUT,PATCH,DELETE">
    @DeleteMapping("/delete")
    @ResponseBody
    public String delete(@RequestBody Map<String, String> request) {
        String fileName = request.get("fileName");
        System.out.println(fileName);
        log.info("fileName!!!!!:" + fileName);
        if (fileName == null || fileName.trim().isEmpty()) {
            return "fail";
        }

        File f = new File(fileName); // 전체 경로를 사용하여 파일 삭제
        boolean isImage = checkimageType(f);
        if (isImage) {
            String thumbnail = fileName.replaceFirst("([^/]+)$", "s_$1"); // 썸네일 경로 처리
            File fThumbnail = new File(thumbnail);
            if (fThumbnail.exists()) {
                fThumbnail.delete();
            }
        }
        if (f.exists()) {
            f.delete();
        }
        return "success";
    }
    


    
    private AttachFileDto uploadFileAndGetDto(MultipartFile multi, String baseUploadPath, boolean createThumbnail) throws IOException {
        if (multi.isEmpty()) {
            return null;
        }

        String folderPath = getFolder();
        String uploadPath = baseUploadPath + "/" + folderPath;

        File folder = new File(uploadPath);
        if (!folder.exists()) {
            folder.mkdirs();
        }

        String uuid = UUID.randomUUID().toString();
        String originalFileName = multi.getOriginalFilename(); // 파일의 원래 이름
        String savedFileName = uuid + "_" + originalFileName; // UUID를 추가한 파일명
        File f = new File(uploadPath, savedFileName);
        multi.transferTo(f);

        boolean isImage = checkimageType(f);
        
        String thumbnailPath = null;

        AttachFileDto attachDto = AttachFileDto.builder()
                .fileName(originalFileName) // 여기서 파일의 원래 이름을 저장
                .uuid(uuid)
                .uploadPath(uploadPath) // 여기에 폴더 경로를 저장
                .image(isImage)
                .build();

        if (isImage) {
            FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + savedFileName));
            Thumbnailator.createThumbnail(multi.getInputStream(), thumbnail, 100, 100);
            thumbnail.close();
            
            thumbnailPath = uploadPath + "/s_" + savedFileName;
        }

        return attachDto;
    }

    
    
    @ResponseBody
    @PostMapping("/ckUploadFormAction")
    public ResponseEntity<Map<String, Object>> uploadCKEditorImage(MultipartFile upload, HttpSession session) {
    	 	String baseUploadPath = "D:/upload";

    	    Map<String, Object> response = new HashMap<>();

    	    try {
    	    	
    	    	AttachFileDto attachDto = uploadFileAndGetDto(upload, baseUploadPath, false);
    	    	
    	    	 if (attachDto == null) {
    	                response.put("uploaded", 0);
    	                response.put("error", Map.of("message", "No file uploaded"));
    	                return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    	            }
    	    	 
	    	    	// 수정: uploadPath에 파일 이름 추가
	    	        String fullPath = attachDto.getUploadPath() + "/" + attachDto.getUuid() + "_" + attachDto.getFileName();
	    	        attachDto.setUploadPath(fullPath);
	    	    	// 로그 추가
	    	        log.info("CKEditor fullPath = " + attachDto.getUploadPath());
    	    	 
    	    	 	List<AttachBoardDto> ckeditorImages = (List<AttachBoardDto>) session.getAttribute("ckeditorImages"); // 추가된 부분
    	            if (ckeditorImages == null) {
    	                ckeditorImages = new ArrayList<>();
    	            }

    	    	 	// 데이터베이스에 파일 정보 저장
    	            AttachBoardDto attachBoardDto = AttachBoardDto.builder()
    	                    .uuid(attachDto.getUuid())
    	                    .fileName(attachDto.getFileName())
    	                    .uploadPath(attachDto.getUploadPath())
    	                    .image(attachDto.isImage() ? "I" : "F")
    	                    .boardNo(null)
    	                    .build();
    	            ckeditorImages.add(attachBoardDto); // 추가된 부분
    	            session.setAttribute("ckeditorImages", ckeditorImages); // 추가된 부분

    	            String fileUrl = "/kim/upload/ckDisplay?fileName=" + getFolder() + "/" + attachDto.getUuid() + "_" + attachDto.getFileName();
    	            response.put("uploaded", 1);
    	            response.put("fileName", attachDto.getFileName());
    	            response.put("url", fileUrl);
    	            response.put("uuid", attachDto.getUuid());
    	            response.put("uploadPath", getFolder());
    	        } catch (Exception e) {
    	            response.put("uploaded", 0);
    	            response.put("error", Map.of("message", e.getMessage()));
    	            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
    	        }

    	        return new ResponseEntity<>(response, HttpStatus.OK);
    }
    
    @ResponseBody
    @GetMapping("/ckDisplay")
    public ResponseEntity<byte[]> displayCKEditorImage(String fileName) throws Exception {
        File file = new File("D:/upload/" + fileName);
        byte[] data = FileCopyUtils.copyToByteArray(file);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", Files.probeContentType(file.toPath()));
        return new ResponseEntity<>(data, headers, HttpStatus.OK);
    }
}