package com.ip_project.entity;

import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

@Component
public class PythonFunction {

    public List<String> getInterviewQuestions(String companyName, String jobPosition) {
        try {
            // pjfunction.py의 get_interview_questions 함수 호출
            ProcessBuilder pb = new ProcessBuilder("python3", "pjfunction.py", "interview",
                    companyName, jobPosition);
            Process p = pb.start();

            BufferedReader in = new BufferedReader(new InputStreamReader(p.getInputStream()));
            List<String> questions = new ArrayList<>();
            String line;
            while ((line = in.readLine()) != null) {
                questions.add(line);
            }
            return questions;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public List<String> getPersonalityQuestions(String introContent) {
        try {
            // pjfunction.py의 get_personality_questions 함수 호출
            ProcessBuilder pb = new ProcessBuilder("python3", "pjfunction.py", "personality",
                    introContent);
            Process p = pb.start();

            BufferedReader in = new BufferedReader(new InputStreamReader(p.getInputStream()));
            List<String> questions = new ArrayList<>();
            String line;
            while ((line = in.readLine()) != null) {
                questions.add(line);
            }
            return questions;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
}