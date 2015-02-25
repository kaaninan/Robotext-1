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
}
