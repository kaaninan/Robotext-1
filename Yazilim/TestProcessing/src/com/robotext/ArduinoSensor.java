package com.robotext;

import cc.arduino.Arduino;

public class ArduinoSensor {
	
	Arduino arduino;
	Pin pin;
	Hareket hareket;
	
	public ArduinoSensor(ArduinoConnect arduinoConnect){
		this.arduino = arduinoConnect.arduino_mega1280;
		pin = new Pin();
		hareket = new Hareket(arduino);
	}
	
	public void sensorDinle(){
		sensorHareket();
		sensorUzaklik();
		// sensorSes
		// sensorGaz
	}
	
	private void sensorHareket(){
		int hareket_sag = pin.a_hareket_on_sag;
		int hareket_sol = pin.a_hareket_on_sol;
		
		int durum_sag = arduino.digitalRead(hareket_sag);
		int durum_sol = arduino.digitalRead(hareket_sag);
		
		int durum_sag_high = 0;
		int durum_sol_high = 0;
		
		if(durum_sag == Arduino.HIGH){
			System.out.println("--> Sağ Tarafta Hareket ALgılandı");
			
			if(durum_sag_high == 0){
				hareket.detect("sag");
				durum_sag_high = 1;
			}else{
				hareket.finish("sag");
				durum_sag_high = 0;
			}
		}
		
		if(durum_sol == Arduino.HIGH){
			System.out.println("--> Sol Tarafta Hareket ALgılandı");
			
			if(durum_sol_high == 0){
				hareket.detect("sol");
				durum_sol_high = 1;
			}else{
				hareket.finish("sol");
				durum_sol_high = 0;
			}
		}
	}

	private void sensorUzaklik(){
		sharp(pin.a_uzaklik_sag_on);
	}
	
	
	
	
	private void sharp(int pin){
		char GP2D12 = (char) read_gp2d12_range(pin);
		char a = (char) (GP2D12/10);
		char b = (char) (GP2D12%10);
		int val = a*10+b;
	 
		if(val>10&&val<80){
			System.out.print(a);
			System.out.print(a);
			System.out.println("cm");
		}else
			System.out.println("over");
	
	}

	private float read_gp2d12_range(int i){
		int tmp;
		tmp = arduino.analogRead(i);
		if (tmp < 3) return -1;
		return (float) ((6787.0 /((float)tmp - 3.0)) - 4.0);
	}
	
	
	// sensorSes
	// sensorGaz
}
