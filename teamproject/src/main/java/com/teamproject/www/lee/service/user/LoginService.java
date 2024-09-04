package com.teamproject.www.lee.service.user;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;


@Service
public class LoginService {

    private final Map<String, HttpSession> userSessions = new ConcurrentHashMap<>();

 
    public void managerUserSession(String userId, HttpSession session) {
        System.out.println("LoginService, managerUserSession");
        if (userSessions.containsKey(userId)) {
            HttpSession existingSession = userSessions.get(userId);
            if (existingSession != null && !existingSession.equals(session)) {
                // 기존 사용자에게 알림 전송
//                webSocketHandler.sendNotification(userId, "다른 위치에서 로그인 되었습니다.");
                System.out.println("다른 위치에서 로그인됨");

                // 기존 세션 무효화
                try {
                    existingSession.invalidate();
                    System.out.println("기존 세션 무효화됨");
                } catch (IllegalStateException e) {
                    System.out.println("세션이 이미 무효화되었습니다.");
                }
            }
        }

        userSessions.put(userId, session);
        System.out.println("userid session 등록");
    }

    public void removeUserSession(String userId) {
        System.out.println("userid session 삭제");
        userSessions.remove(userId);
    }
}