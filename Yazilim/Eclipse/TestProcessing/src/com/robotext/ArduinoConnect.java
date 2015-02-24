package com.robotext;

import cc.arduino.Arduino;

public class ArduinoConnect {
	
	processing.core.PApplet context;
	public String s_arduino_mega1280;
	
	public Arduino arduino_mega1280 = null;

	
	public ArduinoConnect(processing.core.PApplet c, String s_arduino_mega12802){
	    this.context = c;
	    this.s_arduino_mega1280 = s_arduino_mega12802;
	}
	
	
	public void connect(boolean arduino_mega1280_bagli){
		listeYaz();

		if(arduino_mega1280_bagli){
			arduino_mega1280 = new Arduino(context, s_arduino_mega1280, 57600);
			System.out.println("Arduino -> arduino_connect ==> Arduino Mega -> Baglanildi");
			
			pinmode();
  
		}else{
			System.out.println("Arduino -> arduino_connect ==> Arduino Mega -> Bagli Degil");
		}
		
	}
	

	public void pinmode(){
		Pin pin = new Pin();
	    pin.pinMode(arduino_mega1280);
	}
	

	private void listeYaz(){
		for(int i = 0; i < Arduino.list().length; i++){
			System.out.print(i+" -> ");
			System.out.println(Arduino.list()[i]);
		}
	}

}
