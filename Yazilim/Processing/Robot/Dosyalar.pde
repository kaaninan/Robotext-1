void dosyala() {
  println("Resimler Arsivleniyor..");
  try{
    thread("dir_bash");
  }catch (Exception c){
    println("ARSIVLENEMEDI");
  }
  println("-> Arsivlenme Tamamlandi");
}


String tarih = hour()+":"+minute()+"-"+day()+"."+month()+"."+year();

void dir_bash() throws InterruptedException, IOException {
    Runtime run = Runtime.getRuntime();
    
    Process proc2 = run.exec(new String[]{"/bin/sh", "-c", "mkdir /home/pi/guvenlik/"+tarih});
    proc2.waitFor();
    
    Process proc = run.exec(new String[]{"/bin/sh", "-c", "mv /home/pi/temp_guvenlik/* /home/pi/guvenlik/"+tarih});
    proc.waitFor();
}
