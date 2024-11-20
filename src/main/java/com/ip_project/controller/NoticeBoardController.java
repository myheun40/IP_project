package com.ip_project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/notice")
public class NoticeBoardController {

    @GetMapping("/noticeboard")
    public String noticeboard() {
        return "notice/noticeboard";
    }

    @GetMapping("/acceptancewrite")
    public String acceptancewrite() {
        return "notice/acceptancewrite";
    }

    @GetMapping("/acceptanceboard")
    public String acceptanceboard() {
        return "notice/acceptanceboard";
    }

    @GetMapping("/resourcewrite")
    public String resourcewrite() {
        return "notice/resourcewrite";
    }

    @GetMapping("/resourceboard")
    public String resourceboard() {
        return "notice/resourceboard";
    }
}