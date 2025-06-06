package com.future.my.common.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FileController {
	
	@Value("#{util['file.upload.path']}")
	private String CURR_IMAGE_PATH;
	
	@Value("#{util['file.download.path']}")
	private String WEB_PATH;
	
	@RequestMapping("/download")
	public void download(String imageFileName
			           , HttpServletResponse response) throws IOException {
		
		OutputStream out = response.getOutputStream();
		String downloadFile = CURR_IMAGE_PATH + "\\" + imageFileName;
		File file = new File(downloadFile);
		if(!file.exists()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "file not found");
		}
		// 서버에서 요청 파일을 찾아서 전달 (실시간 전송) 
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Content-Disposition", "attachment; fileName="+imageFileName);
		try(FileInputStream in = new FileInputStream(file)){
			byte[]  buffer = new byte[1024 * 8];
			while(true) {
				int count = in.read(buffer);
				if(count == -1) {
					break;
				}
				out.write(buffer,0, count);// 실시간 전송
			}
		}catch(IOException e) {
		}finally {
			out.close();
		}
		
	}

}
