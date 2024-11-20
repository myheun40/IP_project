package com.ip_project.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import com.ip_project.entity.SelfBoard;
import java.util.List;

public interface SelfBoardRepository extends JpaRepository<SelfBoard, Long> {
    // Member 엔티티의 username으로 SelfBoard를 찾는 메서드
    @Query("SELECT sb FROM SelfBoard sb WHERE sb.member.username = :username")
    List<SelfBoard> findByMemberUsername(@Param("username") String username);

    // 또는 이렇게도 가능합니다
    List<SelfBoard> findByMember_Username(String username);
}