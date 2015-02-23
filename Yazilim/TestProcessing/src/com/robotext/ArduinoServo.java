package com.robotext;

import cc.arduino.Arduino;

public class ArduinoServo extends Thread{
	
	Arduino arduino;
	Pin pin;
	
	String yon;
	
	public ArduinoServo(Arduino arduino_mega, String y){
		this.arduino = arduino_mega;
		this.yon = y;
		pin = new Pin();
	}
	
	public void run(){
		try {
			if(yon == "sag"){
				servo_x(0);
				servo_y(0);
				sleep(1000);
				servo_y(180);
				sleep(1000);
			}else{
				servo_x(180);
				servo_y(0);
				sleep(1000);
				servo_y(180);
				sleep(1000);
			}
			
	      }
	      catch(InterruptedException e) {
	      }
	}
	
	public void servo_x(int degree){
		arduino.servoWrite(pin.a_servo_x, degree);
	}
	
	public void servo_y(int degree){
		arduino.servoWrite(pin.a_servo_y, degree);
	}

}
