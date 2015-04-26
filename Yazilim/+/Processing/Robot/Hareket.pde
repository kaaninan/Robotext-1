boolean running = false;
boolean first = true;
boolean the_first = false;
boolean olcmeye_basla = false;

void hareket(String yon){

  if(running == false){
    running = true;
    println("Hareket Başladı");
    ses("hareket");
    
    if(yon == "sag"){ servo_dondur("sag"); }
    else{ servo_dondur("sol"); }
    
    resim_cek();
    // Bittiginde running false
    
    
    if(first == true){
      println("Birinci Mail Gönderiliyor..");
      thread("sendMailBirinci");
    }
  
  }else{
    
    // Üst üste hareket algılandığında
    println("test; cakisma");
    
  }
}
