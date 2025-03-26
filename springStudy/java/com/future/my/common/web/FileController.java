package com.future.my.common.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
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
	public void download(String imageFileName, HttpServletResponse response) throws IOException {
		OutputStream out = response.getOutputStream();
		String downloadFile = CURR_IMAGE_PATH + File.separator + imageFileName;
		File file = new File(downloadFile);
		if (!file.exists()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
			return;
		}
		// 서버에서 요청 파일을 찾아서 전달 (실시간 전송)
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Content-Disposition", "attachment; filename=" + imageFileName);
		try (FileInputStream in = new FileInputStream(file)) {
			byte[] buffer = new byte[1024 * 8];
			int count;
			while ((count = in.read(buffer)) != -1) {
				out.write(buffer, 0, count); // 실시간 전송
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
	}
	
	@RequestMapping("/multiImgUpload")
	public void multiImgUpload(HttpServletRequest req, HttpServletResponse res) {
		try {
			// 저장 후 이미지 저장 정보 전달
			String sFileInfo = "";
			String fileName = req.getHeader("file-name");
			String prifix = fileName.substring(fileName.lastIndexOf(".") + 1);
			String path = CURR_IMAGE_PATH;
			File file = new File(path);
			if (!file.exists()) {
				file.mkdir();
			}
			// 저장될 이름
			String realName = UUID.randomUUID().toString().replace("-", "") + "." + prifix;
			InputStream is = req.getInputStream();
			OutputStream os = new FileOutputStream(new File(path + File.separator + realName));
			int read;
			byte[] b = new byte[1024];
			while ((read = is.read(b)) != -1) {
				os.write(b, 0, read);
			}
			if (is != null) {
				is.close();
			}
			os.flush();
			os.close();
			// smartedit에서 아래 정보를 사용함
			sFileInfo += "&bNewLine=true";
			sFileInfo += "&sFileName=" + fileName;
			sFileInfo += "&sFileURL=" + WEB_PATH + realName;
			System.out.println(sFileInfo);
			PrintWriter print = res.getWriter();
			print.print(sFileInfo);
			print.flush();
			print.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
