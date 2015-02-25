import java.io.*;

void setup(){
  size(10,10);
  
  thread("dosyala");
}

void draw(){}


void dosyala() {
  
  println("Resimler Arsivleniyor..");
  
  try{
    thread("dir_bash");
  }catch (Exception c){
    println("ARSIVLENEMEDI");
  }
  
  println("-> Arsivlenme Tamamlandi");
}


String tarih = hour()+":"+minute()+" "+day()+"."+month()+"."+year();


void dir_bash() throws InterruptedException, IOException {
    Runtime run = Runtime.getRuntime();
    
    Process proc2 = run.exec(new String[]{"/bin/sh", "-c", "mkdir /home/pi/guvenlik/"+tarih});
    proc2.waitFor();
    BufferedReader br = new BufferedReader(new InputStreamReader(proc2.getInputStream()));
    while(br.ready())
        println(br.readLine());
    
    Runtime run = Runtime.getRuntime();
    Process proc = run.exec(new String[]{"/bin/sh", "-c", "mv /home/pi/temp_guvenlik/* /home/pi/guvenlik/"+tarih});
    proc.waitFor();
    BufferedReader br2 = new BufferedReader(new InputStreamReader(proc.getInputStream()));
    while(br2.ready())
        println(br2.readLine());
}
