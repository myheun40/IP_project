package com.ip_project.repository;

import com.ip_project.entity.Company;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CompanyRepository extends JpaRepository<Company, Long> {
    Company findByCompanyNameContaining(String companyName);
}
