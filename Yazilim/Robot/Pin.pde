class Pin {
  
  HashMap<HashMap<String, Integer>,Integer> mega_pin = new HashMap<HashMap<String, Integer>,Integer>();
  HashMap<String, Integer> value = new HashMap<String, Integer>();
  
  //Pin(){}
  
  // 0 -> ANALOG
  // 1 -> INPUT
  // 2 -> OUTPUT
  // 3 -> SERVO
  
  void pinAyarla(){
    
    // PWM
    value.put("motor_sol_on",2); mega_pin.put(value, 2);
    value.put("motor_sol_arka",3); mega_pin.put(value, 2);
    value.put("motor_sag_on",4); mega_pin.put(value, 2);
    value.put("motor_sag_arka",5); mega_pin.put(value, 2);
    value.put("servo_x",6); mega_pin.put(value, 3);
    value.put("servo_y",7); mega_pin.put(value, 3);
    
    // DIGITAL
    value.put("motor_sol_on_yon",22); mega_pin.put(value, 2);
    value.put("motor_sol_arka_yon",23); mega_pin.put(value, 2);
    value.put("motor_sag_on_yon",24); mega_pin.put(value, 2);
    value.put("motor_sag_arka_yon",25); mega_pin.put(value, 2);
    value.put("buzzer_1",26); mega_pin.put(value, 2);
    value.put("buzzer_2",27); mega_pin.put(value, 2);
    value.put("ekran_sag_isik",28); mega_pin.put(value, 2);
    value.put("ekran_sol_isik",29); mega_pin.put(value, 2);
    value.put("hareket_on_sag",30); mega_pin.put(value, 1);
    value.put("hareket_on_sol",31); mega_pin.put(value, 1);
    value.put("hareket_arka_sag",32); mega_pin.put(value, 1);
    value.put("hareket_arka_sol",33); mega_pin.put(value, 1);
    value.put("ses_sensoru",34); mega_pin.put(value, 1);
    value.put("uzaklik_on_alt_1",35); mega_pin.put(value, 1);
    value.put("uzaklik_on_alt_2",36); mega_pin.put(value, 1);
    value.put("uzaklik_on_ust_1",37); mega_pin.put(value, 1);
    value.put("uzaklik_on_ust_2",38); mega_pin.put(value, 1);
    value.put("uzaklik_arka_1",39); mega_pin.put(value, 1);
    value.put("uzaklik_arka_2",40); mega_pin.put(value, 1);
    
    // ANALOG
    value.put("motor_sol_on_hiz",0); mega_pin.put(value, 0);
    value.put("motor_sol_arka_hiz",1); mega_pin.put(value, 0);
    value.put("motor_sag_on_hiz",2); mega_pin.put(value, 0);
    value.put("motor_sag_arka_hiz",3); mega_pin.put(value, 0);
    value.put("uzaklik_sag_on",4); mega_pin.put(value, 0);
    value.put("uzaklik_sag_arka",5); mega_pin.put(value, 0);
    value.put("uzaklik_sol_on",6); mega_pin.put(value, 0);
    value.put("uzaklik_sol_arka",7); mega_pin.put(value, 0);
    value.put("sicaklik",8); mega_pin.put(value, 0);
    value.put("gaz",9); mega_pin.put(value, 0);
    value.put("ldr_on_sag",10); mega_pin.put(value, 0);
    value.put("ldr_on_sol",11); mega_pin.put(value, 0);
    value.put("ldr_arka",12); mega_pin.put(value, 0);

/*
    for (Map.Entry me :mega_pin.entrySet()) {
      print(me.getKey() + " is ");
      println(me.getValue());
    }
*/
  }

  void pinBul(String isim){
    try{
      int val = value.get(isim);
      println(isim+ " pin no: " + val);
    }catch (Exception c){
      println("Bulunamadı");
    }
    
  }

}
