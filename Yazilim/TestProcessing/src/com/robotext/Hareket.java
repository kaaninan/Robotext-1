package com.robotext;

import cc.arduino.Arduino;

public class Hareket {
	
	Arduino arduino;
	Thread arduinoServo;
	
	public Hareket(Arduino arduino_mega){
		this.arduino = arduino_mega;		
	}

	public void detect(String yon){

		if(yon == "sag"){
			arduinoServo = new ArduinoServo(arduino, "sag");
			arduinoServo.start();
			
		}else{
			arduinoServo = new ArduinoServo(arduino, "sol");
			arduinoServo.start();
		}
		
	}

	public void finish(String yon){
		
	}
	
}
