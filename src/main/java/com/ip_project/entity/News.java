package com.ip_project.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Data
@Entity
@Table(name = "News")
public class News {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "news_seq")
    @SequenceGenerator(name = "news_seq", sequenceName = "news_seq", allocationSize = 1)
    @Column(name = "NEWS_IDX")
    private Long newsIdx;  // 자동 증가 컬럼

    @Column(name = "NEWS_TITLE")
    private String newsTitle;  // 뉴스 제목

    @Column(name = "NEWS_DESCRIPTION")
    private String newsDescription;  // 뉴스 설명

    @Column(name = "NEWS_DATE")
    private Date newsDate;  // 뉴스 날짜

    @Column(name = "NEWS_URL")
    private String newsUrl;  // 뉴스 URL

    @Column(name = "NEWS_IMAGE")
    private String newsImage;  // 뉴스 이미지 URL

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "COMPANY_IDX", referencedColumnName = "COMPANY_IDX")
    private Company company;  //

}
