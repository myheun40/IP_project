package com.ip_project.repository;

import com.ip_project.entity.Company;
import com.ip_project.entity.LikeCompany;
import com.ip_project.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface LikeCompanyRepository extends JpaRepository<LikeCompany, Long> {

    @Query("SELECT COUNT(lc) > 0 FROM LikeCompany lc WHERE lc.member = :member AND lc.company = :company")
    boolean existsByMemberAndCompany(@Param("member") Member member, @Param("company") Company company);

    List<LikeCompany> findByMember(Member member);

    // member와 company로 LikeCompany 엔터티를 조회하는 메서드 정의
    LikeCompany findByMemberAndCompany(Member member, Company company);


}
