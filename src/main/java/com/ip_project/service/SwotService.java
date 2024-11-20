package com.ip_project.service;
import com.ip_project.entity.Swot;
import com.ip_project.repository.SwotRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SwotService {
    @Autowired
    private SwotRepository swotRepository;

    public Swot findByCompanyIdx(Long companyIdx) {
        return swotRepository.findByCompany_CompanyIdx(companyIdx);
    }
}
