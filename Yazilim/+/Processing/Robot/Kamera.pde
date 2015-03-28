String[] resimler = new String[50];

void resim_cek() {
  println("Resim Çekiliyor..");
  try{
    resim_bash();
  }catch (Exception c){
    println("Resim Çekilemedi");
  }
  println("Resim Çekildi");
}

void resim_bash() throws InterruptedException, IOException {
    Runtime run = Runtime.getRuntime();
    Process proc = run.exec(new String[]{"/bin/sh", "-c", "./home/pi/Robotext/Yazilim/Bash/kamera.sh"});
    proc.waitFor();
    BufferedReader br = new BufferedReader(new InputStreamReader(proc.getInputStream()));
    while(br.ready())
        println(br.readLine());
    running = false;
}




void resim_bul() {
  
  resim_hafiza_temizle();
  
  println("Resimler Bulunuyor..");
  try{
    resimbul_bash();
  }catch (Exception c){
    println("Resim Bulmada HATA");
  }
  println("Resimler Bulundu");
}

void resimbul_bash() throws InterruptedException, IOException {
    Runtime run = Runtime.getRuntime();
    //Process proc = run.exec(new String[]{"/bin/sh", "-c", "ls /home/pi/temp_guvenlik/*"});
    Process proc = run.exec(new String[]{"/bin/sh", "-c", "ls /Users/Kaaninan/Robotext/Yazilim/Resim/*"});
    proc.waitFor();
    BufferedReader br = new BufferedReader(new InputStreamReader(proc.getInputStream()));
    int a = 0;
    while(br.ready()){
        //println(br.readLine());
        resimler[a] = br.readLine();
        a++;
    }
}

void resim_hafiza_temizle(){
  for(int i = 0; i < 50; i++)
    resimler[i] = null;
}

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
