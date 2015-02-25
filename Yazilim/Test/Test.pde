import java.io.*;

void setup(){
  size(10,10);
}

void draw(){}


void dosyala() {
  
  println("Resimler Arsivleniyor..");
  
  try{
    thread("dir_bash");
  }catch (Exception c){
    println("ARSIVLENEMEDI");
  }
  
  println("Arsivlenme Tamamlandı");
}

void dir_bash() throws InterruptedException, IOException {
    Runtime run = Runtime.getRuntime();
    
    String tarih = hour()+":"+minute()+" "+day()+"."+month()+"."+year();
    
    Process proc2 = run.exec(new String[]{"/bin/sh", "-c", "mkdir /home/pi/guvenlik/"+tarih});
    
    Process proc = run.exec(new String[]{"/bin/sh", "-c", "mv /home/pi/temp_guvenlik/* /home/pi/guvenlik/"+tarih});
    proc.waitFor();
    BufferedReader br = new BufferedReader(new InputStreamReader(proc.getInputStream()));
    while(br.ready())
        println(br.readLine());
}
