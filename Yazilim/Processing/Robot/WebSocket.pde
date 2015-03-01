WebSocketP5 socket;

void websocketOnMessage(WebSocketConnection con, String msg){
  println(msg);
  //json_parse(msg);
}

void websocketOnOpen(WebSocketConnection con){
  // Kullanici geldiginde  
  ekran(1);
  println("Bir Kullanici Baglandi");
}

void websocketOnClosed(WebSocketConnection con){
  // Kullanici ayrlildigida
  println("X-> Kullanici Ayrildi");
}






/* ### JSON ### */

int j_ileri = 0;
int j_geri = 0;
int j_sag = 0;
int j_sol = 0;

void json_parse(String gelen){
  String[] q = split(gelen, ",");
  
  for(int i = 0; i < q.length; i++){
    String[] a = split(q[i], ":");
    String[] b = split(a[0], "\"");
    String[] e = split(a[1], "\"");
    
    if(b[1].equals("ileri")){
      if(e[1].equals("ok")){
        j_ileri = 1;
      }else
        j_ileri = 0;
    }
    
    else if(b[1].equals("geri")){
      if(e[1].equals("ok")){
        j_geri = 1;
      }else
        j_geri = 0;
    }
    
    else if(b[1].equals("sag")){
      if(e[1].equals("ok")){
        j_sag = 1;
      }else
        j_sag = 0;
    }
    
    else if(b[1].equals("sol")){
      if(e[1].equals("ok")){
        j_sol = 1;
      }else
        j_sol = 0;
    } 
  }
}

void mousePressed(){
  sensor_sicaklik = 1;
}



void json_gonder(){
  int a = 0;
  while(true){
    String json = "{\"isik\":\""+sensor_ldr+"\",\"sicaklik\":\""+sensor_sicaklik+"\"}";
    socket.broadcast(json);
    delay(100);
    a++;
  }
}
