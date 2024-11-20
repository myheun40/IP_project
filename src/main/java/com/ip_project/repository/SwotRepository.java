package com.ip_project.repository;
import com.ip_project.entity.Swot;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SwotRepository extends JpaRepository<Swot, Long> {
    Swot findByCompany_CompanyIdx(Long companyIdx);
}
