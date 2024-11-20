package com.ip_project.service;

import com.ip_project.entity.SelfBoard;
import com.ip_project.repository.SelfBoardRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import java.time.LocalDateTime;
import java.util.List;


// SelfBoardService.java
@Service
@Transactional(readOnly = true)  // 읽기 전용 트랜잭션 설정 추가
public class SelfBoardService {
    private final SelfBoardRepository selfBoardRepository;

    @Autowired
    public SelfBoardService(SelfBoardRepository selfBoardRepository) {
        this.selfBoardRepository = selfBoardRepository;
    }

    public void listByUsername(Model model, String username) {
        List<SelfBoard> selfBoards = selfBoardRepository.findByMemberUsername(username);
        selfBoards.sort((o1, o2) -> o2.getSelfDate().compareTo(o1.getSelfDate()));
        model.addAttribute("selfBoards", selfBoards);
    }

    public List<SelfBoard> list() {
        return selfBoardRepository.findAll();
    }

    public SelfBoard findById(Long idx) {
        return selfBoardRepository.findById(idx)
                .orElseThrow(() -> new EntityNotFoundException("SelfBoard not found with id: " + idx));
    }

    @Transactional  // 쓰기 작업을 위한 트랜잭션 추가
    public SelfBoard save(SelfBoard selfBoard) {
        if (selfBoard.getSelfDate() == null) {
            selfBoard.setSelfDate(LocalDateTime.now());
        }
        return selfBoardRepository.save(selfBoard);
    }

    @Transactional
    public void deleteById(Long idx) {
        selfBoardRepository.deleteById(idx);
        System.out.println("삭제하는 selfIdx:" + idx);
    }
}