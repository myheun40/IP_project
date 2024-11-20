package com.ip_project.repository;

import com.ip_project.entity.News;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NewsRepository extends JpaRepository<News, Long> {
    List<News> findByCompany_CompanyIdxOrderByNewsDateDesc(Long companyIdx);
}
