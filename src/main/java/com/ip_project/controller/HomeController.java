package com.ip_project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class HomeController {
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    @GetMapping("/")
    public String index(Model model, HttpServletRequest request) {
        String contextPath = request.getContextPath();
        logger.info("Context Path: {}", contextPath);
        model.addAttribute("cpath", contextPath);
        return "main";
    }
}