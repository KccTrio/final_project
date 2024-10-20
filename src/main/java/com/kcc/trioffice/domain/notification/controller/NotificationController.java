package com.kcc.trioffice.domain.notification.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class NotificationController {

    @GetMapping("/notifications")
    public String getNotification() {
        return "test-noti";
    }
}
