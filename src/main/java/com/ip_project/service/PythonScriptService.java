package com.ip_project.service;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;

@Service
@Slf4j
public class PythonScriptService {
    private Process pythonProcess;

    @PostConstruct
    public void startPythonScript() {
        try {
            String pythonPath = "python";
            String scriptPath = "Python/interview_generator.py";

            ProcessBuilder pb = new ProcessBuilder(pythonPath, scriptPath);
            pb.redirectErrorStream(true);

            // 스크립트 실행
            pythonProcess = pb.start();

            // 출력을 비동기적으로 읽기
            new Thread(() -> {
                try (BufferedReader reader = new BufferedReader(
                        new InputStreamReader(pythonProcess.getInputStream()))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        log.info("Python output: {}", line);
                    }
                } catch (IOException e) {
                    log.error("Error reading Python output", e);
                }
            }).start();

        } catch (IOException e) {
            log.error("Error starting Python script", e);
        }
    }

    @PreDestroy
    public void stopPythonScript() {
        if (pythonProcess != null) {
            pythonProcess.destroy();
        }
    }

    public void sendRequest(Long selfIdx) {
        try {
            // Python 프로세스에 요청 전송
            OutputStream out = pythonProcess.getOutputStream();
            out.write((selfIdx + "\n").getBytes());
            out.flush();
        } catch (IOException e) {
            log.error("Error sending request to Python script", e);
        }
    }
}