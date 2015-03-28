boolean dur = false;
int yon = 2;
int uzaklik_sinir = 20;
int calis = 1;

void gez(){
  
  while(true){
    
    if(yon != 2){
      println("yon != 2");
      
      if(yon == 0){
        println("yon == 0");
        while(true){
          motor_auto_ileri_sag("tam");
          println(sensor_uzaklik);

            if(sensor_uzaklik[4] > uzaklik_sinir && sensor_uzaklik[5] > uzaklik_sinir){
              yon = 2;
              dur = false;
              break;
            }

        }
        
      }else if(yon == 1){
        println("yon == 1");
        while(true){
          motor_auto_ileri_sol("tam");
          println(sensor_uzaklik);
          
            if(sensor_uzaklik[4] > uzaklik_sinir || sensor_uzaklik[5] > uzaklik_sinir){
              yon = 2;
              dur = false;
              break;
            }
            
        }
      }
    }
    
    else if(dur == true && calis == 1){
      motor_auto_dur();
      yon = sag_sol();
      println("dur == true");
      calis = 0;
      delay(400);
    }
    
    else if(dur == false){
      println("ileri");
      motor_test(100,100);
      
      if(sensor_uzaklik[4] != 0 || sensor_uzaklik[5] != 0){
        if(sensor_uzaklik[4] < uzaklik_sinir || sensor_uzaklik[5] < uzaklik_sinir){
          println("sinirda");
          dur = true;
          calis = 1;
        }
      }
    }
    
    println();
    println();
    println();
  }
}

int sag_sol(){
  int sag_ort = (sensor_uzaklik[0]+sensor_uzaklik[1])/2;
  int sol_ort = (sensor_uzaklik[2]+sensor_uzaklik[3])/2;
  
  int i = 0; // DUZENLE
  
  if(sag_ort > sol_ort){
    i = 0;
  }
  else if(sag_ort < sol_ort){
    i = 1;
  }
  return i;
}
