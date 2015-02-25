boolean running = false;
boolean first = true;
boolean the_first = false;
boolean olcmeye_basla = false;

void hareket(String yon){

  if(running == false){
    
    // İlk Hareket Algılandığında Grafik Verilerini Başlat
    if(the_first)
      olcmeye_basla = true;
    
    running = true;
    
    println("Hareket Başladı");
    
    /*ses("hareket");
    
    if(yon == "sag"){
      servo_dondur("sag");
    }else{
      servo_dondur("sol");
    }
    
    resim_cek();
    resim_no++;
    
    if(first == true){
      println("Birinci Mail Gönderiliyor..");
      thread("sendMailBirinci");
    }
    
    */
    
    running = false;
  
  }else{
    
    // Üst üste hareket algılandığında
    println("test; cakisma");
    
  }
}
