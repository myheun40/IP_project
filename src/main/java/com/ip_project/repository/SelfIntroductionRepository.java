package com.ip_project.repository;

import com.ip_project.entity.SelfBoard;
import com.ip_project.entity.SelfIntroduction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SelfIntroductionRepository extends JpaRepository<SelfIntroduction, Long> {
    List<SelfIntroduction> findAllBySelfBoard(SelfBoard selfBoard);
    void deleteBySelfBoard(SelfBoard selfBoard);
}