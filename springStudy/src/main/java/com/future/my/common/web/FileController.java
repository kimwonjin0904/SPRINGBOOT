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
    public void download(String imageFileName, HttpServletResponse response) throws IOException {
        OutputStream out = response.getOutputStream();
        String downloadFile = CURR_IMAGE_PATH + File.separator + imageFileName; // OS 독립적 경로 처리
        File file = new File(downloadFile);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "file not found");
            return; // 파일이 없을 경우 추가 처리 방지
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
            e.printStackTrace(); // 예외 처리 추가 (디버깅용)
        } finally {
            out.close();
        }
    }
}
