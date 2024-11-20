package com.ip_project.service;

import com.ip_project.entity.News;
import com.ip_project.repository.NewsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NewsService {

    @Autowired
    private NewsRepository newsRepository;

    // 회사 ID로 뉴스 목록을 반환하는 메서드
    public List<News> findByCompanyIdx(Long companyIdx) {
        return newsRepository.findByCompany_CompanyIdxOrderByNewsDateDesc(companyIdx);
    }
}
