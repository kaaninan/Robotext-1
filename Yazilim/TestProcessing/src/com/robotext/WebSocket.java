package com.robotext;

import muthesius.net.WebSocketP5;

public class WebSocket {
	
	public WebSocketP5 socket;

	public WebSocket(processing.core.PApplet c){
		socket = new WebSocketP5( c, 8082, "" );
	}
	
	
	
}
