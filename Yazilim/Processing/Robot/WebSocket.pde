WebSocketP5 socket;

void websocketOnMessage(WebSocketConnection con, String msg){
  //println(msg);
  json_parse(msg);
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


//int[] sensor_uzaklik_on = new int[1];
//int[] sensor_uzaklik = new int[3];
// UZAKLIK  ==>  (Sağ Ön, Sağ Arka, Sol Ön, Sol Arka)

void json_gonder(){
  int a = 0;
  while(true){
    String gonder = "";
    
    String[] json = new String[11];
    
    json[0] = "\"isik\":\""+sensor_ldr+"\",";
    json[1] = "\"sicaklik\":\""+sensor_sicaklik+"\",";
    json[2] = "\"ses\":\""+sensor_ses+"\",";
    json[3] = "\"hareket_sag\":\""+sensor_hareket[0]+"\",";    
    json[4] = "\"hareket_sol\":\""+sensor_hareket[1]+"\",";
    json[5] = "\"uzaklik_on_alt\":\""+sensor_uzaklik[4]+"\",";
    json[6] = "\"uzaklik_on_ust\":\""+sensor_uzaklik[5]+"\",";
    json[7] = "\"uzaklik_sag_on\":\""+sensor_uzaklik[0]+"\",";
    json[8] = "\"uzaklik_sag_arka\":\""+sensor_uzaklik[1]+"\",";
    json[9] = "\"uzaklik_sol_on\":\""+sensor_uzaklik[2]+"\",";
    json[10] = "\"uzaklik_sol_arka\":\""+sensor_uzaklik[3]+"\"";
    
    for(int i = 0; i < json.length; i++){
      gonder+= json[i];
    }
    
    gonder = "{"+gonder+"}";
    
    socket.broadcast(gonder);
    delay(100);
    a++;
  }
}
