package com.teamproject.www.kim.util;
//
//import java.io.File;
//import java.io.IOException;
//import java.nio.file.Files;
//
//import org.springframework.http.MediaType;
//
//import lombok.extern.log4j.Log4j;
//
//@Log4j
public class MyFileUtil {
//	// 이미지 파일인지 체크
//	public static boolean checkimageType(File file) {
//		try {
//			String contentType = Files.probeContentType(file.toPath());
//			log.info("contentType:" + contentType);
//			if (contentType == null) {
//				contentType = MediaType.APPLICATION_OCTET_STREAM_VALUE;
//			}
//			return contentType.startsWith("image");
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		return false;
//	}
//	
//	
//	public static String delete(String fileName) {
//		log.info("fileName:" + fileName);
//		File f = new File(fileName);
//		boolean isImage = checkimageType(f);
//		if (isImage) {
//			// 썸네일 이미지 삭제
//			// D:/upload/2024/07/25/07701548-2425-4d0c-a8a8-4d89a03ceaf7_1.png
//			int slashIndex = fileName.lastIndexOf("/");
//			String front = fileName.substring(0, slashIndex + 1);
//			// -> D:/upload/2024/07/25/
//			String rear = fileName.substring(slashIndex + 1);
//			// -> 07701548-2425-4d0c-a8a8-4d89a03ceaf7_1.png
//			String thumbnail = front + "s_" + rear;
//			File fThumbnail = new File(thumbnail);
//			if (fThumbnail.exists()) {
//				fThumbnail.delete();
//			}
//		}
//		// 원본 파일 삭제
//		if (f.exists()) {
//			f.delete();
//		}
//		// 삭제 처리
//		return "success";
//	}
}