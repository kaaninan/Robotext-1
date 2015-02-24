package com.robotext;
import org.webbitserver.WebSocketConnection;

import processing.core.PApplet;
import processing.serial.Serial;
import cc.arduino.Arduino;


public class Processing extends PApplet {
	
	public boolean arduino_bagli = true;
	
	
	public static void main(String args[]) {
		PApplet.main(new String[] { "--present", "com.robotext.Processing" });
	}

	
	WebSocket socket;
	ArduinoSensor arduinoSensor;
	ArduinoMotor arduinoMotor;
	
	public void setup() {
		size(60,60);
		background(0);
		
		System.out.println("ROBOTEXT Started");
		
		socket = new WebSocket(this);
		
		System.out.println(Arduino.list()[9]);
		Serial serial = new Serial(this, Arduino.list()[9], 57600);
		//Arduino arduino_mega1280 = new Arduino(this, Arduino.list()[9], 57600);
		System.out.println("Arduino -> arduino_connect ==> Arduino Mega -> Baglanildi");
		
		// Arduino'ya Bağlan # PinMode OK	
		//ArduinoConnect arduinoConnect = new ArduinoConnect(this, Arduino.list()[9]);
		//arduinoConnect.connect(arduino_bagli);
		
		// Arduino Sensor Dinleme Ac
		//arduinoSensor = new ArduinoSensor(arduinoConnect);
		//arduinoMotor = new ArduinoMotor(arduinoConnect);
		
	}

	public void draw() {
		stroke(255);
		
		arduinoSensor.sensorDinle();
		
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public void stop(){
		socket.socket.stop();
	}


	public void websocketOnMessage(WebSocketConnection con, String msg){
		System.out.println("Mesaj");
	  
		if(msg.equals("test")){
			socket.socket.broadcast("çalışıyor");
		}
	}

	public void websocketOnOpen(WebSocketConnection con){
		System.out.println("A client joined");
	}

	public void websocketOnClosed(WebSocketConnection con){
		System.out.println("A client left");
	}
  
}

