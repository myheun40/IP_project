package com.ip_project.service;

import com.ip_project.dto.SelfIntroductionDTO;
import com.ip_project.entity.SelfBoard;
import com.ip_project.entity.SelfIntroduction;
import com.ip_project.repository.SelfIntroductionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class SelfIntroductionService {

    @Autowired
    private SelfIntroductionRepository selfIntroductionRepository;

    // SelfBoard의 idx를 받아서 해당 idx에 연관된 SelfIntroduction을 가져오는 메서드
    public SelfIntroductionDTO getSelfIntroductions(SelfBoard selfBoard) {
        List<SelfIntroduction> selfIntroductions = selfIntroductionRepository.findAllBySelfBoard(selfBoard);

        SelfIntroductionDTO dto = new SelfIntroductionDTO();
        dto.setIdx(selfBoard.getSelfIdx());  // selfIdx 설정
        dto.setDate(selfBoard.getSelfDate());  // 작성일자 설정
        dto.setTitle(selfBoard.getSelfTitle());  // 제목 설정
        dto.setCompany(selfBoard.getSelfCompany());  // 회사명 설정
        dto.setPosition(selfBoard.getSelfPosition());  // 직무 설정

        List<String> questions = new ArrayList<>();
        List<String> answers = new ArrayList<>();

        // 질문과 답변 설정
        for (SelfIntroduction intro : selfIntroductions) {
            questions.add(intro.getIntroQuestion());
            answers.add(intro.getIntroAnswer());
        }
        dto.setQuestions(questions);
        dto.setAnswers(answers);

        return dto;
    }

    public void saveSelfIntroduction(SelfIntroduction selfIntroduction) {
        selfIntroductionRepository.save(selfIntroduction);
    }

    @Transactional
    public void deleteSelfIntroduction(SelfBoard selfBoard) {
        selfIntroductionRepository.deleteBySelfBoard(selfBoard);
    }

    public List<SelfIntroduction> findBySelfBoard(SelfBoard selfBoard) {
        return selfIntroductionRepository.findAllBySelfBoard(selfBoard);
    }
}