package com.teamproject.www.lee.websoket;

import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import lombok.extern.log4j.Log4j;

@ServerEndpoint("/game")
@Log4j
public class GameServer {
	private static Set<Session> clients = new CopyOnWriteArraySet<Session>();
	
	@OnOpen
	public void onOpen(Session session) {
		clients.add(session);
		log.info("새 연결 : " + session.getId());
	}
	
	@OnMessage
	public void onMessage(String message, Session session){
		for(Session client : clients) {
			if(client.isOpen()) {
				try {
					synchronized(client) {
						client.getBasicRemote().sendText(message);
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	@OnClose
	public void onClose(Session session){
		clients.remove(session);
	}
}
