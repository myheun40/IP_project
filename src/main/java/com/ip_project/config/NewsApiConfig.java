package com.ip_project.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "newsapi")
@Getter
@Setter
public class NewsApiConfig {
    private String key;
}