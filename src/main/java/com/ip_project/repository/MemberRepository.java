package com.ip_project.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.ip_project.entity.Member;
import java.util.Optional;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {
    Optional<Member> findByUsername(String username);
    Optional<Member> findByIdx(Long idx);
    Optional<Member> findByEmail(String email);

    @Query("SELECT COUNT(m) > 0 FROM Member m WHERE m.username = :username")
    boolean existsByUsername(@Param("username") String username);
}